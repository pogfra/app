#!/bin/bash
set -e

# override documentroot and servername in apache vhost
sed -ri -e "s#/var/www/html#/var/www/dev/$PROJECT/web\n\tServerName $PROJECT.dev.local\n\tServerAlias *.$PROJECT.dev.local#" /etc/apache2/sites-available/000-default.conf

# run original entrypoint
apache2-foreground
