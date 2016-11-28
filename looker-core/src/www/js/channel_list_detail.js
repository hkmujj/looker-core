/**
 * Created by fananyuan on 2016/6/20.
 */
define(['require', 'ko', 'underscore', 'C', 'jquery', 'js/channel_list_modify'], function (require ,ko, _, C, $, channel_list_modify) {

   var cahnnel_list_detail = {
        init: function (data) {
            var _this = this,
            //机构详情
             TEM_CHANNEL_LIST_DETAIL = _.template($('#tem_channel_list_detail').html()),
                CHANNELCODE = data.channelCode,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO),CHANNELCODE,TEM_CHANNEL_LIST_DETAIL);
            _this.bind($('#' + CONTAINERNO));

        },
        render: function (CONTAINER,CHANNELCODE,TEM_CHANNEL_LIST_DETAIL) {
            var _this = this;
            $('.show_position_pre').text('>渠道管理');
            $('.show_position').text('>渠道详情');
            //头部样式的切换
            $('#channel_list_detail_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.CAHNNEL_LIST_DETAIL,
                data: {channelCode: CHANNELCODE},
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        CONTAINER.html(TEM_CHANNEL_LIST_DETAIL(res.resData.channel));
                    } else {
                        C.UI.msg(res.resMsg);
                    }
                }
            });

        },
        bind: function (CONTAINER) {
            var _this = this,
                channel_list = require('js/channel_list');

            //点击取消
            CONTAINER.on('click', '.channel_cancel', function () {
                channel_list.init();
            });
            //点击渠道详情 -- 启用 /停用
            CONTAINER.on('click', '.opcl_stop', function () {
                var $this = $(this),
                    channelStatus = $this.attr('channelStatus'),
                    channelCode = $this.attr('channelCode'),
                    channelId = $this.attr('channelId'),
                    orgCode = $this.attr('orgCode'),
                    data = {
                        channelStatus: channelStatus,
                        channelCode: channelCode,
                        channelId: channelId
                    };
                //校验机构是否启用
                C.PageBreak.Loading();
                $.ajax({
                    type: 'get' ,
                    url: C.Api.ISORGOPEN,
                    data:{orgCode: orgCode},
                    success: function(res){
                        C.PageBreak.stopLoading();
                        if (res.resCode == C.ResCodes.SUCCESS && res.resData) {
                            if(!res.resData.isOpen){
                                C.UI.warm({
                                    header: '启用渠道失败!',
                                    content: '当前渠道下的机构未启用',
                                    content2: '请先手动启用机构',
                                    okText: '确定'
                                });
                            }else{
                                saveInfo();
                            }
                        }else{
                            C.UI.msg(res.resMsg);
                        }
                    }
                });
                //保存信息
            function saveInfo(){
                _this.orgstatuschange(data, function () {
                    $this.hide();
                    $this.siblings('.opcl_open').show();
                    C.UI.msg('渠道状态已启用');
                });
            }
            });
            CONTAINER.on('click', '.opcl_open', function () {
                var $this = $(this),
                    channelStatus = $this.attr('channelStatus'),
                    channelCode = $this.attr('channelCode'),
                    channelId = $this.attr('channelId'),
                    orgCode = $this.attr('orgCode'),
                    data = {
                        channelStatus: channelStatus,
                        channelCode: channelCode,
                        channelId: channelId
                    };

                //校验渠道下的产品是否有在使用的
                $.ajax({
                    type: 'get',
                    url: C.Api.ISPRODUCTAUTHUSED,
                    data:{channelCode: channelCode},
                    success: function(res){
                        if (res.resCode == C.ResCodes.SUCCESS && res.resData){
                            if(res.resData.isAdmin && res.resData.isUsed){
                                C.UI.warm({
                                    header: '确定停用渠道吗?',
                                    content: '当前渠道下有正在使用的产品',
                                    content2: '停用渠道将导致产品授权不可用',
                                    okText: '确定',
                                    cancelText: '取消',
                                    ok: function () {

                                      saveInfo();
                                    }
                                });
                            }else if(!res.resData.isAdmin && res.resData.isUsed){
                                C.UI.warm({
                                    header: '停用渠道失败!',
                                    content: '当前渠道下有正在使用的产品授权',
                                    content2: '请先手动关闭产品授权',
                                    okText: '确定'
                                });
                            }else{
                              saveInfo();
                            }
                        }else{
                            C.UI.msg(res.resMsg)
                        }
                    }
                });

                function saveInfo(){
                    _this.orgstatuschange(data, function () {
                        $this.hide();
                        $this.siblings('.opcl_stop').show();
                        C.UI.msg('渠道状态已停用');
                    });
                }

            });



            //渠道详情--修改
            CONTAINER.on('click', '.channel_detail_modify', function () {
                var channelCode = $(this).attr('channelCode'),
                    data = {channelCode:channelCode,type:'2'};
                    channel_list_modify.init(data);
            });
        },
        //机构状态修改接口
        orgstatuschange: function(data,cb){
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.CHANNELSTATUSCHANGE,
                data: data,
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        cb && cb();
                    } else {
                        C.UI.msg(res.resMsg)
                    }
                }
            });
        }
    };
    return cahnnel_list_detail;
});