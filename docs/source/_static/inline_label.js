document.addEventListener("DOMContentLoaded", function() {
    document.querySelectorAll(".math.display").forEach((el, index) => {
        const label = el.querySelector("a.math-anchor");
        if (label) {
            el.setAttribute("data-equation-number", label.innerText);
            label.style.display = "none"; // Hide the top label
        }
    });
});
