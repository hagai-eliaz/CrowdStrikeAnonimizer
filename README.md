# CrowdStrikeAnonimizer
Anonymizes device and policy data from CrowdStrike with logstash

# Instructions
Run logstash with docker
```
docker-compose up
```
Relevant Crowdstrike json data goes in the "input" folder whoch is created by docker
Output can be viewed in the "output" folder
You may need to change the elastic host address in the pipeline files
