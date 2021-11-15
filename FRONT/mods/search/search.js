// --------------------------------------------------
// GLOBALES
// --------------------------------------------------
    
let frmBuscar = null;
let txtTitulo = null;
let txtAutor = null;
let slCategoria = null;
let btnBuscar = null;

// --------------------------------------------------
// LOAD
// --------------------------------------------------

$(() => {
    
    // obtenemos controles
    frmBuscar = $("#frmBuscar");
    txtTitulo = $("#txtTitulo");
    txtAutor = $("#txtAutor");
    slCategoria = $("#slCategoria");
    btnBuscar = $("#btnBuscar");

    // llenamos categorias
    fillCategorias();

    // iniciamos eventos de formularios
    frmBuscar.on('submit', (e) => {
        e.preventDefault();
        onFrmBuscarSubmit();
    });
});

// --------------------------------------------------
// EVENTOS
// --------------------------------------------------

const onFrmBuscarSubmit = () => {

    switchButtonSpinner(btnBuscar);

    let nodo = validarBusqueda();

    if (nodo == null) {
        switchButtonSpinner(btnBuscar);
        return;
    }

    fillCursosFiltro(nodo);

    switchButtonSpinner(btnBuscar);
};

// --------------------------------------------------
// METODOS
// --------------------------------------------------

const validarBusqueda = () => {

    let titulo = txtTitulo.val();
    let autor = txtAutor.val();
    let id_categoria = slCategoria.val();

    if (isEmptyOrNull(titulo) && isEmptyOrNull(autor)) {

        message_warning("Ingrese el titulo o autor del curso");
        return null;
    }
    
    if (isEmptyOrNull(id_categoria)) {

        message_warning("Seleccione la categoría");
        return null;
    }

    return {
        titulo: titulo,
        id_categoria: id_categoria,
        autor: autor
    };
};

const fillCursosFiltro = (nodo) => {

    let container = $("#resultados");
    container.html("");

    // categorias por curso
    getAllFiltro(nodo).done((result) => {

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

const fillCategorias = () => {

    slCategoria.html("");

    getAllCategoria().done((result) => {

        // console.log(result);
        if (isEmptyOrNull(result)) {

            container.html("");
            return;
        }

        let rows = JSON.parse(result);

        rows.forEach((value, idx) => {
        
            let element = `
                <option value="${value.id_categoria}">${value.nombre}</option>
            `;

            slCategoria.append(element);
        });
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
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
                <a href="/mods/curso_show/curso_show.php?id=${nodo.id_curso}" class="btn btn-sm btn-ourlib w-100 justify-content-center">
                    <i class="fas fa-info fs-5 me-2"></i>
                    <span class="fw-normal fs-5">Mas información</span>
                </a>
            </div>
        </div>
    </div>
    `;
};

// --------------------------------------------------
// METODOS AJAX
// --------------------------------------------------

const getAllFiltro = (nodo) => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_CURSO_CONTROLLER_GETALL_FILTRO, nodo: JSON.stringify(nodo) },
        type: 'post'
    });
};

const getAllCategoria = () => {

    return $.ajax({ 
        url: AJAX_URL_CATEG_CONTROLLER,
        data: { action: AJAX_URL_CATEG_CONTROLLER_GETALL, nodo: {} },
        type: 'post'
    });
};