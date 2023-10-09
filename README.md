--    project chrometabs:   make_mytabs.sql
--    puts a copy of all Chrome tabs for all windows into a database
--    companion to flask app chrometabs.py
--       renamed mytabs.sql 10/5/2023 after "pbpaste > mytabs.sql" oopsie
--    1. use TabCopy chrome extension:  copy all tabs
--    2. ipbpaste > mytabs.csv   (or cat > mytabs.csv [ctrlC])
--       maybe hand-scrub a bit.... e.g., there was an unmatched "
--    3. import into mytabs sqlite database mytabs.db, table mytabs:
--       code is in make_mytabs.sql, exec'd using the "-init" argument
--       remove (nn) from title; e.g., change title "(19) CS50P  to "CS50P
--       .import '|sed "s/^.([0-9][0-9]*) /\"/" mytabs.csv' mytabs
--       use SQL to remove gmail, amazon tbs, etc
--    pbpaste > mytabs.csv
--    sqlite3 mytabs.db -init make_mytabs.sql
--    python3 chrometabs.py

.mode csv


# Project chrometabs: 
## Puts a copy of all Chrome tabs for all windows into a database
## A concise way to view my open chrome windows and tabs.
- ... and yet another flask sample app
- ... and another exercise in creating a git repo
- ... renamed mytabs.sql 10/5/2023 after "pbpaste > mytabs.sql" oopsie
## Companion apps: make_mytabs.sql, flask app chrometabs.py

# *** Usage:  ***
## >> Data Gathering Step:
### 1. use TabCopy chrome extension:  copy all tabs
### 2. Paste date into a .csv file: (the names are hardcoded.)
# pbpaste > mytabs.csv  <!-- or cat > mytabs.csv [ctrlC])-->  
### 3. import into mytabs sqlite database mytabs.db, table mytabs.
  <!-- code is in mytabs.sql, exec'd using the "-init" argument. -->
# sqlite3 mytabs.db -init mytabs.sql
  1. this removes (nn) from title; e.g., changes title "(19) CS50P...  to "CS50P...
  1. .import '|sed "s/^.([0-9][0-9]*) /\"/" mytabs.csv' mytabs 
  1. extra adhoc inserts... because.  just because.

## >> Display Step:
#### This is yet another simple flask app  

## python3 chrometabs.py  

