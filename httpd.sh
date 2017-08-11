#!/bin/bash

source /etc/apache2/envvars
apache2 -V
/usr/sbin/apache2 -D FOREGROUND