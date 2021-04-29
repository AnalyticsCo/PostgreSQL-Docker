
import json
from couchbase.cluster import Cluster, ClusterOptions
from couchbase_core.cluster import PasswordAuthenticator
import requests
from requests.auth import HTTPBasicAuth
from couchbase.cluster import QueryOptions

# get a reference to our cluster
cluster = Cluster('couchbase://localhost:8091', ClusterOptions(
  PasswordAuthenticator('Administrator', 'somepassword')))

cb = cluster.bucket('travel-sample')

#Running query
result = cluster.query(
    "SELECT * FROM `travel-sample` LIMIT 5",
    'Administrator', QueryOptions(adhoc='false'))

#Connecting Rest APİ
PARAMS = {'username':'Administrator','password':'somepassword'}
URL = "http://localhost:8091//pools/nodes"
r = requests.get(url=URL,auth = HTTPBasicAuth('Administrator', 'somepassword'))
data= r.json()
parsed = json.loads(json.dumps(data))
print("*************************************Node Bilgileri Aliniyor*************************************N")
print(json.dumps(parsed, indent=4, sort_keys=True))
