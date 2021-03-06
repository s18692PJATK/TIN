class Person {
    constructor(name, surname) {
        this.name = name;
        this.surname = surname;
    }

    get getFullName() {
        return this.name + " " + this.surname;
    }

    set setFullName(fullName) {
        const splitName = fullName.split(" ");
        this.name = splitName[0] || "";
        this.surname = splitName[1] || "";
    }
}

class Student extends Person {
    constructor(name, surname, gradesList) {
        super();
        this.gradesList = gradesList;
    }

    get printStudentInfo() {
        return "Name: " + this.name + "\n" +
            "Surname: " + " " + this.surname + "\n" +
            "Average grade: " + this.getAvgGrade;
    }

    get getAvgGrade() {
        let allGrades = 0.0;
        for (let i = 0; i < this.gradesList.length; i++)
            allGrades += this.gradesList[i];
        return allGrades / this.gradesList.length;
    }

}

const student = new Student("John", "John", [1,2,1,5]);
student.setFullName = "Jan Kowalski";
console.log(student.getFullName + " has average " + student.getAvgGrade );
console.log(student.printStudentInfo);
