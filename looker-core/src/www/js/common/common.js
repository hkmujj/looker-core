/**插件核心
 * Created by fananyuan on 2016/6/6.
 */
define([
        'jquery',
        'js/common/api',
        'js/common/rescodes',
        'js/common/utils',
        'js/common/ui',
        'js/common/constant',
        'js/common/pagebreak'

], function ($, api, ResCodes, Utils, UI, Constant, PageBreak) {

    var C = {
        Api: api.apis,
        ResCodes: ResCodes,
        Utils: Utils,
        UI: UI,
        Constant: Constant,
        PageBreak: PageBreak
    };
    //
    //(function($){
    //    //备份jquery的ajax方法
    //    var _ajax=$.ajax;
    //
    //    //重写jquery的ajax方法
    //    $.ajax=function(opt){
    //        //备份opt中error和success方法
    //        var fn = {
    //            error:function(XMLHttpRequest, textStatus, errorThrown){},
    //            success:function(data, textStatus){}
    //        }
    //        if(opt.error){
    //            fn.error=opt.error;
    //        }
    //        if(opt.success){
    //            fn.success=opt.success;
    //        }
    //
    //        //扩展增强处理
    //        var _opt = $.extend(opt,{
    //            error:function(XMLHttpRequest, textStatus, errorThrown){
    //                //错误方法增强处理
    //                fn.error(XMLHttpRequest, textStatus, errorThrown);
    //            },
    //            success:function(data, textStatus){
    //                //成功回调方法增强处理
    //                fn.success(data, textStatus);
    //            },
    //            beforeSend:function(XHR){
    //                //提交前回调方法
    //                $('body').append("<div id='ajaxInfo' style=''>正在请求数据,请稍等...</div>");
    //            },
    //            complete:function(XHR, TS){
    //                //请求完成后回调函数 (请求成功或失败之后均调用)。
    //                $("#ajaxInfo").remove();
    //            }
    //        });
    //        _ajax(_opt);
    //    };
    //})(jQuery);
    return C;
});