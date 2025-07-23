#!/bin/sh

# 设置 nginx 配置文件路径
nginxpath=/usr/local/nginx/conf/vhosts.d
nginxexample="nginxexample.tpl"
phpexample="phpexample.tpl"

# 设置 PHP 配置路径
phppath=""

# 提示用户输入域名
read -p "请输入域名: " wwwname

# 检查是否输入了域名
if [ -z "$wwwname" ]; then
    echo "错误：域名不能为空！请输入一个有效的域名"
    exit 1
fi

# 检查模板文件是否存在
if [ ! -f "$nginxpath/$nginxexample" ]; then
    echo "错误：模板文件 $nginxpath/$nginxexample 不存在！"
    exit 1
fi


# 检查 PHP 配置模板文件是否存在
if [ ! -f "$nginxpath/$phpexample" ]; then
    echo "错误：PHP 配置模板文件 $nginxpath/$phpexample 不存在！"
    exit 1
fi


# 检查目标配置文件是否已经存在
if [ -f "$nginxpath/$wwwname.conf" ]; then
    echo "错误：配置文件 $nginxpath/$wwwname.conf 已经存在！"
    exit 1
fi

# 复制模板文件并替换内容
cp "$nginxpath/$nginxexample" "$nginxpath/$wwwname.conf"

# 使用 sed 替换模板中的 "example" 为传入的域名
sed -i "s/example/${wwwname}/g" "$nginxpath/$wwwname.conf"


# 显示 PHP 版本选择菜单
echo "请选择 PHP 版本："
echo "1) PHP 5.6"
echo "2) PHP 7.0"
echo "3) PHP 7.4"
read -p "请输入 1、2 或 3 来选择 PHP 版本: " phpversion

# 定义一个函数来创建 nginx 和 PHP 配置文件,socket作为函数的返回值
create_nginx_and_php_config() {
    # 获取 PHP 配置路径
    local phppath="$1"
    local socket
    socket=$(echo $phppath | cut -d'/' -f1-4)

    # 创建 PHP 配置文件
    cp "$nginxpath/$phpexample" "$phppath/$wwwname.conf"
    sed -i "s/example/${wwwname}/g" "$phppath/$wwwname.conf"
    
    # 在 nginx 配置文件中替换 phppath
    #sed -i "s/phppath/${socket}/g" "$nginxpath/$wwwname.conf"
    sed -i "s#phppath#${socket}#g" "$nginxpath/$wwwname.conf" "$phppath/$wwwname.conf"
    echo $socket
}

# 根据选择的 PHP 版本设置相应的配置路径
case "$phpversion" in
    "1")
        phppath="/usr/local/php56/etc/fpm.d"
        socket=$(create_nginx_and_php_config "$phppath")
        ;;
    "2")
        phppath="/usr/local/php7/etc/php-fpm.d"
        socket=$(create_nginx_and_php_config "$phppath")
        ;;
    "3")
        phppath="/usr/local/php74/etc/php-fpm.d"
        socket=$(create_nginx_and_php_config "$phppath")
        ;;
    *)
        echo "错误：无效的选择，请选择 1, 2 或 3。"
        exit 1
        ;;
esac

# 输出 PHP 配置路径
echo "新增域名PHP配置文件路径为：$phppath/$wwwname.conf"
echo "新增域名的nginx配置路径为：$nginxpath/$wwwname.conf"
echo "开始检查nginx+php-fpm配置文件是正确，重载请用命令:systemctl reload nginx php-fpm*"

# 检查 nginx  php-fpm配置文件的语法是否正确
/usr/local/nginx/sbin/nginx -t
NGINX_STATUS=$?

# 检查 php-fpm 配置文件的语法是否正确
$socket/sbin/php-fpm -t
PHPFPM_STATUS=$?

# 如果任何一个配置文件有错误，输出错误信息并退出
if [ $NGINX_STATUS -ne 0 ] || [ $PHPFPM_STATUS -ne 0 ]; then
    echo "错误：nginx 或 php-fpm 配置验证失败，请检查配置文件。"
    exit 1
fi
