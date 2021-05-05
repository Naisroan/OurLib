const registrar = () => {

    let btnRegistrar = $('#btnRegistrar');

    switchButtonSpinner(btnRegistrar);

    let usuario = validarCampos();

    if (usuario == null) {
        
        switchButtonSpinner(btnRegistrar);
        return;
    }

    console.log(usuario);

    existeUsuario(usuario).done((result) => {

        if (!isEmptyOrNull(result) && isJsonString(result)) {

            usuario = JSON.parse(result);

            if (!isEmptyOrNull(usuario)) {

                message_warning("El usuario ya existe, ingrese otro");
                switchButtonSpinner(btnRegistrar);

                return;
            }
        }

        existeCorreo(usuario).done((result) => {
    
            if (!isEmptyOrNull(result) && isJsonString(result)) {
    
                usuario = JSON.parse(result);
    
                if (!isEmptyOrNull(usuario)) {
    
                    message_warning("El correo ya existe, ingrese otro");
                    switchButtonSpinner(btnRegistrar);

                    return;
                }
            }

            crearUsuario(usuario).done((result) => {
    
                toastr_success("Usuario creado con éxito, redirigiendo a pantalla de inicio de sesión");
    
                setTimeout(() =>{
                    window.location = "/mods/login/login.php";
                }, 2500);
    
            })
            .fail((jqXHR) => {
                toastr_error(jqXHR.responseText);
                switchButtonSpinner(btnRegistrar);
                return;
            });
        })
        .fail((jqXHR) => {
            toastr_error(jqXHR.responseText);
            switchButtonSpinner(btnRegistrar);
            return;
        });
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        switchButtonSpinner(btnRegistrar);
        return;
    });
};

const validarCampos = () => {

    let usuario = $("input#txtUsuario").val();
    let tipo_user = $("select#slTipo").val();
    let correo = $("input#txtCorreo").val();
    let confirm_correo = $("input#txtConfirmCorreo").val();
    let password = $("input#txtPassword").val();
    let confirm_password = $("input#txtConfirmPassword").val();

    if (isEmptyOrNull(usuario)) {

        message_warning("Ingrese su nombre de usuario");
        return null;
    }
    
    if (isEmptyOrNull(tipo_user)) {

        message_warning("Seleccione el tipo de usuario");
        return null;
    }
    
    if (isEmptyOrNull(correo)) {

        message_warning("Ingrese su correo");
        return null;
    }
    
    if (isEmptyOrNull(confirm_correo)) {

        message_warning("Confirme su correo");
        return null;
    }
    
    if (isEmptyOrNull(password)) {

        message_warning("Ingrese su contraseña");
        return null;
    }
    
    if (isEmptyOrNull(confirm_password)) {

        message_warning("Confirme su contraseña");
        return null;
    }

    if(!isEmail(correo)) {

        message_warning("El correo ingresado no es valido");
        return null;
    }

    if (correo != confirm_correo) {
        
        message_warning("Los correos no coinciden");
        return null;
    }

    if (!password.match(REGEX_PASSWORD)) {
        
        message_warning("La contraseña no cumple con las restricciones de seguridad");
        return null;
    }

    if (password != confirm_password) {
        
        message_warning("Las contraseñas no coinciden");
        return null;
    }

    return {
        nick: usuario,
        id_rol: tipo_user,
        email: correo,
        password: password
    };
};

const existeUsuario = (usuario) => {

    return $.ajax({ 
        url: AJAX_URL_USER_CONTROLLER,
        data: { action: AJAX_URL_USER_CONTROLLER_GET_BYNICK, nodo: usuario.nick },
        type: 'post'
    });
};

const existeCorreo = (usuario) => {

    return $.ajax({ 
        url: AJAX_URL_USER_CONTROLLER,
        data: { action: AJAX_URL_USER_CONTROLLER_GET_BYEMAIL, nodo: usuario.email },
        type: 'post'
    });
};

const crearUsuario = (usuario) => {

    return $.ajax({ 
        url: AJAX_URL_USER_CONTROLLER,
        data: { action: AJAX_URL_USER_CONTROLLER_CREATE, nodo: JSON.stringify(usuario) },
        type: 'post'
    });
};