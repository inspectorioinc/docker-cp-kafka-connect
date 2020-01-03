FROM maven:3-jdk-8 as jdbc-builder
WORKDIR /build
# hadolint ignore=DL3003
RUN git clone --depth=1 --recurse-submodules -j8 --branch 5.3.1-post https://github.com/inspectorioinc/kafka-connect-jdbc.git \
&&  cd /build/kafka-connect-jdbc/libs/common \
&&  mvn install -DskipTests \
&&  cd /build/kafka-connect-jdbc \
&&  mvn clean package -DskipTests

FROM maven:3-jdk-8 as es-source-builder
WORKDIR /build
# hadolint ignore=DL3003
RUN git clone --depth=1 --recurse-submodules -j8 https://github.com/inspectorioinc/kafka-connect-elasticsearch-source.git \
&&  cd /build/kafka-connect-elasticsearch-source \
&&  mvn clean package -DskipTests

FROM confluentinc/cp-kafka-connect:5.3.1 as runtime

ENV MONGODB_CONNECTOR_VERSION="0.9.2"
ENV JDBC_CONNECTOR_VERSION="5.3.1"
ENV ES_SOURCE_CONNECTOR_VERSION="0.6"

RUN confluent-hub install debezium/debezium-connector-mongodb:${MONGODB_CONNECTOR_VERSION} --no-prompt \
&&  mkdir -p /usr/share/confluent-hub-components/kafka-connect-elasticsearch-source

COPY --from=jdbc-builder /build/kafka-connect-jdbc/target/kafka-connect-jdbc-${JDBC_CONNECTOR_VERSION}.jar  /usr/share/java/kafka-connect-jdbc/kafka-connect-jdbc-${JDBC_CONNECTOR_VERSION}.jar
COPY --from=es-source-builder /build/kafka-connect-elasticsearch-source/target/elastic-source-connect-${ES_SOURCE_CONNECTOR_VERSION}-jar-with-dependencies.jar /usr/share/confluent-hub-components/kafka-connect-elasticsearch-source/kafka-connect-elastic-source-connect-${ES_SOURCE_CONNECTOR_VERSION}.jar
