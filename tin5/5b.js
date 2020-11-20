function Student(name, surname, id, grades) {
    this.name = name;
    this.surname = surname;
    this.gradesList = grades;

    this.printAvgGrades = () =>  {

        let allGrades = 0.0;
        for (let i = 0; i < this.gradesList.length; i++)
            allGrades += this.gradesList[i];

        const avgGrade = allGrades / this.gradesList.length;
        return "Name: " + this.name + "\n" +
            "Surname: " + " " + this.surname + "\n" +
            "Average grade: " + avgGrade;
    };
}

const johnDoe = new Student("John", "Doe", 1, [2, 5, 4, 3]);
console.log(johnDoe.printAvgGrades());

