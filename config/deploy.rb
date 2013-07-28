require "bundler/capistrano"
set :application, "rating"
set :repository,  "git@github.com:Infinitiv/rating.git"
set :deploy_to, "/home/markovnin/www/rating"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "isma_ror"                          # Your HTTP server, Apache/etc
role :app, "isma_ror"                          # This may be the same as your `Web` server
role :db,  "isma_ror", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
set :use_sudo, false
set :user, "markovnin"

namespace :deploy do
  desc "Restart the Thin processes"
  task :restart do
    run "cd #{current_path} && bundle exec thin stop && bundle exec thin -d start -p 3003 -e production"
  end
end