#!/bin/bash

gem uninstall generic_app
DIR_GENERIC_APP=$PWD
mkdir -p log

echo "**************"
echo "bundle install"
bin/setup >/dev/null
echo "*************************"
echo "BEGIN TESTING generic_app"
rake 2>&1 | tee $DIR_GENERIC_APP/log/generic_app.txt
echo "FINISHED TESTING generic_app"
echo "****************************"

echo "********************************"
echo "BEGIN TESTING THE tmp1 RAILS APP"
cd tmp1 && sh test.sh 2>&1 | tee $DIR_GENERIC_APP/log/tmp1.txt
echo "FINISHED TESTING THE tmp1 RAILS APP"
echo "***********************************"

echo "********************************"
echo "BEGIN TESTING THE tmp2 RAILS APP"
cd ..
cd tmp2 && sh test.sh 2>&1 | tee $DIR_GENERIC_APP/log/tmp2.txt
echo "FINISHED TESTING THE tmp2 RAILS APP"
echo "***********************************"
echo "The log of the generic_app test is at $DIR_GENERIC_APP/log/generic_app.txt."
echo "The log of the tmp1 Rails app test is at $DIR_GENERIC_APP/log/tmp1.txt."
echo "The log of the tmp2 Rails app test is at $DIR_GENERIC_APP/log/tmp2.txt."
echo
echo "If all went well, the results at the end of each test show 0 or 31m0 failures and 0 errors."
echo
