/**
 * Created by fananyuan on 2016/6/20.
 */
define(['ko', 'underscore', 'C', 'jquery', 'js/productAuth_open_detail'], function (ko, _, C, $, productAuth_open_detail) {
    var productAuth_open,
    //产品授权开通主模板
        TEM_PRODUCTAUTH_OPEN = _.template($('#tem_productAuth_open').html()),
    //表单
        TEM_PRODUCTAUTH_OPEN_TABLE = _.template($('#tem_productAuth_open_table').html()),
        URL = C.Api.PRODUCTAUTHLIST;

    productAuth_open = {
        init: function () {
            var _this = this,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO));
            _this.bind($('#' + CONTAINERNO));
            window.location.hash = 'productAuth_open';
        },
        render: function (CONTAINER) {
            var _this = this;
            $('.show_position_pre').text('产品授权管理');
            $('.show_position').text('>产品授权查询');
            $('.show_position_next').hide();
            $('#organization_modify_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.DICCODES,
                data: {dicType: 'auth_status'},
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        CONTAINER.html(TEM_PRODUCTAUTH_OPEN(res.resData));
                        C.PageBreak.table({
                            //表格内容包裹层
                            $tablebox: $('.productAuth_open_table_box'),
                            headcontent: [{name: '产品名称', icon: 'iconfont sort', order_by: 'PRODUCT_NAME'}, {name: '机构名称', icon: 'iconfont sort', order_by: 'ORG_NAME'},
                                {name: '渠道名称', icon: 'iconfont sort', order_by: 'CHANNEL_NAME'}, {name: '授权状态', icon: 'iconfont sort', order_by: 'AUTH_STATUS'},
                                {name: '授权条数', icon: 'iconfont sort', order_by: 'AUTH_NUM'}, {name: '授权开始日期', icon: 'iconfont sort', order_by: 'AUTH_BEGIN_TIME'},
                                {name: '授权结束日期', icon: 'iconfont sort', order_by: 'AUTH_END_TIME'}, {name: '状态', icon: 'iconfont sort', order_by: 'STATE'},
                                {name: '操作', icon: '', order_by: ''}],
                            //编译后的表单
                            tem: TEM_PRODUCTAUTH_OPEN_TABLE,
                            //当前页
                            cindex: '1',
                            pageSize: '10',
                            url: URL,
                            //向后端传递的附加参数
                            parm: {
                                totalCount: 0,
                                queryStatus: '5'
                            }
                        });
                    }
                }
            });
        },
        bind: function (CONTAINER) {
            var _this = this;
            //查询按钮
            CONTAINER.on('click', '.productAuth_open_search', function () {
                var productName = $('.productName').val(),
                    orgName = $('.orgName').val(),
                    channelName = $('.channelName').val(),
                    authCode = $('.authCode').val(),
                    authStatus = $('.authStatus').val();
                C.PageBreak.table({
                    //表格内容包裹层
                    $tablebox: $('.productAuth_open_table_box'),
                    headcontent: [{name: '产品名称', icon: 'iconfont sort', order_by: 'PRODUCT_NAME'}, {name: '机构名称', icon: 'iconfont sort', order_by: 'ORG_NAME'},
                        {name: '渠道名称', icon: 'iconfont sort', order_by: 'CHANNEL_NAME'}, {name: '授权状态', icon: 'iconfont sort', order_by: 'AUTH_STATUS'},
                        {name: '授权条数', icon: 'iconfont sort', order_by: 'AUTH_NUM'}, {name: '授权开始日期', icon: 'iconfont sort', order_by: 'AUTH_BEGIN_TIME'},
                        {name: '授权结束日期', icon: 'iconfont sort', order_by: 'AUTH_END_TIME'}, {name: '状态', icon: 'iconfont sort', order_by: 'STATE'},
                        {name: '操作', icon: '', order_by: ''}],
                    //编译后的表单
                    tem: TEM_PRODUCTAUTH_OPEN_TABLE,
                    //当前页
                    cindex: '1',
                    pageSize: '10',
                    url: URL,
                    //向后端传递的附加参数
                    parm: {
                        totalCount: 0,
                        queryStatus: '5',
                        productName: productName,
                        orgName: orgName,
                        channelName: channelName,
                        authCode: authCode,
                        authStatus: authStatus
                    }
                });
            });
           //重置按钮
            CONTAINER.on('click', '.productAuth_open_reset', function () {
                var selectDom = $('.secondtclm select option[value=""]');
                $('.secondtclm input').val('');
                selectDom.attr('selected', true);
                selectDom.removeAttr('selected');
            });

            //详情
            CONTAINER.on('click', '.productAuth_open_detail', function () {
                var $this = $(this),
                    id = $this.attr('authId'),
                    productName = $this.attr('productName');
                productAuth_open_detail.init({id: id, type: '2'});
            });

        }
    };
    return productAuth_open;
});