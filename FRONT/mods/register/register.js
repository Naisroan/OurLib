const registrar = () => {


    let usuario = $("input#txtUsuario").val();
    let tipo_user = $("input#txtTipo").val();
    let correo = $("input#txtCorreo").val();
    let confirm_correo = $("input#txtConfirmCorreo").val();
    let password = $("input#txtPassword").val();
    let confirm_password = $("input#txtConfirmPassword").val();
    

    if (isEmptyOrNull(usuario) || isEmptyOrNull(tipo_user) || isEmptyOrNull(correo) || isEmptyOrNull(confirm_correo) || isEmptyOrNull(password) || isEmptyOrNull(confirm_password)) {

        message_warning("Necesita llenar todos los espacios");
        return;
    }

    if(!isEmail(correo) || !isEmail(confirm_correo)){

        message_warning("Formato del correo no es válido");
        return;
    }

    if (correo != confirm_correo) {
        
        message_warning("Los correos no coinciden");
        return;
    }

    if (correo != confirm_correo) {
        
        message_warning("Los correos no coinciden");
        return;
    }

    if (password != confirm_password) {
        
        message_warning("Las contraseñas no coinciden");
        return;
    }

    toastr_success("Te registraste!");

    setTimeout(() =>{
        window.location = "/mods/login/login.php";
    }, 2000);
};


