
import json

from aws_lambda_powertools.utilities.typing import LambdaContext
from aws_lambda_powertools.utilities.data_classes import SNSEvent

from app import aws_logger

def lambda_handler(incoming_notification: dict, context: LambdaContext):
    """
    Entrypoint for lambda; iterates message payload from SNS. Normally there should only be 1 record in an SNS message
    """
    notification:SNSEvent = SNSEvent(incoming_notification)
    
    for r in notification.records: 
        aws_logger.info(json.dumps(r.sns.message))

    return