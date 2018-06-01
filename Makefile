build:
	docker build -t dougbtv/multus-node .

tag:
	docker tag dougbtv/multus-node dougbtv/multus-node:v3.9
	docker tag dougbtv/multus-node dougbtv/multus-node:v3.9.0

push:
	docker push dougbtv/multus-node:latest
	docker push dougbtv/multus-node:v3.9
	docker push dougbtv/multus-node:v3.9.0
