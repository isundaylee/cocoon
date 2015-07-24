#
# Some useful bash aliases
#

bash_profile 'rails.aliases' do
  user 'vagrant'
  content <<-EOH
    alias be='bundle exec'

    alias rails='bundle exec rails'
    alias rake='bundle exec rake'

    alias web='bundle exec rackup -p 3000 --host 0.0.0.0'
  EOH
end