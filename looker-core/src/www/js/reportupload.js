define(['ko', 'underscore', 'C', 'jquery', 'js/generatetoken', 'js/reportupload','upload'], function (ko, _, C, $, generatetoken, reportupload,upload) {
    var reportupload,
    //  报表查询  文件上传
        TEM_REPORT_UPLOAD = _.template($('#tem_report_upload').html()),

        URL = C.Api.COMMON_REPORTSEARCH;

    reportupload = {
        init: function () {
            var _this = this,
                CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO));
            _this.bind($('#' + CONTAINERNO));
            window.location.hash = 'reportupload';

        },

        render: function (CONTAINER) {
            var _this = this;
            $('.show_position_pre').text('报表管理');
            $('.show_position').text('>报表上传');
            $('.show_position_next').hide();
            $('#organization_modify_header').show().siblings().hide();

            CONTAINER.html(TEM_REPORT_UPLOAD({}));
        },
        bind: function (CONTAINER) {
            var _this = this;
            //选择文件
            CONTAINER.on('change', '#uploadFile', function () {
                var val = $(this).val();
                 $('#upload').val(val);
            });
            //上传
            CONTAINER.on('click', '.fileupload_submit', function(){
                var statementType = $('.sereport').val();

                $("#uploadFile").upload({
                    url: C.Api.UPLOADFILE,
                    // 其他表单数据
                    params: { statementType: statementType },
                    // 上传完成后, 返回json, text
                    dataType: 'json',
                    onSend: function (obj, str) {  return true; },
                    // 上传之后回调
                    onComplate: function (res) {
                        if (res.resCode == C.ResCodes.SUCCESS) {
                            var selectDom = $('.secondtclm select option[value=""]');
                            selectDom.removeAttr('selected');
                            selectDom.attr('selected', true);
                            selectDom.removeAttr('selected');
                            C.UI.msg('报表上传成功!');
                            $('#upload').val('');
                        }else{
                            C.UI.msg(res.resMsg);
                        }

                    }
                });
                $("#uploadFile").upload("ajaxSubmit");
                //$.upload({
                //    url: C.Api.UPLOADFILE,
                //    fileName: 'uploadFile',
                //    params: { statementType: statementType},
                //    dataType: 'json',
                //    onSend: function() {
                //        return true;
                //    },
                //    onComplate: function(res) {
                //        C.UI.msg(res.resMsg);
                //    }
                //});

                //$.ajaxFileUpload({
                //    url: C.Api.UPLOADFILE,
                //    secureuri :false,
                //    fileElementId :'uploadFile',//file控件id
                //    dataType : 'json',
                //    data:{
                //        statementType: statementType
                //    },
                //    success : function (data, status){
                //        if( typeof data == 'undefined' ){
                //           alert(11111111);
                //        }
                //    },
                //    error: function(data, status, e){
                //        console.log(e);
                //    }
                //})
            })
        }
    };
    return reportupload;
});