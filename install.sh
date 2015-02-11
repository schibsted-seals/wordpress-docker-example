#!/bin/sh

wp db reset --yes --allow-root
wp core install --title='STP Blog' --admin_user=admin --admin_password=123 --admin_email=admin@wordpress-example.com --allow-root
cat ./fixtures/posts/post1.txt | wp post generate --count=50 --post_content --allow-root
