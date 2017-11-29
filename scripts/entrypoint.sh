#!/bin/bash
echo "Starting the Azizi AMP Application!"

echo "Wait for DB server to be ready"
/opt/scripts/waitforit.sh "${MYSQL_HOST}:3306"

python /opt/azizi_amp/manage.py makemigrations b3africa
python /opt/azizi_amp/manage.py makemigrations vendor
python /opt/azizi_amp/manage.py migrate
python /opt/azizi_amp/manage.py migrate --run-syncdb

echo "Create the django super user"
echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'info@badili.co.ke', 'Innovate254')" | python /opt/azizi_amp/manage.py shell

echo "Create a default mapped database and import the schema"
mysql -u root -padmin -h azizi-amp-db -e "create database axgg"
mysql -u root -padmin -h azizi-amp-db axgg < /opt/azizi_amp/axgg.sql

echo "Start the server"
python /opt/azizi_amp/manage.py runserver 0.0.0.0:8089