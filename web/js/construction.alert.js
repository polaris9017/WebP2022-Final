var divElement = document.querySelector("#page");
divElement.addEventListener('click', e => {
    if (e.target.id === "") {
        const alertPlaceholder = document.getElementById('alert_area');

        const alert = msg => {
            alertPlaceholder.innerHTML = [`<div class="alert alert-danger alert-dismissible" role="alert">`, `   <div>${msg}</div>`, '   <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>', '</div>'].join('');
        };

        alert('Construction in progress!');
    }
});
