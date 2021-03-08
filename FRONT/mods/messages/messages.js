// Validate empty inputs for messages

const validar_mensajes = () => {


    let mensaje = $("input#txtmessage").val();
    

    if (isEmptyOrNull(mensaje)) {

        message_warning("Necesita llenar todos los espacios");
        return;
    }

    message_success("Se ha enviado su mensaje!");

};