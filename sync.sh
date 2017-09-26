#! /bin/bash

TODAY=`date +%Y-%m-%dT%H:%M:%S`
LOG="/Users/sgillis/log/sync$TODAY.log"
/usr/local/bin/aws s3 sync /Users/sgillis/S3 s3://sgillis > $LOG 2>&1
