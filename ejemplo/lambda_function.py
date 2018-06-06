# Import dependencies
import boto3


def lambda_handler(event, context):
  client = boto3.client('iam')
  usr = event['usr']
  grp = event['grp']
  print(usr)
  print(grp)
  response = client.create_user(
      UserName = str(usr)
  )
  print(response)
  response1 = client.create_group(
      GroupName = str(grp)
  )
  print(response1)
  response2 = client.add_user_to_group(
      GroupName = str(grp),
      UserName = str(usr)
  )
  print(response2)
