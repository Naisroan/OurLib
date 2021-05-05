const MESSAGE_USER_NOT_MATCH = "El usuario y/o contraseña no coinciden";

const login = () => {

    let btnLogin = $('#btnLogin');
    switchButtonSpinner(btnLogin);

    let usuario = validarCampos();

    if (usuario === null) {
        switchButtonSpinner(btnLogin);
        return;
    }

    validarUsuario(usuario).done((result) => {

        if (isEmptyOrNull(result) || !isJsonString(result)) {
            
            message_warning(MESSAGE_USER_NOT_MATCH);
            switchButtonSpinner(btnLogin);
            return;
        }

        usuario = JSON.parse(result);
        console.log(usuario);

        logearUsuario(usuario).done((result) => {

            toastr_success("Sesión iniciada, cargando...");
    
            switchButtonSpinner(btnLogin);
    
            setTimeout(() =>{
                window.location = "/index.php";
            }, 500);
        })
        .fail((jqXHR) => {
            toastr_error(jqXHR.responseText);
            switchButtonSpinner(btnLogin);
            return;
        });
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        switchButtonSpinner(btnLogin);
        return;
    });
};

const validarCampos = () => {

    let usuario = $("input#txtUsuario").val();
    let password = $("input#txtPassword").val();
    
    if (isEmptyOrNull(usuario)) {

        message_warning("Ingrese su usuario");
        return null;
    }
    
    if (isEmptyOrNull(password)) {

        message_warning("Ingrese su contraseña");
        return null;
    }

    return {
        nick: usuario,
        password: password
    };
};

const recuperarContrasena = () => {

    let usuario = $("input#txtUsuario").val();

    if (isEmptyOrNull(usuario)) {

        message_warning("Primero ingrese su usuario");
        return;
    }

    toastr_info("Se ha enviado un correo de recuperación al correo del usuario " + usuario);
};

const validarUsuario = (usuario) => {

    return $.ajax({
        url: AJAX_URL_USER_CONTROLLER,
        data: { action: AJAX_URL_USER_CONTROLLER_VALIDATE, nodo: JSON.stringify(usuario) },
        type: 'post'
    });
};

const logearUsuario = (usuario) => {

    return $.ajax({
        url: AJAX_URL_USER_CONTROLLER,
        data: { action: AJAX_URL_USER_CONTROLLER_LOGIN, nodo: JSON.stringify(usuario) },
        type: 'post'
    });
};