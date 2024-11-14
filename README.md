# dockware-template

> my shopware development environment.

## Development Links

<i>Based on dockware [default credentials](https://docs.dockware.io/use-dockware/default-credentials)</i>:

- [localhost](http://localhost/) - Storefront
- [localhost/admin](http://localhost/admin) - Backend
- [localhost/logs](http://localhost/logs) - Logs (see [docs](https://docs.dockware.io/features/pimp-my-log))
- [localhost/adminer.php](http://localhost/adminer.php) - Adminer (see [docs](https://docs.dockware.io/features/adminer))
- [localhost/mailcatcher](http://localhost/mailcatcher) - Mailcatcher (see [docs](https://docs.dockware.io/features/mailcatcher))

## Usage

### Setup

```sh
# raise the initial docker containers
make init-start

# copy the shopware source
make init-setup

# destroy the initial containers
make init-destroy

# fix permissions
make init-chown

# raise the actual docker containers
make start

# fix permissions for sure
make chown

# fix default language & adminer, install php-cs-fixer
make config
```

### Development

```shell
# create a mysql-dump with current timestamp
make dump

# build a theme & clear cache
make build-theme

# build the admin
make build-admin

# watch the admin
make watch-admin

# build the storefront
make build-storefront

# watch the storefront
make watch-storefront
```

#### Speed up compilation

```sh
export SHOPWARE_ADMIN_BUILD_ONLY_EXTENSIONS=1
export DISABLE_ADMIN_COMPILATION_TYPECHECK=1
```
