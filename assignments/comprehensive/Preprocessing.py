import json

data = json.load(open('./wading-pools.json'))

pools = []

# Get the pool data into a nice list
for pool in data["features"]:
    temp_pool = {
        "name": pool["properties"]["NAME"].split('- ')[1],
        "lat": pool["geometry"]["coordinates"][0],
        "lon": pool["geometry"]["coordinates"][1]
    }
    pools.append(temp_pool)


# Java Output
with open('./java/pools-java.txt', 'w') as outfile:
    for pool in pools:
        outfile.write(pool["name"]+',')
        outfile.write(str(pool["lat"])+',')
        outfile.write(str(pool["lon"])+'\n')

# Prolog Output
with open('./prolog/findroute.pl', 'w') as outfile:
    pool_list = '['
    outfile.write('% Author: Francisco Trindade - 7791605\n')
    outfile.write('% ------ AUTO GENERATED ITEMS FROM PYTHON ------\n')
    for pool in pools:
        outfile.write('pool("'+pool["name"]+'",'+str(pool["lat"])+','+str(pool["lon"])+').\n')
        pool_list += ('"'+pool["name"]+'",')
    outfile.write('poolList(X) :-\n    X = '+pool_list[:-1]+'].\n')
    outfile.write('% ------ END OF AUTO GENERATED ITEMS ------\n')
    outfile.write('% ------ QUERIES MERGED FROM "prolog-solution.pl" ------\n')
    # TODO Write a function to merge the files together
    solution_file = open('./prolog/prolog-solution.pl','r')
    outfile.write(solution_file.read())