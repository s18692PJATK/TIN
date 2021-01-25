const express = require('express');
const collectionRouter = express.Router();
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


collectionRouter.get('/', (req, res) => {
    const sql = "SELECT * from collection";
    db.query(sql, (err, result) => {
        if (err)
            throw err;
        else {
            res.send(result);
            console.log("sent all collections")
        }
    })
});
collectionRouter.get('/:id', (req, res) => {
    const id = req.params.id;
    const sql = "SELECT * from collection where id = " + id;
    db.query(sql, (err, result) => {
        if (err)
            throw err;
        else if (result === 0) {
            res.status(400);
            res.send();
        } else res.send(result);
    })
});

collectionRouter.get('/by-name/:name', (req, res) => {
    const name = req.params.name;
    const sql = "SELECT * from collection where name = " + name;
    db.query(sql, (err, result) => {
        if (err)
            throw err;
        else res.send(result);

    })
});
const isValid = (name) => name != null && name.length >= 3;
collectionRouter.post('/', (req, res) => {
    const sql = 'insert into collection(name,creation_date,user_id)  values (' + '\'' + req.body.name + '\'' + ',sysdate(),' + req.body.user_id + ')';
    ;
    if (!isValid(req.body.name)) {
        res.status(400);
        res.send();
    } else {
        db.query(sql, (err, result) => {
            if (err) {
                res.status(400);
                res.send();
                throw err;
            } else
                res.status(201);
            res.send();
        })
    }


})
collectionRouter.put('/', (req, res) => {
    if (!isValid(req.body.name)) {
        res.status(400);
        res.send();
    } else {
        const sql = 'update collection set name =' + '\'' + req.body.name + '\' where id = ' + req.body.id;
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
collectionRouter.delete('/', (req, res) => {
    const deleteCollectionUsers = 'delete from collection_user where collection_id = ' + req.body.id;
    const deleteCollectionBooks = 'delete from collection_book where collection_id = ' + req.body.id;

    db.query(deleteCollectionBooks, (err, result) => {
        if (err) {
            res.status(500);
            res.send();
            throw err;
        }
    });
    db.query(deleteCollectionUsers, (err, result) => {
        if (err) {
            res.status(500);
            res.send();
            throw err;
        }
    });
    const sql = 'delete from collection where id = ' + req.body.id;
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

collectionRouter.post('/addBook', (req, res) => {
    const sql = 'insert into collection_book (book_id,collection_id,addition_date) values (' + req.body.book_id + ',' + req.body.collection_id + ',sysdate())';
    db.query(sql, (err, result) => {
        if (err) {
            res.status(400)
            res.send();
        } else {
            res.status(201);
            res.send();
        }

    })
})
collectionRouter.post('/deleteBook', (req, res) => {
    const sql = 'delete from collection_book where book_id = ' + req.body.book_id + 'and collection_id = ' + req.body.collection_id;
    db.query(sql, (err, result) => {
        if (err) {
            res.status(400);
            res.send();
        } else {
            res.status(200);
            res.send();
        }
    })
})
collectionRouter.get('/:id/allBooks', (req, res) => {
    const sql = 'select * from book where book_id = (select book_id from collection_book where collection_id = )' + req.params.id;
    db.query(sql, (err, result) => {
        if (err) {
            res.status(400);
            res.send();
        } else {
            res.status(200);
            res.send(result);
        }
    })
})


module.exports = collectionRouter;