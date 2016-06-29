DOCKER_IMAGE_NAME = statuspage

all: osx linux

osx:
	pip install -r requirements/base.txt
	pip install -r requirements/dev.txt
	pyinstaller statuspage.spec
	mv dist/statuspage dist/statuspage_osx

linux:

	docker run -e LC_ALL="C.UTF-8" -e LANG="C.UTF-8" -v $(shell pwd):/app -w=/app -it python:3.5 bash -c "pip install -r requirements/base.txt && pip install -r requirements/dev.txt && pyinstaller statuspage.spec"
	mv dist/statuspage dist/statuspage_linux


alpine:
	@cp -v ./requirements/base.txt ./requirements.txt
	docker run --rm -v ${PWD}:/src six8/pyinstaller-alpine --noconfirm --onefile --log-level DEBUG --clean statuspage.py
	@rm -v ./requirements.txt
	@echo "Your binary for Alpine Linux is now ready:"
	@ls -lh ./dist/statuspage

docker-alpine: #alpine
	docker build -t $(DOCKER_IMAGE_NAME) .
	docker images $(DOCKER_IMAGE_NAME)

