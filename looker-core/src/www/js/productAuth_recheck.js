/**
 * Created by fananyuan on 2016/6/20.
 */
define(['ko', 'underscore', 'C', 'jquery', 'js/productAuth_recheck_detail'], function (ko, _, C, $, productAuth_recheck_detail) {
    var productAuth_recheck,
    //产品授权复核主模板
        TEM_PRODUCTAUTH_RECHECK = _.template($('#tem_productAuth_recheck').html()),
    //表单
        TEM_PRODUCTAUTH_RECHECK_TABLE = _.template($('#tem_productAuth_recheck_table').html()),
        URL = C.Api.PRODUCTAUTHLIST;

    productAuth_recheck = {
        init: function () {
            var _this = this,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO));
            _this.bind($('#' + CONTAINERNO));
            window.location.hash = 'productAuth_recheck';
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
                        CONTAINER.html(TEM_PRODUCTAUTH_RECHECK(res.resData));
                        C.PageBreak.table({
                            //表格内容包裹层
                            $tablebox: $('.productAuth_recheck_table_box'),
                            headcontent: [{name: '产品名称', icon: 'iconfont sort', order_by: 'PRODUCT_NAME'}, {name: '机构名称', icon: 'iconfont sort', order_by: 'ORG_NAME'},
                                {name: '渠道名称', icon: 'iconfont sort', order_by: 'CHANNEL_NAME'}, {name: '授权状态', icon: 'iconfont sort', order_by: 'AUTH_STATUS'},
                                {name: '授权条数', icon: 'iconfont sort', order_by: 'AUTH_NUM'}, {name: '授权开始日期', icon: 'iconfont sort', order_by: 'AUTH_BEGIN_TIME'},
                                {name: '授权结束日期', icon: 'iconfont sort', order_by: 'AUTH_END_TIME'}, {name: '状态', icon: 'iconfont sort', order_by: 'STATE'},
                                {name: '操作', icon: '', order_by: ''}],
                            //编译后的表单
                            tem: TEM_PRODUCTAUTH_RECHECK_TABLE,
                            //当前页
                            cindex: '1',
                            pageSize: '10',
                            url: URL,
                            //向后端传递的附加参数
                            parm: {
                                totalCount: 0,
                                queryStatus: '1'
                            }
                        });
                    }
                }
            });
        },
        bind: function (CONTAINER) {
            var _this = this;
            //查询按钮
            CONTAINER.on('click', '.productAuth_recheck_search', function () {
                var productName = $('.productName').val(),
                    orgName = $('.orgName').val(),
                    channelName = $('.channelName').val(),
                    authCode = $('.authCode').val(),
                    authStatus = $('.authStatus').val();
                C.PageBreak.table({
                    //表格内容包裹层
                    $tablebox: $('.productAuth_recheck_table_box'),
                    headcontent: [{name: '产品名称', icon: 'iconfont sort', order_by: 'PRODUCT_NAME'}, {name: '机构名称', icon: 'iconfont sort', order_by: 'ORG_NAME'},
                        {name: '渠道名称', icon: 'iconfont sort', order_by: 'CHANNEL_NAME'}, {name: '授权状态', icon: 'iconfont sort', order_by: 'AUTH_STATUS'},
                        {name: '授权条数', icon: 'iconfont sort', order_by: 'AUTH_NUM'}, {name: '授权开始日期', icon: 'iconfont sort', order_by: 'AUTH_BEGIN_TIME'},
                        {name: '授权结束日期', icon: 'iconfont sort', order_by: 'AUTH_END_TIME'}, {name: '状态', icon: 'iconfont sort', order_by: 'STATE'},
                        {name: '操作', icon: '', order_by: ''}],
                    //编译后的表单
                    tem: TEM_PRODUCTAUTH_RECHECK_TABLE,
                    //当前页
                    cindex: '1',
                    pageSize: '10',
                    url: URL,
                    //向后端传递的附加参数
                    parm: {
                        totalCount: 0,
                        queryStatus: '1',
                        productName: productName,
                        orgName: orgName,
                        channelName: channelName,
                        authCode: authCode,
                        authStatus: authStatus
                    }
                });
            });
           //重置按钮
            CONTAINER.on('click', '.productAuth_recheck_reset', function () {
                var selectDom = $('.secondtclm select option[value=""]');
                $('.secondtclm input').val('');
                selectDom.attr('selected', true);
                selectDom.removeAttr('selected');
            });

            //复核
            CONTAINER.on('click', '.productAuth_recheck_detail', function () {
                var id = $(this).attr('AuthId'),
                    data = {id: id, type: '2'};
                productAuth_recheck_detail.init(data);
            });

        }
    };
    return productAuth_recheck;
});