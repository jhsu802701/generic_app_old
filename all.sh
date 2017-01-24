#!/bin/bash

mkdir -p log
FILE_TEST_GEM='log/1-test-gem.log'
FILE_TEST_CODE='log/2-test-code.log'
FILE_INSTALL_GEM='log/3-install-gem.log'
sh gem_test.sh 2>&1 | tee $FILE_TEST_GEM
sh code_test.sh 2>&1 | tee $FILE_TEST_CODE
sh gem_install.sh 2>&1 | tee $FILE_INSTALL_GEM

echo 'Results are logged in:'
echo $FILE_TEST_GEM
echo $FILE_TEST_CODE
echo $FILE_INSTALL_GEM
echo
echo 'Gemsurance Report: log/gemsurance_report.html'
echo 'Gem dependency diagram: log/diagram-gems.svg'
