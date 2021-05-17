// --------------------------------------------------
// GLOBALES
// --------------------------------------------------
let id_curso = 0;

// --------------------------------------------------
// LOAD
// --------------------------------------------------

$(() => {

    id_curso = $("#txtId").val();
    fillCurso(id_curso);
});

// --------------------------------------------------
// METODOS
// --------------------------------------------------

const fillCurso = (id_curso) => {

    // obtenemos el curso por su id
    getCursoById(id_curso).done((result) => {

        if (result === undefined || result === "") {
            return;
        }

        // se parsea
        let nodo = JSON.parse(result);

        // datos basicos
        $("#curso").text(nodo.titulo);

        document.title = "Bisonteca © - Certificado- " + nodo.titulo;

        fillUsuarioAutorCurso(nodo.id_usuario);

        // imagen
        // $('#image').css('background-image', !isKk(nodo.tipo_imagen) ? `url(data:${nodo.tipo_imagen};base64,${nodo.imagen})` : "url(https://picsum.photos/600/280)");
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

const fillUsuarioAutorCurso = (id_usuario) => {

    // obtenemos el curso por su id
    getUsuarioById(id_usuario).done((result) => {

        if (result === undefined || result === "") {
            return;
        }

        // se parse
        let nodo = JSON.parse(result);

        // datos basicos
        $('#image').attr('src', nodo.tipo_imagen ? `data:${nodo.tipo_imagen};base64,${nodo.imagen}` : "/certificado/public/user.png");
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

// --------------------------------------------------
// METODOS AJAX
// --------------------------------------------------

const getCursoById = (id_curso) => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_CURSO_CONTROLLER_GET_BYID, nodo: id_curso },
        type: 'post'
    });
};

const getUsuarioById = (id_usuario) => {

    return $.ajax({
        url: AJAX_URL_USER_CONTROLLER,
        data: { action: AJAX_URL_USER_CONTROLLER_GET_BYID, nodo: id_usuario },
        type: 'post'
    });
};