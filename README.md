```
fpm -s dir \
  -C /data/fpm/packages/nginx \
  -t rpm \
  -n nginx \
  -v "1.26.2" \
  --after-install /data/fpm/packages/scripts/after-install-nginx.sh \
  --before-remove /data/fpm/packages/scripts/before-remove-nginx.sh \
  -f \
  -p /data/fpm/packages/output/


fpm -s dir \
  -C /data/fpm/packages/redis \
  -t rpm \
  -n redis \
  -v "5.0.14" \
  --after-install /data/fpm/packages/scripts/after-install-redis.sh \
  --before-remove /data/fpm/packages/scripts/before-remove-redis.sh \
  -f \
  -p /data/fpm/packages/output/


fpm -s dir \
  -C /data/fpm/packages/php56/ \
  -t rpm \
  -n php56 \
  -v "5.6.33" \
  --after-install /data/fpm/packages/scripts/after-install-php56.sh \
  --before-remove /data/fpm/packages/scripts/before-remove-php56.sh	 \
  --depends libtool-ltdl \
  --depends libtool-ltdl-devel \
  -f \
  -p /data/fpm/packages/output/


fpm -s dir \
  -C /data/fpm/packages/php74/ \
  -t rpm \
  -n php74 \
  -v "7.4.33" \
  --after-install /data/fpm/packages/scripts/after-install-php74.sh \
  --before-remove /data/fpm/packages/scripts/before-remove-php74.sh	 \
  --depends libwebp \
  --depends libjpeg \
  --depends oniguruma \
  --depends oniguruma-devel \
  --depends libicu \
  --depends c-ares \
  -f \
  -p /data/fpm/packages/output/



  fpm -s dir \
  -C /data/fpm/packages/php7/ \
  -t rpm \
  -n php71 \
  -v "7.1.15" \
  --after-install /data/fpm/packages/scripts/after-install-php7.sh \
  --before-remove /data/fpm/packages/scripts/before-remove-php7.sh \
  --depends libwebp \
  --depends libjpeg \
  --depends oniguruma \
  --depends oniguruma-devel \
  --depends libicu \
  --depends c-ares \
  -f \
  -p /data/fpm/packages/output/



fpm -s dir \
  -C /data/fpm/packages/mysql/ \
  -t rpm \
  -n mysql \
  -v "5.7.27" \
  --after-install /data/fpm/packages/scripts/after-install-mysql.sh \
  --before-remove /data/fpm/packages/scripts/before-remove-mysql.sh \
  --depends libaio \
  -f \
  -p /data/fpm/packages/output/
```