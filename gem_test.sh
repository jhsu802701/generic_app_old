#!/bin/bash

# gem uninstall generic_app
DIR_GENERIC_APP=$PWD
DIR_PARENT="${PWD%/*}" 

echo '************'
echo 'BEGIN TEST 1'
echo 'Creating new Rails app'

cd $DIR_PARENT/tmp1 && sh test_app.sh 2>&1 | tee $DIR_GENERIC_APP/log/tmp1.txt 
echo 'FINISHED TEST 1'
echo '***************'

echo '************'
echo 'BEGIN TEST 2'
echo 'Adding Generic App features to legacy Rails app'

cd $DIR_PARENT/tmp2 && sh test_app.sh 2>&1 | tee $DIR_GENERIC_APP/log/tmp2.txt 
echo 'FINISHED TEST 2'
echo '***************'



echo
echo '***********************************'
echo 'The locations of the test logs are:'
echo "TEST 1 (new app): $DIR_GENERIC_APP/tmp1.txt"
echo "TEST 2 (legacy app): $DIR_GENERIC_APP/tmp2.txt"
echo
echo "If all went well, the results at the end of each test show 0 or 31m0 failures and 0 errors."
echo
