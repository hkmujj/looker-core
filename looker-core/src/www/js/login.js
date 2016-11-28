/**
 * Created by fananyuan on 2016/6/20.
 */
define(['ko', 'underscore', 'C', 'jquery'],
    function (ko, _, C, $) {
        var Page,


            Page = {
                init: function () {
                    var _this = this;
                    _this.render();
                    _this.bind();
                },
                render: function () {

                },
                bind: function () {
                    var _this = this;
                    $('.loginconter').on('input', '.userName', function(){
                        $('.login_null').hide();
                        $('.login_error').hide();
                    });
                    $('.loginconter').on('input', '.passWord', function(){
                        $('.login_null').hide();
                        $('.login_error').hide();
                    });

                    $('.loginconter').on('mouseover',  '.loginBtn', function(){
                        if( _this.isValid()){
                            $(this).addClass('login_active');
                        }else{
                            $(this).removeClass('login_active');
                        }

                    });

                    $('.loginconter').on('mouseout',  '.loginBtn', function(){
                            $(this).removeClass('login_active');
                    });
                    $('.loginconter').on('click', '.loginBtn', function () {
                        var username = $('.userName').val(),
                            password = $('.passWord').val();
                        if (!username || !password) {
                            $('.login_null').show();
                        } else {
                            $.ajax({
                                type: 'get',
                                url: C.Api.LOGIN,
                                data: {
                                    username: username,
                                    password: password
                                },
                                success: function (res) {
                                    if (res.resCode == C.ResCodes.SUCCESS) {
                                        location.href = 'index.html?userId=' + res.resData;
                                    }else if(res.resCode == '-1003'){
                                        $('.login_error').show();
                                    }else{
                                        C.UI.msg(res.resMsg);
                                    }
                                }
                            });
                        }
                    });
                },
                isValid: function(){
                    var username = $('.userName').val(),
                        password = $('.passWord').val();
                    return username && password;
                }
            };
        $(function () {

            Page.init();
        });
    });