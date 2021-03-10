// Validate empty inputs for profile image

const imagen_perfil = () => {


    let imagen = $("input#profile_image").val();

    if (isEmptyOrNull(imagen)) {

        message_warning("Necesita seleccionar una imágen");
        return;
    }

    message_success("La imágen se ha guardado!");

};


// Validate empty inputs for course register

const guardar_cambios = () => {


    let actual_password = $("input#txtActualPassword").val();
    let new_password = $("input#txtPassword").val();
    let confirm_password = $("input#txtConfirmPassword").val();
    

    if (isEmptyOrNull(actual_password) || isEmptyOrNull(new_password) || isEmptyOrNull(confirm_password)) {

        message_warning("Necesita llenar todos los espacios");
        return;
    }

    if (new_password != confirm_password) {
        
        message_warning("Las contraseñas no coinciden");
        return;
    }

    toastr_success("Se ha guardado los cambios!");

};

const guardar_cambios_nombre = () => {


    let nombre = $("input#txtNombre").val();
    let appaterno = $("input#txtApPaterno").val();
    let apmaterno = $("input#txtApMaterno").val();
    
    if (isEmptyOrNull(nombre)) {

        message_warning("Necesita llenar todos los espacios");
        return;
    }
    

    if (isEmptyOrNull(appaterno)) {

        message_warning("Necesita llenar todos los espacios");
        return;
    }
    

    if (isEmptyOrNull(apmaterno)) {

        message_warning("Necesita llenar todos los espacios");
        return;
    }

    toastr_success("Se ha guardado los cambios!");

};