# aws-alexa-brookfield-ymca
This is an Alexa skill based https://github.com/alexa/skill-sample-python-fact. 

Along with an Alexa Skill in the Alexa Developer Portal you can ask Brookfield YMCA for the Flowrider schedule. The Python Lambda function uses the requests library to read the schedule api and extract the schedule for the FlowRider. You can ask Brookfield YMCA what is the flowrider schedule today, or ask what the schedule is on a specific date.

I built this project to learn to create an Alexa skill and to improve my Python and Terraform.

This source is not complete

## TO DO
- Create CircleCI config.yml
- Implement the S3 backend
- Clean up unnecessary code in lambda_function.py related to the fact skill