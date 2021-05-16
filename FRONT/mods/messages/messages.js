// --------------------------------------------------
// GLOBALES
// --------------------------------------------------

let frmEnviarMensaje = null;
let btnEnviarMensaje = null;

// --------------------------------------------------
// LOAD
// --------------------------------------------------

$(() => {

    // obtenemos controles
    frmEnviarMensaje = $("form#frmEnviarMensaje");
    btnEnviarMensaje = $("#btnEnviarMensaje");

    // iniciamos eventos de formularios
    frmEnviarMensaje.on('submit', (e) => {
        e.preventDefault();
        onFrmEnviarMensajeSubmit();
    });


    let id_usuario_dest = $("#txtId").val();
    let id_usuario_rem = $("#txtIdUsuarioLogeado").val();

    if (id_usuario_dest >= 0 && id_usuario_rem >= 0) {

        fillMensajes(id_usuario_dest, id_usuario_rem);
    }
});

// --------------------------------------------------
// EVENTOS
// --------------------------------------------------

const onFrmEnviarMensajeSubmit = () => {

    switchButtonSpinner(btnEnviarMensaje);

    let nodo = validarCamposMensaje();

    if (nodo == null) {
        switchButtonSpinner(btnEnviarMensaje);
        return;
    }

    crearMensaje(nodo).done((result) => {

        if (result === undefined || result === "") {
            switchButtonSpinner(btnEnviarMensaje);
            return;
        }
        
        $("input#txtmessage").val("");
        $("input#txtmessage").focus();

        fillMensajes($("#txtId").val(), $("#txtIdUsuarioLogeado").val());
        
        toastr_success("Se ha enviado el mensaje");
        switchButtonSpinner(btnEnviarMensaje);
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        switchButtonSpinner(btnEnviarMensaje);
        return;
    });
};

// --------------------------------------------------
// METODOS
// --------------------------------------------------

const validarCamposMensaje = () => {

    let id_usuario_dest = $("#txtId").val();
    let mensaje = $("input#txtmessage").val();

    if (isEmptyOrNull(id_usuario_dest)) {

        message_warning("Seleccione al usuario que desea enviar el mensaje");
        return null;
    }

    if (isEmptyOrNull(mensaje)) {

        message_warning("No se pueden enviar mensajes vacios");
        return null;
    }

    if (isNaN(id_usuario_dest) || id_usuario_dest <= 0) {

        message_warning("Seleccione al usuario que desea enviar el mensaje");
        return null;
    }

    return {
        id_usuario_dest: id_usuario_dest,
        mensaje: mensaje
    };
};

const fillMensajes = (id_usuario_dest, id_usuario_logged) => {

    let container = $("#mensajes");
    container.html("");

    let containerUsuarios = $("#usuarios");
    containerUsuarios.html("");

    // niveles por curso
    getAllNivelByDestinatario(id_usuario_dest).done((result) => {

        // console.log(result);
        if (isEmptyOrNull(result)) {

            container.html("");
            return;
        }

        let rows = JSON.parse(result);
    
        rows.forEach((value, idx) => {

            // let isMessageSentByMe  = value.id_usuario_rem === parseInt(id_usuario_logged);

            // if (!isMessageSentByMe && !isSetInfoDest) {

            //     let imageSrc = "url(/res/examples/user.png)";
            //     imageSrc = !isEmptyOrNull(value.tipo_imagen_usuario_dest) ? `url(data:${value.tipo_imagen_usuario_dest};base64,${value.imagen_usuario_dest})` : imageSrc;

            //     $("#destinatario-image").attr('style',  'background-image: ' + imageSrc);
            //     $("#destinatario").text(value.nick_usuario_dest);
                
            //     isSetInfoDest = true;
            // }
    
            container.append(crearElementoMensaje(value, parseInt(id_usuario_logged)));
        });
        
        // filtramos los usuarios que no sea el logeado
        let users = rows.filter(n => n.id_usuario_rem == parseInt(id_usuario_logged));

        // mapeamos un arreglo en donde no se repita ningun usuario
        users = users.map(item => item.nick_usuario_dest).filter((value, index, self) => self.indexOf(value) === index);

        // creamos un arreglo objetos de usuario con su nick y id
        users = users.map(nick => {
            return {
                id_usuario: rows.find(n => n.nick_usuario_rem == nick).id_usuario_rem,
                nick: nick
            };
        });
    
        users.forEach((value, idx) => {

            containerUsuarios.append(crearElementoUsuario(value));
        });
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

const fillUsuarios = (id_usuario_logged) => {

    let container = $("#usuarios");
    container.html("");

    // niveles por curso
    getAllNivelByDestinatario(id_usuario_dest).done((result) => {

        // console.log(result);
        if (isEmptyOrNull(result)) {

            container.html("");
            return;
        }

        let rows = JSON.parse(result);
    
        rows.forEach((value, idx) => {
            container.append(crearElementoUsuario(value));
        });
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

const crearElementoMensaje = (nodo, id_usuario_logged) => {

    let imageSrc = "url(/res/examples/user.png)";

    if (id_usuario_logged == nodo.id_usuario_rem) {

        imageSrc = !isEmptyOrNull(nodo.tipo_imagen_usuario_rem) ? `url(data:${nodo.tipo_imagen_usuario_rem};base64,${nodo.imagen_usuario_rem})` : imageSrc;

    } else {

        imageSrc = !isEmptyOrNull(nodo.tipo_imagen_usuario_dest) ? `url(data:${nodo.tipo_imagen_usuario_dest};base64,${nodo.imagen_usuario_dest})` : imageSrc;
    }

    return `
    <div class="message d-flex ${id_usuario_logged == nodo.id_usuario_rem ? "yo" : ""}">
        <div class="body">
            <div style="background-image: ${imageSrc};" class="rounded-circle image-usuario"></div>
            <div class="contenido">
                <div class="usuario d-flex justify-content-start align-items-center">
                    <strong>
                        ${id_usuario_logged == nodo.id_usuario_rem ? "Yo" : nodo.nick_usuario_rem}
                    </strong>
                </div>
                <p class="mb-0">
                    ${nodo.mensaje}
                </p>
            </div>
        </div>
    </div>
    `;

    /*
    if (id_usuario_logged == nodo.id_usuario_rem) {

    } else {



        return `
        <div class="message d-flex">
            <div class="body">
                <div style="background-image: ${imageSrc};" class="rounded-circle image-usuario"></div>
                <div class="contenido">
                    <div class="usuario d-flex justify-content-start align-items-center">
                        <strong>
                            ${nick}
                        </strong>
                    </div>
                    <p class="mb-0">
                        ${mensaje}
                    </p>
                </div>
            </div>
        </div>
        `;
    }
    */
};

const crearElementoUsuario = (nodo) => {

    return `
    <li class="list-group-item" onclick="window.location='/mods/messages/messages.php?id=${nodo.id_usuario}'">
        <strong>
            ${nodo.nick}
        </strong>
    </li>
    `;
};

// --------------------------------------------------
// METODOS AJAX
// --------------------------------------------------

const crearMensaje = (nodo) => {

    return $.ajax({ 
        url: AJAX_URL_MENSAJE_CONTROLLER,
        data: { action: AJAX_URL_MENSAJE_CONTROLLER_CREATE, nodo: JSON.stringify(nodo) },
        type: 'post'
    });
};

const getAllNivelByDestinatario = (id_usuario_dest) => {

    return $.ajax({ 
        url: AJAX_URL_MENSAJE_CONTROLLER,
        data: { action: AJAX_URL_MENSAJE_CONTROLLER_GETALL_BYDEST, nodo: id_usuario_dest },
        type: 'post'
    });
};