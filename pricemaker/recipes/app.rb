include_recipe "pricemaker::php53"
include_recipe "pivotal_workstation::composer"

app_ws = ::File.expand_path(File.join(node["workspace_directory"], "pricemaker"), WS_HOME)
app_dir = ::File.join(app_ws, node["pmk_app"]["target_directory"])

node.set["pmk_app"]["document_root"] = app_dir

directory app_ws do
  owner WS_USER
  mode "0755"
  action :create
end

execute "clone pricemaker app" do
	command "git clone #{node["pmk_app"]["repo_url"]} #{node["pmk_app"]["target_directory"]}"
	user WS_USER
	cwd app_ws
	not_if { ::File.exists?(::File.join(app_ws, node["pmk_app"]["target_directory"])) }
end

execute "install composer dependencies" do
  command "/usr/bin/env composer install"
  user WS_USER
  cwd app_dir
  not_if { ::File.exists?(::File.join(app_dir, "vendor")) }
end

template "/etc/apache2/sites/001-pmk-platform" do
  source "vhost.conf.erb"
  owner "root"
end

execute "restart apache" do
  command %'sudo apachectl restart'
end