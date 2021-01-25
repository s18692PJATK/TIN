const express = require('express');
const mysql = require('mysql');
const collectionRouter = require("./routes/CollectionRoute")
const userRouter = require("./routes/UserRoute")
const photoRouter = require("./routes/BookRoute");
let cors = require('cors')
const app = express();
app.use(cors())
app.use(express.json());
const db = mysql.createConnection({
    host: 'localhost',
    user: 'bajo',
    password: 'jajo',
    database: 'tin'
});
db.connect((err) => {
    if (err)
        throw err;
    else
        console.log('It worked');
});
app.use('/collections', collectionRouter);
app.use('/users', userRouter);
app.use('/books', photoRouter);

app.listen('3000', () => {
    console.log('hello');
})