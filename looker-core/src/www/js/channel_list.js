/**
 * Created by fananyuan on 2016/6/20.
 */
define(['ko', 'underscore', 'C', 'jquery', 'js/channel_list_detail', 'js/channel_list_modify'], function (ko, _, C, $, channel_list_detail, channel_list_modify) {
    var channel_list,
    //渠道查询主模板
        TEM_CHANNEL_LIST = _.template($('#tem_channel_list').html()),
    //渠道查询表单
        TEM_CHANNEL_LIST_TABLE = _.template($('#tem_channel_list_table').html()),
        URL = C.Api.CHANNEL_LIST;

    channel_list = {
        init: function () {
            var _this = this,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO));
            _this.bind($('#' + CONTAINERNO));
            window.location.hash = 'channel_list';
        },
        render: function (CONTAINER) {
            var _this = this;
            $('.show_position_pre').text('>渠道管理');
            $('.show_position').text('>渠道查询');
            $('#channel_list_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.DICCODES,
                data: {dicType: 'network_type,status'},
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        CONTAINER.html(TEM_CHANNEL_LIST(res.resData));
                        C.PageBreak.table({
                            //表格内容包裹层
                            $tablebox: $('.channel_list_table_box'),
                            headcontent: [{name: '渠道代码', icon: 'iconfont sort', order_by: 'channel_Code'}, {name: '渠道名称', icon: 'iconfont sort', order_by: 'channel_Name'},
                                {name: '授权代码', icon: 'iconfont sort', order_by: 'auth_Code'}, { name: '所属机构',icon: '',order_by: ''}, {name: '渠道状态', icon: '', order_by: ''},
                                {name: '网络类型', icon: '', order_by: ''}, {name: '操作', icon: '', order_by: ''}],
                            //编译后的表单
                            tem: TEM_CHANNEL_LIST_TABLE,
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
            CONTAINER.on('click', '.channel_list_search', function () {
                var channelCode = $('.channelCode').val(),
                    channelName = $('.channelName').val(),
                    authCode = $('.authCode').val(),
                    orgName = $('.orgName').val(),
                    stateValue = $('.channel_list_status').val(),
                    networkTypeValue = $('.channel_list_type').val();
                C.PageBreak.table({
                    //表格内容包裹层
                    $tablebox: $('.channel_list_table_box'),
                    headcontent: [{name: '渠道代码', icon: 'iconfont sort', order_by: 'channel_Code'}, {name: '渠道名称', icon: '', order_by: ''},
                        {name: '授权代码', icon: '', order_by: ''}, { name: '所属机构',icon: '',order_by: ''}, {name: '渠道状态', icon: '', order_by: ''},
                        {name: '网络类型', icon: '', order_by: ''}, {name: '操作', icon: '', order_by: ''}],
                    //编译后的表单
                    tem: TEM_CHANNEL_LIST_TABLE,
                    //当前页
                    cindex: '1',
                    pageSize: '10',
                    url: URL,
                    parm: {
                        channelCode: channelCode,
                        channelName: channelName,
                        authCode: authCode,
                        orgName: orgName,
                        stateValue: stateValue,
                        networkTypeValue: networkTypeValue,
                        totalCount: 0
                    }
                });
            });
           //重置按钮
            CONTAINER.on('click', '.channel_list_reset', function () {
                var selectDom = $('.secondtclm select option[value=""]');
                $('.secondtclm input').val('');
                selectDom.attr('selected', true);
                selectDom.removeAttr('selected');
            });

            //渠道列表--点击详情
            CONTAINER.on('click', '.channel_list_detail', function () {
                var channelCode = $(this).attr('channelCode'),
                data = {channelCode:channelCode};
                channel_list_detail.init(data);
            });
           //渠道列表/点击修改
            CONTAINER.on('click', '.channel_list_modify', function () {
                var channelCode = $(this).attr('channelCode'),
                    data = {channelCode:channelCode,type:'1'};
                   channel_list_modify.init(data);
            });
        }
    };
    return channel_list;
});