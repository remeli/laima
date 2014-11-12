# ================
# ================
# ================
# ================
# ================
# ================
# По умолчанию для дистрибуции проектов используется Bundler.
# Эта строка включает автоматическое обновление и установку
# недостающих gems, указанных в вашем Gemfile.
#
## !!! Не забудьте добавить
# gem 'capistrano'
# gem 'unicorn'
#
# в ваш Gemfile.
#
# Если вы используете другую систему управления зависимостями,
# закомментируйте эту строку.
require 'bundler/capistrano'

## Чтобы не хранить database.yml в системе контроля версий, поместите
## dayabase.yml в shared-каталог проекта на сервере и раскомментируйте
## следующие строки.

after "deploy:update_code", :copy_database_config
after "deploy", "deploy:cleanup" # keep only the last 5 releases
after "deploy", "deploy:migrate"
after "deploy:migrate", "deploy:seed"

task :copy_database_config, roles => :app do
  db_config = "#{shared_path}/database.yml"
  run "cp #{db_config} #{release_path}/config/database.yml"
end

# В rails 3 по умолчанию включена функция assets pipelining,
# которая позволяет значительно уменьшить размер статических
# файлов css и js.
# Эта строка автоматически запускает процесс подготовки
# сжатых файлов статики при деплое.
# Если вы не используете assets pipelining в своем проекте,
# или у вас старая версия rails, закомментируйте эту строку.
load 'deploy/assets'

# Для удобства работы мы рекомендуем вам настроить авторизацию
# SSH по ключу. При работе capistrano будет использоваться
# ssh-agent, который предоставляет возможность пробрасывать
# авторизацию на другие хосты.
# Если вы не используете авторизацию SSH по ключам И ssh-agent,
# закомментируйте эту опцию.
ssh_options[:forward_agent] = true

# Имя вашего проекта в панели управления.
# Не меняйте это значение без необходимости, оно используется дальше.
set :application,     "laima"

# Сервер размещения проекта.
set :deploy_server,   "hydrogen.locum.ru"

# Не включать в поставку разработческие инструменты и пакеты тестирования.
set :bundle_without,  [:development, :test]

set :user,            "hosting_lagox"
set :login,           "lagox"
set :use_sudo,        false
set :deploy_to,       "/home/#{user}/projects/#{application}"
set :unicorn_conf,    "/etc/unicorn/#{application}.#{login}.rb"
set :unicorn_pid,     "/var/run/unicorn/#{user}/#{application}.#{login}.pid"
set :bundle_dir,      File.join(fetch(:shared_path), 'gems')
role :web,            deploy_server
role :app,            deploy_server
role :db,             deploy_server, :primary => true

# Следующие строки необходимы, т.к. ваш проект использует rvm.
set :rvm_ruby_string, "2.1.2"
set :rake,            "rvm use #{rvm_ruby_string} do bundle exec rake" 
set :bundle_cmd,      "rvm use #{rvm_ruby_string} do bundle"

# Настройка системы контроля версий и репозитария,
# по умолчанию - git, если используется иная система версий,
# нужно изменить значение scm.
set :scm,             :git

# Предполагается, что вы размещаете репозиторий Git в вашем
# домашнем каталоге в подкаталоге git/<имя проекта>.git.
# Подробнее о создании репозитория читайте в нашем блоге
# http://locum.ru/blog/hosting/git-on-locum
set :repository,      "git://github.com/remeli/laima.git"

## Если ваш репозиторий в GitHub, используйте такую конфигурацию
# set :repository,    "git@github.com:username/project.git"

## --- Ниже этого места ничего менять скорее всего не нужно ---

before 'deploy:finalize_update', 'set_current_release'
task :set_current_release, :roles => :app do
    set :current_release, latest_release
end

# for carrierwave
after "deploy:update_code", :symlink_shared
task :symlink_shared, roles => :app do
  run "ln -nfs #{shared_path}/system #{release_path}/public/uploads"
end

# reset db
desc "RESET DB"
task :reset_db, roles: :app do
  run "cd #{deploy_to}/current && rvm use #{rvm_ruby_string} do #{rake} RAILS_ENV=production db:reset"
end

  set :unicorn_start_cmd, "(cd #{deploy_to}/current; rvm use #{rvm_ruby_string} do bundle exec unicorn_rails -Dc #{unicorn_conf})"


# - for unicorn - #
namespace :deploy do
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

  # migrate
  desc "Migrations db"
  task :migrate, :roles => :app do
    run "cd #{deploy_to}/current && #{rake} RAILS_ENV=production db:migrate"
  end
  
  desc "Seeding data"
  task :seed do
    puts "\n\n=== Populating the Production Database! ===\n\n"
    run "cd #{deploy_to}/current && #{rake} RAILS_ENV=production db:seed"
    puts "\n\n------- end seed -------\n\n"
  end

  desc "Generate sitemap.xml.gz"
  task :refresh_sitemaps do
    puts "\n\n=========== Generate sitemap.xml.gz ===========\n\n"
    run "cd #{latest_release} && #{rake} RAILS_ENV=production sitemap:refresh"
    puts "\n\n=========== End generate sitemap.xml.gz ===========\n\n"
  end
  
  after "deploy:seed", "deploy:refresh_sitemaps"
  after "deploy:refresh_sitemaps", "deploy:restart"

end
