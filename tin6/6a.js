// var inputElement = document.createElement('input')
// document.getElementById("nodeGoto").addEventListener("click",function () {
//
// })
const convert = () => {
    const input = document.getElementById("input").value;
    document.getElementById("output").innerHTML=celsiusToFahrenheit(input);
}
const celsiusToFahrenheit = x =>
    32 + (9/5 * x);
const fahrenheitToCelsius = x => 5/9 * x - 32
