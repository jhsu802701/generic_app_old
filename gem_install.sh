#!/bin/bash

gem uninstall generic_gem
bin/setup
echo "****************************"
echo "BEGIN INSTALLING generic_gem"
rake install
echo "FINISHED INSTALLING generic_gem"
echo "*******************************"
