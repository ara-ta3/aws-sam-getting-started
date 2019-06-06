PYTHON=python3
SAM=bin/sam
YARN=yarn
AWS=bin/aws
LambdaFunctionName=hello-lambda
LambdaIAMRoleArn=

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

$(AWS): bin
	source $</activate && pip install -r requirements.txt

bin: 
	$(MAKE) venv

zip: install
	zip -r dist/app.zip src/ node_modules

dist/app.zip:
	$(MAKE) zip

lambda/create: dist/app.zip
	$(AWS) lambda create-function \
		--function-name $(LambdaFunctionName) \
		--runtime nodejs10.x \
		--role $(LambdaIAMRoleArn) \
		--handler src/app.lambdaHandler \
		--zip-file fileb://./$<

lambda/update: dist/app.zip
	$(AWS) lambda update-function-code --function-name $(LambdaFunctionName) \
		--zip-file fileb://./$<
