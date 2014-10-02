IMAGE=hissohathair/openpds-registry
DOCKER=docker
PORTMAP=8000:8000

help:
	@echo " "
	@echo "Make targets for $(IMAGE):"
	@echo "    build	Build docker build and tag"
	@echo "    push 	Push build to Docker repository"
	@echo "    run  	Start the application"
	@echo "    clean 	Delete the image"
	@echo " "

build: Dockerfile
	$(DOCKER) build -t $(IMAGE) .

run: build
	$(DOCKER) run -p $(PORTMAP) $(IMAGE)

push: build
	$(DOCKER) push $(IMAGE)

clean:
	$(DOCKER) rmi -f $(IMAGE)

