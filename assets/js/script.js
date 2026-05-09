document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".success, .error").forEach(function (message) {
        message.setAttribute("role", "status");
    });
});
