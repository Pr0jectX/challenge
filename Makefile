# Makefile based on https://github.com/nuxis/p0sX-server/blob/master/Makefile
# originally by haavardlian and kradalby under MIT license

ENV=./env/bin
PYTHON=$(ENV)/python3
PIP=$(ENV)/pip
MANAGE=$(PYTHON) manage.py

env:
	python3 -m venv env

celery:
	celery -A challenge worker -l info

run:
	$(MANAGE) runserver 0.0.0.0:8000

clean:
	pyclean .
	find . -name "*.pyc" -exec rm -rf {} \;
	rm -rf *.egg-info

freeze:
	mkdir -p requirements
	$(PIP) freeze > requirements/base.txt

dev:
	$(PIP) install -r requirements/development.txt --upgrade

prod:
	$(PIP) install -r requirements/production.txt --upgrade

migrate:
	$(MANAGE) migrate

collect_static:
	$(MANAGE) collectstatic --noinput --clear --link
