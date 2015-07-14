#!/bin/bash

gem cleanup generic_app
bin/setup
echo '------------------------'
echo 'Building generic_app gem'
gem build generic_app.gemspec
echo '------------------------'
echo 'Installing generic_app gem'
gem install generic_app*.gem
echo "FINISHED INSTALLING generic_app"
echo "*******************************"
