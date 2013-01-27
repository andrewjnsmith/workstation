include_recipe "pivotal_workstation::homebrew"

brew_install "beanstalkd"

ruby_block "copy beanstalkd plist to ~/Library/LaunchAgents" do
  block do
    plist_location = ("/usr/local/opt/beanstalk/homebrew.mxcl.beanstalk.plist").to_s
    destination = "#{WS_HOME}/Library/LaunchAgents/homebrew.mxcl.beanstalk.plist"
    system("cp #{plist_location} #{destination} && chown #{WS_USER} #{destination}") || raise("Couldn't find the plist")
  end
end