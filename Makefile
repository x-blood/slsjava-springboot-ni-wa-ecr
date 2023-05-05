STACK_NAME=slsjava-springboot-ni-wa-ecr

build-native-image:
	./mvnw -Pnative native:compile

sam-build:
	aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws
	sam build --use-container

sam-deploy-guided:
	sam deploy --guided --stack-name ${STACK_NAME}

sam-deploy:
	sam deploy
