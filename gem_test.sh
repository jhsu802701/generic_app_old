#!/bin/bash

gem uninstall generic_app
DIR_GENERIC_APP=$PWD
DIR_PARENT="${PWD%/*}" 
mkdir -p log

echo '**************'
echo 'bundle install'
bin/setup >/dev/null

echo '*************************'
echo 'BEGIN TESTING generic_app'
rake 2>&1 | tee $DIR_GENERIC_APP/log/generic_app.txt
echo 'FINISHED TESTING generic_app'
echo '****************************'
echo ''
echo '************************************'
echo 'BEGIN TEST 1A: SQLite, build_fast.sh'
cd $DIR_PARENT/tmp1 && spring stop 
cd $DIR_PARENT/tmp1 && sh build_fast.sh 2>&1 | tee $DIR_GENERIC_APP/log/tmp1A.txt 
echo 'FINISHED TEST1A'
echo '***************'
echo ''
echo '***********************************'
echo 'BEGIN TEST 1B: SQLite, test_code.sh'
echo 'Creating new Rails app'
cd $DIR_PARENT/tmp1 && sh test_code.sh 2>&1 | tee $DIR_GENERIC_APP/log/tmp1B.txt 
echo 'FINISHED TEST 1B'
echo '****************'

echo
echo '***********************************'
echo 'The locations of the test logs are:'
echo "GEM TEST: $DIR_GENERIC_APP/log/generic_app.txt"
echo "TEST 1A (new app): $DIR_GENERIC_APP/log/tmp1A.txt"
echo "TEST 1B (new app): $DIR_GENERIC_APP/log/tmp1B.txt"

echo
echo "If all went well, the results at the end of tests 1A and 2A show 0 or 31m0 failures and 0 errors."
echo
