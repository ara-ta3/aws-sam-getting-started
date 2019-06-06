PYTHON=python3
SAM=bin/sam

venv: 
	$(PYTHON) -m venv .

$(SAM): bin
	source $</activate && pip install sam

bin: venv


