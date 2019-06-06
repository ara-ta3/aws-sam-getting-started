PYTHON=python3
SAM=bin/sam

venv: 
	$(PYTHON) -m venv .

$(SAM): bin
	source $</activate && pip install -r requirements.txt

bin: 
	$(MAKE) venv

