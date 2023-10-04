--    mytabs.sql  
--    put a copy of all Chrome tabs, all windows into a database
--    1. use TabCopy chrome extension:  copy all tabs
--    2. cat > mytabs.csv ctrlC,  or   pbpaste > mytabs.csv
--       maybe hand-scrub a bit.... there was an unmatched "
--    3. import into mytabs sqlite database mytabs.db, table mytabs.
--       code is in mytabs.sql, exec'd using the "-init" argument
--       remove (nn) from title; e.g., change title "(19) CS50P  to "CS50P
--       .import '|sed "s/^.([0-9][0-9]*) /\"/" mytabs.csv' mytabs
--    pbpaste > mytabs.csv
--    sqlite3 mytabs.db -init mytabs.sql

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

-- delete gmail and amazon tabs:
DELETE FROM mytabs WHERE url like "%https://mail.google.com/%";
DELETE FROM mytabs WHERE url like "%https://maps.google.com/%";
DELETE FROM mytabs WHERE url like "%https://%.google.com/%";
DELETE FROM mytabs WHERE url like "%https://%.twitter.com/%";
DELETE FROM mytabs WHERE url like "%https://www.amazon.com/%";
DELETE FROM mytabs WHERE url like "%https://duckduckgo.com/%";

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
select rowid, title, URL from mytabs order by rowid desc;
select count(*), " ===========================" from mytabs;
select count(*), title, url from mytabs group by title, url having count(*)>1 order by count(*);

