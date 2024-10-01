#!/bin/bash

# Pasitikriname ar įvestis - branch'o pavadinimas
if [ -z "$1" ]; then
	echo "Kažką maišai, brolau, įvesk normalų pavadinimą"
	exit 1
fi

# Pasiimam brancho pavadinimą kaip kintamąjį
branch=$1

# Apsirašome failo, kurį pridėsim, pavadinimą
failas="autofailas.txt"

# Sukuriam šaką
echo "Sukuriam naują šaką, pavadinimu: $branch"
git checkout -b "$branch"

# Sukuriam naują failą
echo "Kuriam failą, pavadintą: $failas"
echo "Tai yra scripto sukurtas failas" > "$failas"

# Stage'inam naują failą
echo "Steidžinam naują failą: $failas"
git add "$failas"

# Committinam naują failą
echo "Komituojam naują failą į šaką $branch"
git commit -m "Scripto failas į $branch"

# Šokam atgal į main šaką
echo "Brendam atgal į pagrindinę šaką"
git checkout main

# Merge'inam išorinę šaką ir main šaką
echo "Klijuojame šaką $šaka į pagrindinę"
git merge "$branch"

# Nudžiuginam vartotoją, kad viskas pavyko
echo "Šaka $branch sumerdžinta sėkmingai"
