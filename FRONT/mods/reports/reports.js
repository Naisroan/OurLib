// Validate empty inputs for report section

const validarFiltro = () => {


    let reporte = $("select#slReporte").val();
    

    if (isEmptyOrNull(reporte)) {

        message_warning("Necesita seleccionar un filtro!");
        return;
    }


};