#!/bin/bash
# Proper header for a Bash script.

bundle install
rake db:reset
rake db:migrate
rake test
