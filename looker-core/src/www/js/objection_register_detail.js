/**
 * Created by fananyuan on 2016/6/20.
 */
define(['require', 'ko', 'underscore', 'C', 'jquery'], function (require, ko, _, C, $) {




   var objection_register_detail = {
        init: function (data) {
            var _this = this,
            //详情
             TEM_OBJECT_REGISTER_DETAIL = _.template($('#tem_objection_register_detail').html()),
                objId = data.objId,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO),objId,TEM_OBJECT_REGISTER_DETAIL);
            _this.bind($('#' + CONTAINERNO));
            window.location.hash= 'objection_register_detail';
        },
        render: function (CONTAINER,objId,TEM_OBJECT_REGISTER_DETAIL) {
            var _this = this;
            $('.show_position_next').show().text('>异议登记详情');
            //头部样式的切换
            $('#organization_modify_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.OBJECTION_DETAIL,
                data: {objId: objId},
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        CONTAINER.html(TEM_OBJECT_REGISTER_DETAIL(res.resData));
                        $('.objCombedProduct').val(res.resData.objCombedProduct);
                        $('.objCombedStatus').val(res.resData.objCombedStatus);
                        $('.objCombedConfuse').val(res.resData.objCombedConfuse);
                        $('.objCombedExcept').val(res.resData.objCombedConfuse);
                        $('.objRegisterOpinion').val(res.resData.objRegisterOpinion);
                    } else {
                        C.UI.msg(res.resMsg);
                    }
                }
            });

        },
        bind: function (CONTAINER) {
            var _this = this,
                objection_register = require('js/objection_register'),
                objection_check = require('js/objection_check'),
                objection_list = require('js/objection_list');

            //登记核查
            CONTAINER.on('click', '.objection_register_submit', function(){
                  var $this = $(this),
                      objNumber = $this.attr('objNumber'),
                      objId =$this.attr('objId'),
                      objStatus = $this.attr('objStatus'),
                      objRegisterOpinion = $('.objRegisterOpinion').val(),
                      objCombedProduct = $('.objCombedProduct').val(),
                      objCombedStatus = $('.objCombedStatus').val(),
                      objCombedConfuse = $('.objCombedConfuse').val(),
                      objCombedExcept = $('.objCombedExcept').val();
                if(objRegisterOpinion == ''){
                    C.UI.msg('请填写登记意见！');
                    return;
                }
                C.PageBreak.Loading();
                $.ajax({
                    type: 'get',
                    url: C.Api.UPDATEOBJINFO,
                    data:{
                        objNumber: objNumber,
                        objId: objId,
                        objStatus: objStatus,
                        objRegisterOpinion: objRegisterOpinion,
                        objCombedProduct: objCombedProduct,
                        objCombedStatus: objCombedStatus,
                        objCombedConfuse: objCombedConfuse,
                        objCombedExcept: objCombedExcept
                    },
                    success: function(res){
                        C.PageBreak.stopLoading();
                        if (res.resCode == C.ResCodes.SUCCESS) {
                            C.UI.msg('登记核查保存成功！');
                            objection_register.init('0');
                        }else{
                            C.UI.msg(res.resMsg);
                        }
                    }
                });
            });

            //驳回
            CONTAINER.on('click', '.objection_register_reback', function(){
                var $this = $(this),
                    objId =$this.attr('objId'),
                    objStatus = $this.attr('objStatus'),
                    objCombedProduct = $('.objCombedProduct').val(),
                    objCombedStatus = $('.objCombedStatus').val(),
                    objCombedConfuse = $('.objCombedConfuse').val(),
                    objCombedExcept = $('.objCombedExcept').val();
                C.UI.warm({
                    header: '请填写驳回理由',
                    content_area: '驳回理由',
                    okText: '确定',
                    cancelText: '取消',
                    ok: function(val){
                        if(val == ''){
                            C.UI.msg('驳回失败， 请先填写驳回理由！');
                            return;
                        }
                        C.PageBreak.Loading();
                        $.ajax({
                            type: 'get',
                            url: C.Api.UPDATEOBJINFO,
                            data:{
                                objId: objId,
                                objStatus: objStatus,
                                objRegisterOpinion: val,
                                objCombedProduct: objCombedProduct,
                                objCombedStatus: objCombedStatus,
                                objCombedConfuse: objCombedConfuse,
                                objCombedExcept: objCombedExcept
                            },
                            success: function(res){
                                C.PageBreak.stopLoading();
                                if (res.resCode == C.ResCodes.SUCCESS) {
                                    C.UI.msg('驳回成功！');
                                    objection_register.init('0');
                                }else{
                                    C.UI.msg(res.resMsg);
                                }
                            }
                        });
                    }
                });
            });
            //取消
            CONTAINER.on('click', '.objection_register_detail_cancel', function(){
                objection_register.init('0');
            });
        }
    };
    return objection_register_detail;
});