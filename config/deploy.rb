# config valid for current version and patch releases of Capistrano
lock "~> 3.11.2"

set :application, "NateMate"
set :repo_url, "git@github.com:TadayoshiOtsuka/NateMate.git"
set :rbenv_ruby, '2.5.1'

#Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/rails/NateMate"
set :log_level, :debug

set :linked_files, %w{config/database.yml config/master.key}

set :linked_dirs, %w{log tmp/backup tmp/pids tmp/cache tmp/sockets public/system　vendor/bundle}

namespace :deploy do
    desc 'Restart application'
    task :start do
      invoke 'unicorn:start'
    end

    desc 'Upload database.yml'
    task :upload do
      on roles(:app) do |host|
        if test "[ ! -d #{shared_path}/config ]"
          execute "mkdir -p #{shared_path}/config"
        end
        upload!('config/database.yml', "#{shared_path}/config/database.yml")
      end
    end

    desc 'Create database'
    task :db_create do
      on roles(:db) do |host|
        with rails_env: fetch(:rails_env) do
          within current_path do
            execute :bundle, :exec, :rake, 'db:create'
          end
        end
      end
    end

    after :publishing, :restart

    after :restart, :clear_cache do
      on roles(:web), in: :groups, limit: 3, wait: 10 do
      end
    end
  end
# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
#append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
#append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
