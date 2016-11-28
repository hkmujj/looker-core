/**
 * Created by fananyuan on 2016/6/20.
 */
define(['require','ko', 'underscore', 'C', 'jquery', 'js/objection_register_detail'], function (require,ko, _, C, $, objection_register_detail) {
    var objection_check_detail,
    //异议核查详情主模板
        TEM_OBJECTION_CHECK_DETAIL = _.template($('#tem_objection_check_detail').html()),
    //协查记录表单
        TEM_OBJECTION_CHECK_DETAIL_TABLE = _.template($('#tem_objection_check_detail_table').html()),
        URL = C.Api.OBJECTIONCHECK_LIST;

    objection_check_detail = {
        init: function (data) {
            var _this = this,
                objId = data.objId,
                CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO),objId);
            _this.bind($('#' + CONTAINERNO));
            window.location.hash = 'objection_check_detail';
        },
        render: function (CONTAINER,objId) {
            var _this = this;
            $('.show_position_next').show().text('>异议核查详情');
            $('#organization_modify_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.OBJECTION_DETAIL,
                data: {objId: objId},
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        CONTAINER.html(TEM_OBJECTION_CHECK_DETAIL(res.resData));
                        $('.obj_check_problem').val(res.resData.objCombedConfuse);
                        $('.obj_check_point').val(res.resData.objCombedExcept);
                        C.PageBreak.table({
                            //表格内容包裹层
                            $tablebox: $('.objection_check_detail_table_box'),
                            headcontent: [{name: '协查机构', icon: 'iconfont sort', order_by: 'obj_AssistOrg'}, {name: '异议部分', icon: 'iconfont sort', order_by: 'obj_AssistConfuse'},
                                {name: '异议期望', icon: 'iconfont sort', order_by: 'obj_AssistExpect'}, {name: '协查描述', icon: 'iconfont sort', order_by: 'obj_AssistResult'},
                                {name: '操作', icon: '', order_by: ''}],
                            //编译后的表单
                            tem: TEM_OBJECTION_CHECK_DETAIL_TABLE,
                            //当前页
                            cindex: '1',
                            pageSize: '10',
                            url: URL,
                            //向后端传递的附加参数
                            parm: {
                                totalCount: 0,
                                objId: objId
                            }
                        });
                    }
                }
            });
        },
        bind: function (CONTAINER) {
            var _this = this,
                objection_check = require('js/objection_check');
            //新建协查
           CONTAINER.on('click', '.obj_che_de_new', function(){

              $('.objection_check_mask').fadeIn(200);
              $('.objection_check_detail_new').fadeIn(100);
           });

            //弹窗中的确认
            CONTAINER.on('click', '.obj_check_submit', function(){
                var objId = $(this).attr('objId'),
                    objAssistOrg = $('.objAssistOrg').val(),
                    objAssistConfuse = $('.obj_check_problem').val(),
                    objAssistExpect = $('.obj_check_point').val(),
                    objAssistResult = $('.objAssistResult').val();
                if(objAssistOrg == ''){
                    C.UI.msg('请填写协查机构！');
                    return;
                }else if(objAssistConfuse == ''){
                    C.UI.msg('请填写异议部分！');
                    return;
                }else if(objAssistExpect == ''){
                    C.UI.msg('请填写异议期望！');
                    return;
                }else if(objAssistResult == ''){
                    C.UI.msg('请填写协查结果！');
                    return;
                }
                C.PageBreak.Loading();
                $.ajax({
                    type:'get',
                    url: C.Api.OBJCHECK_SUBMIT,
                    data:{
                        objId: objId,
                        objAssistOrg: objAssistOrg,
                        objAssistConfuse: objAssistConfuse,
                        objAssistResult: objAssistResult,
                        objAssistExpect: objAssistExpect,
                        objAssistStatus: 0
                    },
                    success: function(res){
                        C.PageBreak.stopLoading();
                        if (res.resCode == C.ResCodes.SUCCESS) {
                            $('.objection_check_mask').hide();
                            $('.objection_check_detail_new').hide();
                            C.UI.msg('新建协查保存成功！');
                            C.PageBreak.Loading();
                            $.ajax({
                                type: 'get',
                                url: C.Api.OBJECTION_DETAIL,
                                data: {objId: objId},
                                success: function (res) {
                                    C.PageBreak.stopLoading();
                                    if (res.resCode == C.ResCodes.SUCCESS) {
                                        CONTAINER.html(TEM_OBJECTION_CHECK_DETAIL(res.resData));
                                        $('.obj_check_problem').val(res.resData.objCombedConfuse);
                                        $('.obj_check_point').val(res.resData.objCombedExcept);
                                        C.PageBreak.table({
                                            //表格内容包裹层
                                            $tablebox: $('.objection_check_detail_table_box'),
                                            headcontent: [{name: '协查机构', icon: 'iconfont sort', order_by: 'obj_AssistOrg'}, {name: '异议部分', icon: 'iconfont sort', order_by: 'obj_AssistConfuse'},
                                                {name: '异议期望', icon: 'iconfont sort', order_by: 'obj_AssistExpect'}, {name: '协查描述', icon: 'iconfont sort', order_by: 'obj_AssistResult'},
                                                {name: '操作', icon: '', order_by: ''}],
                                            //编译后的表单
                                            tem: TEM_OBJECTION_CHECK_DETAIL_TABLE,
                                            //当前页
                                            cindex: '1',
                                            pageSize: '10',
                                            url: URL,
                                            //向后端传递的附加参数
                                            parm: {
                                                totalCount: 0,
                                                objId: objId
                                            }
                                        });
                                    }
                                }
                            });
                        }else{
                            C.UI.msg(res.resMsg);
                        }
                    }
                });
            });

            //取消
            CONTAINER.on('click', '.obj_check_cancel', function(){
                $('.objection_check_mask').hide();
                $('.objection_check_detail_new').hide();
            });

            //协查记录中的查看
            CONTAINER.on('click', '.object_check_detail_d', function(){
                var objAssistId = $(this).attr('objAssistId');
                $.ajax({
                    type: 'get',
                    url: C.Api.OBJECTCHECK_DETAIL,
                    data: {objAssistId: objAssistId},
                    success: function(res){
                        if (res.resCode == C.ResCodes.SUCCESS) {
                            $('.product_obj').text(res.resData.objAssistOrg);
                            $('.problem_obj').text(res.resData.objAssistConfuse);
                            $('.excp_obj').text(res.resData.objAssistExpect);
                            $('.result_obj').text(res.resData.objAssistResult);
                            $('.objection_check_mask').fadeIn(200);
                            $('.objection_check_detail_detail').fadeIn(100);
                        }
                    }
                });
            });

            $('body').on('click', '.objection_check_detail_detail_cancel', function(){
                $('.objection_check_mask').hide();
                $('.objection_check_detail_detail').hide();
            });

            //提交结论
            CONTAINER.on('click', '.objection_check_detail_submit', function(){
                  var $this = $(this),
                      objId = $this.attr('objId'),
                      objInspectNumber = $this.attr('objInspectNumber'),
                      objStatus = 3,
                      objInspectStatus = $('.objInspectStatus').val(),
                      objInspectContent = $('.objInspectContent').val();
                $.ajax({
                    type: 'get',
                    url: C.Api.UPDATEOBJINFO,
                    data:{
                        objId: objId,
                        objInspectNumber: objInspectNumber,
                        objStatus: objStatus,
                        objInspectStatus: objInspectStatus,
                        objInspectContent: objInspectContent
                    },
                    success: function(res){
                        if (res.resCode == C.ResCodes.SUCCESS) {
                            C.UI.msg('异议结论提交成功！');
                            objection_check.init('1');
                        }else{
                            C.UI.msg(res.resMsg);
                        }
                    }
                });
            });

            //返回
            CONTAINER.on('click', '.objection_check_detail_cancel', function(){
                objection_check.init('1');
            });
        }
    };
    return objection_check_detail;
});