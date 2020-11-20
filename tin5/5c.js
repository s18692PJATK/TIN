const courses = ["first","second","third"];

function Student(name, surname){
    this.name = name;
    this.surname = surname;
}

Student.prototype.courses = courses;

const student = new Student("John", "Doe");
console.log(student.courses);