const express = require("express");
const app = express();
const port = 1234;
const path = require("path");
const bodyParser = require("body-parser");
app.use(express.json());

app.use(bodyParser.urlencoded({ extended: false }));
app.engine('pug', require('pug').__express)
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');

app.get("/hello", (req, res) => {
    res.send("hello, world");
});

app.get('/form', (req, res) => {
    res.sendFile(path.join(__dirname, './', 'myHtml.html'));
});

app.post('/formdata', function (req, res) {
    res.render('index', {
        title: 'pug does not work for some reason',
        first: req.body.first,
        second: req.body.second,
        third: req.body.third

    })
})

app.get('/jsondata', function (req, res) {
    const fs = require('fs');
    let obj = null;
    fs.readFile('views/myJson.json', (err, data) => {
        if (err) throw err;
        obj = JSON.parse(data);
        console.log(obj);

        res.render('secondIndex', {
            jsonMessage: "some message:",
            first: 'first: ' + obj.first,
            second: 'second: ' + obj.second,
            thrid: 'third is: '+  obj.thrid
        });

    });

});

app.listen(port, () => {
    console.log(`listening at http://localhost:${port}`)
})