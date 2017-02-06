VERSION = "v0.4.0"
PREFIX ?= /usr/local

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	install -m 0755 ios-viper-wrapper $(DESTDIR)$(PREFIX)/bin/ios-viper

uninstall:
	rm $(DESTDIR)$(PREFIX)/bin/ios-viper
	docker rmi garriguv/ios-viper:$(VERSION)
	docker rmi garriguv/ios-viper:latest

build:
	docker build -t garriguv/ios-viper:$(VERSION) . && \
	docker tag garriguv/ios-viper:$(VERSION) garriguv/ios-viper:latest

publish: build
	docker push garriguv/ios-viper:$(VERSION) && \
	docker push garriguv/ios-viper:latest

.PHONY: build publish
