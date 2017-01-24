#!/bin/bash

gem uninstall generic_app
DIR_GENERIC_APP=$PWD
DIR_PARENT="${PWD%/*}" 
mkdir -p log

echo '=============='
echo 'bundle install'
bin/setup >/dev/null

echo '=================='
echo 'BEGIN PART 1: rake'
rake 2>&1 | tee $DIR_GENERIC_APP/log/1.txt
echo 'FINISHED PART 1: rake'
echo '====================='
echo 
echo '====================='
echo 'BEGIN PART 2: rubocop'
rubocop 2>&1 | tee $DIR_GENERIC_APP/log/2.txt
echo 'FINISHED PART 2: rubocop'
echo '========================'
echo
echo '==================================='
echo 'The locations of the test logs are:'
echo "PART 1: $DIR_GENERIC_APP/log/1.txt"
echo "PART 2: $DIR_GENERIC_APP/log/2.txt"

echo
echo 'If all went well, all tests passed with no offenses.'
