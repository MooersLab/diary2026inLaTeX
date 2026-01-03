#!/bin/bash

echo "generate_daily.sh takes the year as a commandline argument."
if [ $# -lt 1 ]; then
  echo 1>&2 "$0: not enough arguments"
  echo "Usage1: ./generate_daily.sh year"
  return 2
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  echo "Usage1: ./generate_daily.sh year"
  return 2
fi

mkdir January
cd January
/opt/local/bin/python3.12 ../generate_daily.py $1 'January' 1 31
mkdir ../February
cd ../February
/opt/local/bin/python3.12 ../generate_daily.py $1 'February' 1 28
mkdir ../March
cd ../March
/opt/local/bin/python3.12 ../generate_daily.py $1 'March' 1 31
mkdir ../April
cd ../April
/opt/local/bin/python3.12 ../generate_daily.py $1 'April' 1 30
mkdir ../May
cd ../May
/opt/local/bin/python3.12 ../generate_daily.py $1 'May' 1 31
mkdir ../June
cd ../June
/opt/local/bin/python3.12 ../generate_daily.py $1 'June' 1 30
mkdir ../July
cd ../July
/opt/local/bin/python3.12 ../generate_daily.py $1 'July' 1 31
mkdir ../August
cd ../August
/opt/local/bin/python3.12 ../generate_daily.py $1 'August' 1 31
mkdir ../September
cd ../September
/opt/local/bin/python3.12 ../generate_daily.py $1 'September' 1 30
mkdir ../October
cd ../October
/opt/local/bin/python3.12 ../generate_daily.py $1 'October' 1 31
mkdir ../November
cd ../November
/opt/local/bin/python3.12 ../generate_daily.py $1 'November' 1 30
mkdir ../December
cd ../December
/opt/local/bin/python3.12 ../generate_daily.py $1 'December' 1 31
