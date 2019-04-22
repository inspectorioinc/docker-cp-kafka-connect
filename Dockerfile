FROM confluentinc/cp-kafka-connect:5.0.1

RUN confluent-hub install debezium/debezium-connector-mongodb:0.9.2 --no-prompt \
&&  mkdir -p /usr/share/confluent-hub-components/kafka-connect-elasticsearch-source \
&&  wget -q https://github.com/inspectorioinc/kafka-connect-elasticsearch-source/raw/v1.0.1/target/elastic-source-connect-0.4-jar-with-dependencies.jar -O /usr/share/confluent-hub-components/kafka-connect-elasticsearch-source/kafka-connect-elastic-source-connect-0.4.jar \
&& wget -q https://github.com/inspectorioinc/kafka-connect-jdbc/raw/inspectorio-v1.0.1/target/kafka-connect-jdbc-5.0.1-package/share/java/kafka-connect-jdbc/kafka-connect-jdbc-5.0.1.jar -O /usr/share/java/kafka-connect-jdbc/kafka-connect-jdbc-5.0.1.jar
