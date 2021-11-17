<?php

    # curso_detail.php

    define('TITLE', 'Contenido');
    define('FOLDER_NAME', 'curso_show');
    define('URL_CSS', '/mods/' . FOLDER_NAME . '/' . FOLDER_NAME . ".css");
    define('URL_JS', '/mods/' . FOLDER_NAME . '/' . FOLDER_NAME . ".js");

    # code
    if (!isset($_SESSION))
    {
        session_start();
    }

    // si el usuario no esta logeado se redirecciona al login
    if (!isset($_SESSION["auth_user"]))
    {
        header("Location: /mods/login/login.php");
        exit();
    }

    $usuarioLogeado = $_SESSION["auth_user"];
?>

<!DOCTYPE html>
<html lang="es-mx" class="overflow-hidden">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OurLib © - <?php echo TITLE ?></title>
    <?php require_once('../../templates/styles_site.php'); ?>
    <link rel="stylesheet" href="<?php echo URL_CSS ?>">
    <link rel='shortcut icon' type='image/x-icon' href='/favicon.ico' />
</head>

<body>

    <!-- menu -->
    <?php require_once('../../templates/header_menu.php') ?>

    <div class="wrapper">

        <!-- id -->
        <input id="txtId" type="text" value="0" class="d-none invisible">
        <input id="txtIdNivelCurso" type="text" value="0" class="d-none invisible">

        <!-- content -->
        <div class="container my-5">
            <div class="row">
                <div class="col-12 col-lg-7 col-xl-8">
                    <div class="row g-3">
                        <div class="col-12 titulo">
                            <h1 id="title" class=""></h1>
                            <h2 id="subtitle" class="fs-4 text-ourlib"></h2>
                        </div>
                        <div class="col-12">
                            <div id="image" class="curso-image">
                            </div>
                        </div>
                        <div class="col-12">
                            <span class="badge bg-secondary fw-normal">
                                <strong class="me-1">Creador por</strong>
                                <strong><span id="lblAutor"></span></strong>
                            </span>
                            <a id="btnEnviarMensaje" href="#!">
                                <span class="badge bg-info fw-normal">
                                    <i class="fas fa-fw fa-paper-plane me-1"></i>
                                    <strong class="">Enviar mensaje</strong>
                                </span>
                            </a>
                        </div>
                        <div class="col-12">
                            <hr>
                        </div>
                        <div class="col-12">
                            <p id="description" class="descripcion-larga lead">
                            </p>
                        </div>
                        <div class="col-12">
                            <h3>Niveles</h3>
                            <small class="text-muted">
                                <!-- Si solo te interesa un nivel del curso, puedes adquirirlo individualmente -->
                                Todos los niveles/fases del contenido
                            </small>
                        </div>
                        <div class="col-12">
                            <ul id="niveles" class="list-group list-group-flush niveles">
                                <!-- <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <div class="input-group input-group-sm justify-content-end">
                                        <input type="text" class="form-control" readonly value="Titulo nivel #1">
                                        <span class="input-group-text">$</span>
                                        <span class="input-group-text">50.00 MXN</span>
                                        <a href="#!" class="btn btn-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                                            Compra individual
                                        </a>
                                    </div>
                                </li> -->
                            </ul>
                        </div>
                        <div class="col-12">
                            <h3>Valoraciones</h3>
                        </div>
                        <div class="col-12 valoracion text-center d-flex align-items-center justify-content-center flex-row w-100">
                            <div class="me-5 fs-1">
                                <i class="fas fa-thumbs-up mr-2"></i>
                                <span id="votos_positivos" class="">0</span>
                            </div>
                            <div class="fs-1">
                                <i class="fas fa-thumbs-down mr-2"></i>
                                <span id="votos_negativos" class="">0</span>
                            </div>
                        </div>
                        <div id="comentarios" class="col-12 comentarios">
                            <!-- <div class="comentario mb-3 p-2">
                                <div class="d-flex">
                                    <img src="http://picsum.photos/60/60/" height="40" width="40" class="rounded-circle me-3" />
                                    <div class="contenido w-100">
                                        <div class="usuario d-flex justify-content-start align-items-center">
                                            <h6 class="mb-0 me-2">Michi49</h6>
                                            <small class="votacion">
                                                <i class="fas fa-thumbs-up active me-2"></i>
                                                <i class="fas fa-thumbs-down me-2"></i>
                                            </small>
                                        </div>
                                        <p class="mb-2">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                    </div>
                                </div>
                            </div> -->
                        </div>
                        <div class="col-12 nuevo-comentario">
                            <div class="row g-3">
                                <div class="col-12 d-flex align-items-center">
                                    <!-- <img src="http://picsum.photos/60/60/" height="60" width="60" class="rounded-circle me-3" /> -->
                                    <div
                                        class="imagen-usuario rounded-circle me-3"
                                        style='background-image: url(<?php
                                                echo isset($usuarioLogeado) && $usuarioLogeado->imagen != null
                                                    ? "data:" . $usuarioLogeado->tipo_imagen . ";base64," . $usuarioLogeado->imagen
                                                    : "/res/examples/user.png"
                                            ?>);'>
                                    </div>
                                    <textarea id="Commentary" name="Commentary" class="form-control" rows="2" cols="1" placeholder="Ingresa tu comentario"></textarea>
                                </div>
                                <form id="frmComentar" method="post" class="col-12 text-end votacion">
                                    <i id="thumbUp" class="fas fa-thumbs-up me-2" onclick="onThumbClickValoracion(this);"></i>
                                    <i id="thumbDown" class="fas fa-thumbs-down me-2" onclick="onThumbClickValoracion(this);"></i>
                                    <button id="btnComentar" class="btn btn-ourlib" type="submit">
                                        <span class="spinner-grow spinner-grow visually-hidden" role="status" aria-hidden="true"></span>
                                        <i class="fas fa-fw fa-paper-plane me-2"></i>
                                        <span class="text">Comentar</span>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-lg-5 col-xl-4">
                    <div class="row g-3 precio">
                        <div class="col-12">
                            <h3 id="price">
                                $ 0.0 MXN
                            </h3>
                            <small class="text-muted">
                                PRECIO TOTAL
                            </small>
                        </div>
                        <div class="col-12">
                            <hr class="text-ourlib">
                        </div>
                        <div class="col-12">
                            <a href="#!" class="btn btn-primary btn-lg w-100" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                                <i class="fas fa-shopping-cart fa-fw mr-2"></i>
                                <!-- <i class="fas fa-heart fa-fw mr-2"></i> -->
                                Adquirir
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="staticBackdropLabel">
                            Inscribirse al contenido
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="frmPagar" method="post" class="w-100 mb-4">
                            <div class="row g-3">
                                <div class="col-12">
                                    <h4 class="label-form text-white text-center">¿Esta de acuerdo en inscribirse al contenido seleccionado?</h4>
                                </div>
                                <div class="col-12">
                                    <label for="" class="label-form text-ourlib">Datos de pago</label>
                                    <hr class="text-ourlib my-0">
                                </div>

                                <div class="col-12">
                                    <label for="" class="label-form">Método de pago</label>
                                    <select id="slMetodoPago" class="form-select">
                                        <option value='1'>Tarjeta</option>
                                        <option value='2'>Folio</option>
                                    </select> 
                                </div>

                                <div id="pnlTarjeta" class="col-12">
                                    <div class="row g-3">
                                        <div class="col-12">
                                            <label for="" class="label-form">Número de tarjeta</label>
                                            <input id="ccn" type="tel" inputmode="numeric" pattern="[0-9\s]{13,19}" autocomplete="cc-number" maxlength="19" placeholder="XXXX XXXX XXXX XXXX" class="form-control">
                                        </div>
                                        <div class="col-12 col-lg-7">
                                            <label for="" class="label-form">Vencimiento</label>
                                            <div class="input-group mb-3">
                                                <select class="form-select" id="txtTarjVencimiento">
                                                    <option value=''>Mes</option>
                                                    <option value='01'>Enero</option>
                                                    <option value='02'>Febrero</option>
                                                    <option value='03'>Marzo</option>
                                                    <option value='04'>Abril</option>
                                                    <option value='05'>Mayo</option>
                                                    <option value='06'>Junio</option>
                                                    <option value='07'>Julio</option>
                                                    <option value='08'>Agosto</option>
                                                    <option value='09'>Septiembre</option>
                                                    <option value='10'>Octubre</option>
                                                    <option value='11'>Noviembre</option>
                                                    <option value='12'>Diciembre</option>
                                                </select> 
                                                <select name="expireYY" class="form-select" id="txtTarjAnio" aria-describedby="basic-addon1">
                                                    <option value=''>Año</option>
                                                    <option value='21'>2021</option>
                                                    <option value='22'>2022</option>
                                                    <option value='23'>2023</option>
                                                    <option value='24'>2024</option>
                                                    <option value='25'>2025</option>
                                                    <option value='26'>2026</option>
                                                    <option value='27'>2027</option>
                                                    <option value='28'>2028</option>
                                                    <option value='29'>2029</option>
                                                    <option value='30'>2030</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-12 col-lg-5">
                                            <label for="" class="label-form">CVV</label>
                                            <input id="txtCvv" type="text" class="form-control">
                                        </div>
                                    </div>
                                </div>

                                <div id="pnlFolio" class="col-12 d-none">
                                    <div class="row g-3">
                                        <div class="col-12">
                                            <label for="" class="label-form"># de Folio</label>
                                            <input id="folio" type="text" autocomplete="" maxlength="49" placeholder="XXXXXXXXX" class="form-control">
                                        </div>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <a href="#!" id="btnPagar" class="btn btn-ourlib w-100" onclick="onBtnPagarClick();">
                                        <span class="spinner-grow spinner-grow visually-hidden" role="status" aria-hidden="true"></span>
                                        <i class="fas fa-check me-2"></i>
                                        <span class="text">Claro, continuar</span>
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Volver</button>
                        <!-- <button type="button" class="btn btn-ourlib">Guardar</button> -->
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- scripts -->
    <?php require_once('../../templates/scripts_site.php'); ?>
    <script src="<?php echo URL_JS ?>"></script>

</body>

</html>