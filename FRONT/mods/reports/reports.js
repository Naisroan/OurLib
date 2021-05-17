// --------------------------------------------------
// GLOBALES
// --------------------------------------------------

let id_rol = 0;

// --------------------------------------------------
// LOAD
// --------------------------------------------------

$(() => {

    id_rol = $("#txtIdRol").val();

    // creador
    if (id_rol == 1) {

        fillVentas();
        fillVentasReporte();
        fillGanancias();
    }

    // alumno
    fillHistorialReporte();
});

// --------------------------------------------------
// EVENTOS
// --------------------------------------------------

const onBtnDescargarCertificado = (id_curso) => {

    window.open('/certificado/certificado.php?id_curso=' + id_curso, '_blank');
};

// --------------------------------------------------
// METODOS
// --------------------------------------------------

const fillHistorialReporte = () => {

    let container = $("#historial");
    container.html("");

    getReporteHistorial().done((result) => {

        // console.log(result);
        if (isEmptyOrNull(result)) {

            container.html("");
            return;
        }

        let rows = JSON.parse(result);
    
        rows.forEach((value, idx) => {
        
            let element = `
            <tr>
                <th scope="row">${value.curso}</th>
                <td>${value.cant_niveles_curso}</td>
                <td>${value.cant_niveles_completados}</td>
                <td>${value.porcentaje_completado}</td>
                <td>${value.fecha_finalizacion}</td>
                <td>
                    ${value.fecha_finalizacion != 0 ? `<a href="#!" onclick="onBtnDescargarCertificado(${value.id_curso})"; class="btn btn-bisonteca">Generar</a>` : ""}
                </td>
            </tr>
            `;
    
            container.append(element);
        });
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

const fillVentasReporte = () => {

    let container = $("#ventastotales");
    container.html("");

    getAllReporte().done((result) => {

        // console.log(result);
        if (isEmptyOrNull(result)) {

            container.html("");
            return;
        }

        let rows = JSON.parse(result);
    
        rows.forEach((value, idx) => {
        
            let element = `
            <tr>
                <th scope="row">${value.curso}</th>
                <td>${value.cantidad_alumnos}</td>
                <td>${value.cantidad_ventas}</td>
                <td>${value.total_curso}</td>
            </tr>
            `;
    
            container.append(element);
        });
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

const fillVentas = () => {

    let container = $("#ventas");
    container.html("");

    getAllVentas().done((result) => {

        // console.log(result);
        if (isEmptyOrNull(result)) {

            container.html("");
            return;
        }

        let rows = JSON.parse(result);
    
        rows.forEach((value, idx) => {
        
            let element = `
            <tr>
                <th scope="row">${value.id_venta}</th>
                <td>${value.nick_usuario}</td>
                <td>${value.forma_pago == 1 ? "TARJETA" : "PAYPAL"}</td>
                <td>${value.monto_pago}</td>
                <td>${value.curso}</td>
                <td>${value.fecha_finalizacion}</td>
            </tr>
            `;
    
            container.append(element);
        });
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

const fillGanancias = () => {

    getGanancia().done((result) => {

        // console.log(result);
        if (isEmptyOrNull(result)) {

            container.html("");
            return;
        }

        $("#ganancia").text(result);
    })
    .fail((jqXHR) => {
        toastr_error(jqXHR.responseText);
        return;
    });
};

// --------------------------------------------------
// METODOS AJAX
// --------------------------------------------------

const getAllVentas = () => {

    return $.ajax({ 
        url: AJAX_URL_VENTA_CONTROLLER,
        data: { action: AJAX_URL_VENTA_CONTROLLER_GETALL, nodo: {} },
        type: 'post'
    });
};

const getAllReporte = () => {

    return $.ajax({ 
        url: AJAX_URL_VENTA_CONTROLLER,
        data: { action: AJAX_URL_VENTA_CONTROLLER_GETALLREPORTE, nodo: {} },
        type: 'post'
    });
};

const getGanancia = () => {

    return $.ajax({ 
        url: AJAX_URL_VENTA_CONTROLLER,
        data: { action: AJAX_URL_VENTA_CONTROLLER_GETGANANCIA, nodo: {} },
        type: 'post'
    });
};

const getReporteHistorial = () => {

    return $.ajax({ 
        url: AJAX_URL_HISTORIALUSUARIO_CONTROLLER,
        data: { action: AJAX_URL_HISTORIALUSUARIO_CONTROLLER_GETREPORTE, nodo: {} },
        type: 'post'
    });
};