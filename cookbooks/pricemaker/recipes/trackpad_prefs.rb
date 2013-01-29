pivotal_workstation_defaults "allow clicking by trackpad" do
  domain 'NSGlobalDomain'
  key 'com.apple.mouse.tapBehavior'
  integer 1
end

execute "allow clicking by trackpad (alt)" do
  command "defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1"
  user WS_USER
end