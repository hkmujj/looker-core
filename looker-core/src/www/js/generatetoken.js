
define(['ko', 'underscore', 'C', 'jquery', 'js/generatetoken'], function (ko, _, C, $, generatetoken) {
    var generatetoken,
    //
        TEM_FEET_LIST = _.template($('#tem_token_list').html()),
    //
        TEM_FEET_LIST_TABLE = _.template($('#tem_token_list_table').html()),
        URL = C.Api.COMMON_TOKENLIST;

    generatetoken = {
        init: function () {
            var _this = this,
                CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO));
            _this.bind($('#' + CONTAINERNO));
            window.location.hash = 'generatetoken';

        },
        render: function (CONTAINER) {
            var _this = this;
            $('.show_position_pre').text('首页');
            $('.show_position').text('>计费查询');
            $('.show_position_next').hide();
            $('#organization_modify_header').show().siblings().hide();

            //todo 模糊匹配
            $.ajax({
                type: 'get',
                url: C.Api.DICCODES,
                data: {dicType: 'status'},
                success: function (res) {

                    if (res.resCode == C.ResCodes.SUCCESS) {
                        CONTAINER.html(TEM_FEET_LIST({}));
                        C.PageBreak.table({
                            //表格内容包裹层
                            $tablebox: $('.generatetoken_table_box'),
                            headcontent: [{name: '机构名称', icon: 'iconfont sort', order_by: 'TOKEN_ORGCODE'}, {name: '渠道名称', icon: 'iconfont sort', order_by: 'TOKEN_CHANNELCODE'},
                                {name: 'token', icon: 'iconfont sort', order_by: 'token_Code'}, {name: '生成时间', icon: 'iconfont sort', order_by: 'create_Time'},
                                {name: '生成人', icon: 'iconfont sort', order_by: 'token_Creater'}],
                            //编译后的表单
                            tem: TEM_FEET_LIST_TABLE,
                            //当前页
                            cindex: '1',
                            pageSize: '10',
                            url: URL,
                            //向后端传递的附加参数
                            parm: {
                                totalCount: 0
                            }
                        });
                    }
                }
            });
        },
        bind: function (CONTAINER) {
            var _this = this;
            //查询按钮
            CONTAINER.on('click', '.token_list_search', function () {
                var ORG_NAME = $('.ORG_NAME').val(),
                    CHANNEL_NAME = $('.CHANNEL_NAME').val(),
                    TOKEN = $('.TOKEN').val();
                C.PageBreak.table({
                    //表格内容包裹层
                    $tablebox: $('.generatetoken_table_box'),
                    headcontent: [{name: '机构名称', icon: 'iconfont sort', order_by: 'TOKEN_ORGCODE'}, {name: '渠道名称', icon: 'iconfont sort', order_by: 'TOKEN_CHANNELCODE'},
                        {name: 'token', icon: 'iconfont sort', order_by: 'token_Code'}, {name: '生成时间', icon: 'iconfont sort', order_by: 'create_Time'},
                        {name: '生成人', icon: 'iconfont sort', order_by: 'token_Creater'}],
                    //编译后的表单
                    tem: TEM_FEET_LIST_TABLE,
                    //当前页
                    cindex: '1',
                    pageSize: '10',
                    url: URL,
                    parm: {
                        orgName: ORG_NAME,
                        token: TOKEN,
                        channelName:CHANNEL_NAME
                    }
                });
            });
            //重置按钮
            CONTAINER.on('click', '.feet_list_reset', function () {
                $('.ORG_NAME').val('');
                $('.CHANNEL_NAME').val('');
                $('.TOKEN').val('');
            });

        }
    };
    return generatetoken;
});