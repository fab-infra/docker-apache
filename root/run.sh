#!/bin/sh -e

# Update sysconfig from environment variables
for FILE in /etc/sysconfig/apache2; do
	FILE_TMP=`mktemp`
	cat "$FILE" > "$FILE_TMP"
	grep '^[^#].*=' "$FILE" | while IFS='=' read KEY VALUE; do
		if [ -n "${!KEY+x}" ]; then
			echo "Updating $FILE: $KEY=${!KEY}" 1>&2
			sed -i "s#^$KEY=.*\$#$KEY=\"${!KEY}\"#g" "$FILE_TMP"
		fi
	done
	cat "$FILE_TMP" > "$FILE"
	rm -f "$FILE_TMP"
done

# Generate configuration
confd -onetime -backend env

# Start Apache
exec start_apache2 -DFOREGROUND
