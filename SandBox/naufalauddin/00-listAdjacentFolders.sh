#!/bin/bash
# 00-listAdjacentsFolder.sh
# INFO: list all folders adjacent to current working directories

ls -l .. | gawk '/^d/ { print $9}' > sandbox-201.txt
