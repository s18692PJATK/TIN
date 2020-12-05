const fs = require("fs");
const fun = path => {
    const file = fs.readdirSync(path);
    console.log("Watching directory " + path);
    console.log(file);

    fs.watch(path,"utf-8",(event, trigger) => {
        console.log(event + " in the file " + trigger);
    })
}

fun("./tin7/myDirectory");