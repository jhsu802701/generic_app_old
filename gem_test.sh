#!/bin/bash

gem uninstall generic_app
bin/setup
echo "*************************"
echo "BEGIN TESTING generic_app"
rake
echo "FINISHED TESTING generic_app"
echo "****************************"

echo "*******************************"
echo "BEGIN TESTING THE tmp RAILS APP"
cd tmp && sh test.sh
echo "FINISHED TESTING THE tmp RAILS APP"
echo "**********************************"

echo "If all went well, there are no error messages and no failed tests."
echo
