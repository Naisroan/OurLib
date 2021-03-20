<?php

    # curso_detail.php

    define('TITLE', 'Curso');
    define('FOLDER_NAME', 'curso_show');
    define('URL_CSS', '/mods/' . FOLDER_NAME . '/' . FOLDER_NAME . ".css");
    define('URL_JS', '/mods/' . FOLDER_NAME . '/' . FOLDER_NAME . ".js");

    # code

    $url
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
        <div class="container my-5">
            <div class="row">
                <div class="col-12 col-lg-7 col-xl-8">
                    <div class="row g-3">
                        <div class="col-12 titulo">
                            <h1 class="">Curso de Introducción a GitHub</h1>
                            <h2 class="fs-4 text-bisonteca">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Officia, assumenda minima.</h2>
                        </div>
                        <div class="col-12">
                            <img src="https://kinsta.com/wp-content/uploads/2018/04/what-is-github-1-1.png" class="w-100" alt="">
                        </div>
                        <div class="col-12">
                            <span class="badge bg-secondary fw-normal">
                                <strong class="mr-2">Autor</strong>
                                <span id="lblAutor">Lorem ipsum</span>
                            </span>
                        </div>
                        <div class="col-12">
                            <hr>
                        </div>
                        <div class="col-12">
                            <p class="descripcion-larga lead">
                                Lorem ipsum dolor sit amet consectetur adipisicing elit. Vel harum quasi explicabo ad tempora sint omnis odit quidem, ea dicta et expedita quo rerum reprehenderit amet suscipit eaque est doloribus?
                                Lorem ipsum, dolor sit amet consectetur adipisicing elit. Esse deleniti eaque repellat eum porro, laudantium adipisci iste at perferendis corrupti doloribus earum est possimus saepe minima. Omnis cum voluptatum libero.
                                Lorem ipsum dolor sit amet consectetur adipisicing elit. Reprehenderit amet minima quia, repellat officia adipisci quas debitis ipsum, nulla delectus maiores, velit ex sint aliquam? Odit optio neque voluptatem molestiae.
                                Lorem ipsum dolor sit amet consectetur adipisicing elit. Vel architecto nam quaerat deserunt dolor praesentium accusantium quisquam quis temporibus sit necessitatibus non error, eveniet assumenda aliquam itaque dignissimos dolorum minima?
                                Lorem ipsum dolor sit amet consectetur adipisicing elit. Quis maiores impedit, sed veniam laboriosam beatae iusto architecto exercitationem, et ex voluptatum? Atque, cupiditate? Dolor provident, doloribus consequuntur perferendis deserunt sit.
                                Lorem ipsum dolor sit amet, consectetur adipisicing elit. Recusandae nihil velit nulla magnam quidem impedit facilis porro, esse doloribus temporibus nobis earum optio aspernatur possimus omnis maxime asperiores sapiente tenetur.
                                Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellendus ex quasi, fugiat sunt nobis sapiente aspernatur dolorem hic, nostrum deleniti veritatis. Impedit, ratione. Quis dignissimos ad aut obcaecati sapiente voluptas.
                            </p>
                        </div>
                        <div class="col-12">
                            <h3>Niveles</h3>
                            <small class="text-muted">
                                Si solo te interesa un nivel del curso, puedes adquirirlo individualmente
                            </small>
                        </div>
                        <div class="col-12">
                            <ul class="list-group list-group-flush niveles">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <div class="input-group input-group-sm justify-content-end">
                                        <input type="text" class="form-control" readonly value="Titulo nivel #1">
                                        <span class="input-group-text">$</span>
                                        <span class="input-group-text">50.00 MXN</span>
                                        <a href="#!" class="btn btn-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                                            Compra individual
                                        </a>
                                    </div>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <div class="input-group input-group-sm justify-content-end">
                                        <input type="text" class="form-control" readonly value="Titulo nivel #2">
                                        <span class="input-group-text">$</span>
                                        <span class="input-group-text">0.00 MXN</span>
                                        <a href="#!" class="btn btn-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                                            Compra individual
                                        </a>
                                    </div>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <div class="input-group input-group-sm justify-content-end">
                                        <input type="text" class="form-control" readonly value="Titulo nivel #3">
                                        <span class="input-group-text">$</span>
                                        <span class="input-group-text">15.00 MXN</span>
                                        <a href="#!" class="btn btn-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                                            Compra individual
                                        </a>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="col-12">
                            <h3>Valoraciones</h3>
                        </div>
                        <div class="col-12 valoracion text-center d-flex align-items-center justify-content-center flex-row w-100">
                            <div class="me-5 fs-1">
                                <i class="fas fa-thumbs-up mr-2"></i>
                                <span class="">323</span>
                            </div>
                            <div class="fs-1">
                                <i class="fas fa-thumbs-down mr-2"></i>
                                <span class="">15</span>
                            </div>
                        </div>
                        <div class="col-12 comentarios">
                            <div class="comentario mb-3 p-2">
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
                                <!-- <div class="footer ml-5 pl-2 mb-2">
                                    <i class="fas fa-thumbs-up mr-3"></i>
                                    <i class="fas fa-thumbs-down mr-3"></i>
                                    <a href="#!">Responder a Michi49</a>
                                </div> -->
                            </div>
                            <div class="comentario mb-3 p-2">
                                <div class="d-flex">
                                    <img src="http://picsum.photos/60/60/" height="40" width="40" class="rounded-circle me-3" />
                                    <div class="contenido w-100">
                                        <div class="usuario d-flex justify-content-start align-items-center">
                                            <h6 class="mb-0 me-2">Michi49</h6>
                                            <small class="votacion">
                                                <i class="fas fa-thumbs-up me-2"></i>
                                                <i class="fas fa-thumbs-down me-2"></i>
                                            </small>
                                        </div>
                                        <p class="mb-2">Lorem ipsum dolor sit amet consectetur adipisicing elit. Eius adipisci incidunt perspiciatis soluta aperiam quia voluptates doloremque deleniti facere itaque distinctio pariatur saepe necessitatibus nam, eveniet veritatis provident nisi illum?</p>
                                    </div>
                                </div>
                                <!-- <div class="footer ml-5 pl-2 mb-2">
                                    <i class="fas fa-thumbs-up mr-3"></i>
                                    <i class="fas fa-thumbs-down mr-3"></i>
                                    <a href="#!">Responder a Michi49</a>
                                </div> -->
                            </div>
                            <div class="comentario mb-3 p-2">
                                <div class="d-flex">
                                    <img src="http://picsum.photos/60/60/" height="40" width="40" class="rounded-circle me-3" />
                                    <div class="contenido w-100">
                                        <div class="usuario d-flex justify-content-start align-items-center">
                                            <h6 class="mb-0 me-2">Michi49</h6>
                                            <small class="votacion">
                                                <i class="fas fa-thumbs-up me-2"></i>
                                                <i class="fas fa-thumbs-down me-2"></i>
                                            </small>
                                            <!-- <i class="fas fa-trash"></i> -->
                                        </div>
                                        <p class="mb-2">Lorem ipsum dolor sit amet consectetur, adipisicing elit. Aperiam laboriosam, expedita dolorum repellat nemo nostrum minima explicabo dolorem! Fugit asperiores quia in deleniti laborum labore nisi aperiam perspiciatis adipisci doloribus.</p>
                                    </div>
                                </div>
                                <!-- <div class="footer ml-5 pl-2 mb-2">
                                    <i class="fas fa-thumbs-up mr-3"></i>
                                    <i class="fas fa-thumbs-down mr-3"></i>
                                    <a href="#!">Responder a Michi49</a>
                                </div> -->
                            </div>
                        </div>
                        <div class="col-12 nuevo-comentario">
                            <div class="row g-3">
                                <div class="col-12 d-flex align-items-center">
                                    <img src="http://picsum.photos/60/60/" height="60" width="60" class="rounded-circle me-3" />
                                    <textarea id="Commentary" name="Commentary" class="form-control" rows="2" cols="1" placeholder="Ingresa tu comentario"></textarea>
                                </div>
                                <div class="col-12 text-end votacion">
                                    <i class="fas fa-thumbs-up me-2"></i>
                                    <i class="fas fa-thumbs-down me-2"></i>
                                    <button class="btn btn-bisonteca" onclick="validarComentario();">
                                        Comentar
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-lg-5 col-xl-4">
                    <div class="row g-3 precio">
                        <div class="col-12">
                            <h3>
                                $ 259.99 MXN
                            </h3>
                            <small class="text-muted">
                                PRECIO TOTAL
                            </small>
                        </div>
                        <div class="col-12">
                            <hr class="text-bisonteca">
                        </div>
                        <div class="col-12">
                            <a href="#!" class="btn btn-primary btn-lg w-100" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                                <i class="fas fa-shopping-cart fa-fw mr-2"></i>
                                Comprar
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
                            Comprar Curso/Nivel
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="" method="post" class="w-100 mb-4">
                            <div class="row g-3">
                                <div class="col-12">
                                    <label for="" class="label-form text-bisonteca">Datos de pago</label>
                                    <hr class="text-bisonteca my-0">
                                </div>
                                <div class="col-12">
                                    <label for="" class="label-form">Método de pago</label>
                                    <select id="slMetodoPago" class="form-select">
                                        <option value='1'>Tarjeta</option>
                                        <option value='2'>PayPal</option>
                                    </select> 
                                </div>
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
                                <div class="col-12">
                                    <a id="btnPagar" href="#!" class="btn btn-bisonteca w-100" onclick="validarCompra();">
                                        <i class="fas fa-shopping-bag me-2"></i>
                                        Checkout!
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Volver</button>
                        <!-- <button type="button" class="btn btn-bisonteca">Guardar</button> -->
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