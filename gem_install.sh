#!/bin/bash

gem uninstall generic_app
bin/setup
echo "****************************"
echo "BEGIN INSTALLING generic_app"
rake install
echo "FINISHED INSTALLING generic_app"
echo "*******************************"
