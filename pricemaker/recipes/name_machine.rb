if node["name_machine"] then
 ["scutil --set ComputerName #{node["name_machine"]}",
     "scutil --set LocalHostName #{node["name_machine"]}",
     "scutil --set HostName #{node["name_machine"]}",
     "hostname #{node["name_machine"]}",
     "diskutil rename / #{node["name_machine"]}" ].each do |host_cmd|
      execute host_cmd
    end
end