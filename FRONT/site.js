// constantes

const MSG_CAPTION_ERROR = "Ups, ha ocurrido un error...";
const MSG_CAPTION_INFO = "Atención";
const MSG_CAPTION_WARNING = "¡Espere!";
const MSG_CAPTION_SUCCESS = "¡Éxito!";
const MSG_CAPTION_QUESTION = "?";

// contantes de AJAX

const AJAX_URL = "/code/AjaxRequests.php";

// UsuarioController

const AJAX_URL_USER_CONTROLLER = "/controllers/UsuarioController.php";

const AJAX_URL_USER_CONTROLLER_CREATE = "create";
const AJAX_URL_USER_CONTROLLER_GET_ALL = "getAll";
const AJAX_URL_USER_CONTROLLER_GET_BYID = "getById";
const AJAX_URL_USER_CONTROLLER_GET_BYNICK = "getByNick";
const AJAX_URL_USER_CONTROLLER_GET_BYEMAIL = "getByEmail";
const AJAX_URL_USER_CONTROLLER_LOGOUT = "logout";
const AJAX_URL_USER_CONTROLLER_VALIDATE = "validate";
const AJAX_URL_USER_CONTROLLER_LOGIN = "login";
const AJAX_URL_USER_CONTROLLER_LOGGED_USER = "getLoggedUser";
const AJAX_URL_USER_CONTROLLER_UPDATE_IMAGE = "updateImage";
const AJAX_URL_USER_CONTROLLER_REFRESH_LOGGED_USER = "refreshLoggedUser";
const AJAX_URL_USER_CONTROLLER_UPDATE_NOMBRE = "updateNombre";
const AJAX_URL_USER_CONTROLLER_UPDATE_PASSWORD = "updatePassword";
const AJAX_URL_USER_CONTROLLER_UPDATE_IDROL = "updateIdRol";

// CursoController

const AJAX_URL_CURSO_CONTROLLER = "/controllers/CursoController.php";
const AJAX_URL_CURSO_CONTROLLER_CREATE = "create";
const AJAX_URL_CURSO_CONTROLLER_UPDATE = "update";
const AJAX_URL_CURSO_CONTROLLER_GET_BYID = "get";
const AJAX_URL_CURSO_CONTROLLER_GET_BYFIRSTVIDEO = "getByFirstVideo";
const AJAX_URL_CURSO_CONTROLLER_EXISTS = "exists";
const AJAX_URL_CURSO_CONTROLLER_UPDATE_IMAGE = "updateImage";
const AJAX_URL_CURSO_CONTROLLER_GETALL_BYUSUARIOLOGEADO = "getAllByUsuarioLogeado"; // obtiene los cursos que ha creado el usuario logeado
const AJAX_URL_CURSO_CONTROLLER_GETALL_ADQUIRIDOBYUSUARIO = "getAllByAdquiridoByUsuario"; // obtiene los cursos adquiridos por el usuario logeado
const AJAX_URL_CURSO_CONTROLLER_GETALL_MASVENDIDOS = "getAllMasVendidos";
const AJAX_URL_CURSO_CONTROLLER_GETALL_POPULARES = "getAllPopulares";
const AJAX_URL_CURSO_CONTROLLER_GETALL_RECIENTES = "getAllRecientes";
const AJAX_URL_CURSO_CONTROLLER_GETALL_FILTRO = "getAllFiltro";

const AJAX_URL_NIVELCURSO_CONTROLLER_CREATE = "createNivelCurso";
const AJAX_URL_NIVELCURSO_CONTROLLER_GET_BYID = "getNivelCurso";
const AJAX_URL_NIVELCURSO_CONTROLLER_EXISTS = "existsNivelCurso";
const AJAX_URL_NIVELCURSO_CONTROLLER_UPDATE = "updateNivelCurso";
const AJAX_URL_NIVELCURSO_CONTROLLER_GETALL_BYCURSO = "getAllNivelByCurso";
const AJAX_URL_NIVELCURSO_CONTROLLER_DELETE = "deleteNivelCurso";

const AJAX_URL_ARCHIVONIVEL_CONTROLLER_CREATE = "createArchivoNivel";
const AJAX_URL_ARCHIVONIVEL_CONTROLLER_GET_BYID = "getArchivoNivel";
const AJAX_URL_ARCHIVONIVEL_CONTROLLER_GET_BYNOMBRE = "getArchivoNivelByNombre";
const AJAX_URL_ARCHIVONIVEL_CONTROLLER_EXISTS = "existsArchivoNivel";
const AJAX_URL_ARCHIVONIVEL_CONTROLLER_GETALL_BYNIVEL = "getAllArchivoNivelByNivel";
const AJAX_URL_ARCHIVONIVEL_CONTROLLER_DELETE = "deleteArchivoNivel";

// CategoriaController

const AJAX_URL_CATEG_CONTROLLER = "/controllers/CategoriaController.php";

const AJAX_URL_CATEG_CONTROLLER_CREATE = "create";
const AJAX_URL_CATEG_CONTROLLER_UPDATE = "update";
const AJAX_URL_CATEG_CONTROLLER_GETALL = "getAll";
const AJAX_URL_CATEG_CONTROLLER_GET_BYID = "get";
const AJAX_URL_CATEG_CONTROLLER_GET_BYNOMBRE = "getByNombre";
const AJAX_URL_CATEG_CONTROLLER_EXISTS = "exists";

const AJAX_URL_CURSOCATEG_CONTROLLER_CREATE = "createCursoCategoria";
const AJAX_URL_CURSOCATEG_CONTROLLER_EXISTS = "existsCursoCategoria";
const AJAX_URL_CURSOCATEG_CONTROLLER_GETALL_BYCURSO = "getAllCursoCategoriaByCurso";
const AJAX_URL_CURSOCATEG_CONTROLLER_DELETE = "deleteCursoCategoria";

// VentaController
const AJAX_URL_VENTA_CONTROLLER = "/controllers/VentaController.php";

const AJAX_URL_VENTA_CONTROLLER_CREATE = "create";
const AJAX_URL_VENTA_CONTROLLER_UPDATE = "update";
const AJAX_URL_VENTA_CONTROLLER_GET_BYID = "get";
const AJAX_URL_VENTA_CONTROLLER_EXISTS = "exists";
const AJAX_URL_VENTA_CONTROLLER_GETALL = "getAll";
const AJAX_URL_VENTA_CONTROLLER_GETALLREPORTE = "getAllReporte";
const AJAX_URL_VENTA_CONTROLLER_GETGANANCIA = "getGanancia";

// ComentarioController
const AJAX_URL_COMENTARIO_CONTROLLER = "/controllers/ComentarioController.php";

const AJAX_URL_COMENTARIO_CONTROLLER_CREATE = "create";
const AJAX_URL_COMENTARIO_CONTROLLER_EXISTS = "exists";
const AJAX_URL_COMENTARIO_CONTROLLER_GETALL_BYCURSO = "getAllByCurso";

// MensajeController
const AJAX_URL_MENSAJE_CONTROLLER = "/controllers/MensajeController.php";

const AJAX_URL_MENSAJE_CONTROLLER_CREATE = "create";
const AJAX_URL_MENSAJE_CONTROLLER_GETALL_BYDEST = "getAllByUsuarioDestinatario"; // obtiene los mensaje en base al usuario remitente (usuario logeado) y destinatario

// HistorialUsuarioController
const AJAX_URL_HISTORIALUSUARIO_CONTROLLER = "/controllers/HistorialUsuarioController.php";

const AJAX_URL_HISTORIALUSUARIO_CONTROLLER_CREATE = "create";
const AJAX_URL_HISTORIALUSUARIO_CONTROLLER_GETREPORTE = "getReporte";

// FolioPaseController
const AJAX_URL_FOLIOPASE_CONTROLLER = "/controllers/FolioPaseController.php";

const AJAX_URL_FOLIOPASE_CONTROLLER_CREATE = "create";
const AJAX_URL_FOLIOPASE_CONTROLLER_UPDATE = "update";
const AJAX_URL_FOLIOPASE_CONTROLLER_GET_BYID = "get";
const AJAX_URL_FOLIOPASE_CONTROLLER_GET_BYFOLIO = "getByFolio";
const AJAX_URL_FOLIOPASE_GETALL = "getAll";
const AJAX_URL_FOLIOPASE_CONTROLLER_DELETE = "delete";

// constantes REGEX
const REGEX_PASSWORD = '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!¡"#$%&\\/=’?\\-¡¿:;,.\\[\\]_+*{}])([A-Za-z\\d!¡"#$%&\\/=’?\\-¡¿:;,.\\[\\]_+*{}]|[^ ]){8,50}$';

var IS_MOBILE = false;
var MENU_HEADER = null;
var MENU_BTN = null;
const MOBILE_WIDTH = 992;

// load
$(() => {

    IS_MOBILE = $(document).width() <= MOBILE_WIDTH;
    MENU_HEADER = $('#header_menu');
    MENU_BTN = $('#btnMenu');

    // configuramos los mensajes de tipo toast
    toastr.options = {
        "closeButton": true,
        "debug": false,
        "newestOnTop": true,
        "progressBar": true,
        "positionClass": "toast-top-right",
        "preventDuplicates": false,
        "onclick": null,
        "showDuration": "300",
        "hideDuration": "1000",
        "timeOut": "5000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    };

    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));

    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });

    // if (MENU_HEADER) {
    //     if (IS_MOBILE) {
    //         MENU_HEADER.removeClass('open');
    //     }
    // }

    if (MENU_BTN) {
        MENU_BTN.on('click', () => {
            let btn = $(this);
            if (!MENU_HEADER || !btn)
                return;
            MENU_HEADER.toggleClass('open');
            MENU_BTN.toggleClass('menu-show');
        });
    }

    $(window).resize(function() {
        IS_MOBILE = $(document).width() <= MOBILE_WIDTH;
        if (MENU_HEADER && IS_MOBILE) {
            MENU_HEADER.removeClass('open');
        } else {
            if (MENU_BTN) {
                MENU_BTN.removeClass('menu-show');
            }
        }
    });

    ocultarLoader();
});

// mensajes con sweetalert2: https://sweetalert2.github.io/

const message_info = (text) => message(MSG_CAPTION_INFO, text, 'info');

const message_error = (text) => message(MSG_CAPTION_ERROR, text, 'error');

const message_success = (text) => message(MSG_CAPTION_SUCCESS, text, 'success');

const message_warning = (text) => message(MSG_CAPTION_WARNING, text, 'warning');

const message_question = (text) => message(MSG_CAPTION_QUESTION, text, 'question');

const message = (caption, text, icon) => {
    Swal.fire({
        title: caption,
        text: text,
        icon: icon
      });
};

// mensajes tipo toast con toastr: https://github.com/CodeSeven/toastr

const toastr_info = (text) => toastr.info(text, MSG_CAPTION_INFO);

const toastr_error = (text) => toastr.error(text, MSG_CAPTION_ERROR);

const toastr_success = (text) => toastr.success(text, MSG_CAPTION_SUCCESS);

const toastr_warning = (text) => toastr.warning(text, MSG_CAPTION_WARNING);

const toastr_clear = toastr.clear();

// procesos

const logout = () => {

    $.ajax({
        url: AJAX_URL_USER_CONTROLLER,
        data: { action: AJAX_URL_USER_CONTROLLER_LOGOUT, nodo: "" },
        type: 'post'
    });

    window.location = '/mods/login/login.php';
};

const getLoggedUser = () => {

    return $.ajax({
        url: AJAX_URL_USER_CONTROLLER,
        data: { action: AJAX_URL_USER_CONTROLLER_LOGGED_USER, nodo: "" },
        type: 'post'
    });
};

// validaciones

const isKk = (val) => val === null || val === undefined;

const isEmptyOrNull = (val) => val === undefined || val === null || val === "";

const isEmail = (val) => {
    
    // let mailformat =/^[a-zA-Z0-9.!#$%&'+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:.[a-zA-Z0-9-]+)$/;
    let mailformat = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return val.match(mailformat);

};

const NumberOnly = (val) => {
    
    var pattern = /^\d+$/;
     return pattern.test(val); 
    
};

const isJsonString = (str) => {
    try {
        JSON.parse(str);
    } catch (e) {
        return false;
    }
    return true;
};

const switchButtonSpinner = (button) => {

    let icon = $(button.find('span.spinner-grow')[0]);
    let spinner = $(button.find('i.fas')[0]);
    let text = $(button.find('span.text')[0]);

    if (spinner.hasClass('visually-hidden')) {

        button.removeClass('disabled');
        spinner.removeClass('visually-hidden');
        text.removeClass('visually-hidden');
        icon.addClass('visually-hidden');

    } else {

        button.addClass('disabled');
        spinner.addClass('visually-hidden');
        text.addClass('visually-hidden');
        icon.removeClass('visually-hidden');
    }
};

// funciones plagiadas

function getPathFile(fileUpload, indexFile = 0) {

    fileUpload = fileUpload[indexFile] !== undefined ? fileUpload[0] : null;

    if (fileUpload != null) {

        if (fileUpload.files && fileUpload.files[indexFile]) {

            return window.URL.createObjectURL(fileUpload.files[indexFile]);
        }
    }

    return "";
}

// funciones generales
const ocultarLoader = (ocultar = true, msToDo = 1500) => {

    setTimeout(() => {
      
        let loader = $('#slCargando');
        let dom = $('html');

        if (ocultar) {

            if (loader && !loader.hasClass('d-none'))
                loader.addClass('d-none');

            if (dom && dom.hasClass('overflow-hidden'))
                dom.removeClass('overflow-hidden');

        } else {

            if (loader && loader.hasClass('d-none'))
                loader.removeClass('d-none');

            if (dom && !dom.hasClass('overflow-hidden'))
               dom.addClass('overflow-hidden');
        }

  }, msToDo);
};