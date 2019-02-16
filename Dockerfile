# Apache HTTPD server based on openSUSE Leap 15
FROM fcrespel/base-image:opensuse15

# Arguments
ARG HTTPD_MPM="worker"
ARG HTTPD_MODULES="access_compat authnz_ldap deflate filter headers http2 ldap proxy proxy_ajp proxy_balancer proxy_fcgi proxy_http proxy_wstunnel remoteip rewrite slotmem_shm status version vhost_alias"
ARG HTTPD_FLAGS="HTTP2"

# Apache HTTPD
RUN zypper in -y apache2 \
	apache2-prefork apache2-worker apache2-event \
	apache2-icons-oxygen \
	apache2-utils \
	check-create-certificate &&\
	zypper clean -a

# Configuration
RUN sysconf_addword /etc/sysconfig/apache2 APACHE_MPM ${HTTPD_MPM} &&\
	for MODULE in ${HTTPD_MODULES}; do a2enmod $MODULE; done &&\
	for FLAG in ${HTTPD_FLAGS}; do a2enflag $FLAG; done

# Files
COPY ./root /
RUN chmod +x /run.sh &&\
	confd -onetime -backend env &&\
	mkdir -p /etc/apache2/sysconfig.d &&\
	chmod -R a+rwX /etc/apache2/conf.d /etc/apache2/sysconfig.d /var/log/apache2 /var/run &&\
	chmod +x /usr/sbin/start_apache2

# Ports
EXPOSE 8080
