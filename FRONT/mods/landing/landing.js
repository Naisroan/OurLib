$(() => {

    fillCursosByUsuarioLogeado();
    fillCursosAdquiridosByUsuarioLogeado();
    fillCursosRecientes();
    fillCursosMasVendidos();
    fillCursosPopulares();
});

const fillCursosByUsuarioLogeado = () => {

    let container = $("#cursossubidos");
    container.html("");

    // categorias por curso
    getAllCursosByUsuarioLogeado().done((result) => {

        // console.log(result);
        if (isEmptyOrNull(result)) {

            container.html("");
            return;
        }

        let rows = JSON.parse(result);
    
        rows.forEach((value, idx) => {
            container.append(crearElementoCursoSubido(value));
        });
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

const fillCursosAdquiridosByUsuarioLogeado = () => {

    let container = $("#cursosadquiridos");
    container.html("");

    // categorias por curso
    getAllByAdquiridoByUsuario().done((result) => {

        // console.log(result);
        if (isEmptyOrNull(result)) {

            container.html("");
            return;
        }

        let rows = JSON.parse(result);
    
        rows.forEach((value, idx) => {
            container.append(crearElementoCursoAdquirido(value));
        });
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

const fillCursosRecientes = () => {

    let container = $("#cursosrecientes");
    container.html("");

    // categorias por curso
    getAllRecientes().done((result) => {

        // console.log(result);
        if (isEmptyOrNull(result)) {

            container.html("");
            return;
        }

        let rows = JSON.parse(result);
    
        rows.forEach((value, idx) => {
            container.append(crearElementoCurso(value));
        });
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

const fillCursosMasVendidos = () => {

    let container = $("#cursosmasvendidos");
    container.html("");

    // categorias por curso
    getAllMasVendidos().done((result) => {

        // console.log(result);
        if (isEmptyOrNull(result)) {

            container.html("");
            return;
        }

        let rows = JSON.parse(result);
    
        rows.forEach((value, idx) => {
            container.append(crearElementoCurso(value));
        });
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

const fillCursosPopulares = () => {

    let container = $("#cursosmasvistos");
    container.html("");

    // categorias por curso
    getAllPopulares().done((result) => {

        // console.log(result);
        if (isEmptyOrNull(result)) {

            container.html("");
            return;
        }

        let rows = JSON.parse(result);
    
        rows.forEach((value, idx) => {
            container.append(crearElementoCurso(value));
        });
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

const getAllCursosByUsuarioLogeado = () => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_CURSO_CONTROLLER_GETALL_BYUSUARIOLOGEADO, nodo: {} },
        type: 'post'
    });
};

const getAllByAdquiridoByUsuario = () => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_CURSO_CONTROLLER_GETALL_ADQUIRIDOBYUSUARIO, nodo: {} },
        type: 'post'
    });
};

const getAllRecientes = () => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_CURSO_CONTROLLER_GETALL_RECIENTES, nodo: {} },
        type: 'post'
    });
};

const getAllMasVendidos = () => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_CURSO_CONTROLLER_GETALL_MASVENDIDOS, nodo: {} },
        type: 'post'
    });
};

const getAllPopulares = () => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_CURSO_CONTROLLER_GETALL_POPULARES, nodo: {} },
        type: 'post'
    });
};

const crearElementoCursoSubido = (nodo) => {

    let imageSrc = nodo.tipo_imagen !== undefined && nodo.tipo_imagen !== null && nodo.tipo_imagen !== ""
        ? `url(data:${nodo.tipo_imagen};base64,${nodo.imagen})` 
        : "url(https://picsum.photos/280/150)";

    return `
    <div class="card-wrapper col-6 col-lg-4 col-xl-3">
        <div class="card">
            <div style="background-image: ${imageSrc};" class="card-img-top curso-image"></div>
            <div class="card-body">
                <h5 class="card-title">
                    ${nodo.titulo}
                    <!--
                    <small>
                        <span class="badge bg-secondary fw-normal">
                            ${nodo.nick_usuario} 
                        </span>
                    </small>
                    -->
                    <small class="d-block text-muted">
                        ${nodo.subtitulo}
                    </small>
                </h5>
                <p class="card-text">
                    ${nodo.descripcion}
                </p>
                <a href="/mods/curso_detail/curso_detail.php?id=${nodo.id_curso}" class="btn btn-sm btn-bisonteca w-100 justify-content-center">
                    <i class="fas fa-edit fs-5 me-2"></i>
                    <span class="fw-normal fs-5">Editar</span>
                </a>
            </div>
        </div>
    </div>
    `;
};

const crearElementoCursoAdquirido = (nodo) => {

    let imageSrc = nodo.tipo_imagen !== undefined && nodo.tipo_imagen !== null && nodo.tipo_imagen !== ""
        ? `url(data:${nodo.tipo_imagen};base64,${nodo.imagen})` 
        : "url(https://picsum.photos/280/150)";

    return `
    <div class="card-wrapper col-6 col-lg-4 col-xl-3">
        <div class="card">
            <div style="background-image: ${imageSrc};" class="card-img-top curso-image"></div>
            <div class="card-body">
                <h5 class="card-title">
                    ${nodo.titulo}
                    <!--
                    <small>
                        <span class="badge bg-secondary fw-normal">
                            ${nodo.nick_usuario} 
                        </span>
                    </small>
                    -->
                    <small class="d-block text-muted">
                        ${nodo.subtitulo}
                    </small>
                </h5>
                <p class="card-text">
                    ${nodo.descripcion}
                </p>
                <a href="/mods/curso_learning/curso_learning.php?id=${nodo.id_curso}" class="btn btn-sm btn-bisonteca w-100 justify-content-center">
                    <i class="fas fa-info fs-5 me-2"></i>
                    <span class="fw-normal fs-5">Aprender</span>
                </a>
            </div>
        </div>
    </div>
    `;
};

const crearElementoCurso = (nodo) => {

    let imageSrc = nodo.tipo_imagen !== undefined && nodo.tipo_imagen !== null && nodo.tipo_imagen !== ""
        ? `url(data:${nodo.tipo_imagen};base64,${nodo.imagen})` 
        : "url(https://picsum.photos/280/150)";

    return `
    <div class="card-wrapper col-6 col-lg-4 col-xl-3">
        <div class="card">
            <div style="background-image: ${imageSrc};" class="card-img-top curso-image"></div>
            <div class="card-body">
                <h5 class="card-title">
                    ${nodo.titulo}
                    <!--
                    <small>
                        <span class="badge bg-secondary fw-normal">
                            ${nodo.nick_usuario} 
                        </span>
                    </small>
                    -->
                    <small class="d-block text-muted">
                        ${nodo.subtitulo}
                    </small>
                </h5>
                <p class="card-text">
                    ${nodo.descripcion}
                </p>
                <a href="/mods/curso_show/curso_show.php?id=${nodo.id_curso}" class="btn btn-sm btn-bisonteca w-100 justify-content-center">
                    <i class="fas fa-info fs-5 me-2"></i>
                    <span class="fw-normal fs-5">Mas información</span>
                </a>
            </div>
        </div>
    </div>
    `;
};