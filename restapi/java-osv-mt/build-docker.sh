mvn package
docker build . -t tg/java-rest-mt
docker save -o ../container/java-rest-mt.tar tg/java-rest-mt
