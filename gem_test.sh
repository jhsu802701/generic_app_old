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

#echo "********************************"
#echo "BEGIN TESTING THE tmp1 RAILS APP"
#cd tmp1 && sh test_app.sh 2>&1; sh list_files.sh | tee $DIR_GENERIC_APP/log/tmp1.txt
#echo "FINISHED TESTING THE tmp1 RAILS APP"
#echo "***********************************"

#echo "********************************"
#echo "BEGIN TESTING THE tmp2 RAILS APP"
#cd ..
#cd tmp2 && bundle install; rake db:migrate 2>&1; sh list_files.sh | tee $DIR_GENERIC_APP/log/tmp2.txt
#echo "FINISHED TESTING THE tmp2 RAILS APP"
#echo "***********************************"

#echo "********************************"
#echo "BEGIN TESTING THE tmp3 RAILS APP"
#cd ..
#cd tmp3 && sh test_app.sh 2>&1; sh list_files.sh | tee $DIR_GENERIC_APP/log/tmp3.txt
#echo "FINISHED TESTING THE tmp3 RAILS APP"
#echo "***********************************"

#echo "********************************"
#echo "BEGIN TESTING THE tmp4 RAILS APP"
#cd ..
#cd tmp4 && sh sh test_app.sh; sh list_files.sh 2>&1 | tee $DIR_GENERIC_APP/log/tmp4.txt
#echo "FINISHED TESTING THE tmp4 RAILS APP"
#echo "***********************************"

#echo "********************************"
#echo "BEGIN TESTING THE tmp5 RAILS APP"
#cd ..
#cd tmp5 && sh test_app.sh; sh list_files.sh 2>&1 | tee $DIR_GENERIC_APP/log/tmp5.txt
#echo "FINISHED TESTING THE tmp5 RAILS APP"
#echo "***********************************"

echo "The log of the generic_app test is at $DIR_GENERIC_APP/log/generic_app.txt."
echo "The log of the tmp1 Rails app test is at $DIR_GENERIC_APP/log/tmp1.txt."
echo "The log of the tmp2 Rails app test is at $DIR_GENERIC_APP/log/tmp2.txt."
echo "The log of the tmp3 Rails app test is at $DIR_GENERIC_APP/log/tmp3.txt."
echo "The log of the tmp4 Rails app test is at $DIR_GENERIC_APP/log/tmp4.txt."
echo
echo "If all went well, the results at the end of each test show 0 or 31m0 failures and 0 errors."
echo
