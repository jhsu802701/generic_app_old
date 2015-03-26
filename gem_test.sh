#!/bin/bash

gem uninstall generic_app
echo "**************"
echo "bundle install"
bin/setup >/dev/null
echo "*************************"
echo "BEGIN TESTING generic_app"
rake
echo "FINISHED TESTING generic_app"
echo "****************************"

echo "********************************"
echo "BEGIN TESTING THE tmp1 RAILS APP"
cd tmp1 && sh test.sh
echo "FINISHED TESTING THE tmp1 RAILS APP"
echo "***********************************"

echo "********************************"
echo "BEGIN TESTING THE tmp2 RAILS APP"
cd ..
cd tmp2 && sh test.sh
echo "FINISHED TESTING THE tmp2 RAILS APP"
echo "***********************************"

echo "If all went well, there are no error messages and no failed tests."
echo
