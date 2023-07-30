#!/bin/bash
# MySQL backup script
MYSQL='mysql --skip-column-names'
        mysql -uroot -e "stop slave";
                for DB in $(mysql -uroot -e 'show databases' -s --skip-column-names);
                do
                mysqldump --events --routines --source-data=2 $DB > "$DB.sql";
        mysql -uroot -e "start slave";
                done
