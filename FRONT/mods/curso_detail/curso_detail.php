<?php

    # curso_detail.php

    define('TITLE', 'Detalle de Curso');
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
    <link rel='shortcut icon' type='image/x-icon' href='/favicon.ico' />
</head>

<body>

    <div class="wrapper">

        <!-- menu -->
        <?php require_once('../../templates/header_menu.php') ?>

        <!-- content -->
        <div class="container my-5">
            <div class="row">
                <div class="col-12 mb-3">
                    <h1 class="h3">Agregar Curso</h1>
                    <p class="lead">Ingrese los datos solicitados</p>
                </div>
                <div class="col-12 col-lg-4 col-xl-3">
                    <div class="row g-3 mb-5">
                        <div class="col-12">
                            <small class="text-bisonteca">Pasos</small>
                            <hr class="my-0">
                        </div>
                        <div class="col-12">
                            <div class="d-flex flex-fill align-items-stretch">
                                <div class="nav flex-column nav-pills flex-fill" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                                    <button class="nav-link text-center text-lg-start active" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">
                                        Datos básicos
                                    </button>
                                    <button class="nav-link text-center text-lg-start" id="v-pills-image-tab" data-bs-toggle="pill" data-bs-target="#v-pills-image" type="button" role="tab" aria-controls="v-pills-image" aria-selected="false">
                                        Imagen
                                    </buttona>
                                    <button class="nav-link text-center text-lg-start" id="v-pills-cat-tab" data-bs-toggle="pill" data-bs-target="#v-pills-cat" type="button" role="tab" aria-controls="v-pills-cat" aria-selected="false">
                                        Categorías
                                    </buttona>
                                    <button class="nav-link text-center text-lg-start" id="v-pills-levels-tab" data-bs-toggle="pill" data-bs-target="#v-pills-levels" type="button" role="tab" aria-controls="v-pills-levels" aria-selected="false">
                                        Niveles
                                    </buttona>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-lg-8 col-xl-9">
                    <div class="tab-content" id="v-pills-tabContent">
                        <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
                            <form action="" method="post" class="w-100">
                                <div class="row g-3">
                                    <div class="col-12">
                                        <small class="text-bisonteca">Información general</small>
                                        <hr class="my-0">
                                    </div>
                                    <div class="col-12 col-lg-12">
                                        <label for="" class="label-form">Título</label>
                                        <input id="txtTitulo" name="txtTitulo" type="text" class="form-control" placeholder="Ingrese el título del curso">
                                    </div>
                                    <div class="col-12 col-lg-12">
                                        <label for="" class="label-form">Subtítulo</label>
                                        <input id="txtSubTitulo" name="txtSubTitulo" type="text" class="form-control" placeholder="Ingrese el subtítulo del curso">
                                    </div>
                                    <div class="col-12 col-lg-12">
                                        <label for="" class="label-form">Precio</label>
                                        <div class="input-group">
                                            <span class="input-group-text" id="lblPrecio">$</span>
                                            <input id="txtPrecio" type="text" class="form-control" placeholder="Precio del curso" aria-label="Precio" aria-describedby="lblPrecio">
                                        </div>
                                    </div>
                                    <div class="col-12 col-lg-12">
                                        <label for="" class="label-form">Descripción</label>
                                        <textarea name="txtDescripcion" id="txtDescripcion" cols="1" rows="5" class="form-control" placeholder="Ingrese la descripción del curso"></textarea>
                                    </div>
                                    <div class="col-12">
                                        <a href="#!" class="btn btn-bisonteca">
                                            <i class="fas fa-save me-2"></i>Guardar
                                        </a>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="tab-pane fade" id="v-pills-image" role="tabpanel" aria-labelledby="v-pills-image-tab">
                            <form action="" method="post" class="w-100">
                                <div class="row g-3">
                                    <div class="col-12">
                                        <small class="text-bisonteca">Imagen principal</small>
                                        <hr class="my-0">
                                    </div>
                                    <div class="col-12">
                                        <img src="https://picsum.photos/600/280" alt="" class="w-100" style="max-heigth: 280px;">
                                    </div>
                                    <div class="col-12 col-lg-12">
                                        <label for="formFile" class="form-label">Seleccione la imagen</label>
                                        <input class="form-control" type="file" id="formFile">
                                    </div>
                                    <div class="col-12">
                                        <a href="#!" class="btn btn-bisonteca">
                                            <i class="fas fa-save me-2"></i>Guardar
                                        </a>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="tab-pane fade" id="v-pills-cat" role="tabpanel" aria-labelledby="v-pills-cat-tab">
                            <form action="" method="post" class="w-100 mb-4">
                                <div class="row g-3">
                                    <div class="col-12">
                                        <small class="text-bisonteca">Categorías del curso</small>
                                        <hr class="my-0">
                                    </div>
                                    <div class="col-12 col-lg-12">
                                        <label for="" class="label-form">Seleccione...</label>
                                        <div class="input-group">
                                            <input id="txtCategoria" name="txtCategoria" type="text" list="cats" class="form-control" placeholder="Nombre de la categoría">
                                            <datalist id="cats">
                                                <option value="Programación"></option>
                                                <option value="Arte"></option>
                                            </datalist>
                                            <a href="#!" class="btn btn-bisonteca">
                                                <i class="fas fa-plus me-2"></i>Agregar
                                            </a>
                                        </div>
                                        <!--<div class="input-group mb-3">
                                            <select name="slCategoria" id="slCategoria" class="form-select">
                                                <option value="0">No esta en la lista</option>
                                                <option value="1">Programación</option>
                                                <option value="2">Arte</option>
                                            </select>
                                        </div>
                                        <input id="txtCategoria" name="txtCategoria" type="text" class="form-control" placeholder="Nombre de la nueva categoría"> -->
                                    </div>
                                </div>
                            </form>
                            <div class="w-100 mb-4">
                                <ul class="list-group">
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        Programación
                                        <a href="#!" class="btn btn-secondary btn-action delete">
                                            <i class="fas fa-trash fa-fw"></i>
                                        </a>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        Arte
                                        <a href="#!" class="btn btn-secondary btn-action delete">
                                            <i class="fas fa-trash fa-fw"></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="v-pills-levels" role="tabpanel" aria-labelledby="v-pills-levels-tab">
                            <!-- Modal -->
                            <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="staticBackdropLabel">
                                                Agregar Nivel
                                            </h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <form action="" method="post" class="w-100 mb-4">
                                                <div class="row g-3">
                                                    <div class="col-12">
                                                        <label for="" class="label-form text-bisonteca">Información básica</label>
                                                        <hr class="text-bisonteca my-0">
                                                    </div>
                                                    <div class="col-12 col-lg-12">
                                                        <label for="" class="label-form">Título del Nivel</label>
                                                        <input id="txtTituloNivel" name="txtTitulo" type="text" class="form-control" placeholder="Ingrese el título del nivel">
                                                    </div>
                                                    <!-- <div class="col-12 col-lg-12">
                                                        <input class="form-check-input" type="checkbox" value="" id="chkNivelGratis">
                                                        <label class="form-check-label" for="chkNivelGratis">
                                                            Nivel gratuito
                                                        </label>
                                                    </div> -->
                                                    <div class="col-12 col-lg-12">
                                                        <label for="" class="label-form">Precio</label>
                                                        <div class="input-group">
                                                            <span class="input-group-text" id="lblPrecioNivel">$</span>
                                                            <input id="txtPrecioNivel" type="text" class="form-control" placeholder="Precio del nivel" aria-label="Precio" aria-describedby="lblPrecioNivel">
                                                        </div>
                                                    </div>
                                                    <div class="col-12">
                                                        <a href="#!" class="btn btn-bisonteca">
                                                            <i class="fas fa-save fa-fw me-2"></i>Guardar
                                                        </a>
                                                    </div>
                                                </div>
                                            </form>
                                            <form action="" method="post" class="w-100 mb-4">
                                                <div class="row g-3">
                                                    <div class="col-12">
                                                        <label for="" class="label-form text-bisonteca">Contenido</label>
                                                        <hr class="text-bisonteca my-0">
                                                    </div>
                                                    <div class="col-12 col-lg-12">
                                                        <label for="formFileLevel" class="form-label">Seleccione el archivo</label>
                                                        <div class="input-group">
                                                            <input class="form-control" type="file" id="formFileLevel">
                                                            <a href="#!" class="btn btn-bisonteca">
                                                                <i class="fas fa-upload fa-fw me-2"></i>Subir
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                            <div class="w-100 mb-4">
                                                <ul class="list-group">
                                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                                        <a href="#!">
                                                            test_document.docx
                                                        </a>
                                                        <a href="#!" class="btn btn-secondary btn-action delete">
                                                            <i class="fas fa-trash fa-fw"></i>
                                                        </a>
                                                    </li>
                                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                                        <a href="#!">
                                                            presentacion.pptx
                                                        </a>
                                                        <a href="#!" class="btn btn-secondary btn-action delete">
                                                            <i class="fas fa-trash fa-fw"></i>
                                                        </a>
                                                    </li>
                                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                                        <a href="#!">
                                                            video.mp4
                                                        </a>
                                                        <a href="#!" class="btn btn-secondary btn-action delete">
                                                            <i class="fas fa-trash fa-fw"></i>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Volver</button>
                                            <!-- <button type="button" class="btn btn-bisonteca">Guardar</button> -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="mb-5">
                                <div id="niveles" class="">
                                    <div class="row g-3">
                                        <div class="col-12">
                                            <small class="text-bisonteca">Niveles del curso</small>
                                            <hr class="my-0">
                                        </div>
                                        <div class="col-12">
                                            <a href="#!" class="btn btn-bisonteca" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                                                <i class="fas fa-plus fa-fw me-2"></i>Agregar nivel
                                            </a>
                                        </div>
                                        <div class="col-12 col-lg-6">
                                            <div class="card nivel w-100">
                                                <div class="card-body">
                                                    <h5 class="card-title">TITULO_NIVEL</h5>
                                                    <p class="card-text">
                                                        Costo <strong>$ 0.0 MXN</strong>
                                                    </p>
                                                    <div class="text-end">
                                                        <a href="#" class="btn btn-secondary btn-action edit" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                                                            <i class="fas fa-edit fa-fw"></i>
                                                        </a>
                                                        <a href="#" class="btn btn-secondary btn-action delete">
                                                            <i class="fas fa-trash fa-fw"></i>
                                                        </a>
                                                    </div>
                                                </div>
                                                <div class="card-header">
                                                    Contenido
                                                </div>
                                                <ul class="list-group list-group-flush">
                                                    <li class="list-group-item">
                                                        <a href="#!">
                                                            recursos.docx
                                                        </a>
                                                    </li>
                                                    <li class="list-group-item">
                                                        <a href="#!">
                                                            contenido.pptx
                                                        </a>
                                                    </li>
                                                    <li class="list-group-item">
                                                        <a href="#!">
                                                            repaso.mp4
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
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