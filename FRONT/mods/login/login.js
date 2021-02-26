const recuperarContrasena = () => {

    let usuario = $("input#txtUsuario").val();

    if (isEmptyOrNull(usuario)) {

        message_warning("Primero ingrese su usuario");
        return;
    }

    toastr_info("Se ha enviado un correo de recuperación al correo del usuario " + usuario);
};