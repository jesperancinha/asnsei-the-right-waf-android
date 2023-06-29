SHELL := /bin/bash
GRADLE_VERSION ?= 8.1.1
MODULE_LOCATIONS := kotlin-keywords-app \
					test-app \
					test-app-2
b: build
build:
	@for location in $(MODULE_LOCATIONS); do \
  		export CURRENT=$(shell pwd); \
  		echo "Building $$location..."; \
		cd $$location; \
		gradle build -x test; \
		cd $$CURRENT; \
	done
upgrade:
	@for location in $(MODULE_LOCATIONS); do \
  		export CURRENT=$(shell pwd); \
  		echo "Upgrading $$location..."; \
		cd $$location; \
		gradle wrapper --gradle-version $(GRADLE_VERSION); \
		cd $$CURRENT; \
	done

upgrade-gradle:
	sudo apt upgrade
	sudo apt update
	export SDKMAN_DIR="$(HOME)/.sdkman"; \
	[[ -s "$(HOME)/.sdkman/bin/sdkman-init.sh" ]]; \
	source "$(HOME)/.sdkman/bin/sdkman-init.sh"; \
	sdk update; \
	gradleOnlineVersion=$(shell curl -s https://services.gradle.org/versions/current | jq .version | xargs -I {} echo {}); \
	if [[ -z "$$gradleOnlineVersion" ]]; then \
		sdk install gradle $(GRADLE_VERSION); \
		sdk use gradle $(GRADLE_VERSION); \
	else \
		sdk install gradle $$gradleOnlineVersion; \
		sdk use gradle $$gradleOnlineVersion; \
		export GRADLE_VERSION=$$gradleOnlineVersion; \
	fi;
	make upgrade
install-linux:
	sudo apt-get install jq
	sudo apt-get install curl
	curl https://services.gradle.org/versions/current
