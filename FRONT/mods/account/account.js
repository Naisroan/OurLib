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

    message_success("Se ha guardado los cambios!");

};