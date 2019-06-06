PYTHON=python3
SAM=bin/sam
YARN=yarn

install:
	$(YARN) install

run/local: $(SAM) install
	$(SAM) local invoke HelloWorldFunction --event event.json

run/local/api: $(SAM) install
	@echo open http://localhost:3000/hello
	$(SAM) local start-api

test: install
	$(YARN) test

venv: 
	$(PYTHON) -m venv .

$(SAM): bin
	source $</activate && pip install -r requirements.txt

bin: 
	$(MAKE) venv

