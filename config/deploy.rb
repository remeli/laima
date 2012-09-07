set :application, "laima"
set :scm, :git
set :repository,  "git://github.com/remeli/laima.git"


set :user, "hosting_lagox"
set :use_sudo, false
set :deploy_to, "/home/#{user}/projects/#{application}"
set :keep_releases, 5
set :unicorn_rails, "/var/lib/gems/1.8/bin/unicorn_rails"
set :unicorn_conf, "/etc/unicorn/#{application}.obl-reklama.rb"
set :unicorn_pid, "/var/run/unicorn/#{application}.obl-reklama.pid"
set :unicorn_start_cmd, "(cd #{deploy_to}/current; rvm use 1.9.3 do bundle exec unicorn_rails -Dc #{unicorn_conf})"

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



after "deploy", "deploy:bundle_gems"
after "deploy:bundle_gems", "deploy:migrate"
after "deploy:migrate", "deploy:ascompile"
after "deploy:ascompile", "deploy:restart"

namespace :deploy do
  
  # assets
  desc "Compile assets"
  task :ascompile, :roles => :app do
    run "cd #{current_path} && rvm use 1.9.3 do bundle exec rake assets:precompile RAILS_ENV=production"    
  end
  
  # bundle install
  desc "Bundle install"
  task :bundle_gems, :roles => :app do
    run "cd #{deploy_to}/current && rvm use 1.9.3 do bundle install --path ../../shared/gems"
  end

  
  # migrate
  desc "Migrations db"
  task :migrate, :roles => :app do
    run "cd #{current_path} && rvm use 1.9.3 do bundle exec rake RAILS_ENV=production db:migrate"
  end
  
  desc "Start application"
  task :start, :roles => :app do
    run unicorn_start_cmd
  end
  
  desc "Stop application"
  task :stop, :roles => :app do
    run "[ -f #{unicorn_pid} ] && kill -QUIT `cat #{unicorn_pid}`"
  end
  
  desc "Restart Application"
  task :restart, :roles => :app do
    run "[ -f #{unicorn_pid} ] && kill -USR2 `cat #{unicorn_pid}` || #{unicorn_start_cmd}"
  end
end