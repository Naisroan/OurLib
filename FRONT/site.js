// constantes

const MSG_CAPTION_ERROR = "Ups, ha ocurrido un error...";
const MSG_CAPTION_INFO = "Atención";
const MSG_CAPTION_WARNING = "¡Espere!";
const MSG_CAPTION_SUCCESS = "¡Éxito!";
const MSG_CAPTION_QUESTION = "?";

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

// validaciones

const isKk = (val) => val === null || val === undefined;

const isEmptyOrNull = (val) => val === null || val === "";

const isEmail = (val) => {
    
    let mailformat =/^[a-zA-Z0-9.!#$%&'+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:.[a-zA-Z0-9-]+)$/;
    return val.match(mailformat);

};

const NumberOnly = (val) => {
    
    var pattern = /^\d+$/;
     return pattern.test(val); 
    
};
