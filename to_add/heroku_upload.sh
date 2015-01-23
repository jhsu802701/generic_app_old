#!/bin/bash
# Proper header for a Bash script.

git push heroku
heroku run rake db:migrate
