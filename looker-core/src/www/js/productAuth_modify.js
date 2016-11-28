define(['require', 'ko', 'underscore', 'C', 'jquery'], function (require, ko, _, C, $) {
    var productAuth_modify,
    //产品授权修改 -- 不通过
        TEM_PRODUCTAUTH_MODIFY = _.template($('#tem_productAuth_modify').html());

    productAuth_modify = {
        init: function (data) {
            var _this = this,
                CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO), data);
            _this.bind($('#' + CONTAINERNO), data);
            window.location.hash = 'productAuth_modify';

        },
        render: function (CONTAINER, data) {
            var _this = this;
            $('.show_position_pre').text('产品授权管理');
            $('.show_position').text('>修改产品授权');
            $('.show_position_next').hide();
            $('#organization_modify_header').show().siblings().hide();

            $.ajax({
                type: 'get',
                url: C.Api.PRODUCTAUTHDETAIL,
                data: {id: data.id},
                success: function(res){
                    if (res.resCode == C.ResCodes.SUCCESS && res.resData) {
                        var item1 = res.resData.productAuthInfo;
                        $.when(
                            $.ajax({type: 'get', url: C.Api.COMMON_CHANNELLIST, data: {orgCode: item1.ORG_CODE}}),
                            $.ajax({type: 'get', url: C.Api.DICCODES, data: {dicType: 'auth_status'}})
                        ).done(function(res1, res2){
                                $.when(
                                    $.ajax({type: 'get', url: C.Api.COMMON_PRODUCTLIST, data: {}}),
                                    $.ajax({type: 'get', url: C.Api.QUERYORGLIST, data: {}})
                                ).done(function(res3, res4){
                                        var item = $.extend(item1, res1[0].resData, res2[0].resData, res3[0].resData, res4[0].resData);
                                        CONTAINER.html(TEM_PRODUCTAUTH_MODIFY(item));
                                            $('.productName option[value="'+ item1.PRODUCT_CODE +'"]').attr('selected', true);
                                            $('.orgName option[value="'+ item1.ORG_CODE +'"]').attr('selected', true);
                                            $('.channelName option[value="'+ item1.CHANNEL_CODE +'"]').attr('selected', true);
                                            $('.authStatus option[value="'+ item1.AUTH_STATUS +'"]').attr('selected', true);
                                    });
                            });
                    }
                }
            });
        },
        bind: function (CONTAINER, data) {
            var _this = this,
            productAuth_list = require('js/productAuth_list'),
            productAuth_noPass_detail = require('js/productAuth_noPass_detail');

            //产品名称选择事件
            CONTAINER.on('change', '.productName', function () {
                var productCode = $('.productName').val();
                $('.productCode').val(productCode);
            });
            //机构名称选择事件
            CONTAINER.on('change', '.orgName', function () {
                var orgCode = $('.orgName').val();
                $('.orgCode').val(orgCode);
                C.PageBreak.loading();
                $.ajax({
                    type: 'get',
                    url: C.Api.COMMON_CHANNELLIST,
                    data: {
                        orgCode: orgCode
                    },
                    success: function (res) {
                        if (res.resCode == C.ResCodes.SUCCESS) {
                            C.PageBreak.stopLoading();
                            var item = res.resData.channelList,
                                channelDOM = $('.channelName'),
                                pool = ['<option value="" authcode="">'+'请选择'+'</option>'];
                            for (var i = 0; i < item.length; i++) {
                                pool.push('<option value="'+ item[i].CHANNEL_CODE +'" authcode="'+ item[i].AUTH_CODE +'">' + item[i].CHANNEL_NAME + '</option>');
                            }
                            channelDOM.html(pool.join(''));
                        }
                    }
                });
            });

            //渠道名称选择事件
            CONTAINER.on('change', '.channelName', function(){
                var channelCode = $('.channelName').val(),
                    authCode = $('.channelName option:selected').attr('authcode');
                    $('.authCode').val(authCode);
                    $('.channelCode').val(channelCode);
            });
            //修改确认按钮
            CONTAINER.on('click', '.modify_productAuth_submit', function () {

                C.PageBreak.Loading();

                var id = data.id,
                    productCode = $('.productCode').val(),
                    orgCode = $('.orgCode').val(),
                    channelCode = $('.channelCode').val(),
                    authCode = $('.authCode').val(),
                    authNum = $('.authNum').val(),
                    authBeginTime = $('.authBeginTime').val(),
                    authEndTime = $('.authEndTime').val(),
                    productPrice = $('.productPrice').val(),
                    authStatus = $('.authStatus').val(),
                    productRebate = $('.productRebate').val(),
                    warningAmount = $('.warningAmount').val(),
                    productName = $('.productName option:selected').text(),
                    parm = {
                        id: id,
                        productCode: productCode,
                        orgCode: orgCode,
                        channelCode: channelCode,
                        authCode: authCode,
                        authNum: authNum,
                        authBeginTime: authBeginTime,
                        authEndTime: authEndTime,
                        productPrice: productPrice,
                        authStatus: authStatus,
                        productRebate: productRebate,
                        warningAmount: warningAmount,
                        state: '1',
                        productName: productName
                    };
                $.ajax({
                    type: 'get',
                    url: C.Api.UPDATEPRODUCTAUTH,
                    data: parm,
                    success: function (res) {
                        C.PageBreak.stopLoading();
                        if (res.resCode == C.ResCodes.SUCCESS) {
                            C.UI.msg('产品授权修改成功！');
                            if(data.type == '1'){
                                productAuth_list.init(data.backTo);
                            }else if(data.type == '2'){
                                productAuth_noPass_detail.init(data);
                            }
                        }
                    }
                });
            });
            CONTAINER.on('click', '.modify_productAuth_cancel', function () {
                if(data.type == '1'){
                    productAuth_list.init(data.backTo);
                }else if(data.type == '2'){
                    productAuth_noPass_detail.init(data);
                }
            });

            //开始时间
            CONTAINER.on('focus', '#productAuth_modify_start', function(){
                laydate({
                    elem: '#productAuth_modify_start',
                    istime: true,
                    istoday: false,
                    min: laydate.now(),
                    max: $('#productAuth_modify_end').val()
                });
            });
            //结束时间
            CONTAINER.on('focus', '#productAuth_modify_end', function(){
                laydate({
                    elem: '#productAuth_modify_end',
                    istime: true,
                    istoday: false,
                    min: $('#productAuth_modify_start').val()
                });
            });

        },
        //输入框校验
        isValidator: function () {
            var orgname = $('.new_orgName').val(),
                orgPhnum = $('.new_org_phone').val(),
                orgEmail = $('.new_orgEmail').val(),
                orgusername = $('.new_orgUserName').val();
            if (orgname == '') {
                $('.new_org_name_tip').show();
                return false;
            } else {
                $('.new_org_name_tip').hide();
            }

            if (!C.Utils.isPhoneNum(orgPhnum)) {
                $('.new_org_phone_tip').show();
                return false;
            } else {
                $('.new_org_phone_tip').hide();
            }

            if (!C.Utils.isEmail(orgEmail)) {
                $('.new_org_email_tip').show();
                return false;
            } else {
                $('.new_org_email_tip').hide();
            }

            if (orgusername == '') {
                $('.new_org_uesrName_tip').show();
                return false;
            } else {
                $('.new_org_uesrName_tip').hide();
            }
            return true;
        }
    };
    return productAuth_modify;
});