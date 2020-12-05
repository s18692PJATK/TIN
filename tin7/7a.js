const http = require("http")
const url = require("url")
const validOperations = ["add", "sub", "div", "mul"].map(o => "/" + o)

const server = http.createServer((req, res) => {
    const operation = req.url.split("?")[0];
    if (!validOperations.includes(operation)) {
        res.write("operation is invalid!");
        res.end();
    }
    else {
        const result = getResult(operation, req)
        res.write(result);
        res.end();
    }
})
server.listen(8888);

const getResult = (operation, req) => {
    const query = url.parse(req.url, true).query
    const first = parseInt(query.first)
    const second = parseInt(query.second)
    if (first && second)
        return first + " " + operationToString(operation) + " " + second + " = " + calculate(first, second, operation)

    else
        return "You passed incorrect parameters";
}


const calculate = (first, second, operation) => {
    switch (operation) {
        case "/add":
            return first + second
        case "/sub":
            return first - second
        case "/div":
            return second === 0 ? "can't divide by zero" : first / second
        case "mul":
            return first * second
        default:
            return operation
    }
}


const operationToString = op => {
    switch (op) {
        case "/add":
            return "+"
        case "/sub":
            return "-"
        case "/div":
            return "/"
        case "mul":
            return "*"
    }
}