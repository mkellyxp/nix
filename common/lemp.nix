{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        php80
	    nodejs
    ];

    networking.extraHosts = ''
        127.0.0.1   www.course.local
        127.0.0.1   www.admin.local
        127.0.0.1   www.public.local
        127.0.0.1	www.dad.local
    '';

    services.mysql = {
  	    enable = true;
  	    package = pkgs.mariadb;
    };

    services.nginx = {
  	    enable = true;
	    virtualHosts."www.admin.local" = {
		    root = "/var/www/vip_member_vault_admin";
		    locations."= /" = {
                extraConfig = ''
                    rewrite ^ /index.php;
              	'';
            };
		    locations."/".extraConfig = ''
			    try_files $uri $uri/ /index.php?$query_string;
		    '';
		    locations."~ \.php$".extraConfig = ''
			    fastcgi_pass  unix:${config.services.phpfpm.pools.mypool.socket};
			    fastcgi_index index.php;
		    '';
	    };

	    virtualHosts."www.course.local" = {
		    root = "/var/www/vip_member_vault";
		    locations."= /" = {
                extraConfig = ''
                    rewrite ^ /index.php;
              	'';
          	};
		    locations."/".extraConfig = ''
			    try_files $uri $uri/ /index.php?$query_string;
		    '';
		    locations."~ \.php$".extraConfig = ''
			    fastcgi_pass  unix:${config.services.phpfpm.pools.mypool.socket};
			    fastcgi_index index.php;
		    '';
	    };

	    virtualHosts."www.public.local" = {
		    root = "/var/www/public_site_2023";
		    locations."= /" = {
                extraConfig = ''
                	rewrite ^ /index.php;
              	'';
          	};
		    locations."/".extraConfig = ''
			    try_files $uri $uri/ /$uri.php;
		    '';
		    locations."~ \.php$".extraConfig = ''
			    fastcgi_pass  unix:${config.services.phpfpm.pools.mypool.socket};
			    fastcgi_index index.php;
		    '';
	    };
    };

    services.phpfpm = {
  	    pools.mypool = {
		    phpPackage = pkgs.php80;
  		    user = "nobody";
		    settings = {
			    pm = "dynamic";
			    "listen.owner" = config.services.nginx.user;
			    "pm.max_children" = 5;
			    "pm.start_servers" = 2;
			    "pm.min_spare_servers" = 1;
			    "pm.max_spare_servers" = 3;
			    "pm.max_requests" = 500;
		    };
  	    };
    };

}

## NOTES ##
#
# To set mysql password
#	sudo mysql -uroot
# 	ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyN3wP4ssw0rd';
#	flush privileges;
#	exit;
#
# Create www folder in /var, then
#   sudo chown -R nginx:nginx www
#   sudo chomd 755 www
#
# Add your user to the nginx group in config like:
#   users.users.mkelly = {
#       isNormalUser = true;
#       description = "Mike Kelly";
#       extraGroups = [ "networkmanager" "wheel" "video" "nginx" ];
#        packages = with pkgs; [];
#   };