import os

# Pasiimam GREETING aplinkos kintamąjį
greeting = os.getenv('GREETING', 'Hello Docker')

# SPausdinam šmaikštų pasisveikinimą
print(greeting)
