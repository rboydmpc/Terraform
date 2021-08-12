import boto3
import datetime
import logging
import os
from operator import itemgetter
from pprint import pprint

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

def rds_service(temp_key, temp_secret, temp_token, task, db_name, region):
    """    Sends Boto3 tasks based on task input

    Args:
        temp_key: Temporary key from assume_role function
        temp_secret: Temporary secret ket from assume_role function
        temp_token: Temporary session token from the assume_role function
        task: Input task to run corresponding Boto3 task
        db_name: Name of RDS to run task against
        region: AWS Region based on Environment selected input_Environemnt

    Returns:
        AWS JSON message
    """    

    
    # set resource and region
    client = boto3.client(
        'rds',
        region_name = region,
        aws_access_key_id = temp_key,
        aws_secret_access_key = temp_secret,
        aws_session_token = temp_token
        )
    
    list_snapshots = client.describe_db_snapshots(
                    DBInstanceIdentifier=db_name
                )

    #sorted_keys = sorted(list_snapshots['DBSnapshots'], key=itemgetter('SnapshotCreateTime'), reverse=True)
    #snapshot_arn = sorted_keys[0]['DBSnapshotArn']
    #dbsnapshotidentifier = sorted_keys[0]['DBSnapshotIdentifier']
    #pprint(dbsnapshotidentifier)
    pprint(list_snapshots)
    
 def copy_latest_snapshot(db_identifier):
    timestamp = '{:%Y%m%d-%H%M%S}'.format(datetime.datetime.now())
    snapshot_copy = f"snapshot-copy{timestamp}"
    logger.info(f"Find latest snapshot of: {db_identifier}")
    response = rds.describe_db_snapshots(DBInstanceIdentifier=db_identifier, SnapshotType='automated')
    sorted_keys = sorted(response['DBSnapshots'], key=itemgetter('SnapshotCreateTime'), reverse=True)
    snapshot_id = sorted_keys[0]['DBSnapshotIdentifier']
    logger.info(f"Wait for snapshot: {snapshot_id}")
    waiter.wait(
        DBInstanceIdentifier=db_identifier,
        DBSnapshotIdentifier=snapshot_id,
        WaiterConfig={'Delay': 5, 'MaxAttempts': 12}
    )
    logger.info(f"Create snapshot copy: {snapshot_copy} of {db_identifier}")
    rds.copy_db_snapshot(SourceDBSnapshotIdentifier=snapshot_id,
                         TargetDBSnapshotIdentifier=snapshot_copy)
    return snapshot_copy
    
def main():

    # grab inputs from morpheus dictory
    input_arn = 'arn:aws-us-gov:iam::147884775654:role/CICD-rds-role' #morpheus['customOptions']['RDSRoleARN']
    input_task = 'test' #morpheus['customOptions']['RDSTask']
    input_db_name = 'boyd881211'  #morpheus['customOptions']['RDSInstance']
    input_environemnt = 'Prod' #morpheus['customOptions']['RDSENV']
    
    # Check instance environment
    if input_environemnt == "DR":
      region = 'us-gov-east-1'
    else:
      region = 'us-gov-west-1'


    # grab temp keys
    temp_key, temp_secret, temp_token = assume_role(input_arn, region)
    #pprint(temp_key)
    #pprint(temp_secret)
    #pprint(temp_token)


    # send task to db with temp keys
    rds_service(temp_key, temp_secret, temp_token, input_task, input_db_name, region)
if __name__ == "__main__":
    main()
   
