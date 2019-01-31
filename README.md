aws cloudformation create-stack --stack-name milad-test --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" --template-body file://cloudformation-prod.json --parameters ParameterKey=VpcId,ParameterValue=vpc-a93aa6d0 \
ParameterKey=SubnetId,ParameterValue=subnet-1425934e \
ParameterKey=ExecutionRoleArn,ParameterValue='arn:aws:iam::192443709020:role/ecsTaskExecutionRole'