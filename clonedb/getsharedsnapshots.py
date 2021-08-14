import boto3
import time
#import logging
#import os
#import sys
from operator import itemgetter
from pprint import pprint

# grab current time for role and DB Snapshot names
time_stamp = time.strftime("%Y%m%d-%H%M%S")
#logger = logging.getLogger(name=__name__)
#env_level = os.environ.get("LOG_LEVEL")
#log_level = logging.INFO if not env_level else env_level
#logger.setLevel(log_level)

#logging.basicConfig(stream=sys.stdout, level=logging.DEBUG)

def assume_role(role_arn, region):
    """Grabs temporary keys of assumed roles from ARN

    Args:
        role_arn: ARN of the role you want to assume
        region: AWS Region based on Environment selected input_Environemnt

    Returns:
        temp_key: Temporary key for assumed role
        temp_secret: Temporary secret key for assumed role
    """

    # set resource and region
    client = boto3.client(
        'sts',
        region_name = region
        )

    response = client.assume_role(
        RoleArn=role_arn,
        RoleSessionName='RDSTask' + time_stamp
        )

    temp_key = response['Credentials']['AccessKeyId']
    temp_secret = response['Credentials']['SecretAccessKey']
    temp_token = response['Credentials']['SessionToken']

    return temp_key, temp_secret, temp_token


def rds_client(temp_key, temp_secret, temp_token, db_name, region):
    
    # set resource and region
    client = boto3.client(
        'rds',
        region_name = region,
        aws_access_key_id = temp_key,
        aws_secret_access_key = temp_secret,
        aws_session_token = temp_token
        )
    
    return client

    #sorted_keys = sorted(list_snapshots['DBSnapshots'], key=itemgetter('SnapshotCreateTime'), reverse=True)
    #snapshot_arn = sorted_keys[0]['DBSnapshotArn']
    #dbsnapshotidentifier = sorted_keys[0]['DBSnapshotIdentifier']
    #pprint(dbsnapshotidentifier)
    #pprint(list_snapshots)
    


def get_latest_snapshot_arn(client, db_identifier):
    response = client.describe_db_snapshots(
        DBSnapshotIdentifier="arn:aws-us-gov:rds:us-gov-west-1:147884775654:snapshot:snapshot-copy20210814-045953",        
        IncludeShared=True,
        SnapshotType="shared",
    )
    #if not response['DBSnapshots']:
    #    return 
    sorted_keys = sorted(response['DBSnapshots'], key=itemgetter('SnapshotCreateTime'), reverse=True)
    snapshot_arn = sorted_keys[0]['DBSnapshotArn']
    return response, snapshot_arn
    

    
def main():

    # grab inputs from morpheus dictory
    input_prod_arn = 'arn:aws-us-gov:iam::147884775654:role/AWSCrossAccountRoleForTerraform'  #morpheus['customOptions']['RDSRoleARN']
    input_nonprod_arn = 'arn:aws-us-gov:iam::940330411695:role/AWSCrossAccountRoleForTerraform'  #morpheus['customOptions']['RDSRoleARN']
    #input_task = 'test' #morpheus['customOptions']['RDSTask']
    input_db_name = 'boyd881211'  #morpheus['customOptions']['RDSInstance']
    input_environemnt = 'Prod' #morpheus['customOptions']['RDSENV']
    input_nonprod_accout = '940330411695'
    
    # Check instance environment
    if input_environemnt == "DR":
      region = 'us-gov-east-1'
    else:
      region = 'us-gov-west-1'

    #pattern = "iam::(.*?):role"
    myString=input_prod_arn[input_prod_arn.find("iam::")+5:input_prod_arn.find(":role")]
    pprint(myString)
    #substring = re.search('iam::(.*):role', s)
    #pprint(substring.group(1))
    ####From Prod AWS
    # grab temp keys for Prod
    temp_key, temp_secret, temp_token = assume_role(input_nonprod_arn, region)
    #pprint(temp_key)
    #pprint(temp_secret)
    #pprint(temp_token)


    # connect rds client
    client = rds_client(temp_key, temp_secret, temp_token, input_db_name, region)
    #waiter = client.get_waiter('db_snapshot_available')
    
    #list snapshots 
    
    
    #copy DB snapshot
    
    response, snapshot_arn = get_latest_snapshot_arn(client, input_db_name)
    pprint(response)
    pprint(snapshot_arn)
    #pprint(return_snapshot)
    #pprint(return_snapshot)
    #pprint(snapshot_copy)
    #pprint(logger.info)
    
if __name__ == "__main__":
    main()
