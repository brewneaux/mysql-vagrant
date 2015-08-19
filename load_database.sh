#!/usr/bin/env bash
mysql --local-infile=1 -e "SET GLOBAL local_infile = 'ON';"
mysql --local-infile=1 medicaid < load_medicaid_data.sql