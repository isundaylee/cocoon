#
# Cookbook Name:: cocoon
# Recipe:: _postgres
#
# Copyright (C) 2014 FullStack
#

#
# Install Postgres.
#
package 'postgresql'
package 'postgresql-contrib'

#
# Create a Postgres user.
#
execute 'createuser' do
  guard = <<-EOH
    psql -U postgres -c "select * from pg_user where
    usename='vagrant'" |
    grep -c vagrant
  EOH

  user 'postgres'
  command 'createuser -s vagrant'
  not_if guard, user: 'postgres'
end

#
# Create a Postgres database, and related role.
#
# Default to use the git repo name defined in chef.json (in Vagrantfile) as the
# database name, as well as the username / password. For example, the Github
# repo 'foo/bar' would map to 'bar'.
#
name = node['repo'].split('/').last

execute 'createrole' do
  guard = <<-EOH
    psql -U postgres -c "select * from pg_user where
    usename='#{name}'" |
    grep -c #{name}
  EOH

  user 'postgres'
  command "psql -U postgres -c \"CREATE ROLE #{name} LOGIN PASSWORD '#{name}'\""
  not_if guard, user: 'postgres'
end

execute 'createdb' do
  guard = <<-EOH
    psql -U postgres -l | grep -c #{name}
  EOH

  user 'postgres'
  command "psql -U postgres -c \"CREATE DATABASE #{name} OWNER #{name}\""
  not_if guard, user: 'postgres'
end