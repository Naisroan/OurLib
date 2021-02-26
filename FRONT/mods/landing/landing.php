<?php

    # landing.php

    define('TITLE', 'Inicio');
    define('FOLDER_NAME', 'landing');
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
    <?php require_once('templates/styles_site.php'); ?>
    <link rel="stylesheet" href="<?php echo URL_CSS ?>">
</head>

<body>

    <div class="wrapper">

        <!-- menu -->
        <?php require_once('templates/header_menu.php') ?>

        <!-- content -->
        <div class="banner">
            <div class="container">
                <div class="row">
                    <div class="col-12 col-lg-6">
                        <h1 class="display-1 text-white">
                            BISONTECA
                        </h1>
                        <hr class="text-white">
                        <p class="lead text-white">
                            Lorem ipsum, dolor sit amet consectetur adipisicing elit. 
                            Ad, molestiae! Sunt nostrum nemo mollitia assumenda ipsum voluptates doloremque quidem amet provident porro! 
                            Vitae iusto deserunt placeat laborum sit. Nisi, incidunt.
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <section class="container my-5">
            <h2>Cursos Adquiridos</h2>
            <p class="text-muted">
                Lorem ipsum dolor sit amet consectetur adipisicing elit.
            </p>
            <div class="row">
                <div class="card-wrapper col-6 col-lg-4 col-xl-3">
                    <div class="card">
                        <img src="http://lorempixel.com/280/150" class="card-img-top" alt="">
                        <div class="card-body">
                            <h5 class="card-title">
                                Card title
                                <small>
                                    <span class="badge bg-secondary fw-normal">Lorem ipsum</span>
                                </small>
                                <small class="d-block text-muted">
                                    Autor
                                </small>
                            </h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="/mods/curso_detail/curso_detail.php?id=0" class="btn btn-sm btn-bisonteca w-100 justify-content-center">
                                <i class="fas fa-info me-2"></i>
                                <span class="fw-normal fs-5">Ver más</span>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="card-wrapper col-6 col-lg-4 col-xl-3">
                    <div class="card">
                        <img src="http://lorempixel.com/280/150" class="card-img-top" alt="">
                        <div class="card-body">
                            <h5 class="card-title">
                                Card title
                                <small>
                                    <span class="badge bg-secondary fw-normal">Lorem ipsum</span>
                                </small>
                                <small class="d-block text-muted">
                                    Autor
                                </small>
                            </h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="/mods/curso_detail/curso_detail.php?id=0" class="btn btn-sm btn-bisonteca w-100 justify-content-center">
                                <i class="fas fa-info me-2"></i>
                                <span class="fw-normal fs-5">Ver más</span>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="card-wrapper col-6 col-lg-4 col-xl-3">
                    <div class="card">
                        <img src="http://lorempixel.com/280/150" class="card-img-top" alt="">
                        <div class="card-body">
                            <h5 class="card-title">
                                Card title
                                <small>
                                    <span class="badge bg-secondary fw-normal">Lorem ipsum</span>
                                </small>
                                <small class="d-block text-muted">
                                    Autor
                                </small>
                            </h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="/mods/curso_detail/curso_detail.php?id=0" class="btn btn-sm btn-bisonteca w-100 justify-content-center">
                                <i class="fas fa-info me-2"></i>
                                <span class="fw-normal fs-5">Ver más</span>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="card-wrapper col-6 col-lg-4 col-xl-3">
                    <div class="card">
                        <img src="http://lorempixel.com/280/150" class="card-img-top" alt="">
                        <div class="card-body">
                            <h5 class="card-title">
                                Card title
                                <small>
                                    <span class="badge bg-secondary fw-normal">Lorem ipsum</span>
                                </small>
                                <small class="d-block text-muted">
                                    Autor
                                </small>
                            </h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="/mods/curso_detail/curso_detail.php?id=0" class="btn btn-sm btn-bisonteca w-100 justify-content-center">
                                <i class="fas fa-info me-2"></i>
                                <span class="fw-normal fs-5">Ver más</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section class="container my-5">
            <h2>Cursos disponibles mas recientes</h2>
            <p class="text-muted">
                Lorem ipsum dolor sit amet consectetur adipisicing elit.
            </p>
            <div class="row">
                <div class="card-wrapper col-6 col-lg-4 col-xl-3">
                    <div class="card">
                        <img src="http://lorempixel.com/280/150" class="card-img-top" alt="">
                        <div class="card-body">
                            <h5 class="card-title">
                                Card title
                                <small>
                                    <span class="badge bg-secondary fw-normal">Lorem ipsum</span>
                                </small>
                                <small class="d-block text-muted">
                                    Autor
                                </small>
                            </h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="/mods/curso_detail/curso_detail.php?id=0" class="btn btn-sm btn-bisonteca w-100 justify-content-center">
                                <i class="fas fa-info me-2"></i>
                                <span class="fw-normal fs-5">Ver más</span>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="card-wrapper col-6 col-lg-4 col-xl-3">
                    <div class="card">
                        <img src="http://lorempixel.com/280/150" class="card-img-top" alt="">
                        <div class="card-body">
                            <h5 class="card-title">
                                Card title
                                <small>
                                    <span class="badge bg-secondary fw-normal">Lorem ipsum</span>
                                </small>
                                <small class="d-block text-muted">
                                    Autor
                                </small>
                            </h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="/mods/curso_detail/curso_detail.php?id=0" class="btn btn-sm btn-bisonteca w-100 justify-content-center">
                                <i class="fas fa-info me-2"></i>
                                <span class="fw-normal fs-5">Ver más</span>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="card-wrapper col-6 col-lg-4 col-xl-3">
                    <div class="card">
                        <img src="http://lorempixel.com/280/150" class="card-img-top" alt="">
                        <div class="card-body">
                            <h5 class="card-title">
                                Card title
                                <small>
                                    <span class="badge bg-secondary fw-normal">Lorem ipsum</span>
                                </small>
                                <small class="d-block text-muted">
                                    Autor
                                </small>
                            </h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="/mods/curso_detail/curso_detail.php?id=0" class="btn btn-sm btn-bisonteca w-100 justify-content-center">
                                <i class="fas fa-info me-2"></i>
                                <span class="fw-normal fs-5">Ver más</span>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="card-wrapper col-6 col-lg-4 col-xl-3">
                    <div class="card">
                        <img src="http://lorempixel.com/280/150" class="card-img-top" alt="">
                        <div class="card-body">
                            <h5 class="card-title">
                                Card title
                                <small>
                                    <span class="badge bg-secondary fw-normal">Lorem ipsum</span>
                                </small>
                                <small class="d-block text-muted">
                                    Autor
                                </small>
                            </h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="/mods/curso_detail/curso_detail.php?id=0" class="btn btn-sm btn-bisonteca w-100 justify-content-center">
                                <i class="fas fa-info me-2"></i>
                                <span class="fw-normal fs-5">Ver más</span>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-12 text-center mt-5">
                    <a href="/mods/search/search.php" class="btn btn-secondary btn-lg">
                        Ver mas cursos
                    </a>
                </div>
            </div>
        </section>
        <section class="container my-5">

        </section>
        <footer class="mt-5 bg-bisonteca">
            <div class="container py-5">
                <div class="row">
                    <div class="col-12">
                        <span>© BISONTECA <?php echo date("Y") ?></span>
                    </div>
                </div>
            </div>
        </footer>
    </div>

    <!-- scripts -->
    <?php require_once('templates/scripts_site.php'); ?>
    <script src="<?php echo URL_JS ?>"></script>

</body>

</html>