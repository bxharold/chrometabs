# Project chrometabs: 
# A concise way to view my open chrome windows and tabs.
- ... and yet another flask sample app
- ... and another exercise in creating a git repo

# Usage:  
##  >> Data Gathering Step:
### 1. use TabCopy chrome extension:  copy all tabs
### 2. Paste date into a .csv file
## pbpaste > mytabs.csv  (or cat > mytabs.csv [ctrlC])   
    maybe hand-scrub a bit.... there was an unmatched "
### 3. import into mytabs sqlite database mytabs.db, table mytabs.
## sqlite3 mytabs.db -init mytabs.sql

  code is in mytabs.sql, exec'd using the "-init" argument

  1. this removes (nn) from title; e.g., changes title "(19) CS50P...  to "CS50P...

  1. .import '|sed "s/^.([0-9][0-9]*) /\"/" mytabs.csv' mytabs
    
  1. extra adhoc inserts... because.  just because.

## >> Display Step:
#### This is yet another simple flask app  

## python3 chrometabs.py  

