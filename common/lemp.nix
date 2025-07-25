{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
    	php82
		mysql80
	    nodejs
		nodePackages.intelephense
		nodePackages.typescript-language-server
		nodePackages.prettier
		vscode-langservers-extracted
		tailwindcss-language-server
    ];

    networking.extraHosts = ''
		127.0.0.1	course.local
      	127.0.0.1   www.course.local
		127.0.0.1   www.course2.local
      	127.0.0.1   www.admin.local
      	127.0.0.1   www.public.local
      	127.0.0.1	www.dad.local
      	127.0.0.1	www.design.local
      	127.0.0.1	www.udon.local
		127.0.0.1	www.upcycle.local
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

		virtualHosts."course.local" = {
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

		virtualHosts."www.course2.local" = {
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
                rewrite ^/(.*)/$ /$1 permanent;
			    try_files $uri $uri/ /$uri.php;
		    '';
		    locations."~ \.php$".extraConfig = ''
			    fastcgi_pass  unix:${config.services.phpfpm.pools.mypool.socket};
			    fastcgi_index index.php;
		    '';
	    };

	    virtualHosts."www.upcycle.local" = {
		    root = "/var/www/upcyclecomputers";
		    locations."= /" = {
                extraConfig = ''
                	rewrite ^ /index.php;
              	'';
          	};
		    locations."/".extraConfig = ''
                rewrite ^/(.*)/$ /$1 permanent;
			    try_files $uri $uri/ /$uri.php;
		    '';
		    locations."~ \.php$".extraConfig = ''
			    fastcgi_pass  unix:${config.services.phpfpm.pools.mypool.socket};
			    fastcgi_index index.php;
		    '';
	    };

	    virtualHosts."www.design.local" = {
		    root = "/var/www/membervault-html/public/admin";
		    locations."= /" = {
                extraConfig = ''
                	rewrite ^ /index.php;
              	'';
          	};
		    locations."~ \.php$".extraConfig = ''
			    fastcgi_pass  unix:${config.services.phpfpm.pools.mypool.socket};
			    fastcgi_index index.php;
		    '';
	    };
			
	    virtualHosts."www.udon.local" = {
		    root = "/var/www/udon";
		    locations."= /" = {
                extraConfig = ''
                	rewrite ^ /index.php;
              	'';
          	};
		    locations."~ \.php$".extraConfig = ''
			    fastcgi_pass  unix:${config.services.phpfpm.pools.mypool.socket};
			    fastcgi_index index.php;
		    '';
	    };
    };

			

    services.phpfpm = {
  	    pools.mypool = {
		    	phpPackage = (pkgs.php82.withExtensions({ enabled, all }: enabled ++ [ all.tidy ]));
  		    user = "nobody";
					phpOptions = ''
			      upload_max_filesize = 512M
			      post_max_size = 512M
			      memory_limit = 512M
			      '';	
					
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
#   sudo chmod -R 775 www
#
# Add your user to the nginx group in config like:
#   users.users.mkelly = {
#       isNormalUser = true;
#       description = "Mike Kelly";
#       extraGroups = [ "networkmanager" "wheel" "video" "nginx" ];
#        packages = with pkgs; [];
#   };
#
# To see your nginx config put together
#	less $(systemctl cat nginx | grep -m 1 -o '/nix/store/[0-9a-z]*-nginx.conf')
