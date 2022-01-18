import boto3
import requests
from pprint import pprint
coordinates = [
   {
       "name": "Location 1",
       "gps": (29.008966, 111.573724)
   },
   {
       "name": "Location 2",
       "gps": (40.1632626, 44.2935926)
   },
   {
       "name": "Location 3",
       "gps": (29.476705, 121.869339)
   }
]
pprint(coordinates, depth=1)
pprint(coordinates)


print(dir())