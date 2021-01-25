const express = require('express');
const userRouter = express.Router();
const mysql = require('mysql');
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


userRouter.get('/', (req, res) => {
    const sql = "SELECT * from user";
    db.query(sql, (err, result) => {
        if (err)
            throw err;
        else res.send(result);
    })
});
userRouter.get('/:id', (req, res) => {
    const id = req.params.id;
    const sql = "SELECT * from user where id = " + id;
    db.query(sql, (err, result) => {
        if (err)
            throw err;
        else if (result.length === 0) {
            res.status(400);
            res.send();
        } else res.send(result);
    })
});

userRouter.get('/by-name/:name', (req, res) => {
    const name = req.params.name;
    const sql = "SELECT * from user where name = " + name;
    db.query(sql, (err, result) => {
        if (err)
            throw err;
        else res.send(result);

    })
});
const isValid = (name, surname, email) =>
    name != null && name.length >= 3 &&
    surname != null && surname.length >= 3 &&
    email != null && email.includes('@');
userRouter.post('/', (req, res) => {
    const sql = 'insert into user(name,surname,email,account_creation_date)  values (' + '\'' + req.body.name + '\',\'' + req.body.surname + '\',\'' + req.body.email + '\'' + ',sysdate())';
    if (!isValid(req.body.name, req.body.surname, req.body.email)) {
        res.status(400);
        res.send();
    } else {
        db.query(sql, (err, result) => {
            if (err) {
                res.status(500);
                res.send();
                throw err;
            } else
                res.status(201);
            res.send();
        })
    }


})
userRouter.put('/', (req, res) => {
    if (!isValid(req.body.name)) {
        res.status(400);
        res.send();
    } else {
        const sql = 'update user set name =' + '\'' + req.body.name + '\',\'' + req.body.surname + '\',\'' + req.body.email + '\'' + 'where id = ' + req.body.id;
        db.query(sql, (err, result) => {
            if (err) {
                res.status(500);
                res.send();
                throw err;
            } else
                res.status(201);
            res.send();
        })
    }
})
userRouter.delete('/', (req, res) => {
    const sql = 'delete from user where id = ' + req.body.id;
    db.query(sql, (err, result) => {
        if (err) {
            res.status(500);
            res.send();
            throw err;
        } else {
            res.status(200);
            res.send();
        }


    });
})
module.exports = userRouter;