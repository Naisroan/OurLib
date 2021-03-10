$(() => {

    $(window).scroll(() => {

        let wrapperPrecio = $(".precio");

        if(window.scrollY > 0) {
            wrapperPrecio.addClass("sticky");
        } else {
            wrapperPrecio.removeClass("sticky");
        }
    });
    
});

// Validate empty inputs for commentary section

const validarComentario = () => {


    let comentario = $("textarea#Commentary").val();
    

    if (isEmptyOrNull(comentario)) {

        message_warning("Necesita escribir un comentario!");
        return;
    }

    message_success("Se ha posteado su comentario!");

};

// Validate empty inputs for buy section

const validarCompra = () => {

    
    let method = $("input#slMetodoPago").val();
    let cardid = $("input#ccn").val();
    let month = $("select#txtTarjVencimiento").val();
    let year = $("select#txtTarjAnio").val();
    let cvv = $("input#txtCvv").val();
    

    if (isEmptyOrNull(method) || isEmptyOrNull(cardid)  || isEmptyOrNull(month) || isEmptyOrNull(year) ||isEmptyOrNull(cvv)) {

        message_warning("Necesita llenar todos los datos!");
        return;

    }


    if(!NumberOnly(cardid) || !NumberOnly(cvv) || !NumberOnly(year) ){

        message_warning("Solo carácteres númericos son permitidos");
        return;

    }

    if (confirm("¿Seguro que desea realizar el pago?")) {
         message_success("Se ha comprado el curso con éxito!");
        toastr_success("Curso adquirido, ve a inicio para ver tus cursos para comenzar a aprender");
         window.location = "/mods/curso_learning/curso_learning.php?id=0";
     }
    
    

};