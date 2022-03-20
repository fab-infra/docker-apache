# Apache HTTPD server based on openSUSE Leap 15.3
FROM ghcr.io/fab-infra/base-image:opensuse15.3

# Environment
ENV APACHE_MPM="worker" \
	APACHE_MODULES="access_compat actions alias auth_basic authn_core authn_file authnz_ldap authz_core authz_groupfile authz_host authz_user autoindex cgi deflate dir env expires filter headers http2 include ldap log_config mime negotiation proxy proxy_ajp proxy_balancer proxy_fcgi proxy_http proxy_wstunnel remoteip reqtimeout rewrite setenvif slotmem_shm socache_shmcb ssl status userdir version vhost_alias" \
	APACHE_SERVER_FLAGS="" \
	APACHE_ACCESS_LOG="/dev/stdout combined" \
	APACHE_ERROR_LOG="/dev/stderr" \
	SERVER_NAME="localhost" \
	SERVER_ENV="production" \
	DEFAULT_DOCROOT="/srv/www/htdocs" \
	LISTEN_HTTP_PORT="8080" \
	LISTEN_HTTPS_PORT="8443"

# Apache HTTPD
RUN zypper in -y apache2 \
	apache2-prefork apache2-worker apache2-event \
	apache2-icons-oxygen \
	apache2-utils &&\
	zypper clean -a

# Files
COPY ./root /
RUN confd -onetime -backend env &&\
	mkdir -p /etc/apache2/sysconfig.d &&\
	chmod -R a+rwX /etc/apache2 /etc/sysconfig/apache2 /var/log/apache2 /var/run &&\
	chmod +x /usr/sbin/start_apache2

# Ports
EXPOSE 8080 8443
