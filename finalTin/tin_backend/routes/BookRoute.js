const express = require('express');
const bookRouter = express.Router();
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


bookRouter.get('/', (req, res) => {
    const sql = "SELECT * from book";
    db.query(sql, (err, result) => {
        if (err)
            throw err;
        else res.send(result);
    })
});

const prepareBookData = array => {
    return {
        id : array[0].bookId,
        name: array[0].bookName,
        bookDate: array[0].bookDate,
        authors: array.map(row => {
            return {
                authorName: row.authorName,
                authorSurname: row.surname,
                additionDate : row.addition_date
            }
        })
    }
}
bookRouter.get('/:id', (req, res) => {
    console.log('get by id books was called')
    const id = req.params.id;
    console.log('Id is' + id);
    const sql = ' select b.id as bookId, b.name as bookName, b.addition_date as bookDate, a.name as authorName,a.surname, ab.addition_date from book b ' +
        'join author_book ab on b.id = ab.book_id ' +
        'join author a on a.id = ab.author_id ' +
        'where b.id = ' + id;
    db.query(sql, (err, result) => {
        if (err)
            throw err;
        else if (result.length === 0) {
            res.status(400);
            console.log('Empty result set in get book by id')
            res.send();
        } else res.send(prepareBookData(result));
    })
});

bookRouter.get('/by-name/:name', (req, res) => {
    const name = req.params.name;
    const sql = "SELECT * from book where name = " + name;
    db.query(sql, (err, result) => {
        if (err)
            throw err;
        else res.send(result);

    })
});
const isValid = (name) => name != null && name.length >= 3;
bookRouter.post('/', (req, res) => {
    console.log("post book was called")
    const sql = 'insert into book(name,addition_date)  values (' + '\'' + req.body.name + '\'' + ',sysdate())';
    if (!isValid(req.body.name)) {
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
bookRouter.put('/', (req, res) => {
    if (!isValid(req.body.name)) {
        res.status(400);
        res.send();
    } else {
        const sql = 'update book set name =' + '\'' + req.body.name + '\' where id = ' + req.body.id;
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

bookRouter.delete('/', (req, res) => {
    const deleteFromAuthors = 'delete from author_book where book_id = ' + req.body.id;
    const deleteFromCollections = 'delete from collection_book where book_id = ' + req.body.id;
    const sql = 'delete from book where id = ' + req.body.id;
    // that's some really bad code
    db.query(deleteFromAuthors, (err,result) => {
        if(err){
            res.status(500);
            res.send();
            throw err;
        }
        else {
            db.query(deleteFromCollections,(err,result) => {
                if(err){
                    res.status(500);
                    res.send();
                    throw err;
                }
                else {
                    db.query(sql,(err,result) => {
                        if(err){
                            res.status(500);
                            res.send();
                            throw err;
                        }
                        else {
                            res.status(201);
                            res.send()
                        }
                    })
                }
            })
        }
    })
});

module.exports = bookRouter;