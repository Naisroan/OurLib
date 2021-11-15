$(() => {

    $('#frmChangeImage').on('submit', (e) => {
        
        e.preventDefault();

        let btnGuardarImagen = $('#btnGuardarImagen');
        switchButtonSpinner(btnGuardarImagen);

        cambiarImagen();
        
        switchButtonSpinner(btnGuardarImagen);
    });

    $("input#profile_image").on('change', (e) => {

        let path = getPathFile($(e.currentTarget));
        let src = `url(${path})`;

        $('#imgUsuario').css('background-image', src);
        toastr_info("Imagen cambiada para visualización, haga click en guardar para conservarla");
    });
});

const cambiarImagen = () => {

    let inImage = $("input#profile_image").val();

    if (isEmptyOrNull(inImage)) {

        message_warning("Seleccione una imagen antes de guardar");
        return;
    }

    let frmData = new FormData();
    let imageData = $("input#profile_image")[0].files[0];
    
    frmData.append('action', AJAX_URL_USER_CONTROLLER_UPDATE_IMAGE);
    frmData.append('nodo', imageData);

    updateUserImage(frmData).done((result) => {

        refreshLoggedUser().done((result) => {
    
            let usuarioLogeado = JSON.parse(result);
            let src = `url(data:${usuarioLogeado.tipo_imagen};base64,${usuarioLogeado.imagen})`;

            $('#imgUsuario').css('background-image', src);
            $("input#profile_image").val("");
            
            toastr_success("Imagen actualizada con éxito");
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

const updateUserImage = (formData) => {

    return $.ajax({
        url: AJAX_URL_USER_CONTROLLER,
        contentType: false,
        processData: false,
        cache: false,
        data: formData,
        type: 'post'
    });
};

const refreshLoggedUser = () => {

    return $.ajax({
        url: AJAX_URL_USER_CONTROLLER,
        data: { action: AJAX_URL_USER_CONTROLLER_REFRESH_LOGGED_USER, nodo: "" },
        type: 'post'
    });
};

const cambiarPassword = () => {

    let actual_password = $("input#txtActualPassword").val();
    let new_password = $("input#txtPassword").val();
    let confirm_password = $("input#txtConfirmPassword").val();

    if (isEmptyOrNull(actual_password)) {

        message_warning("Ingresa la contraseña actual");
        return;
    }

    if (isEmptyOrNull(new_password)) {

        message_warning("Ingresa la nueva contraseña");
        return;
    }

    if (!new_password.match(REGEX_PASSWORD)) {
        
        message_warning("La contraseña no cumple con las restricciones de seguridad");
        return null;
    }

    if (isEmptyOrNull(confirm_password)) {

        message_warning("Confirma la nueva contraseña");
        return;
    }

    if (new_password != confirm_password) {
        
        message_warning("Las contraseñas no coinciden");
        return;
    }

    let password = {
        actual: actual_password,
        new: new_password
    };

    updatePassword(password).done((result) => {

        $("input#txtActualPassword").val("");
        $("input#txtPassword").val("");
        $("input#txtConfirmPassword").val("");

        toastr_success("Se ha guardado los cambios!");
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

const cambiarNombre = () => {

    let nombre = $("input#txtNombre").val();
    let appaterno = '';
    let apmaterno = '';
    
    if (isEmptyOrNull(nombre)) {

        message_warning("Ingresa tu nombre");
        return;
    }

    // if (isEmptyOrNull(appaterno)) {

    //     message_warning("Ingresa tu apellido paterno");
    //     return;
    // }

    // if (isEmptyOrNull(apmaterno)) {

    //     message_warning("Ingresa tu apellido materno");
    //     return;
    // }

    let usuario = {
        nombre: nombre,
        ap_paterno: appaterno,
        ap_materno: apmaterno
    };

    updateNombre(usuario).done((result) => {

        refreshLoggedUser().done((result) => {
    
            let usuarioLogeado = JSON.parse(result);

            $("input#txtNombre").val(usuarioLogeado.nombre);
            $("input#txtApPaterno").val(usuarioLogeado.ap_paterno);
            $("input#txtApMaterno").val(usuarioLogeado.ap_materno);

            toastr_success("Se ha guardado los cambios!");
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

const updateNombre = (nodo) => {

    return $.ajax({
        url: AJAX_URL_USER_CONTROLLER,
        data: { action: AJAX_URL_USER_CONTROLLER_UPDATE_NOMBRE, nodo: JSON.stringify(nodo) },
        type: 'post'
    });
};

const updatePassword = (nodo) => {

    return $.ajax({
        url: AJAX_URL_USER_CONTROLLER,
        data: { action: AJAX_URL_USER_CONTROLLER_UPDATE_PASSWORD, nodo: JSON.stringify(nodo) },
        type: 'post'
    });
};