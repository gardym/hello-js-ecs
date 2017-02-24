#!/bin/bash
set -x
source ./config

TD_TEMPLATE=taskDefinition.template.json
TD_COMPOSED=taskDefinition.json

sed -e "s#VERSION#$VERSION#g" \
  -e "s#IMAGE#$IMAGE#g" \
  -e "s#ECS_FAMILY#$ECS_FAMILY#g" \
  $TD_TEMPLATE > $TD_COMPOSED

SVC_ARN=$(aws ecs list-services --cluster $CLUSTER_NAME | jaq "serviceArns[0]")

# Push new taskDefinition
NEW_TD_ARN=$(aws ecs register-task-definition \
  --cli-input-json file://$(pwd)/$TD_COMPOSED \
  | jaq "taskDefinition.taskDefinitionArn")

# Stop running tasks
TASK_ID=$(aws ecs list-tasks --cluster $CLUSTER_NAME | jaq "taskArns[0]")
aws ecs update-service --service $SVC_ARN --desired-count 0
aws ecs stop-task --task $TASK_ID

# Update the service to use the new taskDefinition and
# scale it back up to 1 task
aws ecs update-service \
  --service $SVC_ARN \
  --task-definition $NEW_TD_ARN \
  --desired-count 1
