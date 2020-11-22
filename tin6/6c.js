
const validateForm = () => {
    const emailB = validateEmail();
    const nameB = validateName();
    const ageB = validateAge();
    return emailB && nameB && ageB;
}
const validateEmail = () => {
    const email = document.form.email.value;
    const isValid = email.includes("@")
    if(!isValid)
        document.form.email.style.background="red";
    return isValid;

}
const validateName = () => {
    const regex = new RegExp("[A-Z][a-z]*");
    const name = document.form.name.value;
    const isValid = regex.test(name);
    if(!isValid)
        document.form.name.style.background="red";
    return isValid;
}
const validateAge = () => {
    const age = document.form.age.value;
    const isValid = age > 18;
    if(!isValid)
        document.form.age.style.background="red";
    return isValid;
}
