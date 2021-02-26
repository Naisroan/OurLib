<?php

    # curso_detail.php

    define('TITLE', 'Curso');
    define('FOLDER_NAME', 'curso_detail');
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
                            <h1 class="">Lorem ipsum</h1>
                            <h2 class="fs-4 text-bisonteca">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Officia, assumenda minima.</h2>
                        </div>
                        <div class="col-12">
                            <img src="https://picsum.photos/800/300" class="w-100" alt="">
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
                                        <div class="usuario d-flex justify-content-between align-items-center">
                                            <h6>Michi49</h6>
                                            <!-- <i class="fas fa-trash"></i> -->
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
                                        <div class="usuario d-flex justify-content-between align-items-center">
                                            <h6>Michi49</h6>
                                            <!-- <i class="fas fa-trash"></i> -->
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
                                        <div class="usuario d-flex justify-content-between align-items-center">
                                            <h6>Michi49</h6>
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
                                    <textarea class="form-control" rows="2" cols="1" placeholder="Ingresa tu comentario"></textarea>
                                </div>
                                <div class="col-12 text-end">
                                    <button class="btn btn-primary">
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
                        </div>
                        <div class="col-12">
                            <a href="#!" id="btnComprar" class="btn btn-primary btn-lg w-100">
                                <i class="fas fa-shopping-cart fa-fw mr-2"></i>
                                Comprar
                            </a>
                        </div>
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