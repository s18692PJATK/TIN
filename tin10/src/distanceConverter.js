exports.kilometers = () => {
    const a = parseFloat(document.getElementById("kilometers").value);
    document.getElementById("miles").value = (a * kiloToMile);
}

exports.miles = () => {
    const a = parseFloat(document.getElementById("miles").value);
    document.getElementById("kilometers").value = (a / kiloToMile);
}
const kiloToMile = 0.62137;
