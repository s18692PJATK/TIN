const temp = require('./tempConverter');
const distance = require('./distanceConverter');

const addListener = name => (type, value) => document.getElementById(name).addEventListener(type,value);
window.onload = () => {
    addListener("celsius")('change', temp.celsius);
    addListener("celsius")('input', temp.celsius);
    addListener("fahrenheit")('change', temp.fahrenheit);
    addListener("fahrenheit")('input', temp.fahrenheit);
    addListener("kelvin")('change', temp.kelvin);
    addListener("kelvin")('input', temp.kelvin);
    addListener("kilometers")('change', distance.kilometers);
    addListener("kilometers")('input', distance.kilometers);
    addListener("miles")('change', distance.miles);
    addListener("miles")('input', distance.miles);
}