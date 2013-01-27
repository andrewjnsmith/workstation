include_recipe "pivotal_workstation::workspace_directory"

directory "#{node["apache2_settings"]["document_root"]}" do
  owner WS_USER
  mode "0755"
  action :create
  not_if "test -d #{node["apache2_settings"]["document_root"]}"
end

directory "/etc/apache2/mods" do
  owner "root"
  mode "0755"
  action :create
  not_if "test -d /etc/apache2/mods"
end

directory "/etc/apache2/sites" do
  owner "root"
  mode "0755"
  action :create
  not_if "test -d /etc/apache2/sites"
end

template "/etc/apache2/httpd.conf" do
  source "httpd.conf.erb"
  owner "root"
end

execute "restart apache" do
  command %'sudo apachectl restart'
end