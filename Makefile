all:
	docker build -f Dockerfile.build -t tinybuild:alpine .
	docker create --name result tinybuild:alpine .
	docker cp result:/hello .
	docker rm -f result
	docker rmi -f tinybuild:alpine
	docker build -t tiny .
	docker run --rm tiny

clean:
	-rm -f hello
	-docker rmi -f tiny 2> /dev/null
