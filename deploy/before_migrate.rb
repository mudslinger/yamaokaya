Chef::Log.info("Running deploy/before_migrate.rb")

env = node[:deploy][:yamaokaya][:rails_env]
current_release = release_path
execute "rake assets:precompile" do
  cwd current_release
  command "bundle exec rake assets:precompile"
  environment "RAILS_ENV" => env
end

#change to JST
sudo "mv /etc/localtime /etc/localtime.#{Time.now.to_i}"	
sudo "ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime"
