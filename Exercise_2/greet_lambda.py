import os

def lambda_handler(event, context):
    os.environ['greeting'] = 'greeting'
    return "{} from Lambda!".format(os.environ['greeting'])
