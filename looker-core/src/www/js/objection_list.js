/**
 * Created by fananyuan on 2016/6/20.
 */
define(['ko', 'underscore', 'C', 'jquery', 'js/objection_list_detail'], function (ko, _, C, $, objection_list_detail) {
    var objection_list,
    //异议登记主模板
        TEM_OBJECTION_LIST = _.template($('#tem_objection_list').html()),
    //异议登记表单
        TEM_OBJECTION_LIST_TABLE = _.template($('#tem_objection_list_table').html()),
        URL = C.Api.OBJECTION_LIST;

    objection_list = {
        init: function (objStatus) {
            var _this = this,
                objStatus = objStatus,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO),objStatus);
            _this.bind($('#' + CONTAINERNO),objStatus);
            window.location.hash = 'objection_list';
        },
        render: function (CONTAINER,objStatus) {
            var _this = this;
            $('.show_position_pre').text('异议管理');
            $('.show_position').text('>异议查询');
            $('#organization_modify_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.DICCODES2,
                data: {dicType: 'type,status'},
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        CONTAINER.html(TEM_OBJECTION_LIST({}));
                        C.PageBreak.table({
                            //表格内容包裹层
                            $tablebox: $('.objection_list_table_box'),

                            headcontent: [{name: '异议申请编号', icon: 'iconfont sort', order_by: 'obj_Number'}, {name: '产品名称', icon: 'iconfont sort', order_by: 'product_Name'},
                                          {name: '姓名', icon: 'iconfont sort', order_by: 'obj_Name'}, {name: '身份证号', icon: 'iconfont sort', order_by: 'obj_CardNo'},
                                          {name: '异议申请时间', icon: 'iconfont sort', order_by: 'obj_ApplyDate'}, {name: '剩余处理时间', icon: 'iconfont sort', order_by: 'obj_TimeLeft'},
                                          {name: '异议状态', icon: 'iconfont sort', order_by: 'obj_Status'}, {name: '当前经办人', icon: 'iconfont sort', order_by: 'update_User'}, {name: '操作', icon: '', order_by: ''}],
                            //编译后的表单
                            tem: TEM_OBJECTION_LIST_TABLE,
                            //当前页
                            cindex: '1',
                            pageSize: '10',
                            url: URL,
                            //向后端传递的附加参数
                            parm: {
                                totalCount: 0,
                                objStatus:objStatus
                            }
                        });
                    }
                }
            });
        },
        bind: function (CONTAINER,objStatus) {
            var _this = this;
            //查询按钮
            CONTAINER.on('click', '.objection_list_search', function () {
                var $this = $(this),
                    objNumber = $('.objNumber').val(),
                    objName = $('.objName').val(),
                    objCardNo = $('.objCardNo').val(),
                    productName = $('.productName').val(),
                    objApplyDateStart = $('.objApplyDateStart').val(),
                    objApplyDateEnd	 = $('.objApplyDateEnd	').val();
                C.PageBreak.table({
                    //表格内容包裹层
                    $tablebox: $('.objection_list_table_box'),

                    headcontent: [{name: '异议申请编号', icon: 'iconfont sort', order_by: 'obj_Number'}, {name: '产品名称', icon: 'iconfont sort', order_by: 'product_Name'},
                        {name: '姓名', icon: 'iconfont sort', order_by: 'obj_Name'}, {name: '身份证号', icon: 'iconfont sort', order_by: 'obj_CardNo'},
                        {name: '异议申请时间', icon: 'iconfont sort', order_by: 'obj_ApplyDate'}, {name: '剩余处理时间', icon: 'iconfont sort', order_by: 'obj_TimeLeft'},
                        {name: '异议状态', icon: 'iconfont sort', order_by: 'obj_Status'}, {name: '当前经办人', icon: 'iconfont sort', order_by: 'update_User'}, {name: '操作', icon: '', order_by: ''}],
                    //编译后的表单
                    tem: TEM_OBJECTION_LIST_TABLE,
                    //当前页
                    cindex: '1',
                    pageSize: '10',
                    url: URL,
                    //向后端传递的附加参数
                    parm: {
                        totalCount: 0,
                        objStatus:objStatus,
                        objNumber: objNumber,
                        objName: objName,
                        objCardNo: objCardNo,
                        productName: productName,
                        objApplyDateStart: objApplyDateStart,
                        objApplyDateEnd:objApplyDateEnd
                    }
                });
            });
           //重置按钮
            CONTAINER.on('click', '.objection_list_reset', function () {
                $('.objNumber').val('');
                $('.objName').val('');
                $('.objCardNo').val('');
                $('.productName').val('');
                $('.objApplyDateStart').val('');
                $('.objApplyDateEnd	').val('');
            });
          //查看
            CONTAINER.on('click', '.objection_list_detail', function(){
                var objId = $(this).attr('objId'),
                    objStatus = $(this).attr('objStatus'),
                    data = {objId: objId, objStatus:objStatus};
                objection_list_detail.init(data);
            });
          //开始日期
            CONTAINER.on('focus', '#objection_list_start', function(){
                laydate({
                    elem: '#objection_list_start',
                    istime: true,
                    istoday: false,
                    max: $('#objection_list_end').val()
                });
            });
          //结束日期
            CONTAINER.on('focus', '#objection_list_end', function(){
                laydate({
                    elem: '#objection_list_end',
                    istime: true,
                    istoday: false,
                    min: $('#objection_list_start').val()
                });
            });
        }
    };
    return objection_list;
});