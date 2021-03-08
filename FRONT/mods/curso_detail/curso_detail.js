// Validate empty inputs for course register

const registrar_curso = () => {


    let titulo = $("input#txtTitulo").val();
    let subtitulo = $("input#txtSubTitulo").val();
    let precio = $("input#txtPrecio").val();
    let descripcion = $("textarea#txtDescripcion").val();
    

    if (isEmptyOrNull(titulo) || isEmptyOrNull(subtitulo) || isEmptyOrNull(precio) || isEmptyOrNull(descripcion)) {

        message_warning("Necesita llenar todos los espacios");
        return;
    }


    if(!NumberOnly(precio)){

        message_warning("Solo carácteres númericos son permitidos");
        return;

    }
    
    message_success("Se ha registrado el curso!");

};

// Validate empty inputs for course image

const cargar_imagen = () => {


    let imagen = $("input#formFile").val();

    if (isEmptyOrNull(imagen)) {

        message_warning("Necesita seleccionar una imágen");
        return;
    }

    message_success("La imágen se ha guardado!");

};

// Validate empty inputs for category register

const registrar_categoria = () => {


    let categoria = $("input#txtCategoria").val();

    if (isEmptyOrNull(categoria)) {

        message_warning("Necesita llenar el título de la categoría");
        return;
    }

    message_success("La categoría se ha registrado!");

};


// Validate empty inputs for course level register

const registrar_nivel = () => {


    let titulo = $("input#txtTituloNivel").val();
    let Precio = $("input#txtPrecioNivel").val();

    if (isEmptyOrNull(titulo) || isEmptyOrNull(Precio)) {

        message_warning("Necesita llenar los datos solicitados!");
        return;
    }

    if(!NumberOnly(Precio)){

        message_warning("Solo carácteres númericos son permitidos");
        return;

    }

    message_success("Se ha registrado un nivel!");

};

// Validate empty inputs for course level register

const registrar_archivo = () => {


    let archivo = $("input#formFileLevel").val();

    if (isEmptyOrNull(archivo)) {

        message_warning("Necesita cargar un archivo!");
        return;
    }

    message_success("Se subido un archivo!");

};
