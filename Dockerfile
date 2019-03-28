FROM confluentinc/cp-kafka-connect:5.0.1

RUN confluent-hub install debezium/debezium-connector-mongodb:0.9.2 --no-prompt \
&&  mkdir -p /usr/share/confluent-hub-components/kafka-connect-elasticsearch-source \
&&  wget -q https://github.com/NGL91/kafka-connect-elasticsearch-source/raw/master/target/elastic-source-connect-0.4-jar-with-dependencies.jar -O /usr/share/confluent-hub-components/kafka-connect-elasticsearch-source/kafka-connect-elastic-source-connect-0.4.jar


