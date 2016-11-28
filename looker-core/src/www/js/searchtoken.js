
define(['ko', 'underscore', 'C', 'jquery', 'js/generatetoken', 'js/searchtoken'], function (ko, _, C, $, generatetoken, searchtoken) {
    var searchtoken,
    //
        TEM_FEET_LIST = _.template($('#tem_token_search').html()),

        URL = C.Api.COMMON_TOKENSEARCH;

    searchtoken = {
        init: function () {
            var _this = this,
                CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO));
            _this.bind($('#' + CONTAINERNO));
            window.location.hash = 'searchtoken';

        },
        render: function (CONTAINER) {
            var _this = this;
            $('.show_position_pre').text('首页');
            $('.show_position').text('>生成token');
            $('.show_position_next').hide();
            $('#organization_modify_header').show().siblings().hide();
            CONTAINER.html(TEM_FEET_LIST({}));
        },
        bind: function (CONTAINER) {
            var _this = this;
            //复制token
            var clipboard = new Clipboard('.btn_token');
            clipboard.on('success', function(e) {
                C.UI.msg('token已成功复制到剪切板！');
            });

            clipboard.on('error', function(e) {
                C.UI.msg('token复制失败, 请手动复制！');
            });
            //生成token按钮
            CONTAINER.on('click', '.pere_token', function () {
                var ORG_NAME = $('.orgName').val(),
                    CHANNEL_NAME = $('.channelName').val(),
                    data = {
                        orgCode: ORG_NAME,
                        channelCode: CHANNEL_NAME
                    };
                if(ORG_NAME == ''){
                    C.UI.msg('请输入机构名称！');
                    return;
                }else if(CHANNEL_NAME == ''){
                    C.UI.msg('请输入渠道名称！');
                    return;
                }
                C.PageBreak.Loading();
                $(".tokendisplay").css({"display":"block"});
                $.ajax({
                    type: 'get',
                    url: C.Api.COMMON_TOKENSEARCH,
                    data: data,
                    success: function (res) {
                        C.PageBreak.stopLoading();
                        var T= res.resData.token;
                        $(".tokenfont").text(T);
                    }
                });
                $(".tokenpere").css("display","block");
            });
            CONTAINER.on('click', '.tokenrecord', function () {
                generatetoken.init();
            });

        }
    };
    return searchtoken;
});