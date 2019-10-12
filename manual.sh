#!/usr/bin/env bash

# Start Concourse using DOcker Compose
docker-compose -f ./concourse/docker-compose.yml up -d

# Add target
fly --target test login --concourse-url http://localhost:8080 -u test -p test

# Show target config
cat ~/.flyrc

# Configure basic pipeline and login to Concourse
fly -t test set-pipeline -c ./pipelines/basic-pipeline.yaml -p hello-world

# Update basic pipeline
fly -t test set-pipeline -c ./pipelines/basic-pipeline_v2.yaml -p hello-world