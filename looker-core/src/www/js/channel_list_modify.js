/**
 * Created by fananyuan on 2016/6/20.
 */
define(['require', 'ko', 'underscore', 'C', 'jquery'], function (require, ko, _, C, $) {
    var channel_list_modify = {
        init: function (data) {
            var _this = this,
                TEM_CAHNNEL_LIST_MODIFY = _.template($('#tem_channel_list_modify').html()),
                CAHNNELCODE = data.channelCode, type = data.type,
                CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO), TEM_CAHNNEL_LIST_MODIFY, CAHNNELCODE);
            _this.bind($('#' + CONTAINERNO), type);

        },
        render: function (CONTAINER, TEM_CAHNNEL_LIST_MODIFY, CAHNNELCODE) {
            var _this = this;
            $('.show_position').text('>修改渠道');
            //头部样式的切换
            $('#organization_modify_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.DICCODES,
                data: {dicType: 'status,network_type'},
                success: function (res1) {
                    if (res1.resCode == C.ResCodes.SUCCESS) {
                        C.PageBreak.stopLoading();
                        $.ajax({
                            type: 'get',
                            url: C.Api.CAHNNEL_LIST_DETAIL,
                            data: {channelCode: CAHNNELCODE},
                            success: function (res2) {
                                if (res2.resCode == C.ResCodes.SUCCESS) {
                                    var item = $.extend(res1.resData, res2.resData.channel);
                                    CONTAINER.html(TEM_CAHNNEL_LIST_MODIFY(item));
                                    //默认选中产品原始状态
                                    $('.cahnnel_status [value = ' + item.state + ']').attr('selected', true);
                                    $('.cahnnel_nettype [value = ' + item.networkType + ']').attr('selected', true);
                                    $('.channel_ip_address').val(item.ipAddress);
                                    $('.channel_desc').val(item.remark);
                                } else {
                                    C.UI.msg(res.resMsg);
                                }
                            }
                        });
                    } else {
                        C.UI.msg(res.resMsg);
                    }
                }
            });

        },
        bind: function (CONTAINER, type) {
            var _this = this,
                channel_list = require('js/channel_list'),
                channel_list_detail = require('js/channel_list_detail');
            //点击修改里的确认
            CONTAINER.on('click', '.submit_channel_modify', function () {
                if(!_this.isValidator()){
                    return;
                }
                var $this = $(this),
                    channelId = $this.attr('channelId'),
                    channelCode = $this.attr('channelCode'),
                    channelName = $this.attr('channelName'),
                    state1 = $this.attr('state'),
                    state2 = $('.cahnnel_status').val(),
                    orgCode = $this.attr('orgCode'),
                    networkType = $('.cahnnel_nettype').val(),
                    authCode = $this.attr('authCode'),
                    startTime = $('.start_time').val(),
                    endTime = $('.end_time').val(),
                    ipAddress = $('.channel_ip_address').val(),
                    contactName = $('.contactName').val(),
                    contactPhone = $('.contactPhone').val(),
                    contactMail = $('.contactMail').val(),
                    remark = $('.channel_desc').val(),
                    data = {
                        channelId: channelId,
                        channelCode: channelCode,
                        channelName: channelName,
                        state: state2,
                        orgCode: orgCode,
                        networkType: networkType,
                        authCode: authCode,
                        startTime: startTime,
                        endTime: endTime,
                        ipAddress: ipAddress,
                        contactName:contactName,
                        contactPhone:contactPhone,
                        contactMail: contactMail,
                        remark:remark
                    };
                //停用到启用校验
                if(state1 == '1' && state1 != state2){
                    $.ajax({
                        type: 'get' ,
                        url: C.Api.ISORGOPEN,
                        data:{orgCode: orgCode},
                        success: function(res){
                            if (res.resCode == C.ResCodes.SUCCESS && res.resData) {
                                if(!res.resData.isOpen){
                                    C.UI.warm({
                                        header: '启用渠道失败!',
                                        content: '当前渠道下的机构为启用',
                                        content2: '请先手动启用机构',
                                        okText: '确认'
                                    });
                                }else{
                                    saveInfo();
                                }
                            }else{
                                C.UI.msg(res.resMsg);
                            }
                        }
                    });
                    //启用到停用校验
                }else if(state1 == '0' && state1 != state2){
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
                                        oklText: '确定'
                                    });
                                }else{
                                    saveInfo();
                                }
                            }else{
                                C.UI.msg(res.resMsg)
                            }
                        }
                    });
                }else{
                    saveInfo();
                }
                function saveInfo(){
                    _this.saveInfo(data, function () {
                        C.UI.msg('渠道状态修改成功');
                        if (type == '1') {
                            channel_list.init();
                        } else if (type == '2') {
                            channel_list_detail.init({channelCode: channelCode});
                        }
                    });
                }
            });
            //点击修改机构里的取消
            CONTAINER.on('click', '.cancel__modify_channel', function () {
                var channelCode = $(this).attr('channelCode');
                if (type == '1') {
                    channel_list.init();
                } else if (type == '2') {
                    channel_list_detail.init({channelCode: channelCode});
                }
            });
            //开始时间
            CONTAINER.on('focus', '#channel_modify_start', function(){
                laydate({
                    elem: '#channel_modify_start',
                    istime: true,
                    istoday: false,
                    min: laydate.now(),
                    max: $('#channel_modify_end').val()
                });
            });
            //结束时间
            CONTAINER.on('focus', '#channel_modify_end', function(){
                laydate({
                    elem: '#channel_modify_end',
                    istime: true,
                    istoday: false,
                    min: $('#channel_modify_start').val() || laydate.now()
                });
            });

        },
        //机构新增修改接口调用
        saveInfo: function (data, cb) {
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.CHANNEL_SAVE,
                data: data,
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        cb && cb();
                    } else {
                        C.UI.msg(res.resMsg);
                    }
                }
            });
        },

    //输入框校验
        isValidator: function(){
        var startTime = $('.start_time').val(),
            endTime = $('.end_time').val(),
            ipAddress = $('.channel_ip_address').val().split(','),
            contactName = $('.contactName').val(),
            contactPhone = $('.contactPhone').val(),
            contactMail = $('.contactMail').val();

        if(startTime == ''){
            $('.start_time_tip').show();
            return false;
        }else{
            $('.start_timee_tip').hide();
        }
        if(endTime == ''){
            $('.end_time_tip').show();
            return false;
        }else{
            $('.end_time_tip').hide();
        }
        for(var i = 0; i < ipAddress.length; i++ ){
            if(ipAddress[i] && !C.Utils.isIp(ipAddress[i])){
                $('.channel_ip_address_tip').show();
                return false;
            }else{
                $('.channel_ip_address_tip').hide();
            }
        }

        if(contactName && !C.Utils.isName(contactName)){
            $('.contactName_tip').show();
            return false;
        }else{
            $('.contactName_tip').hide();
        }
        if(contactPhone && !C.Utils.isPhoneNum(contactPhone)){
            $('.contactPhone_tip').show();
            return false;
        }else{
            $('.contactPhone_tip').hide();
        }

        if(contactMail && !C.Utils.isEmail(contactMail)){
            $('.contactMail_tip').show();
            return false;
        }else{
            $('.contactMail_tip').hide();
        }
        return true;
    }
    };
    return channel_list_modify;
});