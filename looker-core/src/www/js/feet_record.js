
define(['ko', 'underscore', 'C', 'jquery'], function (ko, _, C, $) {
    var feet_record,
    //充值记录主模板
        TEM_FEET_RECORD = _.template($('#tem_feet_record').html()),
    //充值记录表单
        TEM_FEET_RECORD_TABLE = _.template($('#tem_feet_record_table').html()),
        URL = C.Api.QUERYRECHARGELIST;

    feet_record = {
        init: function (data) {
            var _this = this,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO),data);
            _this.bind($('#' + CONTAINERNO),data);

        },
        render: function (CONTAINER, data) {
            var _this = this;
            $('.show_position_pre').text('计费管理');
            $('.show_position').text('>充值记录查询');
            $('.show_position_next').hide();
            $('#organization_modify_header').show().siblings().hide();
            C.PageBreak.Loading();
            //todo 模糊匹配
            $.ajax({
                type: 'get',
                url: C.Api.DICCODES,
                data: {dicType: 'status'},
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        CONTAINER.html(TEM_FEET_RECORD({}));
                        C.PageBreak.table({
                            //表格内容包裹层
                            $tablebox: $('.feet_record_table_box'),
                            headcontent: [{name: '充值时间', icon: 'iconfont sort', order_by: 'RECHARGE_TIME'}, {name: '充值金额', icon: 'iconfont sort', order_by: 'RECHARGE_MONEY'},
                                          {name: '充值人', icon: 'iconfont sort', order_by: 'RECHARGE_PERSON'}, {name: '备注', icon: '', order_by: ''}],
                            //编译后的表单
                            tem: TEM_FEET_RECORD_TABLE,
                            //当前页
                            cindex: '1',
                            pageSize: '10',
                            url: URL,
                            //向后端传递的附加参数
                            parm: $.extend({
                                totalCount: 0
                            }, data)
                        });
                    }
                }
            });
        },
        bind: function (CONTAINER ,data) {
            var _this = this;
            //查询按钮
            CONTAINER.on('click', '.feet_record_search', function () {
                var beginTime = $('.beginTime').val(),
                    endTime = $('.endTime').val(),
                    rechargePerson = $('.rechargePerson').val();
                C.PageBreak.table({
                    //表格内容包裹层
                    $tablebox: $('.feet_record_table_box'),
                    headcontent: [{name: '充值时间', icon: 'iconfont sort', order_by: 'RECHARGE_TIME'}, {name: '充值金额', icon: 'iconfont sort', order_by: 'RECHARGE_MONEY'},
                        {name: '充值人', icon: 'iconfont sort', order_by: 'RECHARGE_PERSON'}, {name: '备注', icon: '', order_by: ''}],
                    //编译后的表单
                    tem: TEM_FEET_RECORD_TABLE,
                    //当前页
                    cindex: '1',
                    pageSize: '10',
                    url: URL,
                    //向后端传递的附加参数
                    parm: $.extend({
                        totalCount: 0,
                        beginTime: beginTime,
                        endTime: endTime,
                        rechargePerson: rechargePerson
                    }, data)
                });
            });
           //重置按钮
            CONTAINER.on('click', '.feet_record_reset', function () {
                    $('.beginTime').val('');
                    $('.endTime').val('');
                    $('.rechargePerson').val('');
            });

            //开始时间
            CONTAINER.on('focus', '#feet_record_start', function(){
                laydate({
                    elem: '#feet_record_start',
                    istime: true,
                    istoday: false,
                    max: $('#feet_record_end').val()
                });
            });

            //结束时间
            CONTAINER.on('focus', '#feet_record_end', function(){
                laydate({
                    elem: '#feet_record_end',
                    istime: true,
                    istoday: false,
                    min: $('#feet_record_start').val()
                });
            });
        }
    };
    return feet_record;
});