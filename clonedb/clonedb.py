import requests
import sys
import boto3
import time
from pprint import pprint


#requests.packages.urllib3.disable_warnings()

#appliance_name = sys.argv[1]
#command = sys.argv[2]
#bearer_token = sys.argv[3]
#memory = int(sys.argv[4]) * 1073741824


#def execute_rest(method, url, bearer_token):
#    headers = {
#        'Authorization': 'BEARER ' + bearer_token + '',
#        'Content-Type': 'application/json'
#    }
#    response = requests.request(
#        method, url, headers=headers, verify=False)
#    json = response.json()
#
#
#    return json

#def get_plans(appliance_name, bearer_token):
#    url = "https://"+appliance_name+"/api/service-plans?includeZones=true&includeInactive=true&max=1000"

#response = execute_rest("GET", url, bearer_token)
#    json = response['servicePlans']

#    return json

#def disable_plans(appliance_name, bearer_token, memory):
#        plans = get_plans(appliance_name, bearer_token)
#        disable = [plan for plan in plans if plan['maxMemory'] > memory and plan['active'] is True and plan['name'] not in ['Amazon R5 2xLarge - 8 Core, 64GB Memory']]
#        print("These plans have been deactivated:")
#        print("---------------------------------------------------")
#        for item in disable:
#            plan_id = str(item['id'])
#            name = item['name']
#            url = "https://"+appliance_name+"/api/service-plans/"+plan_id+'/deactivate'
#            response = execute_rest("PUT", url, bearer_token)
#            print(name + "  ---- Deactivated")



#if command == "disable_plans":
#   disable_plans(appliance_name, bearer_token, memory)
