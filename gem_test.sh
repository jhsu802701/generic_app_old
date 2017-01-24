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
rake
echo 'FINISHED PART 1: rake'
echo '====================='
echo 
echo '========================'
echo 'BEGIN PART 2: rubocop -D'
rubocop -D
echo 'FINISHED PART 2: rubocop -D'
echo '==========================='
echo
