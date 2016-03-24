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
rake 2>&1 | tee $DIR_GENERIC_APP/log/generic_app-rake_test.txt
echo 'FINISHED TESTING generic_app'
echo '****************************'
echo 
echo '****************************************'
echo 'BEGIN TESTING generic_app - code quality'
rubocop 2>&1 | tee $DIR_GENERIC_APP/log/generic_app-rubocop.txt
echo 'FINISHED TESTING generic_app - code quality'
echo '*******************************************'
echo
echo '************************************'
echo 'BEGIN TEST 1A: SQLite, build_fast.sh'
cd $DIR_PARENT/tmp1 && spring stop 
cd $DIR_PARENT/tmp1 && sh build_fast.sh 2>&1 | tee $DIR_GENERIC_APP/log/tmp1A.txt 
echo 'FINISHED TEST1A'
echo '***************'
echo ''
echo '***********************************'
echo 'BEGIN TEST 1B: SQLite, test_code.sh'
printf 'y\n' | cd $DIR_PARENT/tmp1 && sh test_code.sh 2>&1 | tee $DIR_GENERIC_APP/log/tmp1B.txt 
echo 'FINISHED TEST 1B'
echo '****************'

echo '*************************************'
echo 'BEGIN TEST 2A: PostgreSQL, pg-test.sh'
printf 'y\n' | cd $DIR_PARENT/tmp1 && sh pg-test.sh auto 2>&1 | tee $DIR_GENERIC_APP/log/tmp2A.txt
echo 'FINISHED TEST 2A'
echo '****************'

echo '***************************************'
echo 'BEGIN TEST 2B: PostgreSQL, test_code.sh'
cd $DIR_PARENT/tmp1 && sh test_code.sh auto 2>&1 | tee $DIR_GENERIC_APP/log/tmp2B.txt
echo "\n"
echo 'FINISHED TEST 2B'
echo '****************'

echo
echo '***********************************'
echo 'The locations of the test logs are:'
echo "GEM TEST: $DIR_GENERIC_APP/log/generic_app-rake_test.txt"
echo "GEM TEST - code quality: $DIR_GENERIC_APP/log/generic_app-rubocop.txt"
echo "TEST 1A (SQLite, build_fast.sh): $DIR_GENERIC_APP/log/tmp1A.txt"
echo "TEST 1B (SQLite, test_code.sh): $DIR_GENERIC_APP/log/tmp1B.txt"
echo "TEST 2A (PostgreSQL, pg-test.sh): $DIR_GENERIC_APP/log/tmp2A.txt"
echo "TEST 2B (PostgreSQL, test_code.sh): $DIR_GENERIC_APP/log/tmp2B.txt"

echo
echo 'If all went well, the results at the end of tests 1A and 2A show 0 failures and 0 errors.'
echo 'Please note that in tests 1B and 2B, bundle-audit will flag violations due to outdated'
echo 'rails, pg, and nokogiri gems.'
echo 'It is up to the user to update these gems upon creating a new Rails project.'
echo
