
brew_install "dnsmasq"

bash "Set dnsmasq as a resolver for *.dev" do
    user "root"
    cwd "/tmp"
    code <<-EOH
echo 'address=/#{node["dnsmasq"]["tld"]}/127.0.0.1' > $(brew --prefix)/etc/dnsmasq.conf
sudo cp -v $(brew --prefix dnsmasq)/homebrew.mxcl.dnsmasq.plist /Library/LaunchDaemons
sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
sudo mkdir -v /etc/resolver
sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/dev'
EOH

end