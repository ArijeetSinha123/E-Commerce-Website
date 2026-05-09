document.addEventListener("DOMContentLoaded", function () {
    var alerts = document.querySelectorAll(".success, .error");

    alerts.forEach(function (alert) {
        alert.setAttribute("role", "status");
    });
});
