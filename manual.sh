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


# Configure pipeline resources
fly -t test set-pipeline -c ./pipelines/pipeline-resources.yaml -p pipeline-resources
# Update pipeline resources with trigger to automatically start on new version
fly -t test set-pipeline -c ./pipelines/pipeline-resources_v2.yaml -p pipeline-resources


# Configure pipeline resources
fly -t test set-pipeline -c ./pipelines/task-outputs.yaml -p task-outputs

# Configure pipeline variables and pipeline parameters
fly -t test sp -c ./pipelines/pipeline-parameters.yaml -p pipeline-parameters
# Now set missing variables
fly -t test sp -c ./pipelines/pipeline-parameters.yaml -p pipeline-parameters -v cat-name=garfield -v dog-name=odie


# Configure parameterized resource pipeline
fly -t test sp -c ./pipelines/parameterized-resource-pipeline.yaml -p parameterized-resource-pipeline --load-vars-from ./pipeline-vars/parameterized-resource-pipeline-config.yaml