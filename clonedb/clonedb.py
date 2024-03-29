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
    
def copy_latest_snapshot(db_identifier, client, waiter):
    #timestamp = '{:%Y%m%d-%H%M%S}'.format(datetime.datetime.now())
    snapshot_copy = f"snapshot-copy{time_stamp}"
    #logger.info(f"Find latest snapshot of: {db_identifier}")
    response = client.describe_db_snapshots(DBInstanceIdentifier=db_identifier, SnapshotType='automated')
    sorted_keys = sorted(response['DBSnapshots'], key=itemgetter('SnapshotCreateTime'), reverse=True)
    snapshot_id = sorted_keys[0]['DBSnapshotIdentifier']
    DBSnapshotId = sorted_keys[0]['DBSnapshotArn']
    #logger.info(f"Wait for snapshot: {snapshot_id}")
    waiter.wait(
        DBInstanceIdentifier=db_identifier,
        DBSnapshotIdentifier=snapshot_id,
        WaiterConfig={'Delay': 5, 'MaxAttempts': 12}
    )
    #logger.info(f"Create snapshot copy: {snapshot_copy} of {db_identifier}")
    client.copy_db_snapshot(
        SourceDBSnapshotIdentifier=snapshot_id,
        TargetDBSnapshotIdentifier=snapshot_copy,
    )
    #pprint(logger.info)
    return snapshot_copy, snapshot_id, response, DBSnapshotId

def share_copy_snapshot(db_identifier, snapshot_id, nonprodaccount, client, waiter):
        #max_wait = int(os.environ.get("MAX_WAIT"))
        #max_att = int(max_wait / 5)
        #logger.info(f"Wait for snapshot: {snapshot_id}")
        waiter.wait(
            DBInstanceIdentifier=db_identifier,
            DBSnapshotIdentifier=snapshot_id,
            WaiterConfig={'Delay': 10, 'MaxAttempts': 100}
        )
        #shared_account = os.environ.get("SHARED_ACCOUNT")
        #logger.info(f"Share snapshot: {snapshot_id} of {db_identifier}")
        client.modify_db_snapshot_attribute(
            DBSnapshotIdentifier=snapshot_id,
            AttributeName="restore",
            ValuesToAdd=[nonprodaccount]
        )

def get_latest_snapshot_arn(client, db_identifier):
    response = client.describe_db_snapshots(
        DBSnapshotIdentifier=db_identifier,        
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
    input_nonprod_account = '940330411695'
    input_prod_account = '147884775654'
    
    # Check instance environment
    if input_environemnt == "DR":
      region = 'us-gov-east-1'
    else:
      region = 'us-gov-west-1'

    ####From Prod AWS
    # grab temp keys for Prod
    temp_key, temp_secret, temp_token = assume_role(input_prod_arn, region)
    pprint(temp_key)
    pprint(temp_secret)
    pprint(temp_token)


    # connect rds client
    client = rds_client(temp_key, temp_secret, temp_token, input_db_name, region)
    waiter = client.get_waiter('db_snapshot_available')
    
    #list snapshots 
    list_snapshots = client.describe_db_snapshots(
                    DBInstanceIdentifier=input_db_name
                )
    
    #copy DB snapshot
    snapshot_copy, snapshot_id, response, DBSnapshotId = copy_latest_snapshot(input_db_name, client, waiter)
    share_snapshot = share_copy_snapshot(input_db_name, snapshot_copy, input_nonprod_account, client, waiter)
    
    
    #get_latest_snapshot_arn(client)
    #pprint(return_snapshot)
    #pprint(return_snapshot)
    #pprint(snapshot_copy)
    #pprint('snapshotID')
    #pprint(DBSnapshotId)
    #pprint(logger.info)
    DBSnapshotArn = "arn:aws-us-gov:rds:" + region + ":" + input_prod_account + ":snapshot:" + snapshot_copy
    #arn:aws-us-gov:rds:us-gov-west-1:147884775654:snapshot:snapshot-copy20210813-190203
    pprint(DBSnapshotArn)

     ##Connect to nonprod account
    temp_key, temp_secret, temp_token = assume_role(input_nonprod_arn, region)
    client = rds_client(temp_key, temp_secret, temp_token, input_db_name, region)
    
    #pprint(temp_key)
    #pprint(temp_secret)
    #pprint(temp_token)
    
    response, snapshot_arn = get_latest_snapshot_arn(client, DBSnapshotArn)
    #response, snapshot_arn = get_latest_snapshot_arn(client, input_db_name)
    #pprint(response)
    pprint(snapshot_arn)




if __name__ == "__main__":
    main()
