function calc() {
    console.log("called")
    const formula = {
        first: document.getElementById("first").value,
        second: document.getElementById("second").value,
        operator: document.getElementById("operator").value
    };

    const xhr = new window.XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            const p = document.getElementsByTagName("p")[0];
            p.textContent = JSON.stringify(JSON.parse(xhr.responseText));
        }
    };

    xhr.open("POST", "http://localhost:8000/calc", true);
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    xhr.send(JSON.stringify(formula));
}