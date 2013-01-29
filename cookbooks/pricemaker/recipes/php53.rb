include_recipe "pivotal_workstation::homebrew"
include_recipe "pricemaker::apache2"

execute "tap the josegonzalez repo" do
    command "brew tap josegonzalez/php"
    not_if { system("brew tap | grep 'josegonzalez' > /dev/null 2>&1") }
end

execute "tap the dupes repo" do
    command "brew tap homebrew/dupes"
    not_if { system("brew tap | grep 'dupes' > /dev/null 2>&1") }
end

brew_install "php53", {:brew_args => "--with-mysql"}

brew_install "php53-oauth"
brew_install "php53-mcrypt"

execute "Move native php binary out of the way" do
  command "mv /usr/bin/php /usr/bin/php-native"
  only_if { system("test -f /usr/bin/php") }
end

execute "Symlink php53 binary to /usr/bin/php" do
  command "ln -s $(brew --prefix josegonzalez/php/php53)/bin/php /usr/bin/php"
  not_if { system("test -L /usr/bin/php")}
end

execute "Load php53 module into apache" do
  command "brew info php53 | grep LoadModule | sed 's/^[ \t]*//' >> /etc/apache2/mods/php53.load && sudo apachectl restart"
  not_if { system(" test -f /etc/apache2/mods/php53.load") }
end

directory "/usr/local/etc/php/5.3/conf.d" do
  owner WS_USER
  mode "0755"
  action :create
end