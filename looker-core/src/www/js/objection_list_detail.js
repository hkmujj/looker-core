/**
 * Created by fananyuan on 2016/6/20.
 */
define(['require','ko', 'underscore', 'C', 'jquery'], function (require,ko, _, C, $) {
    var objection_list_detail,
    //异议查询详情主模板
        TEM_OBJECTION_LIST_DETAIL = _.template($('#tem_objection_list_detail').html()),
    //协查记录表单
        TEM_OBJECTION_LIST_DETAIL_TABLE = _.template($('#tem_objection_list_detail_table').html()),
        URL =  C.Api.OBJECTIONCHECK_LIST;

    objection_list_detail = {
        init: function (data) {
            var _this = this,
                objId = data.objId,
                objStatus = parseInt(data.objStatus),
                CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO),objId,objStatus);
            _this.bind($('#' + CONTAINERNO));
            window.location.hash = 'objection_list_detail';
        },
        render: function (CONTAINER, objId, objStatus) {
            var _this = this;
            $('.show_position_next').show().text('>异议详情');
            $('#organization_modify_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.OBJECTION_DETAIL,
                data: {objId: objId},
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        CONTAINER.html(TEM_OBJECTION_LIST_DETAIL(res.resData));
                        C.PageBreak.table({
                            //表格内容包裹层
                            $tablebox: $('.objection_list_detail_table_box'),
                            headcontent: [{name: '协查机构', icon: 'iconfont sort', order_by: 'obj_AssistOrg'}, {name: '异议问题', icon: 'iconfont sort', order_by: 'obj_AssistConfuse'},
                                {name: '异议期望', icon: 'iconfont sort', order_by: 'obj_AssistExpect'}, {name: '协查描述', icon: 'iconfont sort', order_by: 'obj_AssistResult'},
                                {name: '操作', icon: '', order_by: ''}],
                            //编译后的表单
                            tem: TEM_OBJECTION_LIST_DETAIL_TABLE,
                            //当前页
                            cindex: '1',
                            pageSize: '10',
                            url: URL,
                            //向后端传递的附加参数
                            parm: {
                                totalCount: 0,
                                objId: objId
                            },
                            callback: function(){
                                var dom = $('.mecsearch').children();
                                 switch (objStatus){
                                     case 0:
                                         dom.slice(0,1).show();
                                         break;
                                     case 1:
                                         dom.slice(0,3).show();
                                         break;
                                     case 2:
                                         dom.slice(0,2).show();
                                         break;
                                     case 3:
                                         dom.slice(0,4).show();
                                 }

                            }
                        });
                    }
                }
            });
        },
        bind: function (CONTAINER) {
            var _this = this,
                objection_list = require('js/objection_list');

            //返回
            CONTAINER.on('click', '.objection_list_detail_cancel', function(){
                objection_list.init();
            });

            //协查记录中的查看
            CONTAINER.on('click', '.object_list_detail_d', function(){
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
        }
    };
    return objection_list_detail;
});