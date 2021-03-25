rake db:migrate 2>/dev/null || rake db:create

echo 'Postgres database has been created and migrated!'

/bin/sh
