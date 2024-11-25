# dockware-template

> my shopware development environment.

## Development Links

*Based on dockware [default credentials](https://docs.dockware.io/use-dockware/default-credentials):*

- [localhost](http://localhost/) - Storefront
- [localhost/admin](http://localhost/admin) - Backend
- [localhost/logs](http://localhost/logs) - Logs (see [docs](https://docs.dockware.io/features/pimp-my-log))
- [localhost/adminer.php](http://localhost/adminer.php) - Adminer (see [docs](https://docs.dockware.io/features/adminer))
- [localhost/mailcatcher](http://localhost/mailcatcher) - Mailcatcher (see [docs](https://docs.dockware.io/features/mailcatcher))

## Usage

### Setup

```sh
# execute all initial tasks
make init
```

executes the following tasks:

```sh
# raise the initial docker containers
make init_start

# copy the shopware source
make init_setup

# destroy the initial containers
make init_destroy

# fix permissions
make init_chown

# raise the actual docker containers
make dev_start

# fix permissions
make dev_chown

# fix default language & adminer, install php-cs-fixer
make dev_config

# fix permissions for sure
make dev_chown
```

### Development

```shell
# create a mysql-dump with current timestamp
make dump

# build a theme & clear cache
make build_theme

# build the admin
make build_admin

# build the storefront
make build_storefront
```

#### Speed up compilation

```sh
export SHOPWARE_ADMIN_BUILD_ONLY_EXTENSIONS=1
export DISABLE_ADMIN_COMPILATION_TYPECHECK=1
```
