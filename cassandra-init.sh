cat >/import.cql <<EOF
CREATE KEYSPACE IF NOT EXISTS test_keyspace WITH replication = {'class':'SimpleStrategy','replication_factor':'1'};

USE test_keyspace;

CREATE TABLE test (
	id int,
	value text,
	primary key(id)
);

INSERT INTO test(id, value) Values(1, 'Value 1');
INSERT INTO test(id, value) Values(2, 'Value 2');
INSERT INTO test(id, value) Values(3, 'Value 3');
EOF

# You may add some other conditionals that fits your stuation here
until cqlsh -f /import.cql; do
  echo "cqlsh: Cassandra is unavailable to initialize - will retry later"
  sleep 2
done &

exec /docker-entrypoint.sh "$@"
