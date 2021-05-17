// --------------------------------------------------
// GLOBALES
// --------------------------------------------------

let frmPagar = null;
let btnPagar = null;

let frmComentar = null;
let btnComentar = null;

// --------------------------------------------------
// LOAD
// --------------------------------------------------

$(() => {

    // obtenemos controles
    frmPagar = $("form#frmPagar");
    btnPagar = $("#btnPagar");
    
    frmComentar = $("form#frmComentar");
    btnComentar = $("button#btnComentar");

    // iniciamos eventos de formularios
    frmPagar.on('submit', (e) => {
        e.preventDefault();
        onFrmPagarSubmit();
    });

    frmComentar.on('submit', (e) => {
        e.preventDefault();
        onFrmComentarSubmit();
    });

    // buscamos parametros en la url
    const params = new URLSearchParams(window.location.search);

    if (!params.has("id")) {
        window.location = "/index.php";
        return;
    }

    let id = params.get("id"); 

    if (isNaN(id) || id <= 0) {
        window.location = "/index.php";
        return;
    }

    id_curso = parseInt(id);

    // eventos de diseño
    $(window).scroll(() => {

        let wrapperPrecio = $(".precio");

        if(window.scrollY > 0) {
            wrapperPrecio.addClass("sticky");
        } else {
            wrapperPrecio.removeClass("sticky");
        }
    });

    // nos traemos la info del curso
    fillCurso(id_curso);
    fillNiveles(id_curso);
});

// --------------------------------------------------
// VENTA
// --------------------------------------------------

const onFrmPagarSubmit = () => {

    switchButtonSpinner(btnPagar);

    let nodo = validaCamposPago();

    if (nodo == null) {
        switchButtonSpinner(btnPagar);
        return;
    }

    if (!confirm("¿Seguro que desea realizar el pago?")) {
        return;
    }

    existsVenta(nodo).done((result) => {

        let existe = (result !== undefined && result !== "") && result === "1";

        if (result === undefined || result === "") {
            switchButtonSpinner(btnPagar);
            return;
        }

        // existe
        if (existe) {
            toastr_error("Ya a adquirido este curso/nivel anteriormente");
            switchButtonSpinner(btnPagar);
            return;
        }
        
        crearVenta(nodo).done((result) => {
        
            if (result === undefined || result === "") {
                switchButtonSpinner(btnPagar);
                return;
            }
            
            toastr_success("Se ha realizado la compra con éxito");
            toastr_info("Redirigiendo al curso...");

            setTimeout(() => {

                window.location = "/mods/curso_learning/curso_learning.php?id=" + result;
                
            }, 1000);
        })
        .fail((jqXHR) => {
            toastr_error(jqXHR.responseText);
            switchButtonSpinner(btnPagar);
            return;
        });
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        switchButtonSpinner(btnPagar);
        return;
    });
};

const onBtnPagarClick = () => {
    $("input#txtIdNivelCurso").val("0");
    frmPagar.submit();
};

const onBtnCompraIndividual = (id_nivel_curso) => {
    $("input#txtIdNivelCurso").val(id_nivel_curso);
};

const crearVenta = (nodo) => {

    return $.ajax({ 
        url: AJAX_URL_VENTA_CONTROLLER,
        data: { action: AJAX_URL_VENTA_CONTROLLER_CREATE, nodo: JSON.stringify(nodo) },
        type: 'post'
    });
};

const existsVenta = (nodo) => {

    return $.ajax({ 
        url: AJAX_URL_VENTA_CONTROLLER,
        data: { action: AJAX_URL_VENTA_CONTROLLER_EXISTS, nodo: JSON.stringify(nodo) },
        type: 'post'
    });
};

const fillCurso = (id_curso) => {

    // obtenemos el curso por su id
    getCursoById(id_curso).done((result) => {

        if (result === undefined || result === "") {
            window.location = "/index.php";
            return;
        }

        // se obtiene el curso
        // console.log(result);

        // se parse
        let nodo = JSON.parse(result);

        // datos basicos
        $("input#txtId").val(nodo.id_curso);
        $("#title").text(nodo.titulo);
        $("#subtitle").text(nodo.subtitulo);
        $("#lblAutor").text(nodo.nick_usuario);
        $("#btnEnviarMensaje").attr("href", "/mods/messages/messages.php?id=" + nodo.id_usuario);
        $("#description").text(nodo.descripcion);
        $("#price").text("$ " + nodo.precio + " MXN");
        $("#votos_positivos").text(nodo.votos_positivos);
        $("#votos_negativos").text(nodo.votos_negativos);

        // imagen
        $('#image').css('background-image', !isKk(nodo.tipo_imagen) ? `url(data:${nodo.tipo_imagen};base64,${nodo.imagen})` : "url(https://picsum.photos/600/280)");

        // comentarios
        fillComentarios(nodo.id_curso);
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

const fillNiveles = (id_curso) => {

    let container = $("#niveles");
    container.html("");

    // niveles por curso
    getAllNivelByCurso(id_curso).done((result) => {

        // console.log(result);
        if (isEmptyOrNull(result)) {

            container.html("");
            return;
        }

        let rows = JSON.parse(result);
    
        rows.forEach((value, idx) => {
        
            let element = `
            <li class="list-group-item d-flex justify-content-between align-items-center">
                <div class="input-group input-group-sm justify-content-end">
                    <input type="text" class="form-control" readonly value="${value.titulo}">
                </div>
            </li>
            `;

            /*
            
                    <span class="input-group-text">$</span>
                    <span class="input-group-text">${value.precio} MXN</span>
                    <a onclick="onBtnCompraIndividual(${value.id_nivel_curso});" href="#!" class="btn btn-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                        Compra individual
                    </a>
                    
             */
    
            container.append(element);
        });
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

const getCursoById = (id_curso) => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_CURSO_CONTROLLER_GET_BYID, nodo: id_curso },
        type: 'post'
    });
};

const getAllNivelByCurso = (id_curso) => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_NIVELCURSO_CONTROLLER_GETALL_BYCURSO, nodo: id_curso },
        type: 'post'
    });
};

const validaCamposPago = () => {

    let method = $("select#slMetodoPago").val();
    let cardid = $("input#ccn").val();
    let month = $("select#txtTarjVencimiento").val();
    let year = $("select#txtTarjAnio").val();
    let cvv = $("input#txtCvv").val();
    
    if (isEmptyOrNull(method)) {

        message_warning("Seleccione el método de pago");
        return null;
    }
    
    if (isEmptyOrNull(cardid)) {

        message_warning("Ingrese el número de tarjeta");
        return null;
    }
    
    if (isEmptyOrNull(month)) {

        message_warning("Seleccione el mes de vencimiento de su tarjeta");
        return null;
    }
    
    if (isEmptyOrNull(year)) {

        message_warning("Seleccione el año de vencimiento de su tarjeta");
        return null;
    }
    
    if (isEmptyOrNull(cvv)) {

        message_warning("Ingrese el código de seguridad de su tarjeta");
        return null;
    }

    if(isNaN(cardid)){

        message_warning("El número de tarjeta debe ser númerico");
        return null;
    }

    if(isNaN(cvv)){

        message_warning("El código de seguridad de su tarjeta debe ser númerico");
        return null;
    }

    return {
        id_venta: 0,
        id_usuario: 0,
        id_curso: $("input#txtId").val(),
        id_nivel_curso: $("input#txtIdNivelCurso").val(),
        monto_pago: 0,
        forma_pago: method,
        fecha_finalizacion: "",
        fecha_alta: "",
        fecha_mod: ""
    };
};

// --------------------------------------------------
// COMENTARIO
// --------------------------------------------------

const onFrmComentarSubmit = () => {

    switchButtonSpinner(btnComentar);

    let nodo = validarComentario();

    if (nodo == null) {
        switchButtonSpinner(btnComentar);
        return;
    }

    existsComentario(nodo).done((result) => {

        let existe = (result !== undefined && result !== "") && result === "1";

        if (result === undefined || result === "") {
            switchButtonSpinner(btnComentar);
            return;
        }

        // existe
        if (existe) {
            toastr_error("Ya a realizado un comentario acerca de este curso");
            switchButtonSpinner(btnComentar);
            return;
        }
        
        crearComentario(nodo).done((result) => {
        
            if (result === undefined || result === "") {
                switchButtonSpinner(btnComentar);
                return;
            }

            $("#thumbUp").removeClass("active");
            $("#thumbDown").removeClass("active");
            $("textarea#Commentary").val("");

            fillCurso($("input#txtId").val());
            
            switchButtonSpinner(btnComentar);
            toastr_success("Se ha realizado el comentario");
        })
        .fail((jqXHR) => {
            toastr_error(jqXHR.responseText);
            switchButtonSpinner(btnComentar);
            return;
        });
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        switchButtonSpinner(btnComentar);
        return;
    });
};

const onThumbClickValoracion = (element) => {

    let clickedThumb = $(element);
    let thumbUp = $("#thumbUp");
    let thumbDown = $("#thumbDown");

    thumbUp.removeClass("active");
    thumbDown.removeClass("active");
    clickedThumb.addClass("active");
};

const validarComentario = () => {

    let comentario = $("textarea#Commentary").val();
    let valoracion = $("#thumbUp").hasClass('active') ? 1 : ($("#thumbDown").hasClass('active') ? 0 : -1);
    
    if (isEmptyOrNull(comentario)) {

        message_warning("Ingrese su comentario");
        return null;
    }

    if (valoracion == -1) {

        message_warning("Seleccione una valoración");
        return null;
    }
        
    return {
        id_comentario: 0,
        id_curso: $("input#txtId").val(),
        id_usuario: 0,
        comentario: comentario,
        valoracion: valoracion,
        fecha_alta: "",
        fecha_mod: ""
    };
};

const fillComentarios = (id_curso) => {

    let container = $("#comentarios");
    container.html("");

    // niveles por curso
    getAllComentarioByCurso(id_curso).done((result) => {

        // console.log(result);
        if (isEmptyOrNull(result)) {

            container.html("");
            return;
        }

        let rows = JSON.parse(result);
    
        rows.forEach((value, idx) => {

            let imageSrc = value.tipo_imagen_usuario !== undefined && value.tipo_imagen_usuario !== null && value.tipo_imagen_usuario !== ""
                ? `url(data:${value.tipo_imagen_usuario};base64,${value.imagen_usuario})` 
                : "url(/res/examples/user.png)";
        
            let element = `
            <div class="comentario mb-3 p-2">
                <div class="d-flex">
                    <div style="background-image: ${imageSrc}" class="imagen-usuario rounded-circle me-4"></div>
                    <div class="contenido w-100">
                        <div class="usuario d-flex justify-content-start align-items-center">
                            <h5 class="mb-0 me-2">
                                ${value.nick_usuario}
                            </h5>
                            <small class="votacion">
                                <i class="fas fa-thumbs-up ${value.valoracion == 1 ? "active" : ""} me-2"></i>
                                <i class="fas fa-thumbs-down ${value.valoracion == 0 ? "active" : ""} me-2"></i>
                            </small>
                        </div>
                        <p class="mb-2">
                            ${value.comentario}
                        </p>
                    </div>
                </div>
            </div>
            `;
    
            container.append(element);
        });
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

const crearComentario = (nodo) => {

    return $.ajax({ 
        url: AJAX_URL_COMENTARIO_CONTROLLER,
        data: { action: AJAX_URL_COMENTARIO_CONTROLLER_CREATE, nodo: JSON.stringify(nodo) },
        type: 'post'
    });
};

const existsComentario = (nodo) => {

    return $.ajax({ 
        url: AJAX_URL_COMENTARIO_CONTROLLER,
        data: { action: AJAX_URL_COMENTARIO_CONTROLLER_EXISTS, nodo: JSON.stringify(nodo) },
        type: 'post'
    });
};

const getAllComentarioByCurso = (id_curso) => {

    return $.ajax({ 
        url: AJAX_URL_COMENTARIO_CONTROLLER,
        data: { action: AJAX_URL_COMENTARIO_CONTROLLER_GETALL_BYCURSO, nodo: id_curso },
        type: 'post'
    });
};