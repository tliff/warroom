set :application, "warroom"
set :repository,  "git@github.com:tliff/warroom.git"
set :scm, :git

set :deploy_to, "/opt/warroom"

set :deploy_via, :checkout


set :user, "root"
set :runner, nil
role :app, "rupert.tliff.de"
role :web, "rupert.tliff.de"
role :db,  "rupert.tliff.de", :primary => true

task :after_update_code do
  run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end


namespace :deploy do
  task :restart do
    sudo "touch /opt/warroom/current/tmp/restart.txt"
  end  
end
