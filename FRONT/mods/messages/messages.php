<?php

    # example.php

    define('TITLE', 'Mensajes');
    define('FOLDER_NAME', 'messages');
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
        <div class="container">
            <div class="row py-4">
                <div class="col-4 col-lg-4 col-xl-3">
                    <ul class="list-group list-group-flush lista-usuarios" id="list-tab" role="tablist">
                        <li class="list-group-item">
                            <input type="text" class="form-control" placeholder="Buscar usuario...">
                        </li>
                        <li class="list-group-item" onclick="window.location='/mods/messages/messages.php?id=0'">
                            <img src="/res/examples/user.png" class="usuario rounded-circle" alt="">
                            <strong>
                                Ian
                            </strong>
                        </li>
                        <li class="list-group-item" onclick="window.location='/mods/messages/messages.php?id=1'">
                            <img src="/res/examples/user.png" class="usuario rounded-circle" alt="">
                            <strong>
                                Karen
                            </strong>
                        </li>
                        <li class="list-group-item" onclick="window.location='/mods/messages/messages.php?id=2'">
                            <img src="/res/examples/user.png" class="usuario rounded-circle" alt="">
                            <strong>
                                Edgar
                            </strong>
                        </li>
                    </ul>
                </div>
                <div class="col-8 col-lg-8 col-xl-9">
                    <div class="messages d-flex justify-content-between flex-column">
                        <div class="">
                            <h3>
                                <img src="/res/examples/user.png" class="usuario rounded-circle" alt="">
                                Ian
                            </h3>
                            <hr>
                        </div>
                        <div class="content">
                            <div class="message d-flex">
                                <div class="body">
                                    <img src="/res/examples/user.png" height="40" width="40" class="rounded-circle" />
                                    <div class="contenido">
                                        <div class="usuario d-flex justify-content-start align-items-center">
                                            <strong>
                                                Ian
                                            </strong>
                                        </div>
                                        <p class="mb-0">
                                            A accusamus voluptatum dolorum minima voluptas praesentium sequi?
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="message yo d-flex">
                                <div class="body">
                                    <img src="http://picsum.photos/60/60/" height="40" width="40" class="rounded-circle" />
                                    <div class="contenido">
                                        <div class="usuario d-flex justify-content-start align-items-center">
                                            <strong>
                                                Yo
                                            </strong>
                                        </div>
                                        <p class="mb-0">
                                            Lorem ipsum, dolor sit amet consectetur adipisicing elit.
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="">
                            <hr>
                            <div class="row g-3">
                                <div class="col-12 d-flex align-items-center">
                                    <input class="form-control" id="txtmessage" placeholder="Ingresa tu mensaje">
                                </div>
                                <div class="col-12 text-end votacion">
                                    <button class="btn btn-bisonteca"  onclick="validar_mensajes();">
                                        Enviar
                                    </button>
                                </div>
                            </div>
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