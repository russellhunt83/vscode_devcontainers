import os
import time

from aws_lambda_powertools.logging import Logger

#Absolutely 100% make sure that all timestamps are handled as UTC
os.environ['TZ'] = "UTC"
time.tzset()

ENVIRONMENT = os.getenv('ENVIRONMENT')
APPLICATION_NAME = os.getenv('APPNAME', "TemplateExample")
AWS_REGION = os.getenv('AWS_REGION','eu-west-2')
AWS_PROFILE = os.getenv('AWS_PROFILE', 'default')
IS_DEV = bool(os.getenv("LOCAL_DEV", "False") == "True")

log_level = os.getenv("LOG_LEVEL", "INFO")
aws_logger = Logger(
    service=APPLICATION_NAME, 
    level=log_level,
)