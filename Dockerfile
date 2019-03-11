FROM confluentinc/cp-kafka-connect:5.0.1

RUN confluent-hub install debezium/debezium-connector-mongodb:0.9.2 --no-prompt \
&&  confluent-hub install confluentinc/kafka-connect-elasticsearch:4.1.1 --no-prompt
