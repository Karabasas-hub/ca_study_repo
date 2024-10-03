import yaml

with open ('C:\\Users\\Augustas\\Desktop\\ca_python\\nineth.yml', 'r') as file:
    data = yaml.safe_load(file)

#pridedam darbuotoją

new_employee = {
    'firstName': 'Emily',
    'lastName': 'Clark',
    'skills': ['management', 'leadership']
}
data['employees'].append(new_employee)

#pamodifikuojam darbuotoja

for employee in data['employees']:
    if employee['firstName'] == 'John':
        employee['skills'].append('teamwork')

# atimam skillsą iš daruotojo

for employee in data['employees']:
    if employee['firstName'] == 'Anna':
        employee['skills'].remove('problem-solving')

# išsaugom modifikuota faila

with open ('nineth_mod.yml', 'w') as new_file:
    yaml.dump(data, new_file, default_flow_style=False)

print("Pamodifikavom YAML failą")