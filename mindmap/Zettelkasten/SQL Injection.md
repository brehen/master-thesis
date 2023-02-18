202211031820
Status: #idea

Tags: #IN5290 #hacking #security #SQL

# SQL Injection

[[SQL]] Injection is a technique for exploiting the fact that there are some services out there with unsafe input fields. These unsafe fields are often used to insert the inserted data into a database. If this text input isn't cleaned properly before being inserted into a SQL query, a malicious user could sneak in SQL queries into the request and do some serious damage. Everything from reading user passwords, to dropping entire tables and databases worth of data.

## Forms of SQL injections

### Simple example

The easiest way to perform an SQL injection can happen when we have direct influence on an action. In most extreme cases, we could append some simple text after a field, that might be interpreted by the SQL engine to result in a different result than expected.

Example:

```sql
SELECT * FROM Table1 WHERE email='admin' AND pass='12345' OR '1'='1'
```

In this example, we added the following text: 
```sql
' OR '1'='1`
```

The key here, being that the SQL engine will interpret.

### Boolean based blind
Depending on the input, the attacker can see two different answers from the server.

Example:

Given the url:
```url
http://193.225.218.118/sql3.php?email=lazlo
```

If the page shows different content based on the user being a specific user or not, we could do the following:
```url
https://193.225.218.118/sql3.php?email=lazlo' or '1'='1 // true
```

This could show the page intended for a specific user, maybe admin. And this:

```url
https://193.225.218.118/sql3.php?email=lazlo' or '1'='2 // false
```

might show another version.

### Error based
### Union query
### Stacked query
### Time based blind
### Other options
### Reading local files
### Writing local files
### Executing OS commands

---
# references