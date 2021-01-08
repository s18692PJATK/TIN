const express = require("express");
const app = express();
const port = 8000;
app.use(express.json());

const cors = require('cors');
app.use(cors());

app.post("/calc", (request, respond) => {
    const results = [];
    const first = parseInt(request.body.first);
    const second = parseInt(request.body.second);
    const operator = request.body.operator;
    let result = 0;
    let obj;
    switch(operator) {
        case "add":
            result = first + second;
            results.push(obj = {first : first, operator : operator, second : second,  result : result});
            break;
        case "sub":
            result = first - second;
            results.push(obj = {first : first, operator : operator, second : second,  result : result});
            break;
       case "dev":
            result = first / second;
            results.push(obj = {first : first, operator : operator, second : second,  result : result});
            break;
        case "mul":
            result = first * second;
            results.push(obj = {first : first, operator : operator, second : second,  result : result});
            break;
        default:
            results.push(obj = {first : first, operator : operator, second : second,  result : result});
            break;
    }
    respond.json(results);
});


app.listen(port, () => console.log(`Listening on port ${port}`));