/**
 * Created by fananyuan on 2016/6/20.
 */
define(['ko', 'underscore', 'C', 'jquery', 'js/feet_detail', 'js/feet_charge'], function (ko, _, C, $, feet_detail, feet_charge) {
    var feet_list,
    //充值记录主模板
        TEM_FEET_LIST = _.template($('#tem_feet_list').html()),
    //充值记录表单
        TEM_FEET_LIST_TABLE = _.template($('#tem_feet_list_table').html()),
        URL = C.Api.QUERYFEETLIST;

    feet_list = {
        init: function () {
            var _this = this,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO));
            _this.bind($('#' + CONTAINERNO));
           window.location.hash = 'feet_list';

        },
        render: function (CONTAINER) {
            var _this = this;
            $('.show_position_pre').text('计费管理');
            $('.show_position').text('>计费查询');
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
                        CONTAINER.html(TEM_FEET_LIST({}));
                        C.PageBreak.table({
                            //表格内容包裹层
                            $tablebox: $('.feet_list_table_box'),
                            headcontent: [{name: '机构名称', icon: 'iconfont sort', order_by: 'ORG_NAME'}, {name: '渠道名称', icon: 'iconfont sort', order_by: 'CHANNEL_NAME'},
                                          {name: '产品名称', icon: 'iconfont sort', order_by: 'PRODUCT_NAME'}, {name: '产品单价', icon: 'iconfont sort', order_by: 'PRODUCT_PRICE'},
                                          {name: '预警值', icon: 'iconfont sort', order_by: 'WARNING_AMOUNT'}, {name: '余额', icon: 'iconfont sort', order_by: 'BALANCE'}, {name: '操作', icon: '', order_by: ''}],
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
            CONTAINER.on('click', '.feet_list_search', function () {
                var ORG_NAME = $('.ORG_NAME').val(),
                    PRODUCT_NAME = $('.PRODUCT_NAME').val(),
                    CHANNEL_NAME = $('.CHANNEL_NAME').val();
                C.PageBreak.table({
                    //表格内容包裹层
                    $tablebox: $('.feet_list_table_box'),
                    headcontent: [{name: '机构名称', icon: 'iconfont sort', order_by: 'ORG_NAME'}, {name: '渠道名称', icon: 'iconfont sort', order_by: 'CHANNEL_NAME'},
                        {name: '产品名称', icon: 'iconfont sort', order_by: 'PRODUCT_NAME'}, {name: '产品单价', icon: 'iconfont sort', order_by: 'PRODUCT_PRICE'},
                        {name: '预警值', icon: 'iconfont sort', order_by: 'WARNING_AMOUNT'}, {name: '余额', icon: 'iconfont sort', order_by: 'BALANCE'}, {name: '操作', icon: '', order_by: ''}],
                    //编译后的表单
                    tem: TEM_FEET_LIST_TABLE,
                    //当前页
                    cindex: '1',
                    pageSize: '10',
                    url: URL,
                    parm: {
                        totalCount: 0,
                        orgName: ORG_NAME,
                        productName: PRODUCT_NAME,
                        channelName:CHANNEL_NAME
                    }
                });
            });
           //重置按钮
            CONTAINER.on('click', '.feet_list_reset', function () {
                 $('.ORG_NAME').val('');
                 $('.PRODUCT_NAME').val('');
                 $('.CHANNEL_NAME').val('');
            });

         //详情
            CONTAINER.on('click', '.feet_list_detail', function(){
                  var feetId = $(this).attr('feetId'),
                      data = {ID:feetId};
                      feet_detail.init(data);
            });
          //充值
            CONTAINER.on('click', '.feet_list_charge', function(){
                var $this = $(this),
                    orgCode = $this.attr('orgCode'),
                    channelCode = $this.attr('channelCode'),
                    productCode = $this.attr('productCode'),
                    balanceMoney = $this.attr('balanceMoney'),
                    ID = $this.attr('feetId'),
                    channelName = $this.attr('channelName'),
                    orgName = $this.attr('orgName'),
                    productName = $this.attr('productName'),
                    data = {
                        orgCode: orgCode,
                        channelCode: channelCode,
                        productCode: productCode,
                        balanceMoney: balanceMoney,
                        channelName: channelName,
                        orgName: orgName,
                        productName: productName,
                        ID: ID,
                        type: '1'
                    };
                feet_charge.init(data);
            });
        }
    };
    return feet_list;
});