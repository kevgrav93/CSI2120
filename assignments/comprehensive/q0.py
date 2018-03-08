import json

data = json.load(open('./wading-pools.json'))

# Java Output
with open('./java/pools-java.txt', 'w') as outfile:
    for pool in data["features"]:
        outfile.write(pool["properties"]["NAME"].split('- ')[1]+',')
        outfile.write(str(pool["geometry"]["coordinates"][0])+',')
        outfile.write(str(pool["geometry"]["coordinates"][1])+'\n')

# TODO make a prolog file out of this mess