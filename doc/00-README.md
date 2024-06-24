# EPS 3 Deploy Symfony Application on AWS AppRunner

## Problems
1. AppRunner build didn't support to modify webserver for rewrite URL.
2. I don't want to learn another tech like `setup.sh` or `supervisord`.

## Possible Solution
Use Docker Image to deploy Symfony Application on AWS AppRunner.

### Pros
1. I have full control.
2. Faster deployment, since it only load image, no build needed. From 10 minutes to 3 minutes.
3. Familiar with Docker. No need to learn another tech.

### Cons
1. Need to pay for ECR (Elastic Container Image). Image size 200Mb. Cost $0.10/GB/month.
2. Need to build the image myself locally. Can be mitigated with AWS CodeBuild.
