FROM docker.elastic.co/logstash/logstash:7.6.1
RUN rm -f /usr/share/logstash/pipeline/logstash.conf
ADD pipeline/ /usr/share/logstash/pipeline/
ADD config/ /usr/share/logstash/config/

logstash:
image: docker.elastic.co/logstash/logstash:7.6.1
networks:
elastic:
aliases:
- "logstash"
ipv4_address: 172.16.254.111
logging:
driver: "json-file"
options:
max-size: "10m"
max-file: "1"
depends_on: 
- node-01
- node-02
volumes: 
- "./logstash/config/:/usr/share/logstash/config/"
