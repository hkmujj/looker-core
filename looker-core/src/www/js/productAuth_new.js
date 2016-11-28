define(['ko', 'underscore', 'C', 'jquery', 'js/productAuth_list'], function (ko, _, C, $, productAuth_list) {
    var productAuth_new,
    //新建产品授权模板
        TEM_PRODUCTAUTH_NEW = _.template($('#tem_productAuth_new').html());

    productAuth_new = {
        init: function () {
            var _this = this,
                CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO));
            _this.bind($('#' + CONTAINERNO));
            window.location.hash = 'productAuth_new';
        },
        render: function (CONTAINER) {
            var _this = this;
            $('.show_position_pre').text('产品授权管理');
            $('.show_position').text('>新建产品授权');
            $('.show_position_next').hide();
            $('#organization_modify_header').show().siblings().hide();

            $.when(
                $.ajax({type: 'get', url: C.Api.COMMON_PRODUCTLIST, data: {}}),
                $.ajax({type: 'get', url: C.Api.QUERYORGLIST, data: {}})
            ).
                done(function (res1, res2) {
                    $.ajax({
                        type: 'get',
                        url: C.Api.DICCODES,
                        data: {dicType: 'auth_status'},
                        success: function (res3) {
                            if (res3.resCode == C.ResCodes.SUCCESS) {
                                var item = $.extend(res1[0].resData, res2[0].resData, res3.resData);
                                CONTAINER.html(TEM_PRODUCTAUTH_NEW(item));
                            }
                        }
                    });
                }).
                fail(function () {
                    C.UI.msg('系统忙,请稍后再试！')
                });

        },
        bind: function (CONTAINER) {
            var _this = this;

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
            //新建确认按钮
            CONTAINER.on('click', '.new_productAuth_submit', function () {
                if(!_this.isValidator()){
                    return;
                }
                C.PageBreak.Loading();
                var productCode = $('.productCode').val(),
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
                    data = {
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
                        productName: productName
                    };
                $.ajax({
                    type: 'get',
                    url: C.Api.ADDPRODUCTAUTH,
                    data: data,
                    success: function (res) {
                        C.PageBreak.stopLoading();
                        if (res.resCode == C.ResCodes.SUCCESS) {
                            C.UI.msg('产品授权保存成功');
                            productAuth_list.init();
                        }else{
                            C.UI.msg(res.resMsg);
                        }
                    }
                });
            });
            CONTAINER.on('click', '.new_productAuth_cancel', function () {
                productAuth_list.init();
            });

            //开始日期
            CONTAINER.on('focus', '#productAuth_new_time_start', function(){
                laydate({
                    elem: '#productAuth_new_time_start',
                    istime: true,
                    istoday: false,
                    min: laydate.now(),
                    max: $('#productAuth_new_time_end').val()
                });
            });
            //结束日期
            CONTAINER.on('focus', '#productAuth_new_time_end', function(){
                laydate({
                    elem: '#productAuth_new_time_end',
                    istime: true,
                    istoday: false,
                    min: $('#productAuth_new_time_start').val()
                });
            });

            CONTAINER.on('focus', 'input', function(){
                $('.tips').hide();
            });

        },
        //输入框校验
        isValidator: function () {
            var productName = $('.productName').val(),
                orgName = $('.orgName').val(),
                channelName = $('.channelName').val(),
                authNum = $('.authNum').val(),
                authBeginTime = $('.authBeginTime').val(),
                authEndTime = $('.authEndTime').val(),
                productPrice = $('.productPrice').val(),
                warningAmount = $('.warningAmount').val(),
                productRebate = $('.productRebate').val();

            if (productName == '') {
                $('.productName_tip').show();
                return false;
            } else {
                $('.productName_tip').hide();
            }
            if (orgName == '') {
                $('.orgName_tip').show();
                return false;
            } else {
                $('.orgName_tip').hide();
            }
            if (channelName == '') {
                $('.channelName_tip').show();
                return false;
            } else {
                $('.channelName_tip').hide();
            }
            if (!/^(-|\+)?\d+$/.test(authNum)) {
                $('.authNum_tip').show();
                return false;
            } else {
                $('.authNum_tip').hide();
            }
            if (authBeginTime == '') {
                $('.authBeginTime_tip').show();
                return false;
            } else {
                $('.authBeginTime_tip').hide();
            }
            if (authEndTime == '') {
                $('.authEndTime_tip').show();
                return false;
            } else {
                $('.authEndTime_tip').hide();
            }
            if (!/^\d+(.\d{1,2})?$/.test(productPrice)) {
                $('.productPrice_tip').show();
                return false;
            } else {
                $('.productPrice_tip').hide();
            }
            if (!/^\d+(.\d{1,2})?$/.test(warningAmount)) {
                $('.warningAmount_tip').show();
                return false;
            } else {
                $('.warningAmount_tip').hide();
            }
            if (!/(^([0|1])\.(\d)$)|[0|1]/.test(productRebate)) {
                $('.productRebate_tip').show();
                return false;
            } else {
                $('.productRebate_tip').hide();
            }
            return true;
        }
    };
    return productAuth_new;
});