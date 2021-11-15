// --------------------------------------------------
// GLOBALES
// --------------------------------------------------
    
let id_curso = 0;
let id_nivel_curso = 0;

// --------------------------------------------------
// LOAD
// --------------------------------------------------

$(() => {

    // buscamos parametros en la url
    const params = new URLSearchParams(window.location.search);

    if (!params.has("id")) {
        window.location = "/index.php";
        return;
    }

    id_curso = parseInt(params.get("id")); 
    id_nivel_curso = params.has("id_nivel_curso") ? parseInt(params.get("id_nivel_curso")) : 0; 

    if (isNaN(id_curso) || id_curso <= 0) {
        window.location = "/index.php";
        return;
    }

    // nos traemos la info del curso
    fillCurso(id_curso);
    fillNiveles(id_curso);

    if (id_nivel_curso > 0) {

        fillNivelCurso(id_nivel_curso);

        crearHistorial(id_nivel_curso).done((result) => {

            if (result === undefined || result === "") {
                return;
            }
        })
        .fail((jqXHR) => {
            toastr_error(jqXHR.responseText);
            return;
        });
    }
});

// --------------------------------------------------
// EVENTOS
// --------------------------------------------------

// --------------------------------------------------
// METODOS
// --------------------------------------------------

const fillCurso = (id_curso) => {

    // obtenemos el curso por su id
    getCursoById(id_curso).done((result) => {

        if (result === undefined || result === "") {
            window.location = "/index.php";
            return;
        }

        // se parse
        let nodo = JSON.parse(result);

        // datos basicos
        $("#title").text(nodo.titulo);
        $("#subtitle").text(nodo.subtitulo);
        $("#description").text(nodo.descripcion);

        document.title = "OurLib © - " + nodo.titulo;

        // imagen
        let image = !isKk(nodo.tipo_imagen) && nodo.imagen !== "" ? `url(data:${nodo.tipo_imagen};base64,${nodo.imagen})` 
            : "url(https://picsum.photos/600/280)";

        $('#image').css('background-image', image);
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
            <a href="/mods/curso_learning/curso_learning.php?id=${value.id_curso}&id_nivel_curso=${value.id_nivel_curso}" class="list-group-item list-group-item-action">
                <strong>
                    ${value.titulo}
                </strong>
            </a>
            `;
    
            container.append(element);
        });
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

const fillNivelCurso = (id_nivel_curso) => {

    // obtenemos el curso por su id
    getNivelCursoById(id_nivel_curso).done((result) => {

        if (result === undefined || result === "") {
            return;
        }

        // se parsea
        let nodo = JSON.parse(result);

        // nivel
        $("#titlenivel").text(nodo.titulo);
        
        // se obtienen archivos del nivel
        fillArchivoNivel(id_nivel_curso);

        // se carga el primer video
        getArchivoNivelByFirstVideo(id_nivel_curso).done((result) => {

            if (result === undefined || result === "") {
                return;
            }

            // se parsea
            let multimedia = JSON.parse(result);

            let videoContainer = $("#videonivel");
            let blobsPathIdx = multimedia.ruta.indexOf("blobs");
            let relativePath = multimedia.ruta.substr(blobsPathIdx, multimedia.ruta.length);
            let finalPath = decodeURI(location.host) + "\\" + decodeURI(relativePath);

            videoContainer.html("");
            videoContainer.attr('src', "http://" + finalPath);
            // videoContainer.load();
        })
        .fail((jqXHR) => {
            toastr_error(jqXHR.responseText);
            return;
        });
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

const fillArchivoNivel = (id_nivel_curso) => {

    let container = $("#ulNivelArchivos");
    container.html("");

    // categorias por curso
    getAllArchivoNivelByNivel(id_nivel_curso).done((result) => {

        // console.log(result);
        if (isEmptyOrNull(result)) {

            container.html("");
            return;
        }

        let rows = JSON.parse(result);
    
        rows.forEach((value, idx) => {
        
            let element = `
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    <a href="/multimedia.php?id=${value.id_multimedia_nivel}" target="_blank">
                        ${value.nombre}
                    </a>
                </li>
            `;
    
            container.append(element);
        });
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

const getAllNivelByCurso = (id_curso) => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_NIVELCURSO_CONTROLLER_GETALL_BYCURSO, nodo: id_curso },
        type: 'post'
    });
};

const getNivelCursoById = (id_nivel_curso) => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_NIVELCURSO_CONTROLLER_GET_BYID, nodo: id_nivel_curso },
        type: 'post'
    });
};

const getAllArchivoNivelByNivel = (id_nivel_curso) => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_ARCHIVONIVEL_CONTROLLER_GETALL_BYNIVEL, nodo: id_nivel_curso },
        type: 'post'
    });
};

const getArchivoNivelByFirstVideo = (id_nivel_curso) => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_CURSO_CONTROLLER_GET_BYFIRSTVIDEO, nodo: id_nivel_curso },
        type: 'post'
    });
};

const crearHistorial = (id_nivel_curso) => {

    return $.ajax({ 
        url: AJAX_URL_HISTORIALUSUARIO_CONTROLLER,
        data: { action: AJAX_URL_HISTORIALUSUARIO_CONTROLLER_CREATE, nodo: id_nivel_curso },
        type: 'post'
    });
};