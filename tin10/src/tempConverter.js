exports.kelvin = () => {
    const a = parseFloat(document.getElementById("kelvin").value);
    document.getElementById("celsius").value = fromKelvinToCelsius(a);
    document.getElementById("fahrenheit").value = fromCelsiusToFahr(fromKelvinToCelsius(a));
}

exports.celsius = () => {
    const a = parseFloat(document.getElementById("celsius").value);
    document.getElementById("kelvin").value = fromCelsiusToKelvin(a);
    document.getElementById("fahrenheit").value = fromCelsiusToFahr(a);
}

exports.fahrenheit = () => {
    const a = parseFloat(document.getElementById("fahrenheit").value);
    document.getElementById("kelvin").value = fromCelsiusToKelvin(fromFahrToCelsius(x));
    document.getElementById("celsius").value = fromFahrToCelsius(a);
}

const fromCelsiusToKelvin = x => x  - 273.15;
const fromKelvinToCelsius = x => x + 273.15;
const fromCelsiusToFahr = x => (9/5 * x) + 32;
const fromFahrToCelsius = x => (5/9 * x) - 32;