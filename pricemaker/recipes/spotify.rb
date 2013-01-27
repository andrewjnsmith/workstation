unless File.exists?("/Applications/Spotify.app")

  remote_file "#{Chef::Config[:file_cache_path]}/spotify.zip" do
    source "http://download.spotify.com/SpotifyInstaller.zip"
    owner WS_USER
  end

  execute "unzip spotify" do
    command "unzip #{Chef::Config[:file_cache_path]}/spotify.zip -d #{Chef::Config[:file_cache_path]}/"
    user WS_USER
  end

  execute "Install Spotify" do
    command "'#{Chef::Config[:file_cache_path]}/Install Spotify.app/Contents/MacOS/Install Spotify'"
    user WS_USER
    group "admin"
  end

  ruby_block "test to see if Spotify.app was installed" do
    block do
      raise "Spotify.app was not installed" unless File.exists?("/Applications/Spotify.app")
    end
  end

end