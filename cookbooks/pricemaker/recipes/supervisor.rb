
include_recipe "pricemaker::app"

execute "install supervisor" do
	command "easy_install supervisor"
	not_if { system( "which supervisorctl > /dev/null 2>&1" ) }
end

directory "/usr/local/etc/supervisor/conf.d" do
  action :create
  recursive true
end

template "/usr/local/etc/supervisor/supervisord.conf" do
  source "supervisord.conf.erb"
  user "root"
end

cookbook_file "/Library/LaunchDaemons/com.agendaless.supervisord.plist" do
	source "com.agendaless.supervisord.plist"
	mode "0644"
end

execute "unload launchd script for supervisord if it exists" do
	command "sudo launchctl unload -w /Library/LaunchDaemons/com.agendaless.supervisord.plist"
	only_if { system( "sudo launchctl list | grep com.agendaless.supervisor > /dev/null 2>&1" ) }
end

execute "load launchd script for supervisord" do
	command "sudo launchctl load -w /Library/LaunchDaemons/com.agendaless.supervisord.plist"
	not_if { system( "sudo launchctl list | grep com.agendaless.supervisor > /dev/null 2>&1" ) }
end


template "/usr/local/etc/supervisor/conf.d/workers.conf" do
  source "workers.conf.erb"
  user "root"
end

execute "supervisorctl restart all"