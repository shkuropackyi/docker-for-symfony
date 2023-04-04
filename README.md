## Deployemnt
* Copy `.env.dist` to `.env`
* Set your environment with `.env`
* Put db dumps to `mysql/dumps`
    * Note: make dump with `--databases` parameter or add `CREATE DATABASE` and `USE` statements in the beginning of dump file
* Put your ssl certificates to `nginx/{env}/certs` directory, naming - `cert.pem` and `key.pem` (e.g. to `nginx/dev/certs/cert.pem` and `nginx/dev/certs/key.pem`)
* Run `bin/docker_up.sh`

## Configuration
##### PHP
* Create custom config file in `php/{env}/config` (e.g `75-custom-config.php`) to add own configuration to container
##### Nginx
* You can create custom configuration files in `nginx/{env}/config`. All `*.conf` files from this directory will be imported.
##### MySQL
* You can create custom configuration files in `mysql/config`. All `*.cnf` files from this directory will be imported.

## Hints
#### Useful commands:
* `bin/docker_up.sh` - Docker containers up
* `bin/docker_down.sh` - Docker containers down
* `bin/docker_build.sh` - Docker containers up with containers rebuild

##### Generating trusted ssl certificate for local environment
* `mkcert` tool allow generating trusted localhost ssl certificates
* Install `mkcert`:
`````
wget https://github.com/FiloSottile/mkcert/releases/download/v1.1.2/mkcert-v1.1.2-linux-amd64
mv mkcert-v1.1.2-linux-amd64 mkcert
chmod +x mkcert
cp mkcert /usr/local/bin/
mkcert -install
`````
* Generate certificates:
`````
mkcert "your.domain.local" localhost 127.0.0.1 ::1
`````