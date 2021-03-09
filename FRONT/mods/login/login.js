const validarCampos = () => {


    let usuario = $("input#txtUsuario").val();
    let password = $("input#txtPassword").val();
    

    if (isEmptyOrNull(usuario)|| isEmptyOrNull(password)) {

        message_warning("Necesita llenar todos los espacios");
        return;
    }


    window.location = "/index.php";

};



const recuperarContrasena = () => {

    let usuario = $("input#txtUsuario").val();

    if (isEmptyOrNull(usuario)) {

        message_warning("Primero ingrese su usuario");
        return;
    }

    toastr_info("Se ha enviado un correo de recuperación al correo del usuario " + usuario);
};