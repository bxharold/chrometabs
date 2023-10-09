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
DROP TABLE IF EXISTS "mytabs";
CREATE TABLE IF NOT EXISTS "mytabs" (
    -- id INTEGER PRIMARY KEY,  -- use builtin rowid instead
    title  varchar(200),
    url  varchar(200)
);
-- .import mytabs.csv mytabs
.import    '|sed "s/^.([0-9][0-9]*) /\"/" mytabs.csv' mytabs

-- ad hoc additions:
INSERT INTO mytabs (title,url) VALUES ("vim macro recording", "https://vim.fandom.com/wiki/Recording_keys_for_repeated_jobs");

-- delete google, yahoo, amazon, duckduckgo, twitter tabs:
DELETE FROM mytabs WHERE url like "%https://%.google.com/%";
-- DELETE FROM mytabs WHERE url like "%https://mail.google.com/%";
-- DELETE FROM mytabs WHERE url like "%https://maps.google.com/%";
DELETE FROM mytabs WHERE url like "%https://%.twitter.com/%";
DELETE FROM mytabs WHERE url like "%https://www.amazon.com/%";
DELETE FROM mytabs WHERE url like "%https://duckduckgo.com/%";
DELETE FROM mytabs WHERE url like "%https://mail.yahoo.com/%";

/*   --  comment these out to find bad input 
-- .read mytabsScript.txt  -- so short, do it inline
.mode column
.width 3, 80, 100
select rowid, title, URL from mytabs order by title;
select count(*) from mytabs;
.width 3, 100
select count(*), title from mytabs group by title order by count(*);
*/
.mode column
.width 3, 80, 80
-- select rowid, title, URL from mytabs order by title;
-- select rowid, title, URL from mytabs order by rowid desc;
select count(*), "*** ROWCOUNT:  ===========================" from mytabs;
select count(*), "*** DUPLICATE TABS:  ===========================" ;
select count(*), title, url from mytabs group by title, url having count(*)>1 order by count(*);

