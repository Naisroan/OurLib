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

<div id="slCargando" class="screen-loader">
    <div class="screen-loader-wrapper">
        <div class="lds-ripple">
            <div></div>
            <div></div>
        </div>
    </div>
</div>

<button id="btnMenu" class="btn btn-menu btn-lg">
    <i class="fas fa-bars"></i>
</button>

<header id="header_menu" class="">
    <nav id="nav_menu" class="bg-menu text-menu">
        <div class="container d-flex flex-column">
            <div id="nav_logo" class="my-4">
                <span class="">
                    <a href="/index.php" class="link-logo">
                        <img src="/res/logos/ourlib.png" alt="" class="">
                        <!-- OurLib -->
                    </a>
                </span>
            </div>
            <div id="nav_items" class="d-flex flex-fill flex-column">
                <ul class="list-unstyled list-group m-0">
                    <li>
                        <hr class="mt-0" />
                    </li>
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
                    </li>
                    <li>
                        <hr />
                    </li>
                    <!-- <li class="<?php echo $usuarioLogeado != null ? "" : "visually-hidden" ?>">
                        <a href="/mods/reports/reports.php">
                            Reportes
                        </a>
                    </li> -->
                    <li>
                        <a href="/index.php">
                            <i class="fas fa-home fa-fw me-2"></i>
                            Inicio
                        </a>
                    </li>
                    <li>
                        <a href="/mods/search/search.php">
                            <i class="fas fa-search fa-fw me-2"></i>
                            Descubrir
                        </a>
                    </li>
                    <li>
                        <a href="/mods/messages/messages.php">
                            <i class="fas fa-comment fa-fw me-2"></i>
                            Mensajes
                        </a>
                    </li>
                    <li class="<?php echo $usuarioLogeado != null && $usuarioLogeado->id_rol == 1 ? "" : "visually-hidden" ?>">
                        <a href="/mods/curso_detail/curso_detail.php" class="btn-ourlib-gradient">
                            <i class="fas fa-plus fa-fw me-2"></i>
                            Crear contenido
                        </a>
                    </li>
                    <li>
                        <hr />
                    </li>
                </ul>
                <ul class="list-unstyled list-group m-0 <?php echo $usuarioLogeado != null && $usuarioLogeado->id_rol_especial == 1 ? "" : "visually-hidden" ?>">
                    <li>
                        <a href="/mods/departments/departments.php">
                            <i class="fas fa-archway me-2"></i>
                            Departamentos
                        </a>
                    </li>
                    <li>
                        <hr />
                    </li>
                </ul>
                <ul class="list-unstyled list-group m-0">
                    <li>
                        <a href="#!" tooltip="Cerrar sesión" onclick="logout();" class="nav-link <?php echo $usuarioLogeado != null ? "" : "visually-hidden" ?>">
                            <i class="fas fa-sign-out-alt fa-fw me-2"></i>
                            Cerrar Sesión
                        </a>
                    </li>
                    <li>
                        <hr />
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>