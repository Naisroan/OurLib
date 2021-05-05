<?php

    # header_menu.php

    if(!isset($_SESSION)) {
        session_start(); 
    }

    $usuarioLogeado = null;

    if (isset($_SESSION["auth_user"])) {
        
        $usuarioLogeado = $_SESSION["auth_user"];
    }
?>

<header id="header_menu">
    <nav id="nav_menu" class="bg-menu text-menu">
        <div class="container d-flex">
            <div id="nav_logo" class="me-4 py-3">
                <span class="">
                    <a href="/index.php" class="link-logo">
                        <!-- <img src="/res/logos/bisonteca_blanco_trans.png" alt="" class=""> -->
                        BISONTECA
                    </a>
                </span>
            </div>
            <div id="nav_items" class="d-flex flex-fill justify-content-between align-items-center">
                <ul class="list-unstyled m-0">
                    <!-- <li>
                        <a href="/mods/search/search.php">
                            Mis Cursos
                        </a>
                    </li> -->
                    <li class="<?php echo $usuarioLogeado != null && $usuarioLogeado->id_rol == 1 ? "" : "visually-hidden" ?>">
                        <a href="/mods/curso_detail/curso_detail.php">
                            Crear curso
                        </a>
                    </li>
                    <li class="<?php echo $usuarioLogeado != null ? "" : "visually-hidden" ?>">
                        <a href="/mods/reports/reports.php">
                            Reportes
                        </a>
                    </li>
                </ul>
                <ul class="list-unstyled m-0">
                    <li>
                        <a href="/mods/search/search.php">
                            <i class="fas fa-search fa-fw"></i>
                        </a>
                    </li>
                    <li>
                        <a href="/mods/messages/messages.php">
                            <i class="fas fa-comment fa-fw"></i>
                        </a>
                    </li>
                    <!-- <li>
                        <a href="/mods/login/login.php">Iniciar Sesión</a>
                    </li> -->
                    <li class="<?php echo $usuarioLogeado != null ? "" : "visually-hidden" ?>">
                        <a href="/mods/account/account.php" class="link-cuenta d-flex align-items-center">
                            <div
                                class="imagen-usuario rounded-circle me-2"
                                style='background-image: url(<?php
                                        echo isset($usuarioLogeado) && $usuarioLogeado->imagen != null
                                            ? "data:" . $usuarioLogeado->tipo_imagen . ";base64," . $usuarioLogeado->imagen
                                            : "/res/examples/user.png"
                                    ?>);'>
                            </div>
                            <strong>
                                <?php
                                    if ($usuarioLogeado != null) {
                                        echo $usuarioLogeado->nick;
                                    } else{
                                        echo "";
                                    }
                                ?>
                            </strong>
                        </a>
                    </li>
                    <li>
                        <a href="/mods/login/login.php" class="nav-link <?php echo $usuarioLogeado == null ? "" : "visually-hidden" ?>">
                            Iniciar Sesión
                        </a>
                        <a href="#!" onclick="logout();" class="nav-link <?php echo $usuarioLogeado != null ? "" : "visually-hidden" ?>">
                            Cerrar Sesión
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>