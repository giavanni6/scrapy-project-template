# Makefile scrapy

PIP=$(VIRTUAL_ENV)/bin/pip
PY=$(VIRTUAL_ENV)/bin/python

.PHONY: all clean env help pep8 project_name project requirements requirements.update

all: help

help:
	@echo '** Makefile **'

project_name:
	@if test "$(n)" = "" ; then echo "Project name is undefined. Set var n with it."; exit 1; fi

startproject: project_name env
	@grep -rl '{{ project_name }}' . --exclude=Makefile | xargs sed -i '' 's/{{ project_name }}/$(n)/g'
	@mv project_name $(n)

env:
	@cp .env-example .env

requirements:
	@$(PIP) install -r requirements.txt

requirements.update:
	@$(PIP) install -U -r requirements.txt

clean:
	@find . -name '*.pyc' -exec rm -f {} \;
	@find . -name 'Thumbs.db' -exec rm -f {} \;
	@find . -name '*~' -exec rm -f {} \;

pep8:
	@pep8 --filename="*.py" --ignore=W --exclude="manage.py,settings.py,migrations" --first --show-source --statistics --count {{ project_name }}
