#!/bin/bash

DIR_PARENT="${PWD%/*}"
DIR_TMP="$DIR_PARENT/tmp"
mkdir -p log
rm -rf tmp

echo '--------------'
echo 'bundle install'
bin/setup >/dev/null

echo
echo '----------------------'
echo 'bundle exec rubocop -D'
bundle exec rubocop -D

echo
echo '-----------'
echo 'sandi_meter'
sandi_meter

echo
echo '------------'
echo 'bundle-audit'
bundle-audit

echo '----------------------------------------------'
echo 'gemsurance --output log/gemsurance_report.html'
gemsurance --output log/gemsurance_report.html
echo 'Gemsurance Report: log/gemsurance_report.html'

echo '------------------------------------------------------------------------'
echo 'bundle viz --file=log/diagram-gems --format=jpg --requirements --version'
bundle viz --file=log/diagram-gems --format=jpg --requirements --version
echo 'Gem dependency diagram: log/diagram-gems.jpg'
