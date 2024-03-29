[![build](https://github.com/fab-infra/docker-apache/actions/workflows/build.yml/badge.svg)](https://github.com/fab-infra/docker-apache/actions/workflows/build.yml)

# Apache HTTPD Docker image

## Ports

The following ports are exposed by this container image.

| Port | Description |
| ---- | ----------- |
| 8080 | HTTP port |
| 8443 | HTTPS port |

## Environment variables

The following environment variables can be used with this container.

| Variable | Description | Default value |
| -------- | ----------- | ------------- |
| APACHE_MPM | Multi-Processing Module (prefork, worker, event) | worker |
| APACHE_MODULES | Modules to enable (space-separated) | (see Dockerfile) |
| APACHE_SERVER_FLAGS | Flags to enable (space-separated) | |
| APACHE_ACCESS_LOG | Access log location and format | /dev/stdout combined |
| APACHE_ERROR_LOG | Error log location | /dev/stderr |
| SERVER_NAME | Server host name | localhost |
| SERVER_ENV | Server environment | production |
| DEFAULT_DOCROOT | Document root of the default virtual host | /srv/www/htdocs |
| LISTEN_HTTP_PORT | HTTP port to listen to | 8080 |
| LISTEN_HTTPS_PORT | HTTPS port to listen to | 8443 |

## Volumes

The following container paths can be used to mount a dedicated volume or to customize configuration.

| Path | Description |
| ---- | ----------- |
| /etc/apache2/vhosts.d | Virtual hosts configuration (*.conf files) |
| /srv/www/htdocs | Default document root |

## Useful links

- [Apache HTTPD documentation](https://httpd.apache.org/docs/2.4/)
