#!/bin/bash

gem uninstall generic_app
DIR_GENERIC_APP=$PWD
DIR_PARENT="${PWD%/*}" 
mkdir -p log

echo '=============='
echo 'bundle install'
bin/setup >/dev/null

echo '===='
echo 'rake'
rake

echo '======================'
echo 'bundle exec rubocop -D'
bundle exec rubocop -D
