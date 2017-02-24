#!/bin/sh
VERSION=10
TD_TEMPLATE=taskDefinition.template.json
TD_COMPOSED=taskDefinition.json

sed s/VERSION/$VERSION/g $TD_TEMPLATE > $TD_COMPOSED

OLD_TD_ARN=$(aws ecs list-task-definitions | jaq "taskDefinitionArns[0]")
SVC_ARN=$(aws ecs list-services | jaq "serviceArns[0]")

# Push new taskDefinition
NEW_TD_ARN=$(aws ecs register-task-definition \
  --cli-input-json file://$(pwd)/$TD_COMPOSED \
  | jaq "taskDefinition.taskDefinitionArn")

# Stop running tasks
aws ecs update-service --service $SVC_ARN --desired-count 0
TASK_ID=$(aws ecs list-tasks | jaq "taskArns[0]")
aws ecs stop-task --task $TASK_ID

# Update the service to use the new taskDefinition and
# scale it back up to 1 task
aws ecs update-service \
  --service $SVC_ARN \
  --task-definition $NEW_TD_ARN \
  --desired-count 1

# Deregister the old task definition
aws ecs deregister-task-definition --task-definition $OLD_TD_ARN
