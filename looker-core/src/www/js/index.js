/**
 * Created by fananyuan on 2016/6/20.
 */
define(['ko', 'underscore', 'C', 'jquery', 'move',
        'js/organization',
        'js/organization_new',
        'js/channel_list',
        'js/channel_list_new',
        'js/userAuth_list',
        'js/userAuth_manage',
        'js/product_list',
        'js/product_new',
        'js/product_recheck',
        'js/product_disrecheck',
        'js/feet_list',
        'js/objection_register',
        'js/objection_check',
        'js/objection_list',
        'js/userManager_new',
        'js/userManager_list',
        'js/productAuth_list',
        'js/productAuth_new',
        'js/productAuth_recheck',
        'js/productAuth_open',
        'js/generatetoken',
        'js/searchtoken',
        'js/searchreport',
        'js/reportupload'
    ],
    function (ko, _, C, $, move,
              organization,
              organization_new,
              channel_list,
              channel_list_new,
              userAuth_list,
              userAuth_manage,
              product_list,
              product_new,
              product_recheck,
              product_disrecheck,
              //充值记录
              feet_list,
              objection_register,
              objection_check,
              objection_list,
              userManager_new,
              userManager_list,
              productAuth_list,
              productAuth_new,
              productAuth_recheck,
              productAuth_open,
              generatetoken,
              searchtoken,
              searchreport,
              reportupload ) {
        var Page,
            USERINFO =   C.Utils.data('userInfo') || {},
            TEM_MENU_MAX = _.template($('#tem_menu_max').html()),
            TEM_MENU_MIN = _.template($('#tem_menu_min').html());

            Page = {
                init: function () {
                    var _this = this;
                    _this.render();
                    _this.bind_index();
                    _this.bind_organization();
                    _this.bind_channel();
                    _this.bind_userAuth();
                    _this.bind_product();
                    _this.bind_feet();
                    _this.bind_objection();
                    _this.bind_userManager();
                    _this.bind_productAuth();
                    _this.bind_token();
                    _this.bind_report();
                    _this.bind_logout();
                   // _this.router_index();
                },
                render: function () {
                    var  firstName = USERINFO.userName ? USERINFO.userName.charAt(0) : '';
                    $('.fullname').text(USERINFO.userName);
                    $('.first_name').text(firstName);
                    $.ajax({
                        type: 'get',
                        url: C.Api.LONGIN_MENU,
                        data:{
                            userId: USERINFO.userId
                        },
                        success: function(res){
                            if (res.resCode == C.ResCodes.SUCCESS) {
                                $('#menu_max').html(TEM_MENU_MAX(res.resData));
                                $('#menu_min').html(TEM_MENU_MIN(res.resData));
                                $('#organization_search_header').show().siblings().hide();
                                $('.show_position').text('>机构查询');
                                if(res.resData.menu[0].child[1]){
                                    $('.' + res.resData.menu[0].child[1].className).trigger('click');
                                }else{
                                    $('.' + res.resData.menu[0].child[0].className).trigger('click');
                                }
                                window.location.hash = 'organization';
                            }
                        }
                    });

                },
                bind_index: function () {
                    var _this = this, navEl = $('.nav'),active=true;
                    //首页侧边栏动画
                   $('.partright').on('click', '.headicon', function (){
                       var partleft_max = $('.partleft_max'),
                           partleft_min =$('.partleft_min');
                       if(active){
                           partleft_max.animate({opacity:'0'},'fast');
                           partleft_max.hide();
                           $('.partleft').animate({width:'60px'},'fast');
                           partleft_min.fadeIn('slow');
                           $('#container_zx .partright').animate({marginLeft:'60px'},'fast');
                           active = false;
                       }else{
                           $('#container_zx .partright').animate({marginLeft:'200px'},'fast');
                           partleft_min.hide();
                           $('.partleft').animate({width:'200px'},'fast',function(){
                               partleft_max.show();
                               partleft_max.animate({opacity:'1'},'fast');
                           });
                           active = true;
                       }
                   });

                    //点击下拉
                    navEl.on('click', '.ddown', function () {
                        var self = $(this);
                        domSlideDown(self);
                        self.parents('li').siblings('.active').removeClass('active');
                        self.parents('li').siblings().find('.laed').removeClass('laed').addClass('la');
                        self.parents('li').siblings().find('ul').slideUp(300);
                        $('.second-leaver li').removeClass('index_select');
                    });
                    //点击上缩
                    navEl.on('click', '.bactive', function () {
                        var self = $(this);
                        domSlideUp(self);
                        $('.second-leaver li').removeClass('index_select');
                    });
                   //向下滑动展开
                    function domSlideDown(self) {
                        self.siblings('ul').slideDown(200);
                        self.find('span').removeClass('la').addClass('laed');
                        self.parents('li').addClass('active');
                        self.parents('li').siblings().find('.bactive').removeClass('bactive').addClass('ddown');
                        self.removeClass('ddown').addClass('bactive');
                    }

                    //向上滑动收起
                    function domSlideUp(self) {
                        self.siblings('ul').slideUp(300);
                        self.find('span').removeClass('laed').addClass('la');
                        self.removeClass('bactive').addClass('ddown');
                        self.parents('li').removeClass('active');
                    }
                },
                //机构
                bind_organization: function(){
                    var _this = this, navEl = $('.nav');
                    //点击机构查询
                    navEl.on('click', '.organization_search', function () {
                        _this.selectItem($(this));
                        organization.init();

                    });
                    //点击新建机构
                    navEl.on('click', '.organization_new', function () {
                        _this.selectItem($(this));
                        $('.show_position').text('>新建机构');
                        $('#organization_new_header').show().siblings().hide();
                          organization_new.init();

                    });
                    //头部点击对应相应的模块
                    $('.header').on('click', '.new', function () {
                        $('.show_position').text('>新建机构');
                        $('#organization_new_header').show().siblings().hide();
                        organization_new.init();
                    });
                    $('.header').on('click', '.search', function () {
                        organization.init();
                    });
                },
                //渠道
                bind_channel: function(){
                    var _this = this, navEl = $('.nav');
                    //点击渠道查询
                    navEl.on('click', '.channel_list', function(){
                        _this.selectItem($(this));
                        channel_list.init();
                    });
                    //点击渠道管理--新建渠道
                    navEl.on('click','.channel_new',function(){
                        _this.selectItem($(this));
                        channel_list_new.init();
                    });

                    $('.header').on('click', '.channel_list_new_header', function(){
                        channel_list_new.init();
                    });
                    $('.header').on('click', '.channel_list_search_header', function(){
                         channel_list.init();
                    });
                },
                //用户授权
                bind_userAuth: function(){
                    var _this = this, navEl = $('.nav');
                    //点击用户授权记录
                    navEl.on('click', '.userAuth_list', function(){
                        _this.selectItem($(this));
                        userAuth_list.init();
                    });
                    //点击用户授权管理
                    navEl.on('click', '.userAuth_manage', function(){
                        _this.selectItem($(this));
                         userAuth_manage.init();
                    });
                },
                //产品
                bind_product: function(){
                    var _this = this, navEl = $('.nav');
                    //点击产品查询
                    navEl.on('click', '.product_list', function(){
                        _this.selectItem($(this));
                        var recheckStatuis = $(this).attr('recheckStatuis');
                        product_list.init('1');
                    });
                    //点击新建产品
                    navEl.on('click','.product_new',function(){
                        _this.selectItem($(this));
                         product_new.init();
                    });
                    //点击产品复核
                    navEl.on('click', '.product_recheck', function(){
                        _this.selectItem($(this));
                        var recheckStatuis = $(this).attr('recheckStatuis');
                         product_recheck.init('0');
                    });
                    //点击未通过产品复核
                    navEl.on('click','.product_disrecheck',function(){
                        _this.selectItem($(this));
                        var recheckStatuis = $(this).attr('recheckStatuis');
                        product_disrecheck.init('2');
                    });

                    $('.header').on('click', '.product_new_header', function(){
                        product_new.init();
                    });
                    $('.header').on('click', '.product_list_header', function(){
                       product_list.init();
                    });
                },
                //计费管理
                bind_feet:function(){
                    var _this = this, navEl = $('.nav');
                    //点击充值记录
                    navEl.on('click','.feet_list',function(){
                        _this.selectItem($(this));
                         feet_list.init();
                    });
                },
                //token
                bind_token: function(){
                    var _this = this, navEl = $('.nav');
                    //点击生成token
                    navEl.on('click', '.generatetoken', function(){
                        _this.selectItem($(this));
                        searchtoken.init();
                    });
                    //点击token查询
                    navEl.on('click', '.searchtoken', function(){
                        _this.selectItem($(this));

                        generatetoken.init();
                    });
                },
                //报表
                bind_report: function(){
                    var _this = this, navEl = $('.nav');
                    //点击报表上传
                    navEl.on('click', '.reportForms_upload', function(){
                        _this.selectItem($(this));
                        reportupload.init();
                    });
                    //点击报表查询
                    navEl.on('click', '.reportForms_list', function(){
                        _this.selectItem($(this));

                        searchreport.init();
                    });
                },
                //异议管理
                bind_objection:function(){
                    var _this = this, navEl = $('.nav');
                    //点击异议登记
                    navEl.on('click','.objection_register',function(){
                        _this.selectItem($(this));
                        var objStatus = '0';
                        objection_register.init(objStatus);
                    });
                    //点击异议核查
                    navEl.on('click','.objection_check',function(){
                        _this.selectItem($(this));
                        var objStatus = '1';
                        objection_check.init(objStatus);
                    });
                    //点击异议查询
                    navEl.on('click','.objection_list',function(){
                        _this.selectItem($(this));
                        var objStatus = '';
                        objection_list.init(objStatus);
                    });
                },
                //系统管理
                bind_userManager: function(){
                    var _this = this, navEl = $('.nav');
                    //新建用户
                    navEl.on('click', '.user_new', function(){
                        _this.selectItem($(this));
                        userManager_new.init();
                    });
                    //用户管理
                    navEl.on('click', '.user_manage', function(){
                        _this.selectItem($(this));
                        userManager_list.init();
                    });
                },
                //产品授权管理
                bind_productAuth: function(){
                    var _this = this, navEl = $('.nav');
                    //产品授权查询
                    navEl.on('click', '.productLicense_list', function(){
                        _this.selectItem($(this));
                        productAuth_list.init();
                    });
                    //新建产品授权
                    navEl.on('click', '.productLicense_new', function(){
                        _this.selectItem($(this));
                        productAuth_new.init();
                    });
                    //产品授权复核
                    navEl.on('click', '.productLicense_recheck', function(){
                        _this.selectItem($(this));
                        productAuth_recheck.init();
                    });
                    //产品授权开通
                    navEl.on('click', '.productLicense_open', function(){
                        _this.selectItem($(this));
                        productAuth_open.init();
                    });
                },
                //登出
                bind_logout: function(){
                    var _this = this;
                    $('.logoutfont').click(function(){
                        $.ajax({
                            type:'get',
                            url: C.Api.LOGOUT,
                            data: {},
                            success: function(res){
                                if (res.resCode == C.ResCodes.SUCCESS) {
                                    location.href = 'login.html';
                                    C.Utils.data('userInfo', null);
                                }
                            }
                        });
                    });
                },
                //选中状态
                selectItem: function(self){
                    self.addClass('index_select').siblings().removeClass('index_select');
                },
                //首页路由
                router_index: function(){
                    if(window.addEventListener){
                        window.addEventListener('hashchange',routerChange,false);
                    }else{
                        window.attachEvent("onhashchange", routerChange);
                    }

                    function routerChange(){
                        var hash = window.location.hash;
                        switch (hash){
                            case '#organization':
                                organization.init();
                                break;
                            case '#organization_new':
                                organization_new.init();
                                break;
                            case '#channel_list':
                                channel_list.init();
                                break;
                            case '#channel_list_new':
                                channel_list_new.init();
                                break;
                            case '#userAuth_list':
                                userAuth_list.init();
                                break;
                            case '#userAuth_manage':
                                userAuth_manage.init();
                                break;
                            case '#product_list':
                                product_list.init('1');
                                break;
                            case '#product_recheck':
                                product_recheck.init('0');
                                break;
                            case '#product_disrecheck':
                                product_disrecheck.init('2');
                                break;
                            case '#product_new':
                                product_new.init();
                                break;
                            case '#feet_list':
                                feet_list.init();
                                break;
                            case '#objection_register':
                                objection_register.init('1');
                                break;
                            case '#objection_check':
                                objection_check.init('2');
                                break;
                            case '#objection_list':
                                objection_list.init('');
                                break;
                        }
                    }
                }
            };
        $(function () {
            var height = document.documentElement.clientHeight;
            $(".partleft").height(height);
            Page.init();
        });
    });