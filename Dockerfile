FROM hseeberger/scala-sbt:8u222_1.3.5_2.12.10 as build
COPY . /delta-sharing
WORKDIR /delta-sharing
RUN sbt server/universal:packageBin

FROM ubuntu:20.04
ENV AWS_ACCESS_KEY_ID xyz
ENV AWS_SECRET_ACCESS_KEY abc
WORKDIR /
RUN apt update && apt install wget unzip openjdk-16-jre-headless -y 
COPY --from=build /delta-sharing/server/target/universal/*.zip .
RUN unzip delta-sharing-server-0.2.0-SNAPSHOT.zip\
 && rm delta-sharing-server-0.2.0-SNAPSHOT.zip
# prepare sources
COPY ["conf/delta-sharing-server.yaml", "/delta-sharing-server-0.2.0-SNAPSHOT/conf"]
ENTRYPOINT ["/delta-sharing-server-0.2.0-SNAPSHOT/bin/delta-sharing-server","--","--conf","/delta-sharing-server-0.2.0-SNAPSHOT/conf/delta-sharing-server.yaml"]