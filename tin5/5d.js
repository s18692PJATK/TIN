function Student(name, surname, gradesList) {
    this.name = name;
    this.surname = surname;
    this.gradesList = gradesList;

    this.getAvgGrade = () =>  {

        let allGrades = 0.0;
        for (let i = 0; i < this.gradesList.length; i++)
            allGrades += this.gradesList[i];
        return allGrades / this.gradesList.length;
    };

    this.setFullName = fullName =>  {
        const splitName = fullName.split(" ");
        this.name = splitName[0] || "";
        this.surname = splitName[1] || "";
    };

    this.getFullName = () =>  {
        return this.name + " " + this.surname;
    };


}


const student = new Student("John", "Doe", [1,1,1,1]);
student.setFullName("Jan Kowalski");
console.log(student.getFullName() + " has average " + student.getAvgGrade() );