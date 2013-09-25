# encoding: utf-8

require 'bundler/capistrano'
require "rvm/capistrano"


set :application, "abuglak"
set :scm,         :git
set :repository,  "git@github.com:abuglak/abuglak.git"
set :git_enable_submodules, 1

set :deploy_to,   "/home/deployer/apps/#{application}"
set :deploy_via,  :remote_cache
set :rails_env,   "production"

set :use_sudo, false
set :user,     "deployer"

task :production do
  set :rvm_ruby_string, '1.9.3-p448@global'
  server '82.196.0.195', :app, :web, :db, :primary => true
  set :branch, 'master'
end

before 'deploy:assets:precompile', 'sys:symlink'

def rake_task(task)
  "cd #{current_path} && RAILS_ENV=#{rails_env} #{rake} #{task}"
end

namespace :sys do

  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end

end

namespace :deploy do

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

end