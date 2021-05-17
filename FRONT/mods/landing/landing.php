<?php

    # landing.php

    define('TITLE', 'Inicio');
    define('FOLDER_NAME', 'landing');
    define('URL_CSS', '/mods/' . FOLDER_NAME . '/' . FOLDER_NAME . ".css");
    define('URL_JS', '/mods/' . FOLDER_NAME . '/' . FOLDER_NAME . ".js");

    if(!isset($_SESSION)) {
        session_start(); 
    }

    $usuarioLogeado = null;

    if (isset($_SESSION["auth_user"])) {
        
        $usuarioLogeado = $_SESSION["auth_user"];
    }
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
    <link rel='shortcut icon' type='image/x-icon' href='/favicon.ico' />
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
                        <h1 class="text-white w-100">
                            <img src="/res/logos/bisonteca_blanco_trans.png" alt="" class="w-100" srcset="">
                        </h1>
                        <hr class="text-white">
                        <p class="lead text-white">
                            Aprende, disfruta y crece con Bisonteca, los cursos de chavos, para chavos ♥
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <?php

        if (isset($usuarioLogeado) && $usuarioLogeado->id_rol == 1) {
        
        ?>

        <section class="container my-5">
            <h2>Mis cursos subidos</h2>
            <p class="text-muted">
                Visualiza y edita tus cursos
            </p>
            <div class="row" id="cursossubidos">
                <!-- <div class="card-wrapper col-6 col-lg-4 col-xl-3">
                    <div class="card">
                        <img src="https://picsum.photos/280/150" class="card-img-top" alt="">
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
                            <a href="/mods/curso_show/curso_show.php?id=0" class="btn btn-sm btn-bisonteca w-100 justify-content-center">
                                <i class="fas fa-info me-2"></i>
                                <span class="fw-normal fs-5">Ver más</span>
                            </a>
                        </div>
                    </div>
                </div> -->
                <!-- <div class="col-12 text-center mt-5">
                    <a href="/mods/search/search.php" class="btn btn-secondary btn-lg">
                        Ver todos mis cursos
                    </a>
                </div> -->
            </div>
        </section>

        <?php
            
        }

        ?>

        <?php

        if (isset($usuarioLogeado)) {
        
        ?>
        
        <section class="container my-5">
            <h2>Cursos Adquiridos</h2>
            <p class="text-muted">
                Aprende continuamente
            </p>
            <div id="cursosadquiridos" class="row">
                <!-- <div class="card-wrapper col-6 col-lg-4 col-xl-3">
                    <div class="card">
                        <img src="https://picsum.photos/280/150" class="card-img-top" alt="">
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
                            <a href="/mods/curso_learning/curso_learning.php?id=0" class="btn btn-sm btn-bisonteca w-100 justify-content-center">
                                <i class="fas fa-info me-2"></i>
                                <span class="fw-normal fs-5">Aprender</span>
                            </a>
                        </div>
                    </div>
                </div> -->
                <!-- <div class="col-12 text-center mt-5">
                    <a href="/mods/search/search.php" class="btn btn-secondary btn-lg">
                        Ver mis cursos
                    </a>
                </div> -->
            </div>
        </section>

        <?php
        }
        ?>
        
        <section class="container my-5">
            <h2>Cursos mas recientes</h2>
            <p class="text-muted">
                Descubre los cursos nuevos
            </p>
            <div class="row" id="cursosrecientes">
                <!-- <div class="card-wrapper col-6 col-lg-4 col-xl-3">
                    <div class="card">
                        <img src="https://kinsta.com/wp-content/uploads/2018/04/what-is-github-1-1.png" class="card-img-top" alt="">
                        <div class="card-body">
                            <h5 class="card-title">
                                Curso de Introducción a GitHub
                                <small>
                                    <span class="badge bg-secondary fw-normal">Lorem ipsum</span>
                                </small>
                                <small class="d-block text-muted">
                                    Autor
                                </small>
                            </h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="/mods/curso_show/curso_show.php?id=0" class="btn btn-sm btn-bisonteca w-100 justify-content-center">
                                <i class="fas fa-info me-2"></i>
                                <span class="fw-normal fs-5">Ver más</span>
                            </a>
                        </div>
                    </div>
                </div> -->
                <!-- <div class="col-12 text-center mt-5">
                    <a href="/mods/search/search.php" class="btn btn-secondary btn-lg">
                        Ver mas cursos
                    </a>
                </div> -->
            </div>
        </section>

        <section class="container my-5">
            <h2>Cursos mas vendidos</h2>
            <p class="text-muted">
                Descubre los cursos mas adquiridos por la comunidad
            </p>
            <div class="row" id="cursosmasvendidos">
                <!-- <div class="card-wrapper col-6 col-lg-4 col-xl-3">
                    <div class="card">
                        <img src="https://kinsta.com/wp-content/uploads/2018/04/what-is-github-1-1.png" class="card-img-top" alt="">
                        <div class="card-body">
                            <h5 class="card-title">
                                Curso de Introducción a GitHub
                                <small>
                                    <span class="badge bg-secondary fw-normal">Lorem ipsum</span>
                                </small>
                                <small class="d-block text-muted">
                                    Autor
                                </small>
                            </h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="/mods/curso_show/curso_show.php?id=0" class="btn btn-sm btn-bisonteca w-100 justify-content-center">
                                <i class="fas fa-info me-2"></i>
                                <span class="fw-normal fs-5">Ver más</span>
                            </a>
                        </div>
                    </div>
                </div> -->
                <!-- <div class="col-12 text-center mt-5">
                    <a href="/mods/search/search.php" class="btn btn-secondary btn-lg">
                        Ver mas cursos
                    </a>
                </div> -->
            </div>
        </section>
        
        <section class="container my-5">
            <h2>Cursos mejor calificados</h2>
            <p class="text-muted">
                Descubre los cursos mas populares
            </p>
            <div class="row" id="cursosmasvistos">
                <!-- <div class="card-wrapper col-6 col-lg-4 col-xl-3">
                    <div class="card">
                        <img src="https://picsum.photos/280/150" class="card-img-top" alt="">
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
                            <a href="/mods/curso_show/curso_show.php?id=0" class="btn btn-sm btn-bisonteca w-100 justify-content-center">
                                <i class="fas fa-info me-2"></i>
                                <span class="fw-normal fs-5">Ver más</span>
                            </a>
                        </div>
                    </div>
                </div> -->
                <!-- <div class="col-12 text-center mt-5">
                    <a href="/mods/search/search.php" class="btn btn-secondary btn-lg">
                        Ver mas cursos
                    </a>
                </div> -->
            </div>
        </section>

        <footer class="mt-5 bg-dark">
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