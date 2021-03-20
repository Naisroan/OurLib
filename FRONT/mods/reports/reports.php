<?php

    # example.php

    define('TITLE', 'Reportes');
    define('FOLDER_NAME', 'reports');
    define('URL_CSS', '/mods/' . FOLDER_NAME . '/' . FOLDER_NAME . ".css");
    define('URL_JS', '/mods/' . FOLDER_NAME . '/' . FOLDER_NAME . ".js");
?>

<!DOCTYPE html>
<html lang="es-mx">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bisonteca © - <?php echo TITLE ?></title>
    <?php require_once('../../templates/styles_site.php'); ?>
    <link rel="stylesheet" href="<?php echo URL_CSS ?>">
    <link rel='shortcut icon' type='image/x-icon' href='/favicon.ico' />
</head>

<body>

    <div class="wrapper">

        <!-- menu -->
        <?php require_once('../../templates/header_menu.php') ?>

        <!-- content -->
        <div class="container my-4">
            <div class="row g-3">
                <div class="col-12">
                    <div class="input-group">
                        <select name="" id="slReporte" class="form-select">
                            <option value="0">Reporte...</option>
                            <option value="1">Historial</option>
                            <option value="2">Ventas</option>
                        </select>
                        <!-- <select name="" id="slFiltro" class="form-select">
                            <option value="0">Filtro...</option>
                        </select>
                        <input type="text" class="form-control" placeholder="Ingrese el filtro de búsqueda"> -->
                        <button class="btn btn-bisonteca"  onclick="validarFiltro();">
                            <i class="fas fa-search me-2"></i>
                            Filtrar
                        </button>
                    </div>
                </div>
                <div class="col-12">
                    <div class="table-responsive">
                        <table class="table table-borderless">
                            <thead>
                                <tr>
                                    <th scope="col">ID</th>
                                    <th scope="col">Persona</th>
                                    <th scope="col">Curso</th>
                                    <th scope="col">Progreso</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th scope="row">1</th>
                                    <td>Ian Alexandro Solis Cardona</td>
                                    <td>Programación Avanzada</td>
                                    <td>30%</td>
                                </tr>
                                <tr>
                                    <th scope="row">2</th>
                                    <td>Edgar Eliud</td>
                                    <td>Master en AutoDesk Maya</td>
                                    <td>45%</td>
                                </tr>
                                <tr>
                                    <th scope="row">3</th>
                                    <td>Juan Perez de la Rosa Cruz</td>
                                    <td>Alto Volumen de Administración de Datos</td>
                                    <td>100%</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-12">
                    <img src="/res/examples/Certificado02_Ejemplo.jpg" alt="" class="w-100">
                </div>
            </div>
        </div>

    </div>

    <!-- scripts -->
    <?php require_once('../../templates/scripts_site.php'); ?>
    <script src="<?php echo URL_JS ?>"></script>

</body>

</html>