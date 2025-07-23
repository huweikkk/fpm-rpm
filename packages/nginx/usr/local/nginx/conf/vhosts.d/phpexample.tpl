[example]
user=www
group=www
listen = var/run/$pool.socket
pm = dynamic
listen.mode = 0666
pm.start_servers = 1
pm.max_children = 32
pm.min_spare_servers = 1
pm.max_spare_servers = 32
pm.status_path = /status
slowlog = var/log/fpm.$pool.slow.log
request_slowlog_timeout = 10s
;默认代码目录，根据实际情况修改后把注释取消
;chdir = /web/$pool/wwwroot
env[PATH] = /usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
env[TMP] = /tmp
env[TMPDIR] = /tmp
env[TEMP] = /tmp
;默认代码目录，根据实际情况修改后把注释取消
;php_admin_value[open_basedir] = /tmp:phppath/lib:/web/$pool/wwwroot
php_admin_value[error_log] = var/log/fpm.$pool.error.log
