Good Reads v2 is a very simple single-page application, that only supports
basic CRUD operations. I wrote backend in js with express and frontend in
[Elm](https://elm-lang.org/)  
(it is already compiled to javascript so you don't need to install it yourself)  
In order to run backend you should call "npm install" in tin_backend directory  
and then run node app.js  
In order to run frontend, run "http-server-spa ."(note the dot at the end)  
in the tin_frontend directory.  
If http-server-spa is not installed on your system  
you can install it with "npm-install http-server-spa".

Connecting to the database  
Inside the mysql cli enter the following:  
create user 'bajo'@'localhost' identified by 'jajo';  
grant all privileges on * . * to 'bajo'@'localhost';  
flush priveleges;

after that switch to newly created user:  
mysql -u bajo -p  
(you will be asked for password, pass "jajo")

then execute commands present in:  
/finalTin/tin_backend/schema.sql  
/finalTin/tin_backend/data.sql

after that you should be good to go!


