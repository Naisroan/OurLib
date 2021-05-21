// globales
let frmGuardarDatosBasicos = null;
let btnGuadarDatosBasicos = null;

let frmGuardarImagen = null;
let fuGuardarImagen = null;
let btnGuardarImagen = null;

let frmGuardarCategoria = null;
let btnGuardarCategoria = null;

let frmGuardarNivel = null;
let btnGuardarNivel = null;

let frmGuardarArchivo = null;
let fuGuardarArchivo = null;
let btnGuardarArchivo = null;

// load
$(() => {

    // obtenemos controles
    frmGuardarDatosBasicos = $("form#frmGuardarDatosBasicos");
    btnGuadarDatosBasicos = $("button#btnGuardarDatosBasicos");
    
    frmGuardarImagen = $("form#frmGuardarImagen");
    btnGuardarImagen = $("button#btnGuardarImagen");
    fuGuardarImagen = $("#fuGuardarImagen");

    frmGuardarCategoria = $("form#frmGuardarCategoria");
    btnGuardarCategoria = $("button#btnGuardarCategoria");

    frmGuardarNivel = $("form#frmGuardarNivel");
    btnGuardarNivel = $("button#btnGuardarNivel");
    
    frmGuardarArchivo = $("form#frmGuardarArchivo");
    btnGuardarArchivo = $("button#btnGuardarArchivo");
    fuGuardarArchivo = $("#fuGuardarArchivo");

    // buscamos parametros en la url
    const params = new URLSearchParams(window.location.search);

    if (params.has("id")) {

        let id = params.get("id"); 

        if (isNaN(id)) {
            return;
        }

        editCurso(parseInt(id));
    }

    // asignamos eventos de formularios
    frmGuardarDatosBasicos.on('submit', (e) => {
        e.preventDefault();
        onFrmGuardarDatosBasicosSubmit();
    });

    frmGuardarImagen.on('submit', (e) => {
        e.preventDefault();
        onFrmGuardarImagenSubmit();
    });

    frmGuardarCategoria.on('submit', (e) => {
        e.preventDefault();
        onFrmGuardarCategoriaSubmit();
    });

    frmGuardarNivel.on('submit', (e) => {
        e.preventDefault();
        onFrmGuardarNivelSubmit();
    });

    frmGuardarArchivo.on('submit', (e) => {
        e.preventDefault();
        onFrmGuardarArchivoSubmit();
    });

    // asignamos evento para cambio de imagen
    fuGuardarImagen.on('change', (e) => {

        let path = getPathFile($(e.currentTarget));
        let src = `url(${path})`;

        $('#imgCurso').css('background-image', src);
        toastr_info("Imagen cambiada para visualización, haga click en guardar para conservarla");
    });
});

// --------------------------------------------------
// DATOS BASICOS
// --------------------------------------------------

const onFrmGuardarDatosBasicosSubmit = () => {

    switchButtonSpinner(btnGuadarDatosBasicos);

    let nodo = validaCamposDatosBasicos();

    if (nodo == null) {
        switchButtonSpinner(btnGuadarDatosBasicos);
        return;
    }

    existsCurso(nodo.titulo).done((result) => {

        let existeCurso = (result !== undefined && result !== "") && result === "1";

        if (result === undefined || result === "") {
            switchButtonSpinner(btnGuadarDatosBasicos);
            return;
        }

        // existe el curso y no lo esta editando
        if (existeCurso && nodo.id_curso <= 0) {
            toastr_error("Ya cuenta con un curso con el mismo titulo");
            switchButtonSpinner(btnGuadarDatosBasicos);
            return;
        }

        // nuevo curso
        if (!existeCurso && nodo.id_curso <= 0) {

            crearCurso(nodo).done((result) => {
        
                if (result === undefined || result === "") {
                    switchButtonSpinner(btnGuadarDatosBasicos);
                    return;
                }
        
                console.log(result);
        
                editCurso(result);
                
                toastr_success("Se ha registrado el curso");
                switchButtonSpinner(btnGuadarDatosBasicos);
            })
            .fail((jqXHR) => {
                toastr_error(jqXHR.responseText);
                switchButtonSpinner(btnGuadarDatosBasicos);
                return;
            });
        }
        // editar curso
        else {
            
            updateCurso(nodo).done((result) => {
        
                if (result === undefined || result === "") {
                    switchButtonSpinner(btnGuadarDatosBasicos);
                    return;
                }
        
                console.log(result);
        
                editCurso(result);
                
                toastr_success("Se ha actualizado el curso");
                switchButtonSpinner(btnGuadarDatosBasicos);
            })
            .fail((jqXHR) => {
                toastr_error(jqXHR.responseText);
                switchButtonSpinner(btnGuadarDatosBasicos);
                return;
            });
        }
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        switchButtonSpinner(btnGuadarDatosBasicos);
        return;
    });
};

const validaCamposDatosBasicos = () => {

    let id = $("input#txtId").val();
    let titulo = $("input#txtTitulo").val();
    let subtitulo = $("input#txtSubTitulo").val();
    let precio = $("input#txtPrecio").val();
    let descripcion = $("textarea#txtDescripcion").val();
    
    if (isEmptyOrNull(titulo)) {

        message_warning("Ingrese el titulo del curso");
        return null;
    }
    
    if (isEmptyOrNull(subtitulo)) {

        message_warning("Ingrese el subtitulo del curso");
        return null;
    }
    
    if (isEmptyOrNull(precio)) {

        message_warning("Ingrese el precio del curso");
        return null;
    }

    if(isNaN(precio)) {

        message_warning("El precio debe ser solo númerico");
        return null;
    }

    if (precio < 0) {

        message_warning("El precio no puede ser negativo");
        return null;
    }
    
    if (isEmptyOrNull(descripcion)) {

        message_warning("Ingrese la descripcion del curso");
        return null;
    }

    return {
        id_curso: id,
        id_usuario: 0,
        titulo: titulo,
        subtitulo: subtitulo,
        precio: precio,
        descripcion: descripcion
    };
};

const editCurso = (id_curso) => {

    // obtenemos el curso por su id
    getCursoById(id_curso).done((result) => {

        if (result === undefined || result === "") {
            return;
        }

        // se obtiene el curso
        // console.log(result);

        // se parse
        let nodo = JSON.parse(result);

        // datos basicos
        $("h1#title").text("Editar curso - " + nodo.titulo);
        $("input#txtId").val(nodo.id_curso);
        $("input#txtTitulo").val(nodo.titulo);
        $("input#txtSubTitulo").val(nodo.subtitulo);
        $("input#txtPrecio").val(nodo.precio);
        $("textarea#txtDescripcion").val(nodo.descripcion);

        // imagen
        $('#imgCurso').css('background-image', !isKk(nodo.tipo_imagen) ? `url(data:${nodo.tipo_imagen};base64,${nodo.imagen})` : "https://picsum.photos/600/280");
        
        // categorias
        fillCategorias();
        fillCategoriasCurso(id_curso);

        // niveles
        fillNivelCurso(id_curso);

        // tabs
        $('#btnTabImagen').removeClass('invisible');
        $('#btnTabCategorias').removeClass('invisible');
        $('#btnTabNiveles').removeClass('invisible');
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

const crearCurso = (nodo) => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_CURSO_CONTROLLER_CREATE, nodo: JSON.stringify(nodo) },
        type: 'post'
    });
};

const updateCurso = (nodo) => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_CURSO_CONTROLLER_UPDATE, nodo: JSON.stringify(nodo) },
        type: 'post'
    });
};

const getCursoById = (id_curso) => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_CURSO_CONTROLLER_GET_BYID, nodo: id_curso },
        type: 'post'
    });
};

const existsCurso = (titulo) => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_CURSO_CONTROLLER_EXISTS, nodo: titulo },
        type: 'post'
    });
};

// --------------------------------------------------
// IMAGEN
// --------------------------------------------------

const onFrmGuardarImagenSubmit = () => {

    switchButtonSpinner(btnGuardarImagen);

    let nodo = validaCamposImagen();

    if (nodo == null) {
        switchButtonSpinner(btnGuardarImagen);
        return;
    }
            
    updateImagen(nodo).done((result) => {

        if (result === undefined || result === "" || !result) {
            switchButtonSpinner(btnGuardarImagen);
            return;
        }

        // editCurso(result);
        
        toastr_success("Se ha actualizado la imagen");
        switchButtonSpinner(btnGuardarImagen);
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        switchButtonSpinner(btnGuardarImagen);
        return;
    });
};

const validaCamposImagen = () => {

    let id_curso = $("input#txtId").val();
    let imagen = fuGuardarImagen.val();

    if (isEmptyOrNull(id_curso)) {

        message_warning("Primero cree un nuevo curso o seleccione uno");
        return null;
    }

    if (isEmptyOrNull(imagen)) {

        message_warning("Seleccione una imagen antes de guardar");
        return null;
    }
    
    let data = new FormData();
    
    data.append('action', AJAX_URL_CURSO_CONTROLLER_UPDATE_IMAGE);
    data.append('nodo', fuGuardarImagen[0].files[0]);
    data.append('id_curso', id_curso);

    return data;
};

const updateImagen = (formData) => {

    return $.ajax({
        url: AJAX_URL_CURSO_CONTROLLER,
        contentType: false,
        processData: false,
        cache: false,
        data: formData,
        type: 'post'
    });
};

// --------------------------------------------------
// CATEGORIA
// --------------------------------------------------

const onFrmGuardarCategoriaSubmit = () => {

    switchButtonSpinner(btnGuardarCategoria);

    let nodo = validaCamposCategoria();

    if (nodo == null) {
        switchButtonSpinner(btnGuardarCategoria);
        return;
    }

    // nodo no tiene id_categoria, hay que obtenerla dependiendo si ya ha sido creada o es nueva

    // verificamos si existe la categoría
    existsCategoria(nodo.nombre).done((result) => {

        let existe = (result !== undefined && result !== "") && result === "1";

        if (result === undefined || result === "") {
            switchButtonSpinner(btnGuardarCategoria);
            return;
        }

        // si no existe la categoría se crea
        if (!existe) {

            crearCategoria(nodo).done((result) => {
        
                if (result === undefined || result === "") {
                    switchButtonSpinner(btnGuardarCategoria);
                    return;
                }

                fillCategorias();
            })
            .fail((jqXHR) => {
                toastr_error(jqXHR.responseText);
                switchButtonSpinner(btnGuardarCategoria);
                return;
            });
        }

        // ya creada o no, obtenemos la categoria
        getCategoriaByNombre(nodo.nombre).done((result) => {

            let categoria = JSON.parse(result);
            nodo.id_categoria = categoria.id_categoria;

            // verificamos si el curso ya tiene la categoría
            existsCursoCategoria(nodo).done((result) => {

                let existe = (result !== undefined && result !== "") && result === "1";

                if (result === undefined || result === "") {
                    switchButtonSpinner(btnGuardarCategoria);
                    return;
                }

                if (existe) {
                    toastr_error("El curso ya cuenta con esa categoría");
                    $("input#txtCategoria").val("");
                    switchButtonSpinner(btnGuardarCategoria);
                    return;
                }

                // agregamos la categoría al curso
                crearCursoCategoria(nodo).done((result) => {
            
                    if (result === undefined || result === "") {
                        switchButtonSpinner(btnGuardarCategoria);
                        return;
                    }

                    console.log(result);

                    fillCategoriasCurso(nodo.id_curso);
                    $("input#txtCategoria").val("");
                    
                    toastr_success("Se ha agregado la categoría");
                    switchButtonSpinner(btnGuardarCategoria);
                })
                .fail((jqXHR) => {
                    toastr_error(jqXHR.responseText);
                    switchButtonSpinner(btnGuardarCategoria);
                    return;
                });
            })
            .fail((jqXHR) => {
                toastr_error(jqXHR.responseText);
                switchButtonSpinner(btnGuardarCategoria);
                return;
            });
        })
        .fail((jqXHR) => {
            toastr_error(jqXHR.responseText);
            switchButtonSpinner(btnGuardarCategoria);
            return;
        });
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        switchButtonSpinner(btnGuardarCategoria);
        return;
    });
};

const validaCamposCategoria = () => {

    let categoria = $("input#txtCategoria").val();

    if (isEmptyOrNull(categoria)) {

        message_warning("Ingrese el nombre de la categoría o seleccione una");
        return;
    }

    return {
        id_curso: $("input#txtId").val(),
        id_categoria: 0,
        nombre: categoria
    };
};

const onBtnDeleteCursoCategoriaClick = (id_curso_categoria) => {

    deleteCursoCategoria(id_curso_categoria).done((result) => {

        if (isEmptyOrNull(result)) {
            return;
        }

        fillCategoriasCurso($("input#txtId").val());

        toastr_success("Categoría retirada");
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        switchButtonSpinner(btnGuardarCategoria);
        return;
    });
};

const fillCategorias = () => {

    let container = $("#cats");
    container.html("");

    getAllCategoria().done((result) => {

        // console.log(result);
        if (isEmptyOrNull(result)) {

            container.html("");
            return;
        }

        let rows = JSON.parse(result);

        rows.forEach((value, idx) => {
        
            let element = `
                <option value="${value.nombre}"></option>
            `;

            container.append(element);
        });
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

const fillCategoriasCurso = (id_curso) => {

    let container = $("#catscurso");
    container.html("");

    // categorias por curso
    getAllCursoCategoria(id_curso).done((result) => {

        // console.log(result);
        if (isEmptyOrNull(result)) {

            container.html("");
            return;
        }

        let rows = JSON.parse(result);
    
        rows.forEach((value, idx) => {
        
            let element = `
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    ${value.categoria}
                    <a href="#!" class="btn btn-secondary btn-action delete" onclick="onBtnDeleteCursoCategoriaClick(${value.id_curso_categoria})">
                        <i class="fas fa-trash fa-fw"></i>
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

const crearCategoria = (nodo) => {

    return $.ajax({ 
        url: AJAX_URL_CATEG_CONTROLLER,
        data: { action: AJAX_URL_CATEG_CONTROLLER_CREATE, nodo: JSON.stringify(nodo) },
        type: 'post'
    });
};

const existsCategoria = (nombre) => {

    return $.ajax({ 
        url: AJAX_URL_CATEG_CONTROLLER,
        data: { action: AJAX_URL_CATEG_CONTROLLER_EXISTS, nodo: nombre },
        type: 'post'
    });
};

const getCategoriaByNombre = (nombre) => {

    return $.ajax({ 
        url: AJAX_URL_CATEG_CONTROLLER,
        data: { action: AJAX_URL_CATEG_CONTROLLER_GET_BYNOMBRE, nodo: nombre },
        type: 'post'
    });
};

const crearCursoCategoria = (nodo) => {

    return $.ajax({ 
        url: AJAX_URL_CATEG_CONTROLLER,
        data: { action: AJAX_URL_CURSOCATEG_CONTROLLER_CREATE, nodo: JSON.stringify(nodo) },
        type: 'post'
    });
};

const existsCursoCategoria = (nodo) => {

    return $.ajax({ 
        url: AJAX_URL_CATEG_CONTROLLER,
        data: { action: AJAX_URL_CURSOCATEG_CONTROLLER_EXISTS, nodo: JSON.stringify(nodo) },
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

const getAllCursoCategoria = (id_curso) => {

    return $.ajax({ 
        url: AJAX_URL_CATEG_CONTROLLER,
        data: { action: AJAX_URL_CURSOCATEG_CONTROLLER_GETALL_BYCURSO, nodo: id_curso },
        type: 'post'
    });
};

const deleteCursoCategoria = (id_curso_categoria) => {

    return $.ajax({ 
        url: AJAX_URL_CATEG_CONTROLLER,
        data: { action: AJAX_URL_CURSOCATEG_CONTROLLER_DELETE, nodo: id_curso_categoria },
        type: 'post'
    });
};

// --------------------------------------------------
// NIVEL
// --------------------------------------------------

const onFrmGuardarNivelSubmit = () => {

    switchButtonSpinner(btnGuardarNivel);

    let nodo = validaCamposNivel();

    if (nodo == null) {
        switchButtonSpinner(btnGuardarNivel);
        return;
    }

    existsNivelCurso(nodo).done((result) => {

        let existe = (result !== undefined && result !== "") && result === "1";

        if (result === undefined || result === "") {
            switchButtonSpinner(btnGuardarNivel);
            return;
        }

        // existe el curso y no lo esta editando
        if (existe && nodo.id_nivel_curso <= 0) {
            toastr_error("Ya cuenta con un nivel con el mismo titulo");
            switchButtonSpinner(btnGuardarNivel);
            return;
        }

        // nuevo curso
        if (!existe && nodo.id_nivel_curso <= 0) {

            crearNivelCurso(nodo).done((result) => {
        
                if (result === undefined || result === "") {
                    switchButtonSpinner(btnGuardarNivel);
                    return;
                }
        
                // console.log(result);
        
                editNivelCurso(result);
                
                toastr_success("Se ha registrado el nivel");
                switchButtonSpinner(btnGuardarNivel);
            })
            .fail((jqXHR) => {
                toastr_error(jqXHR.responseText);
                switchButtonSpinner(btnGuardarNivel);
                return;
            });
        }
        // editar curso
        else {
            
            updateNivelCurso(nodo).done((result) => {
        
                if (result === undefined || result === "") {
                    switchButtonSpinner(btnGuardarNivel);
                    return;
                }
        
                // console.log(result);
        
                editNivelCurso(result);
                
                toastr_success("Se ha actualizado el curso");
                switchButtonSpinner(btnGuardarNivel);
            })
            .fail((jqXHR) => {
                toastr_error(jqXHR.responseText);
                switchButtonSpinner(btnGuardarNivel);
                return;
            });
        }
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        switchButtonSpinner(btnGuardarNivel);
        return;
    });
};

const onBtnAgregarNivelClick = () => {

    $("#titleNivelCurso").text("Agregar nivel");
    $("input#txtIdNivelCurso").val("-1");
    $("input#txtTituloNivel").val("");
    $("input#txtPrecioNivel").val("");
    $("ul#ulNivelArchivos").html("");
};

const onBtnDeleteNivelCursoClick = (id_nivel_curso) => {

    deleteNivelCurso(id_nivel_curso).done((result) => {

        if (isEmptyOrNull(result)) {
            return;
        }

        fillNivelCurso($("input#txtId").val());

        toastr_success("Nivel retirado");
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

const onBtnEditNivelCursoClick = (id_nivel_curso) => {

    editNivelCurso(id_nivel_curso, false);
};

const editNivelCurso = (id_nivel_curso, fetchNiveles = true) => {

    // obtenemos el curso por su id
    getNivelCursoById(id_nivel_curso).done((result) => {

        if (result === undefined || result === "") {
            return;
        }

        // se obtiene el curso
        // console.log(result);

        // se parsea
        let nodo = JSON.parse(result);

        // nivel
        $("#titleNivelCurso").text("Editar nivel - " + nodo.titulo);
        $("input#txtIdNivelCurso").val(nodo.id_nivel_curso);
        $("input#txtTituloNivel").val(nodo.titulo);
        $("input#txtPrecioNivel").val(nodo.precio);

        // se obtienen archivos del nivel
        fillArchivoNivel(id_nivel_curso);

        if (fetchNiveles) {
            fillNivelCurso(nodo.id_curso);
        }
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

const validaCamposNivel = () => {

    let id_curso = $("input#txtId").val();
    let id_nivel_curso = $("input#txtIdNivelCurso").val();
    let titulo = $("input#txtTituloNivel").val();
    // let precio = $("input#txtPrecioNivel").val();
    let precio = 0;

    if (isEmptyOrNull(id_curso) || parseInt(id_curso) <= 0) {

        message_warning("Seleccione o cree un curso para agregar un nivel");
        return;
    }

    if (isEmptyOrNull(titulo)) {

        message_warning("Ingrese el titulo del nivel");
        return;
    }

    if (isEmptyOrNull(precio)) {

        message_warning("Ingrese el precio del nivel");
        return;
    }

    if (isNaN(precio)) {

        message_warning("El precio debe ser solo númerico");
        return;
    }

    if (parseFloat(precio) < 0) {

        message_warning("El precio no debe ser negativo");
        return;
    }

    return {
        id_nivel_curso: parseInt(id_nivel_curso),
        id_curso: parseInt(id_curso),
        orden: 0,
        precio: 0,
        titulo: titulo,
        descripcion: ""
    };
};

const fillNivelCurso = (id_curso) => {

    let container = $("#nivelescurso");
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
            <div class="col-12 col-md-6 col-xl-4">
                <div class="card nivel w-100">
                    <div class="card-body">
                        <h5 class="card-title">${value.titulo}</h5>
                        <p class="card-text d-none">
                            Costo <strong>$ ${value.precio} MXN</strong>
                        </p>
                        <div class="text-end">
                            <a href="#" class="btn btn-secondary btn-action edit" data-bs-toggle="modal" data-bs-target="#staticBackdrop"
                            onclick="onBtnEditNivelCursoClick(${value.id_nivel_curso});">
                                <i class="fas fa-edit fa-fw"></i>
                            </a>
                            <a href="#" class="btn btn-secondary btn-action delete"
                                onclick="onBtnDeleteNivelCursoClick(${value.id_nivel_curso});">
                                <i class="fas fa-trash fa-fw"></i>
                            </a>
                        </div>
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

const crearNivelCurso = (nodo) => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_NIVELCURSO_CONTROLLER_CREATE, nodo: JSON.stringify(nodo) },
        type: 'post'
    });
};

const updateNivelCurso = (nodo) => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_NIVELCURSO_CONTROLLER_UPDATE, nodo: JSON.stringify(nodo) },
        type: 'post'
    });
};

const existsNivelCurso = (nodo) => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_NIVELCURSO_CONTROLLER_EXISTS, nodo: JSON.stringify(nodo) },
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

const getAllNivelByCurso = (id_curso) => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_NIVELCURSO_CONTROLLER_GETALL_BYCURSO, nodo: id_curso },
        type: 'post'
    });
};

const deleteNivelCurso = (id_nivel_curso) => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_NIVELCURSO_CONTROLLER_DELETE, nodo: id_nivel_curso },
        type: 'post'
    });
};

// --------------------------------------------------
// NIVEL - ARCHIVO
// --------------------------------------------------

const onFrmGuardarArchivoSubmit = () => {

    switchButtonSpinner(btnGuardarArchivo);

    let nodo = validaCamposArchivo();

    if (nodo == null) {
        switchButtonSpinner(btnGuardarArchivo);
        return;
    }

    crearArchivoNivel(nodo).done((result) => {

        if (result === undefined || result === "" || !result) {
            toastr_warning("Ha ocurrido algo mientras se subia el archivo");
            switchButtonSpinner(btnGuardarArchivo);
            return;
        }

        fuGuardarArchivo.val("");
        fillArchivoNivel($("input#txtIdNivelCurso").val());
        
        toastr_success("Se ha agregado el recurso multimedia");
        switchButtonSpinner(btnGuardarArchivo);
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        switchButtonSpinner(btnGuardarArchivo);
        return;
    });
};

const onBtnDeleteArchivoNivelClick = (id_multimedia_nivel) => {

    deleteArchivoNivel(id_multimedia_nivel).done((result) => {

        if (isEmptyOrNull(result)) {
            return;
        }

        fillArchivoNivel($("input#txtIdNivelCurso").val());

        toastr_success("Recurso retirado");
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        switchButtonSpinner(btnGuardarCategoria);
        return;
    });
};

const validaCamposArchivo = () => {

    let id_curso = $("input#txtId").val();
    let id_nivel_curso = $("input#txtIdNivelCurso").val();
    let archivo = fuGuardarArchivo.val();

    if (isEmptyOrNull(id_curso) || parseInt(id_curso) <= 0) {

        message_warning("Seleccione o cree un curso para agregar un nivel");
        return;
    }

    if (isEmptyOrNull(id_nivel_curso) || parseInt(id_nivel_curso) <= 0) {

        message_warning("Seleccione o cree un nivel del curso para agregar un archivo");
        return;
    }

    if (isEmptyOrNull(archivo)) {

        message_warning("Seleccione un archivo antes de subirlo");
        return;
    }
    
    let data = new FormData();
    
    data.append('action', AJAX_URL_ARCHIVONIVEL_CONTROLLER_CREATE);
    data.append('nodo', fuGuardarArchivo[0].files[0]);
    data.append('data', JSON.stringify({
        id_curso: id_curso,
        id_nivel_curso: id_nivel_curso
    }));

    return data;
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
                    <a href="#!" class="btn btn-secondary btn-action delete" onclick="onBtnDeleteArchivoNivelClick(${value.id_multimedia_nivel});">
                        <i class="fas fa-trash fa-fw"></i>
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

const crearArchivoNivel = (formData) => {

    return $.ajax({
        url: AJAX_URL_CURSO_CONTROLLER,
        contentType: false,
        processData: false,
        cache: false,
        data: formData,
        type: 'post'
    });
};

const existsArchivoNivel = (nodo) => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_ARCHIVONIVEL_CONTROLLER_EXISTS, nodo: JSON.stringify(nodo) },
        type: 'post'
    });
};

const getArchivoNivelByNombre = (nombre) => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_ARCHIVONIVEL_CONTROLLER_GET_BYNOMBRE, nodo: nombre },
        type: 'post'
    });
};

const getArchivoNivelById = (id_multimedia_nivel) => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_ARCHIVONIVEL_CONTROLLER_GET_BYID, nodo: id_multimedia_nivel },
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

const deleteArchivoNivel = (id_multimedia_nivel) => {

    return $.ajax({ 
        url: AJAX_URL_CURSO_CONTROLLER,
        data: { action: AJAX_URL_ARCHIVONIVEL_CONTROLLER_DELETE, nodo: id_multimedia_nivel },
        type: 'post'
    });
};