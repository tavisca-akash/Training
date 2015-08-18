function pageLoad() {
    $(".ui-dialog-titlebar-close").hover(function () { $(this).addClass("ui-state-hover"); },
							 function () { $(this).removeClass("ui-state-hover"); });
}  

/*-------------------------------------------------------------------- 
* JQuery Plugin: "EqualHeights" & "EqualWidths"
* by:	Scott Jehl, Todd Parker, Maggie Costello Wachs (http://www.filamentgroup.com)
*
* Copyright (c) 2007 Filament Group
* Licensed under GPL (http://www.opensource.org/licenses/gpl-license.php)
*
* Description: Compares the heights or widths of the top-level children of a provided element 
and sets their min-height to the tallest height (or width to widest width). Sets in em units 
by default if pxToEm() method is available.
* Dependencies: jQuery library, pxToEm method	(article: http://www.filamentgroup.com/lab/retaining_scalable_interfaces_with_pixel_to_em_conversion/)							  
* Usage Example: $(element).equalHeights();
Optional: to set min-height in px, pass a true argument: $(element).equalHeights(true);
* Version: 2.0, 07.24.2008
* Changelog:
*  08.02.2007 initial Version 1.0
*  07.24.2008 v 2.0 - added support for widths

Sangram : Changed Selectors
--------------------------------------------------------------------*/


$.fn.equalHeights = function (px) {
    var currentTallest = 0;
    $(this).each(function (i) {
        if ($(this).height() > currentTallest) { currentTallest = $(this).height(); }
    });
    if (!px || !Number.prototype.pxToEm) currentTallest = currentTallest.pxToEm(); //use ems unless px is specified
    // for ie6, set height since min-height isn't supported
    if ($.browser.msie && $.browser.version == 6.0) { $(this).css({ 'height': currentTallest }); }
    $(this).css({ 'min-height': currentTallest });

    return this;
};

// just in case you need it...
$.fn.equalWidths = function (px) {
    var currentWidest = 0;
    $(this).each(function (i) {
        if ($(this).width() > currentWidest) { currentWidest = $(this).width(); }
    });
    if (!px || !Number.prototype.pxToEm) currentWidest = currentWidest.pxToEm(); //use ems unless px is specified
    // for ie6, set width since min-width isn't supported
    if ($.browser.msie && $.browser.version == 6.0) { $(this).css({ 'width': currentWidest }); }
    $(this).css({ 'min-width': currentWidest });

    return this;
};


/*-------------------------------------------------------------------- 
* javascript method: "pxToEm"
* by:
Scott Jehl (scott@filamentgroup.com) 
Maggie Wachs (maggie@filamentgroup.com)
http://www.filamentgroup.com
*
* Copyright (c) 2008 Filament Group
* Dual licensed under the MIT (filamentgroup.com/examples/mit-license.txt) and GPL (filamentgroup.com/examples/gpl-license.txt) licenses.
*
* Description: Extends the native Number and String objects with pxToEm method. pxToEm converts a pixel value to ems depending on inherited font size.  
* Article: http://www.filamentgroup.com/lab/retaining_scalable_interfaces_with_pixel_to_em_conversion/
* Demo: http://www.filamentgroup.com/examples/pxToEm/	 	
*							
* Options:  	 								
scope: string or jQuery selector for font-size scoping
reverse: Boolean, true reverses the conversion to em-px
* Dependencies: jQuery library						  
* Usage Example: myPixelValue.pxToEm(); or myPixelValue.pxToEm({'scope':'#navigation', reverse: true});
*
* Version: 2.0, 08.01.2008 
* Changelog:
*		08.02.2007 initial Version 1.0
*		08.01.2008 - fixed font-size calculation for IE
--------------------------------------------------------------------*/

Number.prototype.pxToEm = String.prototype.pxToEm = function (settings) {
    //set defaults
    settings = jQuery.extend({
        scope: 'body',
        reverse: false
    }, settings);

    var pxVal = (this == '') ? 0 : parseFloat(this);
    var scopeVal;
    var getWindowWidth = function () {
        var de = document.documentElement;
        return self.innerWidth || (de && de.clientWidth) || document.body.clientWidth;
    };

    /* When a percentage-based font-size is set on the body, IE returns that percent of the window width as the font-size. 
    For example, if the body font-size is 62.5% and the window width is 1000px, IE will return 625px as the font-size. 	
    When this happens, we calculate the correct body font-size (%) and multiply it by 16 (the standard browser font size) 
    to get an accurate em value. */

    if (settings.scope == 'body' && $.browser.msie && (parseFloat($('body').css('font-size')) / getWindowWidth()).toFixed(1) > 0.0) {
        var calcFontSize = function () {
            return (parseFloat($('body').css('font-size')) / getWindowWidth()).toFixed(3) * 16;
        };
        scopeVal = calcFontSize();
    }
    else { scopeVal = parseFloat(jQuery(settings.scope).css("font-size")); };

    var result = (settings.reverse == true) ? (pxVal * scopeVal).toFixed(2) + 'px' : (pxVal / scopeVal).toFixed(2) + 'em';
    return result;
};
/*--------------------------------------------------------------------*/

/*** Other Functions ***/
function txtLabelValidate(sender, args) {
    if ($('#cbOverrideVersion').is(':checked') == false && args.Value.length == 0) {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}

function ddlLabelValidate(sender, args) {
    if ($('#cbOverrideVersion').is(':checked') == true && args.Value.length == 0) {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }
}

function UpdatePageStyle(pageUrl) {
    $("link[href*=/Templar/Css]:last").after('<link href="' + pageUrl + '\" rel=\"stylesheet\" type=\"text/css\"/>');
    if ($("link[href*=/Templar/Css]").size() > 1) {
        $("link[href*=/Templar/Css]:first").remove();
    }
}

function ShowPageSettings() {

    $(".jQueryTabs").tabs('destroy');
    $(".jQueryTabs").tabs();

    $('#divPageEnvironmentDataContainer').PageData({ 'CustomKeyValidator': function (key) {
        var regexp = /^([0-9a-zA-Z])+$/;
        if (!key || !(regexp.test(key)) || key.length < 3 || key.length > 30) {
            return false;
        }
        return true;
    }, 'KeyValidationFailedMsg': 'Only alphanumeric key of length between 3 and 30 are valid.'
    });
    $('#divPageEnvironmentDataContainer').PageData('Populate', $('#hfPageEnvironmentDataJson').val());

    $('#divPageMetaDataContainer').PageData({ 'CustomKeyValidator': function (key) {
        var regexp = /^([0-9a-zA-Z])+$/;
        if (!key || !(regexp.test(key)) || key.length < 3 || key.length > 30) {
            return false;
        }
        return true;
    }, 'KeyValidationFailedMsg': 'Only alphanumeric key of length between 3 and 30 are valid.'
    });
    $('#divPageMetaDataContainer').PageData('Populate', $('#hfPageMetaDataConfigJson').val());

    $('#divPageScripts').DataDictionary(
                {
                    Data: $('#hfPageScripts').val(),
                    CustomKeyValidator: function (key) { var regexp = /^([0-9a-zA-Z])+$/; if (!key || !(regexp.test(key)) || key.length < 3 || key.length > 30) { return false; } return true; },
                    KeyValidationFailedMsg: 'Only alphanumeric key of length between 3 and 30 are valid.',
                    Sortable: true,
                    HelpContent: "<div>" +
                                    "<div>Key can only be alphanumeric</div>" +
                                    "<div>Values can be</div><hr/>" +
                                    "<ul style=\"color:black;\">" +
	                                    "<li> Absolute Url e.g. http://anydomain/SampleJs.js </li>" +
	                                    "<li> Relative Url e.g. ~/Widgets/SampleJs.js </li>" +
	                                    "<li> SiteResource e.g. SiteResourceUrl(\"&lt;ResourceName&gt;\")</li>" +
                                    "</ul>" +
                                "</div>"
                });


    $('#btnSavePageData').bind('click', function (e) {
        $('#divPageEnvironmentDataContainer').PageData('GetData', 'hfPageEnvironmentDataJson');
        $('#divPageMetaDataContainer').PageData('GetData', 'hfPageMetaDataConfigJson');
        $('#divPageScripts').DataDictionary('GetData', 'hfPageScripts');
    });

    $('#lblMsg').effect("highlight", {}, 2500).hide('slow');

    $('div.jQueryTabs input.fw_checkbox[type="checkbox"]').each(function () {
        HideShowDefaultWidth(this);
        $(this).bind('click', function () { HideShowDefaultWidth(this); });
    });
}

function HideShowDefaultWidth(control) {
    var siblingDiv = $(control).parent().parent().next('div');
    if ($(control).is(':checked')) {
        $(siblingDiv[0]).hide();
    }
    else {
        $(siblingDiv[0]).show();
    }
}

function HideWidgetHelp(pageId, serviceUrl, mode) {
    $('.MyWidget').attr('title', '').unbind('mouseover').unbind('mouseout').find('.MyHeader .helpText').remove();
}

function ShowWidgetHelp(pageId, serviceUrl, mode) {
    var cachedMetaData = $('.designer-toolbar input[id$="hfWidgetHelpMode"]').data('metaData');
    if (!cachedMetaData) {
        TemplarFx.GetWidgetMetaData(pageId, mode, serviceUrl, function (metaData) {
            $('.designer-toolbar input[id$="hfWidgetHelpMode"]').data('metaData', metaData);
            BindHelpMetaData(metaData);
        });
    } else {
        BindHelpMetaData(cachedMetaData);
    }
}

function ClearWidgetHelpData() {
    $('.designer-toolbar input[id$="hfWidgetHelpMode"]').data('metaData', null);
}

function BindHelpMetaData(metaData) {
    $.each(metaData.response.WI, function () {
        var details = this;
        $('.MyWidget[data-instanceid="' + details.Id + '"]').data('tooltip', details.D).mouseover(ShowWidgetHelpTooltip).mouseout(HideWidgetHelpTooltip).find('.MyHeader').append('<span class="helpText"> ( ' + details.N + ' ) </span>');
    });
}

function ShowWidgetHelpTooltip() {
    if ($(this).is('.MyWidget')) {
        var tooltip = $(this).data('tooltip');
        if (tooltip) {
            var position = $(this).position();
            $('#divWidgetHelpTooltip').html(tooltip).css({ "top": position.top - ($('#divWidgetHelpTooltip').height() + 15), "left": position.left }).show();
        }
    }
}

function HideWidgetHelpTooltip() {
    if ($(this).is('.MyWidget')) {
        $("#divWidgetHelpTooltip").hide();
    }
}

function InitWidgetHelp(pageId, serviceUrl) {
    $('#divWidgetHelpTooltip').remove();
    var tooltipMarkup = '<div id="divWidgetHelpTooltip" style="display:none;padding:5px;position: absolute; background-color: rgb(255, 243, 181); max-width: 270px; border: 1px solid rgb(112, 88, 52); z-index: 1000; text-align: left;"></div>';
    $('body').append(tooltipMarkup);
    $('.designer-toolbar a[id$="lnkWidgetHelp"]').click(function () {
        var $that = $(this);
        var currentState = $('.designer-toolbar input[id$="hfWidgetHelpMode"]').val();
        if (currentState.toLowerCase() === 'active') {
            $('.designer-toolbar input[id$="hfWidgetHelpMode"]').val('inactive');
            $that.children().removeClass('templar-widgethelp-enabled').addClass('templar-widgethelp-disabled');
            HideWidgetHelp(pageId, serviceUrl, 'page');
        } else {
            $('.designer-toolbar input[id$="hfWidgetHelpMode"]').val('active');
            $that.children().removeClass('templar-widgethelp-disabled').addClass('templar-widgethelp-enabled');
            ShowWidgetHelp(pageId, serviceUrl, 'page');
        }
        return false;
    });
}

function InitEventMapInfoDisplay(args) {
    var eventMapping = $.parseJSON($('#' + args).val());
    var context = $('div.EventInfo');
    $('.EventName:not(.UnMapped)', context).click(function () {
        $('.SelectedSource', context).removeClass('SelectedSource');
        $('.AttachedTarget', context).removeClass('AttachedTarget');

        var src = $(this);
        src.addClass('SelectedSource');
        var mode = src.closest('ul').data('mode');

        $.each(eventMapping, function (i, v) {
            var txtVal = jQuery.trim(src.text());
            var upParent = $('ul[data-mode=' + mode + ']', context);
            if (v.SW.EN === txtVal) {
                var lst = $('.EventName:not(.UnMapped)', upParent);
                for (var ii = 0; ii < lst.length; ii++) {
                    if ($(lst[ii]).text() === v.DW.T.NEN) {
                        $(lst[ii]).addClass('AttachedTarget');
                    }
                }
            }
            else if (v.DW.T.NEN === txtVal) {
                var lst = $('.EventName:not(.UnMapped)', upParent);
                for (var ii = 0; ii < lst.length; ii++) {
                    if ($(lst[ii]).text() === v.SW.EN) {
                        $(lst[ii]).addClass('AttachedTarget');
                    }
                }
            }
        });
    });
}

function ShowPublishPageModal(serviceUrl) {

    $.ajax({
        type: "GET",
        contentType: "application/json",
        url: serviceUrl + "/GetServerTime",
        data: null,
        dataType: 'json',
        cache: false,
        processData: false,
        success: function (currentTime) {
            $('#txtPageScheduleTime').val(currentTime);
        }
    });

    var pageId = $('input[type="hidden"][id$="hfPageId"]').val();

    var userId = $('input[type="hidden"][id$="hfUserId"]').val();

    $('#divAdvPagePublish').tabs().dialog({ modal: true, title: 'Publish Page', width: 454 });

    $('#txtPageScheduleTime').datetimepicker();

    $('#cbxPublishNow').unbind('click').click(function () {
        if ($(this).is(':checked')) {
            $('#txtPageScheduleTime').attr('disabled', 'disabled');
        } else {
            $('#txtPageScheduleTime').removeAttr('disabled');
        }
    });

    $('#btnCancelCreatePageVersion,#btnCancelPublishPage').click(function () {
        $('#divAdvPagePublish').dialog('destroy');
    });

    $('#btnPublishPage').unbind('click').click(function () {
        if ($('#cbxPublishNow').is(':checked')) {
            PublishPage(serviceUrl, userId, pageId);
        } else {
            var time = new Date($('#txtPageScheduleTime').val());
            var strTime = time.getFullYear() + '|' + (time.getMonth() + 1) + '|' + time.getDate() + '|' + time.getHours() + '|' + time.getMinutes();
            SchedulePage(serviceUrl, userId, pageId, strTime);
        }
    });

    $('#btnCreatePageVersion').unbind('click').click(function () {
        var versionName = $('#keyDetail').val();
        var versionDesc = $('#valueDetail').val();

        if (!versionName) {
            TemplarFx.ShowMsg('Error Occured', 'Version name cannot be empty.', 'Error');
            return false;
        }

        CreatePageVersion(serviceUrl, userId, pageId, versionName, versionDesc);

    });

}

function PublishPage(serviceUrl, userId, pageId) {

    var jsonData = Sys.Serialization.JavaScriptSerializer.serialize(pageId);

    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: serviceUrl + "/PublishPage/" + userId,
        data: jsonData,
        dataType: 'json',
        cache: false,
        processData: false,
        beforeSend: TemplarFx.ShowAjaxLoader,
        success: function (result) {
            $('#divAdvPagePublish').dialog('destroy');
            TemplarFx.HideAjaxLoader();
            if (result && result.status) {
                if (result.status.success) {
                    TemplarFx.ShowMsg('Creation successfull', result.status.errormessage, 'Success', true);
                } else {
                    TemplarFx.ShowMsg('Error Occured', result.status.errormessage, 'Error');
                }
            } else {
                TemplarFx.ShowMsg('Error Occured', 'Error occured while communicating with server.', 'Error');
            }
        },
        error: function () {
            $('#divAdvPagePublish').dialog('destroy');
            TemplarFx.HideAjaxLoader();
            TemplarFx.ShowMsg('Error Occured', 'Error occured while communicating with server.', 'Error');
        }
    });
}

function SchedulePage(serviceUrl, userId, pageId, time) {

    var jsonData = Sys.Serialization.JavaScriptSerializer.serialize(time);

    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: serviceUrl + '/SchedulePage/' + userId + '/' + pageId,
        data: jsonData,
        dataType: 'json',
        cache: false,
        processData: false,
        beforeSend: TemplarFx.ShowAjaxLoader,
        success: function (result) {
            $('#divAdvPagePublish').dialog('destroy');
            TemplarFx.HideAjaxLoader();
            if (result && result.status) {
                if (result.status.success) {
                    TemplarFx.ShowMsg('Scheduling successfull', result.status.errormessage, 'Success', true);
                } else {
                    TemplarFx.ShowMsg('Error Occured', result.status.errormessage, 'Error');
                }
            } else {
                TemplarFx.ShowMsg('Error Occured', 'Error occured while communicating with server.', 'Error');
            }
        },
        error: function () {
            $('#divAdvPagePublish').dialog('destroy');
            TemplarFx.HideAjaxLoader();
            TemplarFx.ShowMsg('Error Occured', 'Error occured while communicating with server.', 'Error');
        }
    });

}

function CreatePageVersion(serviceUrl, userId, pageId, versionName, versionDesc) {

    var pageVersion = {};
    pageVersion.N = versionName;
    pageVersion.D = versionDesc;
    pageVersion.Id = pageId;

    var jsonData = Sys.Serialization.JavaScriptSerializer.serialize(pageVersion);

    TemplarFx.ShowAjaxLoader();

    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: serviceUrl + "/CreatePageVersion/" + userId,
        data: jsonData,
        dataType: 'json',
        cache: false,
        processData: false,
        success: function (result) {
            $('#divAdvPagePublish').dialog('destroy');
            TemplarFx.HideAjaxLoader();
            if (result && result.status) {
                if (result.status.success) {
                    TemplarFx.ShowMsg('Creation successfull', result.status.errormessage, 'Success', true);
                } else {
                    TemplarFx.ShowMsg('Error Occured', result.status.errormessage, 'Error');
                }
            } else {
                TemplarFx.ShowMsg('Error Occured', 'Error occured while communicating with server.', 'Error');
            }
        },
        error: function () {
            $('#divAdvPagePublish').dialog('destroy');
            TemplarFx.HideAjaxLoader();
            TemplarFx.ShowMsg('Error Occured', 'Error occured while communicating with server.', 'Error');
        }
    });

}