#!/bin/bash

gem uninstall generic_app
DIR_GENERIC_APP=$PWD
DIR_PARENT="${PWD%/*}" 
mkdir -p log

echo "**************"
echo "bundle install"
bin/setup >/dev/null

echo "*************************"
echo "BEGIN TESTING generic_app"
rake 2>&1 | tee $DIR_GENERIC_APP/log/generic_app.txt
echo "FINISHED TESTING generic_app"
echo "****************************"
echo ''
echo '*************'
echo 'BEGIN TEST 1A'
echo 'Creating new Rails app'
cd $DIR_PARENT/tmp1 && spring stop 
cd $DIR_PARENT/tmp1 && sh test_app.sh 2>&1 | tee $DIR_GENERIC_APP/log/tmp1A.txt 
echo 'FINISHED TEST1A'
echo '***************'
echo ''
echo '*************'
echo 'BEGIN TEST 1B'
echo 'Creating new Rails app'
cd $DIR_PARENT/tmp1 && sh test_code.sh 2>&1 | tee $DIR_GENERIC_APP/log/tmp1B.txt 
echo 'FINISHED TEST 1B'
echo '****************'
echo ''
echo '*************'
echo 'BEGIN TEST 2A'
echo 'Adding Generic App features to legacy Rails app'
cd $DIR_PARENT/tmp2 && spring stop
cd $DIR_PARENT/tmp2 && sh test_app.sh 2>&1 | tee $DIR_GENERIC_APP/log/tmp2A.txt
echo 'FINISHED TEST 2A'
echo '****************'
echo ''
echo '*************'
echo 'BEGIN TEST 2B'
cd $DIR_PARENT/tmp2 && sh test_code.sh 2>&1 | tee $DIR_GENERIC_APP/log/tmp2B.txt
echo 'FINISHED TEST 2B'
echo '****************'

echo
echo '***********************************'
echo 'The locations of the test logs are:'
echo "GEM TEST: $DIR_GENERIC_APP/log/generic_app.txt"
echo "TEST 1A (new app): $DIR_GENERIC_APP/log/tmp1A.txt"
echo "TEST 1B (new app): $DIR_GENERIC_APP/log/tmp1B.txt"
echo "TEST 2A (legacy app): $DIR_GENERIC_APP/log/tmp2A.txt"
echo "TEST 2B (legacy app): $DIR_GENERIC_APP/log/tmp2B.txt"
echo
echo "If all went well, the results at the end of tests 1A and 2A show 0 or 31m0 failures and 0 errors."
echo 'Test 2B may show vulnerabilities in some gems.  This is normal for the legacy app.'
echo
