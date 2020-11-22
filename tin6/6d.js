const addRow = () => {
    const name = document.form.name.value;
    const surname = document.form.surname.value;
    const table = document.getElementById('table');
    const length = table.getElementsByTagName("tr").length;
    const row = document.getElementById('table').insertRow(length);
    const rowName = row.insertCell(0);
    const rowSurname = row.insertCell(1);
    rowName.innerText = name;
    rowSurname.innerText = surname;
}