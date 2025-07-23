server{
        listen          80;
        #listen         443 ssl;
        server_name     example;

        root            /example/public/;    ####代码目录路径
        index           index.html index.htm default.htm index.php;

        access_log      logs/example.access.log main;
        error_log       logs/example.error.log;

        #ssl_certificate     ssl/example//example.crt;
        #ssl_certificate_key ssl/example/example.key;

        ####80跳转到443
        #include    rewrite/http-https.conf;

        ####非www优先
        #include    rewrite/not-www-first.conf;
        
        ####www优先
        #include    rewrite/www-first.conf;

        ####禁止访问 .git、.svn、.hg 目录
        include    rewrite/deny.conf;

        location / {
            if (!-e $request_filename) {
                rewrite ^.*$ /index.php;
            }
        }

        location = /static/ {
               expires 30d;
        }

        location ~ .*\.(?:jpg|jpeg|gif|png|ico|cur|gz|svg|svgz|mp4|ogg|ogv|webm)$ {
                expires      7d;
        }

        location ~ .*\.(css|js)$ {
                expires      7d;
        }

        location ~ \.php$ {
            #fastcgi_pass   unix:/usr/local/php7/var/run/example.socket;
            fastcgi_pass   unix:phppath/var/run/example.socket;
            fastcgi_index  index.php;
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
            include        fastcgi_params;
        }

    }
