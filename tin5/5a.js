let getDogData = function(object){
    let data;
    let string = "";
    for(let elem in object){
        data = object[elem];
        string += elem + "    " + typeof(data) + "\n";
    }
    return string;
}

const dog = {
    id:1,
    name:"Tippy",
    hasTail:true,

    whatIsYourName: function () {
        console.log("My name is " + this.name);
    },
    getId: function() {
        console.log(this.id);
    }
}

console.log(getDogData(dog));