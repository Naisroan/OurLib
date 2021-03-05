$(() => {

    $(window).scroll(() => {

        let wrapperPrecio = $(".precio");

        if(window.scrollY > 0) {
            wrapperPrecio.addClass("sticky");
        } else {
            wrapperPrecio.removeClass("sticky");
        }
    });

    $("#btnComprar").on("click", () => {
        toastr_success("Curso adquirido, ve a la sección de mis cursos para comenzar a aprender");
    });
});