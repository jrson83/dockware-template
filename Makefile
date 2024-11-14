# include src/.env.local

init-start:
	docker compose -f docker-compose.init.yml up -d

init-setup:
	mkdir -p ./src
	docker cp shopware:/var/www/html/. ./src
	cp ./src/.env ./src/.env.local
	rm -rf ./src/compose.yaml ./src/compose.override.yaml ./src/.gitignore

init-destroy:
	docker compose -f docker-compose.init.yml down
	docker volume rm -f shopware_shop_volume
	
init-chown:
	sudo chown -R www-data:www-data .
	sudo setfacl -Rm d:u:dev:rwX,u:dev:rwX .
	sudo setfacl -Rm d:u:www-data:rX,u:www-data:rX .

start:
	docker compose -f docker-compose.yml up -d

chown:
	docker exec -i shopware bash -c "sudo chown -R www-data:www-data /var/www/html"

config:
	docker exec -it shopware bash -c "bin/console system:configure-shop --shop-name=Demo --shop-email=demo@jrson.de --shop-locale=de-DE"
	docker exec -it shopware bash -c "composer require --dev friendsofphp/php-cs-fixer"
	docker exec -it shopware bash -c "sudo rm -rf /usr/share/adminer \
	&& sudo mkdir /usr/share/adminer \
	&& sudo wget 'https://github.com/adminerevo/adminerevo/releases/download/v4.8.4/adminer-4.8.4.php' -O /usr/share/adminer/latest.php \
	&& sudo ln -s /usr/share/adminer/latest.php /usr/share/adminer/adminer.php"

stop:
	docker compose -f docker-compose.yml down

dump:
	docker exec -it shopware bash -c 'sudo mysqldump -uroot -proot shopware > /var/backups/mysql/shopware-db-`date +"%Y-%m-%d_%H-%M"`.sql'

plugin-refresh:
	docker exec -it shopware bash -c "bin/console plugin:refresh"

plugin-install:
	docker exec -it shopware bash -c "bin/console plugin:install --activate SwagTabPlugin \
	&& bin/console cache:clear"

plugin-uninstall:
	docker exec -it shopware bash -c "bin/console plugin:deactivate SwagTabPlugin \
	&& bin/console plugin:uninstall SwagTabPlugin \
	&& bin/console cache:clear"

build-admin:
	docker exec -it shopware bash -c "./bin/build-administration.sh"

watch-admin:
	docker exec -it shopware bash -c "./bin/watch-administration.sh"

build-storefront:
	docker exec -it shopware bash -c "./bin/build-storefront.sh"

watch-storefront:
	docker exec -it shopware bash -c "./bin/watch-storefront.sh"
