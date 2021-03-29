rake db:migrate 2>/dev/null || rake db:create db:migrate

echo 'Postgres database has been created and migrated!'

/bin/sh
