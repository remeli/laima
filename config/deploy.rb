set :application, "laima"
set :repository,  "git://github.com/remeli/laima.git"

set :scm, :git
set :user, "hosting_obl-reklama"
set :use_sudo, :false
set :deploy_to, "/home/#{user}/projects/#{application}"



role :web, "lithium.locum.ru"
role :app, "lithium.locum.ru"
role :db,  "lithium.locum.ru", :primary => true
set :deploy_via, :remote_cache

# shared database
after "deploy:update_code", :copy_database_config
task :copy_database_config, roles => :app do
  db_config = "#{shared_path}/database.yml"
  run "cp #{db_config} #{release_path}/config/database.yml"
end

# paperclip
after "deploy:update_code", :symlink_shared
task :symlink_shared, roles => :app do
  run "ln -nfs #{shared_path}/system #{release_path}/public/system"
end

set :unicorn_rails, "/var/lib/gems/1.8/bin/unicorn_rails"
set :unicorn_conf, "/etc/unicorn/laima.obl-reklama.rb"
set :unicorn_pid, "/var/run/unicorn/laima.obl-reklama.pid"
set :unicorn_start_cmd, "rvm use 1.9.3 do bundle exec unicorn_rails -Dc #{unicorn_conf}"

after "deploy", "deploy:bundle_gems"
after "deploy:bundle_gems", "deploy:restart"

namespace :deploy do
  desc "Bundle install"
  task :bundle_gems, :roles => :app do
    run "cd #{deploy_to}/current && rvm use 1.9.3 do bundle install --path ../../shared/gems"
  end
  
  desc "Start application"
  task :start, :roles => :app do
    run "cd #{current_path} && #{unicorn_start_cmd}"
  end

  desc "Stop application"
  task :stop, :roles => :app do
    run "[ -f #{unicorn_pid} ] && kill -QUIT `cat #{unicorn_pid}`"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "[ -f #{unicorn_pid} ] && kill -USR2 `cat #{unicorn_pid}` || cd #{current_path} #{unicorn_start_cmd}"
  end
end