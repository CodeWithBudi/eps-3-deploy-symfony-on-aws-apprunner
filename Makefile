docker-build-prod:
	docker build -t CodeWithBudi/eps-3-deploy-symfony-on-aws-apprunner-prod .
	docker image ls CodeWithBudi/eps-3-deploy-symfony-on-aws-apprunner-prod
docker-run-prod:
	docker run --rm -p 8080:80 CodeWithBudi/eps-3-deploy-symfony-on-aws-apprunner-prod
