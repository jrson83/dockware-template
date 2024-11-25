# include src/.env.local

# init
init: init_start init_setup init_destroy init_chown

init_start:
	docker compose -f docker-compose.init.yml up -d

init_setup:
	mkdir -p ./src
	docker cp shopware:/var/www/html/. ./src
	cp ./src/.env ./src/.env.local
	rm -rf ./src/compose.yaml ./src/compose.override.yaml ./src/.gitignore ./src/custom/plugins/DockwareSamplePlugin/

init_destroy:
	docker compose -f docker-compose.init.yml down
	docker volume rm -f shopware_shop_volume

init_chown:
	sudo chown -R www-data:www-data .
	sudo setfacl -Rm d:u:dev:rwX,u:dev:rwX .
	sudo setfacl -Rm d:u:www-data:rX,u:www-data:rX .

# dev
dev_start:
	docker compose -f docker-compose.yml up -d

dev_chown:
	docker exec -i shopware bash -c "sudo chown -R www-data:www-data /var/www/html"

dev_config:
	docker exec -it shopware bash -c "echo y | bin/console system:configure-shop --shop-name=Demo --shop-email=demo@jrson.de --shop-locale=de-DE"
	docker exec -it shopware bash -c "sudo composer self-update && sudo composer require --dev friendsofphp/php-cs-fixer"
	docker exec -it shopware bash -c "sudo rm -rf /usr/share/adminer \
	&& sudo mkdir /usr/share/adminer \
	&& sudo wget 'https://github.com/adminerevo/adminerevo/releases/download/v4.8.4/adminer-4.8.4.php' -O /usr/share/adminer/latest.php \
	&& sudo ln -s /usr/share/adminer/latest.php /usr/share/adminer/adminer.php"

dev_stop:
	docker compose -f docker-compose.yml down

dump:
	docker exec -it shopware bash -c 'sudo mysqldump -uroot -proot shopware > /var/backups/mysql/shopware-db-`date +"%Y-%m-%d_%H-%M"`.sql'

plugin_refresh:
	docker exec -it shopware bash -c "bin/console plugin:refresh"

plugin_install:
	docker exec -it shopware bash -c "bin/console plugin:install --activate ProductTabsPlugin \
	&& bin/console cache:clear"

plugin_uninstall:
	docker exec -it shopware bash -c "bin/console plugin:deactivate ProductTabsPlugin \
	&& bin/console plugin:uninstall ProductTabsPlugin \
	&& bin/console cache:clear"

build_admin:
	docker exec -it shopware bash -c "./bin/build-administration.sh"

build_storefront:
	docker exec -it shopware bash -c "./bin/build-storefront.sh"
