#!/usr/bin/env bash
# exit on error

set -o errexit
pip install -r requirements.txt
python manage.py collectstatic --no-input
python manage.py migrate
python manage.py shell -c "from django.contrib.auth import get_user_model; import os; User = get_user_model(); u, _ = User.objects.get_or_create(username=os.environ['DJANGO_SUPERUSER_USERNAME'], defaults={'email': os.environ['DJANGO_SUPERUSER_EMAIL'], 'is_superuser': True, 'is_staff': True}); u.email = os.environ['DJANGO_SUPERUSER_EMAIL']; u.set_password(os.environ['DJANGO_SUPERUSER_PASSWORD']); u.is_superuser = True; u.is_staff = True; u.save()"
