bundle exec middleman build
rm -rf build/2012
rm -rf build/2012.html
s3cmd sync --delete-removed build/ s3://dw.coon-and-friends.com