#!/usr/local/bin/python3   # HiMac2:~/vscode/yanother_flask_app/yafa.py  9/25/2023
### exploring the difference between jsonify(data) and json.dumps(data)
### uses birthday as model for the database code and jinja2 template looping
### The idea was only to display mytabs query result using both jasonify and jdomps
### ... but this sidetrack is turning into a useful tab-tracker.

# lsof -iTCP -sTCP:LISTEN -n -P

from flask import Flask, flash, jsonify, redirect, render_template, request 
import json    # for dumps
import sqlite3    
from sqlite3 import Error  

def create_connection(db_file):
    conn = None
    try:
        conn = sqlite3.connect(db_file)
    except Error as e:
        print(e)
    return conn

app = Flask(__name__)
 
@app.route('/returnjson', methods = ['GET'])
def returnjson():
    data = { "month" : "September",  "day" : 25, }
    jsonifydata = jsonify(data)
    print("jsonifydata", type(jsonifydata), jsonifydata)
    # jsonifydata <class 'flask.wrappers.Response'> <Response 40 bytes [200 OK]>
    return jsonifydata     # 4 lines on a black page
"""
{
  "day": 25,
  "month": "September"
}
"""
@app.route('/returndumps', methods = ['GET'])
def returndumps():
    data = { "month" : "September",  "day" : 25, }
    jsondumpsdata = json.dumps(data)
    print("jsondumpsdata", type(jsondumpsdata), jsondumpsdata)
    # jsondumpsdata <class 'str'> {"month": "September", "day": 25}
    return jsondumpsdata    # 1 line on a white page
"""
{"month": "September", "day": 25}
"""
@app.route('/', methods = ['GET'])
def index():
    rows = "amusing"  # jinja2 splits this.
    msg = "this is the index route."
    canqs = makeCannedQueries()   # <class 'list'> ["SELECT rowid, etc
    return render_template("index.html", msg=msg, canqs=canqs, 
        sqlcmd = "select '', datetime(), 'ver= '||sqlite_version();")

def makeCannedQueries():
    x=[]
    x.append("SELECT rowid, title, url FROM mytabs WHERE title LIKE '%%'")
    x.append("SELECT rowid, title, url FROM mytabs WHERE title LIKE '%%' ORDER BY url ")
    x.append("SELECT rowid, title, url FROM mytabs WHERE url LIKE '%%' ORDER BY url ")
    x.append("SELECT rowid, title, url FROM mytabs WHERE title LIKE '%%' ORDER BY title ")
    x.append("SELECT rowid, title, url FROM mytabs WHERE title LIKE '%%' LIMIT 20")
    x.append("SELECT rowid, title, substring(url,9) FROM mytabs WHERE title LIKE '%%'")
    # substring(url,9) hack is moot now that columns are fixed-width and allow word-break
    x.append("SELECT '', '', count(*) FROM mytabs")
    return x     # still can't understand why not    return json.dumps(x)

@app.route('/query1', methods = ['GET', 'POST'])
def query1():
    dbconn = create_connection("mytabs.db")  
    cur = dbconn.cursor()
    if request.method == 'POST':
        sql = request.form.get('Name') 
    else:
        sql="select '',datetime(),'ver= '||sqlite_version();"  # ?? different value from shell
    cur.execute(sql)
    rows = cur.fetchall()   # type=<class 'list'>
    msg = f"<< {sql} >>"
    canqs = makeCannedQueries()   # <class 'list'> ["SELECT rowid, etc
    return render_template("index.html", rows=rows, msg=msg, sqlcmd=sql, canqs=canqs)

if __name__=='__main__':
    app.run(host="0.0.0.0", debug=True) 

