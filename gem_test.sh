#!/bin/bash

gem uninstall generic_app
DIR_GENERIC_APP=$PWD
DIR_PARENT="${PWD%/*}" 
mkdir -p log

echo '=============='
echo 'bundle install'
bin/setup >/dev/null

echo '================================='
echo 'BEGIN PART 1: testing generic_app'
rake 2>&1 | tee $DIR_GENERIC_APP/log/1.txt
echo 'FINISHED PART 1: testing generic_app'
echo '===================================='
echo 
echo '================================================'
echo 'BEGIN PART 2: testing generic_app - code quality'
rubocop 2>&1 | tee $DIR_GENERIC_APP/log/2.txt
echo 'FINISHED PART 2: testing generic_app - code quality'
echo '==================================================='
echo
echo '=========================='
echo 'BEGIN PART 3: testing tmp1'
cd $DIR_PARENT/tmp1 && sh build_fast.sh 2>&1 | tee $DIR_GENERIC_APP/log/3.txt 
echo 'FINISHED PART 3: testing tmp1'
echo '============================='
echo 
echo '========================================='
echo 'BEGIN PART 4: testing tmp1 - code quality'
cd $DIR_PARENT/tmp1 && sh test_code.sh 2>&1 | tee $DIR_GENERIC_APP/log/4.txt 
echo 'FINISHED PART 4: testing tmp1 - code quality'
echo '============================================'
echo
echo '==================================='
echo 'The locations of the test logs are:'
echo "PART 1: $DIR_GENERIC_APP/log/1.txt"
echo "PART 2: $DIR_GENERIC_APP/log/2.txt"
echo "PART 3: $DIR_GENERIC_APP/log/3.txt"
echo "PART 4: $DIR_GENERIC_APP/log/4.txt"

echo
echo 'If all went well, the results at the end of tests 1 and 3 show 0 failures and 0 errors,'
echo 'and the results of tests 2 and 4 show no offenses.'
echo 'Please note that in test 4, bundle-audit may flag violations due to outdated'
echo 'rails, pg, and nokogiri gems.'
echo 'It is up to the user to update these gems upon creating a new Rails project.'
echo
