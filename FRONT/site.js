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

// constantes REGEX

const REGEX_PASSWORD = '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!¡"#$%&\\/=’?\\-¡¿:;,.\\[\\]_+*{}])([A-Za-z\\d!¡"#$%&\\/=’?\\-¡¿:;,.\\[\\]_+*{}]|[^ ]){8,50}$';

// load
$(() => {

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
    
    let mailformat =/^[a-zA-Z0-9.!#$%&'+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:.[a-zA-Z0-9-]+)$/;
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