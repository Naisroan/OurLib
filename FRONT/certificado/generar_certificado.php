<?php
    # librerias
    require_once '../code/dompdf/autoload.inc.php';

    # namespaces
    use Dompdf\Dompdf;

    # code
    if (!isset($_SESSION)) {
        session_start();
    }

    if (!isset($_SESSION["auth_user"]))
    {
        header("Location: /mods/login/login.php");
        exit();
    }

    $usuarioLogeado = $_SESSION["auth_user"];

    $dompdf = new Dompdf(array('enable_remote' => true));
    $dompdf->setPaper('A4', 'landscape');
    $dompdf->load_html(file_get_contents('certificado.php'));
    $dompdf->render();
    $dompdf->stream("certificado.pdf");
?>