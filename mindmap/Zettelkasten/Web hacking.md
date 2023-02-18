202211282028
Status: #idea

Tags: #IN5290 #hacking #web

# Web hacking

Example questions:
> Write 3 examples of information disclosure on a website

1. Finding hidden files and directories under robots.txt
2. Sensitive data (api keys/ip addresses) in source files
3. Disclosing table names and errors in plain text on invalid input


> List and explain 3 different ways for XSS filter evasion

1. Write code in an iframe. This will execute the iframe on response in the html.
2. Base64 encode the script
3. Use other ways to run javascript, other than <script> tags</script>
4. Write characters in a special format, this might not be filtered, but might be interpreted as valid symbols when returned.


> List and explain 3 different ways of exploiting local file inclusion

- Inserting a path to a potentially crucial file in the query. This would then /include/ and execute/read the information stored in the given file.
- In some cases, you can point the query to another url that stores a harmful script that might get uploaded and stored on the client server.
- You can also do a base64 encode/decode of a resource function, and see what the function does.


## Obligatory headers fields of HTTP

- Method GET/POST/PUT/DELETE/ETC
- Protocol version
- Requested file
- Host name

## Information disclosure on a website
`What is information disclosure?`
- Data about other users
- Sensitive commercial or business data
- Technical data about the website and its infra

`Examples of information disclosure`
- Revealing names of hidden directories, structure and contents via robots.txt
- Providing access to source code files via temporary backups
- Explicitly mentioning database table or column names in error messages
- Unnecessarily exposing highly sensitive information, such as cc details
- Hard-coding api keys, ip adresses, database creds in source code
- Hinting at existence or absence of resources, usernames and so on.

## Brute-force on a website
- You can use dirb to brute force directories on a website. 
## Web-methods

- GET - gets a web page and downloads the assets (html/jss/css++). Can send query parameters.
- POST - Used to send information to a service with the intention of creating/writing something. 
- PUT - Like POST, but mostly used for updating. Can also upload files.
- DELETE - Request a deletion based on provided selection
- UPDATE - Like Put, but more explicit

---

## Burp method attack types
- Spider: Crawl applications
- Intruder: Automate attack on web app
- Sequencer: quality analysis of the randomness in a sample of data items
- Decoder: Transform encoded data
- Comparer: Perform comparison of packets
- Scanner: automatic security test
## Cross site scripting

Cross site scripting, or XSS, is the vulnerability of input fields allowing input to be code that executes elsewhere on the site, hence cross site.

Without validation, the attacker can provide html elements and/or javascript. JS can overwrite website content by manipulating the DOM, redirect the page or access browser data. (Cookies can be accessed from dev tools too)

- DOM based XSS - data flow never leaves browser
- Stored XSS - User input is stored on target server
- Reflected XSS - User input is immediately returned by a web application in an error message, search result or ay response
- Client side XSS: Malicious data is used to fire a JS call
- Server side XSS: Malicious data is sent to the server, and server responses without proper validation.


## Ways to compromise a website with XSS
What can be done with XSS:
- Attacker can provide html element including JS
```
<div>
	<script text="script/javascript">alert(document.cookies);</script>
</div>
```
- Redirect the page to another side, misleading the user
- Rewrite the document content to mislead the user
- Get the cookie variables (session hijacking)
- Key-logging: Attacker can register a keyboard event listener and send all keystrokes to his own server.
- Phishing: Attacker can insert fake login form into page to obtain credentials
- Launch browser exploits
## XSS filter evasions
- Alternative ways for executing javascript
- Write characters in special format
- Base64 encode
- Write iframe
## Stealing the session variable
Stealing the session variable can be done in multiple ways:
1. Attacker already knows the credential for one or two users. Using i.e. Burp to inspect the requests and responses, can show a session variable being set in order to validate a user session.
2. Session sniffing
3. XSS, redirecting user to another site that steals the cookie
4. Man-in-the-middle attack
5. Man-in-the-browser attack

---

## Sql injection types
- Boolean based blind. `a' or '1'='1`
- Error based. Force syntactically wrong queries and map database based on error messages.
- Union query. If the attacker can hijack the sql query, they can form a second query using the union select.
- Stacked query. Write additional queries 
- Reading local files. 
- Writing local files. `write help.php into /etc/www`
- Executing OS commands. `ls -a`

## File upload with sql injection
`<query> into '/var/www/temp/apples.php'`

Possible if:
- Union select or stacked queries are enabled
- Have to know, or guess the row number
- A writeable folder is needed
- The attacker has to know or guess the webroot folder


## Xpath injection

Possible if there is no input validation, or the validation is inappropriate in the xpath query.

## Local file inclusion exploit

If the server doesn't validate the query properly, an attacker could potentially find a file
in the path tree, if the function that uses the query is a `include` function. 
Adding %00 sometimes works, if it normally doesn't.

---
# references