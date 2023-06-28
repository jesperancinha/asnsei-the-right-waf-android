include ../../../Makefile

b: build-gradle-report
build-gradle:
	./gradlew build test
build-wrapper:
	gradle wrapper --gradle-version $(GRADLE_VERSION);
build-gradle-report: build-wrapper build-gradle
