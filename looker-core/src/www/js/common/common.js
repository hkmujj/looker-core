/**�������
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
    //    //����jquery��ajax����
    //    var _ajax=$.ajax;
    //
    //    //��дjquery��ajax����
    //    $.ajax=function(opt){
    //        //����opt��error��success����
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
    //        //��չ��ǿ����
    //        var _opt = $.extend(opt,{
    //            error:function(XMLHttpRequest, textStatus, errorThrown){
    //                //���󷽷���ǿ����
    //                fn.error(XMLHttpRequest, textStatus, errorThrown);
    //            },
    //            success:function(data, textStatus){
    //                //�ɹ��ص�������ǿ����
    //                fn.success(data, textStatus);
    //            },
    //            beforeSend:function(XHR){
    //                //�ύǰ�ص�����
    //                $('body').append("<div id='ajaxInfo' style=''>������������,���Ե�...</div>");
    //            },
    //            complete:function(XHR, TS){
    //                //������ɺ�ص����� (����ɹ���ʧ��֮�������)��
    //                $("#ajaxInfo").remove();
    //            }
    //        });
    //        _ajax(_opt);
    //    };
    //})(jQuery);
    return C;
});