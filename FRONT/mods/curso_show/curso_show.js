$(() => {

    $(window).scroll(() => {

        let wrapperPrecio = $(".precio");

        if(window.scrollY > 0) {
            wrapperPrecio.addClass("sticky");
        } else {
            wrapperPrecio.removeClass("sticky");
        }
    });

    $("#btnPagar").on("click", () => {

        if (confirm("¿Seguro que desea realizar el pago?")) {
            toastr_success("Curso adquirido, ve a inicio para ver tus cursos para comenzar a aprender");
        }

        window.location = "/mods/curso_learning/curso_learning.php?id=0";

    });
});