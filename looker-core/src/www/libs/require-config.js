
(function(){

    requirejs.config({
        baseUrl:"",
        paths: {
            C: 'js/common/common',
            jquery: 'libs/jquery-1.12.4.min',
            underscore: 'libs/underscore-min',
            ko: 'libs/knockout',
            move: 'libs/move.min',
            layer:'libs/layer',
            fileupload: 'libs/ajaxfileupload',
            upload: 'libs/jquery.upload'
        },
        shim: {
            //'angular': {
            //    deps: ['jquery'],
            //    exports: 'angular'
            //}
            'layer': {
                deps: ['jquery'],
                exports: 'layer'
            },
            'fileupload':{
                deps: ['jquery'],
                exports: 'fileupload'
            },
            'upload':{
                deps: ['jquery'],
                exports: 'upload'
            }
            //'deferred': {
            //    deps: ['callbacks'],
            //    exports: '$'
            //},
            //'data': {
            //    deps: ['zepto_core'],
            //    exports: '$'
            //},
            //'fx': {
            //    deps: ['zepto_core'],
            //    exports: '$'
            //},
            //'swipe': {
            //    deps: ['zepto_core'],
            //    exports: 'Swipe'
            //},
            //'nouislider': {
            //    deps: ['zepto'],
            //    exports: '$'
            //}
        }
    });
})();
