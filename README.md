# cassandra-monitoring-by-ELK
Monitoring cassandra cluster by ELK (Elasticsearch , logstach and Kibana) 
#Overview
Many organisation used cassandra as NoSQL database to handle large amount of data. so its necessary to monitor health of cassandra clusters. Cassandra is a famous NoSQL database and there is no any free monitoring tool  available. 
ELK is a good solution for this and provide real time monitoring of clusters nodes.

#Key features
*	Real time monitoring of cluster nodes status
*	CPU statistics.
*	Load on Cluster Nodes
*	Memory statistics
*	Process Status
*	Input/output statistics
*	Pending tasks
*	Read latency
*	Write latency

#How to install
* Install all dashboards from dashboard folder in your Kibana
* Install/Run all scripts under scripts folder in your each node of cluster and run cassandra_perf.sh script in cron and send data to Logstash server
* Install/Run cassandra.conf in your Logstash server and send data to elasticsearch server 
