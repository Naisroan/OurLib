<?php

    # header_menu.php

?>

<header id="header_menu">
    <nav id="nav_menu" class="bg-menu text-menu">
        <div class="container d-flex">
            <div id="nav_logo" class="me-4 py-3">
                <span class="">
                    <a href="/index.php" class="link-logo">
                        <img src="/res/logos/bisonteca_blanco_trans.png" alt="" class="">
                        <!-- BISONTECA -->
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
                    <li>
                        <a href="/mods/curso_detail/curso_detail.php">
                            Crear curso
                        </a>
                    </li>
                    <li>
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
                    <li>
                        <a href="/mods/account/account.php" class="link-cuenta">
                            <img src="/res/examples/user.png" class="me-2" alt="">
                            <strong>isolis</strong>
                        </a>
                    </li>
                    <li>
                        <a href="/mods/login/login.php" class="btn btn-bisonteca btn-sm">
                            Iniciar Sesión
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>