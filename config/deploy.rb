lock "~> 3.11.2"

set :application, "NateMate"
set :repo_url, "git@github.com:TadayoshiOtsuka/NateMate.git"
set :rbenv_ruby, '2.5.1'

set :deploy_to, "/var/www/rails/NateMate"

set :format, :pretty
set :log_level, :debug

set :puma_threads,  [4, 16]
set :puma_workers, 0

set :pty, true

set :linked_files, %w{config/database.yml config/master.key}

set :linked_dirs, %w{log tmp/backup tmp/pids tmp/cache tmp/sockets public/system　vendor/bundle}


set :rbenv_type, :user
set :rbenv_ruby, File.read(".ruby-version").strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all

# pumaの設定
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log,  "#{release_path}/log/puma.error.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true

append :rbenv_map_bins, "puma", "pumactl"

set :keep_releases, 3

set :bundle_jobs, 4

namespace :puma do
  desc "Create Puma Pids and Socket"
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end
  before :start, :make_dirs
end

namespace :deploy do
    desc 'Make sure local git is in sync with remote.'
    task :check_revision do
      on roles(:app) do
        unless "git rev-parse HEAD" == "git rev-parse origin/master"
        end
      end
    end

    desc "Initial Deploy"
    task :initial do
      on roles(:app) do
        before "deploy:restart","puma:start"
        invoke "deploy"
      end
    end

    desc "Restart Puma"
    task :restart do
      on roles(:app), in: :sequence, wait: 5 do
        invoke "puma:restart"
      end
    end

    desc 'Generate sitemap'
    task :sitemap do
      on roles(:app) do
       within release_path do
          execute :bundle, :exec, :rake, 'sitemap:create'
          end
       end
    end
before :starting,:check_revision
after :finishing,:compile_assets
after :finishing,:cleanup
end
