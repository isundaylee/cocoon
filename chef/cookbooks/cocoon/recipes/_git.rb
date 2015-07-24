#
# Cookbook Name:: cocoon
# Recipe:: _git
#
# Copyright (C) 2014 FullStack
#

#
# Install Git.
#
package 'git'

repo = node[:repo]

git '/home/vagrant/code' do
  repository "git@github.com:#{repo}.git"
  reference "master"
  action :sync
end
