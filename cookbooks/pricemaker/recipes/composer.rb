include_recipe "pricemaker::php53"

execute "disable detect_unicode configuration" do
    command "echo 'detect_unicode = Off' > /usr/local/etc/php/5.3/conf.d/composer.ini"
    not_if { system("test -f /usr/local/etc/php/5.3/conf.d/composer.ini") }
end

if File.exists?("/usr/local/bin/composer")

    bash "update_composer" do
        user "root"
        cwd "/tmp"
        code <<-EOH
            /usr/local/bin/composer self-update
        EOH
    end

else

    bash "install_composer" do
        user "root"
        cwd "/tmp"
        code <<-EOH
            curl -s https://getcomposer.org/installer | php
            mv composer.phar /usr/local/bin/composer
        EOH
    end

end
