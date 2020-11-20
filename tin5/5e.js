class Student {
    constructor(name, surname, gradesList) {
        this.name = name;
        this.surname = surname;
        this.gradesList = gradesList;
    }

    get getAvgGrade() {
        let allGrades = 0.0;
        for (let i = 0; i < this.gradesList.length; i++)
            allGrades += this.gradesList[i];
        return allGrades / this.gradesList.length;
    }

    get getFullName() {
        return this.name + " " + this.surname;
    }

    set setFullName(fullName) {
        let splitName = fullName.split(" ");
        this.name = splitName[0] || "";
        this.surname = splitName[1] || "";
    }


    get printStudentInfo() {
        return "Name: " + this.name + "\n" +
            "Surname: " + " " + this.surname + "\n" +
            "Average grade: " + this.getAvgGrade;
    }
}

const student = new Student("John", "John", [1,2,1,5]);
student.setFullName = "Jan Kowalski";
console.log(student.getFullName + " has average " + student.getAvgGrade );
console.log(student.printStudentInfo);
