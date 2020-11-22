const addParagraph = () => {
    setTimeout(() => {
        const node = document.createElement("p");
        node.innerHTML="some paragraph";
        document.getElementById("a").appendChild(node);
    },5000);
}
addParagraph()