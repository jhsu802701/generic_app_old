#!/bin/bash
# Proper header for a Bash script.

bundle exec rake db:migrate:reset
bundle exec rake db:seed
