import json

# pasiloadinam json failą

with open ('C:\\Users\\Augustas\\Desktop\\ca_python\\third.json', 'r') as file:
    data = json.load(file)

# Pakeičiam amžių
data['age'] = 30

# Pridedam eilutę
data['email'] = 'john.smith@hotmail.com'

# ištrinam eilutę

if 'address' in data:
    del data['address']

# išsaugom ką padarėm
with open('third_mod.json', 'w') as new_file:
    json.dump(data, new_file, indent=4)

print("Pakoregavom json failą")