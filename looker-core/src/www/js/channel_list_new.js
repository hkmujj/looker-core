define(['ko', 'underscore', 'C', 'jquery', 'js/channel_list_detail', 'js/channel_list'], function (ko, _, C, $, channel_list_detail, channel_list) {
    var organization_new,
    //新建渠道模板
        TEM_CHANNEL_LIST_NEW = _.template($('#tem_channel_list_new').html());
    organization_new = {
        init: function () {
            var _this = this,
                CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO));
            _this.bind($('#' + CONTAINERNO));
            window.location.hash = 'channel_list_new';

        },
        render: function (CONTAINER) {
            $('.show_position_pre').text('渠道管理');
            $('.show_position').text('>新建渠道');
            $('#channel_list_new_header').show().siblings().hide();

            $.when(
                $.ajax({type: 'get', url:  C.Api.DICCODES, data: {dicType: 'status,network_type'}}),
                $.ajax({type:'get', url: C.Api.GETCHANNELCODE, data: {}})
            ).
                done(function(res1,res2){
                    $.ajax({
                        type:'get',
                        url: C.Api.QUERYORGLIST,
                        data: {},
                        success: function(res3){
                            var item = $.extend(res1[0].resData,{channelCode:res2[0].resData.channelCode},res3.resData);
                            CONTAINER.html(TEM_CHANNEL_LIST_NEW(item));
                        }
                    });
                }).
                fail(function(){C.UI.msg('系统忙,请稍后再试！')});
        },
        bind: function (CONTAINER) {
            var _this = this;
            //确认按钮
            CONTAINER.on('click', '.new_channel_submit', function(){
                if(!_this.isValidator()){
                    return;
                }
                C.PageBreak.Loading();
                var channelCode = $(this).attr('channelCode'),
                    channelName = $('.channelName').val(),
                    state = $('.channel_state').val(),
                    orgCode = $('.orgCode').val(),
                    networkType = $('.networkType').val(),
                    authCode = $('.authCode').val(),
                    startTime = $('.startTime').val(),
                    endTime = $('.endTime').val(),
                    ipAddress = $('.ipAddress').val(),
                    contactName = $('.contactName').val(),
                    contactPhone = $('.contactPhone').val(),
                    contactMail = $('.contactMail').val(),
                    remark = $('.remark_text').val(),
                    data = {
                        channelCode: channelCode,
                        channelName: channelName,
                        state: state,
                        orgCode: orgCode,
                        networkType: networkType,
                        authCode: authCode,
                        startTime: startTime,
                        endTime: endTime,
                        ipAddress: ipAddress,
                        contactName: contactName,
                        contactPhone: contactPhone,
                        contactMail: contactMail,
                        remark: remark
                    };
                $.ajax({
                    type:'get',
                    url: C.Api.CHANNEL_SAVE,
                    data:data,
                    success:function(res){
                        C.PageBreak.stopLoading();
                        if (res.resCode == C.ResCodes.SUCCESS) {
                            C.UI.msg('渠道保存成功！');
                            channel_list.init();
                        }else if(res.resCode == '-1001'){
                           $('.authCode_repeat_tip').show();
                        }else{
                            C.UI.msg(res.resMsg);
                        }
                    }
                });
            });
            CONTAINER.on('click', '.new_channel_cancel', function(){
                channel_list.init();
            });
            //开始时间
            CONTAINER.on('focus', '#channel_new_start', function(){
                laydate({
                    elem: '#channel_new_start',
                    istime: true,
                    istoday: false,
                    min: laydate.now(),
                    max: $('#channel_new_end').val()
                });
            });
            //结束时间
            CONTAINER.on('focus', '#channel_new_end', function(){
                laydate({
                    elem: '#channel_new_end',
                    istime: true,
                    istoday: false,
                    min: $('#channel_new_start').val() || laydate.now()
                });
            });
            CONTAINER.on('focus', 'input', function(){
                $('.tips').hide();
            });
            CONTAINER.on('focus', 'textarea', function(){
                $('.tips').hide();
            });
        },
        //输入框校验
        isValidator: function(){
            var channelName = $('.channelName').val(),
                authCode = $('.authCode').val(),
                startTime = $('.startTime').val(),
                endTime = $('.endTime').val(),
                ipAddress = $('.ipAddress').val().split(','),
                contactName = $('.contactName').val(),
                contactPhone = $('.contactPhone').val(),
                contactMail = $('.contactMail').val();
            if(!C.Utils.illegalChar(channelName) || channelName == ''){
                $('.channelName_tip').show();
                return false;
            }else{
                $('.channelName_tip').hide();
            }
            if(authCode == '' || !/^[A-Za-z0-9]{20,}/.test(authCode)){
                $('.authCode_tip').show();
                return false;
            }else{
                $('.authCode_tip').hide();
            }
            if(startTime == ''){
                $('.startTime_tip').show();
                return false;
            }else{
                $('.startTime_tip').hide();
            }
            if(endTime == ''){
                $('.endTime_tip').show();
                return false;
            }else{
                $('.endTime_tip').hide();
            }
            for(var i = 0; i < ipAddress.length; i++ ){
                if(ipAddress[i] && !C.Utils.isIp(ipAddress[i])){
                    $('.ipAddress_tip').show();
                    return false;
                }else{
                    $('.ipAddress_tip').hide();
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
    return organization_new;
});