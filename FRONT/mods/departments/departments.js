// --------------------------------------------------
// GLOBALES
// --------------------------------------------------
let tblUsuarios = null;

// --------------------------------------------------
// LOAD
// --------------------------------------------------

$(() => {
  
    // obtenemos controles
    tblUsuarios = $("#tblUsuarios");
    
    // llenamos usuarios
    fillUsuarios();

    // eventos
    $(document).on('change', '.chkEsDepartamento', (e) => {

        let chk = $(e.currentTarget);
        let id_usuario = chk.val();
        let esDepartamento = chk.is(':checked');
        
        onChangeChkEsDepartamento({
            id_usuario : id_usuario,
            id_rol: esDepartamento ? 1 : 2
        });
    });
});

// --------------------------------------------------
// EVENTOS
// --------------------------------------------------

const onChangeChkEsDepartamento = (nodo) => {

    updateIdRol(nodo).done((result) => {

        if (result === undefined || result === "") {
            return;
        }

        toastr_success("Rol asignado");
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

// --------------------------------------------------
// METODOS
// --------------------------------------------------

const fillUsuarios = () => {

    let tbody = $(tblUsuarios.find('tbody'));
    tbody.html("");

    getAllUsuarios().done((result) => {

        // console.log(result);
        if (isEmptyOrNull(result)) {

            tbody.html("");
            return;
        }

        let rows = JSON.parse(result);

        if (rows == null || rows.length <= 0) {

            tbody.append(`<tr><td colspan="5">No hay usuarios que asignar como departamento</td></tr>`);
            return;
        }

        rows.forEach((value, idx) => {
        
            let element = `
                <tr>
                    <td>
                      <div class="form-check">
                          <input class="form-check-input chkEsDepartamento" type="checkbox" value="${value.id_usuario}" ${value.id_rol == 1 ? "checked" : ""}>
                      </div>
                    </td>
                    <td>
                        ${value.id_usuario}
                    </td>
                    <td>
                        ${value.nick}
                    </td>
                    <td>
                        ${value.nombre}
                    </td>
                    <td>
                        ${value.email}
                    </td>
                </tr>
            `;

            tbody.append(element);
        });
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

const getAllUsuarios = () => {

    return $.ajax({ 
        url: AJAX_URL_USER_CONTROLLER,
        data: { action: AJAX_URL_USER_CONTROLLER_GET_ALL, nodo: {} },
        type: 'post'
    });
};

const updateIdRol = (nodo) => {

    return $.ajax({ 
        url: AJAX_URL_USER_CONTROLLER,
        data: { action: AJAX_URL_USER_CONTROLLER_UPDATE_IDROL, nodo: JSON.stringify(nodo) },
        type: 'post'
    });
};