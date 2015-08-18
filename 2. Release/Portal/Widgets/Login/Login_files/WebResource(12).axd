(function (window, jQuery, undefined) {

    if (!Array.prototype.forEach) {
        Array.prototype.forEach = function (fn, scope) {
            for (var i = 0, len = this.length; i < len; ++i) {
                fn.call(scope, this[i], i, this);
            }
        }
    }

    if (!Array.prototype.indexOf) {
        Array.prototype.indexOf = function (obj, start) {
            for (var i = (start || 0), j = this.length; i < j; i++) {
                if (this[i] === obj) { return i; }
            }
            return -1;
        }
    }

    var templarFx = function () { };
    templarFx.fn = templarFx.prototype = {
        // The current version of  Templar FrameWork
        version: "1.0",
        jq: jQuery,
        TemplarServicePath: '',
        PageId: 0
    };
    templarFx.fn.extend = function () {
        // copy reference to target object
        var target = arguments[0] || {}, i = 1, length = arguments.length, deep = false, options, name, src, copy;

        // Handle a deep copy situation
        if (typeof target === "boolean") {
            deep = target;
            target = arguments[1] || {};
            // skip the boolean and the target
            i = 2;
        }

        // Handle case when target is a string or something (possible in deep copy)
        if (typeof target !== "object" && !templarFx.isFunction(target)) {
            target = {};
        }

        // extend _TemplarFx itself if only one argument is passed
        if (length === i) {
            target = this;
            --i;
        }

        for (; i < length; i++) {
            // Only deal with non-null/undefined values
            if ((options = arguments[i]) != null) {
                // Extend the base object
                for (name in options) {
                    src = target[name];
                    copy = options[name];

                    // Prevent never-ending loop
                    if (target === copy) {
                        continue;
                    }

                    // Recurse if we're merging object literal values or arrays
                    if (deep && copy && (templarFx.isPlainObject(copy) || templarFx.isArray(copy))) {
                        var clone = src && (templarFx.isPlainObject(src) || templarFx.isArray(src)) ? src
						: templarFx.isArray(copy) ? [] : {};

                        // Never move original objects, clone them
                        target[name] = templarFx.extend(deep, clone, copy);

                        // Don't bring in undefined values
                    } else if (copy !== undefined) {
                        target[name] = copy;
                    }
                }
            }
        }

        // Return the modified object
        return target;
    };
    templarFx.fn.ShowMsg = function (title, msg, type, inline) {
        if (inline) {
            switch (type.toLowerCase()) {
                case 'info':
                    type = 'infoMsg';
                    break;
                case 'error':
                    type = 'errorMsg';
                    break;
                case 'warning':
                    type = 'errorMsg';
                    break;
                case 'success':
                    type = 'infoMsg';
                    break;
                default:
                    type = 'infoMsg';
            }
            var t = TemplarFx.jq('div[id$="upInfoMessage"]');
            t.html('<div id="divMessage" class="' + type + '">' + msg + '</div>');
            setTimeout(function () { TemplarFx.jq('div[id$=\"divMessage\"]', t).slideUp('slow'); }, 3000);
        }
        else {

            switch (type.toLowerCase()) {
                case 'info':
                    type = 'infoIcon';
                    break;
                case 'error':
                    type = 'errorIcon';
                    break;
                case 'warning':
                    type = 'warningIcon';
                    break;
                case 'success':
                    type = 'successIcon';
                    break;
                default:
                    type = 'infoIcon';
            }
            TemplarFx.jq('<div  title="' + title + '" style="height:auto;"><div class="' + type + '" style="float:left; margin:0px 7px 0px 0px;"></div><p style="margin-top: 5px;">' + msg + '</p></div>')
					.dialog({ modal: true,
					    resizable: false,
					    maxWidth: 500,
					    width: 500,
					    zIndex: 11000,
					    close: function () { TemplarFx.jq(this).dialog('destroy').remove(); },
					    buttons: {
					        'Ok': function () { TemplarFx.jq(this).dialog('destroy').remove(); }
					    }
					});
        }
    };
    templarFx.fn.Confirm = function (title, msg, s, callback) {
        var src = TemplarFx.jq(s);
        if (src.data('confirm') != null || src.data('confirm') != undefined) {
            var val = src.data('confirm');
            src.removeData('confirm', true);
            return val;
        }
        else {
            TemplarFx.jq('<div  title="' + title + '" style="height:auto;width:100%"><div class="warningIcon" style="float:left; margin:0px 7px 0px 0px;"></div><div style="float:left;margin-top: 5px;width:90%;">' + msg + '</div></div>')
				.dialog(
					{
					    modal: true,
					    close: function () { TemplarFx.jq(this).dialog('destroy').remove(); },
					    buttons: {
					        Cancel: function () {
					            if (TemplarFx.jq.isFunction(callback)) {
					                callback(false);
					            }
					            TemplarFx.jq(this).dialog('destroy').remove();
					        },
					        Ok: function () {
					            if (TemplarFx.jq.isFunction(callback)) {
					                callback(true);
					            }
					            else {
					                if (src.attr('href')) {
					                    eval(src.attr('href'));
					                }
					                else if (src.attr('type') === 'submit') {
					                    src.closest('form').submit();
					                }
					                else {
					                    src.data('confirm', true);
					                    src.delay(1000).trigger('click');
					                }
					            }
					            TemplarFx.jq(this).dialog('destroy').remove();
					        }
					    },
					    resizable: false,
					    maxWidth: 500,
					    width: 500,
					    zIndex: 11000
					});
            return false;
        }
    };
    templarFx.fn.ModalPopup = function (title, id) {
        var element = TemplarFx.jq('#' + id);
        var parent = element.parent();
        var x = TemplarFx.jq('<div  title="' + title + '" style="height:auto;"></div>');
        element.show().wrap(x).parent().dialog({ modal: true, resizable: false, maxWidth: 625, width: 625,
            close: function () {
                element.remove();
                TemplarFx.jq(this).dialog('destroy').remove();
            }
        }).parent().appendTo(parent);
        TemplarFx.jq('form ~ .ui-widget-overlay:last').appendTo(parent);
    };
    templarFx.fn.OpenWindow = function (title, url, paramaters) {
        var w = TemplarFx.jq('body').outerWidth();
        var h = TemplarFx.jq('body').outerHeight();
        var path;
        if (paramaters == null || paramaters == '')
            path = url;
        else
            path = String.format("{0}?{1}", url, paramaters);

        var parentDiv = TemplarFx.jq('<div title="' + title + '"></div>');
        parentDiv.append(TemplarFx.jq('<div><iframe frameborder="0" height="' + (h - 45) + '" width="' + (w - 35) + '" scrolling="no" src="' + path + '"></iframe></div>'))
				 .dialog({ modal: true, height: h - 5, width: w - 5, close: function () { parentDiv.remove(); TemplarFx.jq(this).dialog('destroy').remove(); } });
        return false;
    };
    templarFx.fn.ShowAjaxLoader = function () {
        TemplarFx.jq('#divAjaxLoader').remove();
        var ajaxLoaderhtml = '<div id="divAjaxLoader" class="" style="position: fixed; left: 0px; top: 0px; z-index: 10100;height:2000px;width:2000px;"><div id="divAjaxLoaderInner" class="AjaxLoading_Circular"></div></div>';
        TemplarFx.jq('body').append(ajaxLoaderhtml);
        TemplarFx.jq('#divAjaxLoaderInner').center();
    };
    templarFx.fn.HideAjaxLoader = function () {
        TemplarFx.jq('#divAjaxLoader').remove();
    };
    window.TemplarFx = new templarFx();
})(window, jQuery);

TemplarFx.jq.fn.center = function () {
    this.css("position", "fixed");
    this.css("top", (TemplarFx.jq(window).height() - this.height()) / 2 + TemplarFx.jq(window).scrollTop() + "px");
    this.css("left", (TemplarFx.jq(window).width() - this.width()) / 2 + TemplarFx.jq(window).scrollLeft() + "px");
    return this;
};

TemplarFx.jq.fn.outerHTML = function () {
    return TemplarFx.jq('<div />').append(this.eq(0).clone()).html();
};

TemplarFx.Designer = {
    Attributes: {
        CONTAINER_ID: "containerId",
        INSTANCE_ID: "data-instanceId",
        ZONE_ID: "columnNo",
        WIDGET_ZONE_DUMMY_LINK: "widget_holder_panel_post_link"
    },
    newWidget: function (title) {
        return TemplarFx.jq('<div onmouseout="this.className=\'MyWidget\'" onmouseover="this.className=\'MyWidget widget_hover\'" class="MyWidget">' +
								'<div style="width: auto;">' +
									'<div style="margin: 0.1em; padding: 0.5em;" class="ui-widget-header">' +
										'<div class="MyHeader"><a style="font-size: 0.8em;" >' + title + '</a></div>' +
									'</div>' +
									'<hr style="height: 1px; background-color: rgb(66, 151, 215);">' +
									'<div style="height: auto; width: auto; overflow: auto;">' +
										'<div class="widget_body AjaxLoading_Circular" style="display:table;margin:auto;"></div>' +
									'</div>' +
								'</div>' +
							'</div>');
    },
    showProgress: function (hide) {
        if (hide)
            TemplarFx.jq('div.designer-loadingSmall').parent().show();
        else
            TemplarFx.jq('div.designer-loadingSmall').parent().hide();
    },
    Actions: {
        delWidgetInst: function (target) {
            var wInstName = $(target).parent().find('.MyHeader').text().trim();
            return TemplarFx.Confirm('Confirm Widget Deletion', 'Are you sure you want to remove the Widget Instance \'<b>' + wInstName + '</b>\'  ?', target, function (retVal) {
                if (retVal) {
                    TemplarFx.Designer.showProgress(true);
                    var element = TemplarFx.jq(target).closest('.MyWidget');
                    var instanceId = $(target).attr(TemplarFx.Designer.Attributes.INSTANCE_ID);
                    var widgetZone = element.closest('.widget_zone');
                    TemplarFx.jq.ajax({
                        type: "GET",
                        contentType: "application/json",
                        url: TemplarFx.TemplarServicePath + "/deleteWidgetInstance/" + TemplarFx.PageId + "/" + instanceId,
                        data: null,
                        cache: false,
                        processData: false,
                        success: function () {
                            /* Log Widget Delete Activity */
                            TemplarFx.LogAndSync('Deleted ' + wInstName + ' widget', '1');

                            TemplarFx.Designer.showProgress(false);
                            element.remove();
                            TemplarFx.Designer.updateWidgetZone(widgetZone);
                        },
                        error: function () {
                            TemplarFx.Designer.showProgress(false);
                            TemplarFx.ShowMsg('Error Occurred', 'Error occurred while deleting widget, Reloading page', 'Error');
                            TemplarFx.Designer.updateWidgetZone(widgetZone);
                            /*eval(TemplarFx.jq('.' + TemplarFx.Designer.Attributes.WIDGET_ZONE_DUMMY_LINK).attr('href'));*/
                        }
                    });
                }
                return false;
            });
        },

        onDrop: function (containerId, columnNo, instanceId, row, callback) {
            TemplarFx.Designer.showProgress(true);
            TemplarFx.jq.ajax({
                type: "GET",
                contentType: "application/json",
                url: TemplarFx.TemplarServicePath + "/moveWidgetInstance/" + instanceId + "/" + columnNo + "/" + row + "/" + containerId,
                data: null,
                cache: false,
                processData: false,
                success: function () {
                    TemplarFx.Designer.showProgress(false);
                    callback();
                },
                error: function () {
                    TemplarFx.Designer.showProgress(false);
                    TemplarFx.ShowMsg('Error Occurred', 'Error occurred while updating widget position, Reloading page', 'Error');
                    callback();
                    /*eval(TemplarFx.jq('.' + TemplarFx.Designer.Attributes.WIDGET_ZONE_DUMMY_LINK).attr('href'));*/
                }
            });

        },

        onWidgetAdd: function (containerId, widgetId, columnNo, row, callback) {
            TemplarFx.jq.ajax({
                type: "GET",
                contentType: "application/json",
                url: TemplarFx.TemplarServicePath + "/addWidget/" + TemplarFx.PageId + "/" + widgetId + "/" + columnNo + "/" + row + "/" + containerId,
                data: null,
                cache: false,
                processData: false,
                success: callback,
                error: function () {
                    TemplarFx.ShowMsg('Error Occurred', 'Error occurred while adding widget, Reloading page', 'Error');
                    callback();
                    /*eval(TemplarFx.jq('.' + TemplarFx.Designer.Attributes.WIDGET_ZONE_DUMMY_LINK).attr('href'));*/
                }
            });
        }
    },
    initDragDrop: function (widgetClass, newWidgetClass, handleClass, zoneClass) {
        TemplarFx.jq('.ContentPanel').find('[containerid=-1]').equalHeights();

        TemplarFx.Designer.initAddStuff(zoneClass, newWidgetClass);

        // Get all widget zones on the page and allow widget to be dropped on any of them
        var allZones = TemplarFx.jq('.' + zoneClass);

        //var zone = TemplarFx.jq('#' + zoneId);
        allZones.each(function () {
            var plugin = TemplarFx.jq(this).data('sortable');
            if (plugin) plugin.destroy();
        });

        allZones.sortable({
            items: '.' + widgetClass + ':not(.NonDrag-MyWidget)',
            handle: '.' + handleClass,
            cancel: 'a, input',
            cursor: 'move',
            cursorAt: { cursor: "move", top: 50, left: 50 },
            appendTo: 'body',
            connectWith: allZones,
            opacity: 0.8,
            revert: true,
            placeholder: 'placeholder',
            start: function (e, ui) {
                ui.helper.css("width", 100);
                ui.helper.css("height", 100);
                ui.placeholder.height(ui.item.height());
                TemplarFx.Designer.suspendPendingWidgetZoneUpdate();
            },
            beforeStop: function (e, ui) {
                //console.log(ui);
                var position = ui.item.parent()
									.children('.' + widgetClass)
									.index(ui.item);
                var widgetZone = ui.item.parents('.' + zoneClass + ':first');
                var containerId = parseInt(widgetZone.attr(TemplarFx.Designer.Attributes.CONTAINER_ID));
                var column = parseInt(widgetZone.attr(TemplarFx.Designer.Attributes.ZONE_ID));

                if (ui.item.hasClass(newWidgetClass)) {
                    //new item has been dropped into the sortable list
                    var widgetId = ui.item.data('widgetid');
                    TemplarFx.Designer.newWidget(TemplarFx.jq(ui.item).attr('title')).insertAfter(ui.item);
                    ui.item.remove();

                    TemplarFx.Designer.Actions.onWidgetAdd(containerId, widgetId, column, position,
						function () {
						    TemplarFx.Designer.updateWidgetZone(widgetZone);
						});
                }
                else {
                    ui.item.css({ 'width': 'auto' });
                    var instanceId = parseInt(ui.item.attr(TemplarFx.Designer.Attributes.INSTANCE_ID));
                    TemplarFx.Designer.Actions.onDrop(containerId, column, instanceId, position, function () {
                        TemplarFx.Designer.updateWidgetZone(widgetZone);
                    });
                }
            }
        });
    },
    searchWidget: function (text) {
        text = text.trim().toLowerCase();
        var context = TemplarFx.jq('#nv-panel .searchResults');
        TemplarFx.jq('ul.searchResultsList li', context).each(function () {
            if ((TemplarFx.jq(this).data('name') + '').trim().indexOf(text) >= 0) { TemplarFx.jq(this).show(); }
            else { TemplarFx.jq(this).hide(); }
        });
    },
    // Hook jquery stuffs on the widget list so that new widgets
    // can be added by dragging & dropping a widget from the widget
    // list.
    initAddStuff: function (zoneClass, newWidgetClass) {
        var searchTextBox = TemplarFx.jq('#nv-panel .searchPanel :text').bind('keyup', function () { TemplarFx.Designer.searchWidget(TemplarFx.jq(this).val()); });
        TemplarFx.jq('#nv-panel .searchPanel a').click(function (e) { e.stopImmediatePropagation(); searchTextBox.val(""); TemplarFx.Designer.searchWidget(""); });
        var allZones = TemplarFx.jq('.' + zoneClass);

        var widgetLinks = TemplarFx.jq('.' + newWidgetClass);
        widgetLinks.draggable("destroy");
        widgetLinks.each(function () {
            var plugin = TemplarFx.jq(this).data('sortable');
            if (plugin) plugin.destroy();
        });

        TemplarFx.jq('.' + newWidgetClass).draggable(
		{
		    connectToSortable: allZones,
		    helper: 'clone',
		    opacity: 0.7,
		    revert: "invalid",
		    cursorAt: { cursor: "move", top: 50, left: 50 }
		});
    },
    // Queue update for a widget zone.
    updateWidgetZone: function (widgetZone) {
        // update the widget zone after three seconds because user might drag & drop another widget
        // in the meantime.
        if ((TemplarFx.Designer.__updateWidgetZoneTimerId || 0) === 0) {
            var zoneList = TemplarFx.Designer.__widgetZonesToUpdate || [];
            zoneList.push(widgetZone);
            TemplarFx.Designer.__widgetZonesToUpdate = zoneList;
            widgetZone.attr("__pendingUpdate", "1");
            TemplarFx.Designer.__updateWidgetZoneTimerId = window.setTimeout(function () {
                TemplarFx.jq(TemplarFx.Designer.__widgetZonesToUpdate).each(function (index, zone) {
                    if (zone.attr("__pendingUpdate") == "1") {
                        zone.attr("__pendingUpdate", "0");
                        var f = function () { return Sys.WebForms.PageRequestManager.getInstance().get_isInAsyncPostBack(); };
                        TemplarFx.Designer.untilFalse(f, function () {
                            TemplarFx.Designer.asyncPostbackWidgetZone(zone);
                        });
                    }
                });
                TemplarFx.Designer.__updateWidgetZoneTimerId = 0;
            }, 1000);
        }
        else {
            // Restart the timer when another update is queued
            TemplarFx.Designer.suspendPendingWidgetZoneUpdate();
            TemplarFx.Designer.updateWidgetZone(widgetZone);
        }
    },
    suspendPendingWidgetZoneUpdate: function () {
        if (TemplarFx.Designer.__updateWidgetZoneTimerId > 0) {
            window.clearTimeout(TemplarFx.Designer.__updateWidgetZoneTimerId);
            TemplarFx.Designer.__updateWidgetZoneTimerId = 0;
        }
    },
    asyncPostbackWidgetZone: function (widgetZone) {
        TemplarFx.Designer.showProgress(true);
        //setTimeout("window.location.reload();", 2000);
        /*var postBackLink = TemplarFx.jq('.' + TemplarFx.Designer.Attributes.WIDGET_ZONE_DUMMY_LINK);
        eval(postBackLink.attr('href'));*/
        window.location.reload();
    },
    untilTrue: function (test, callback) {
        if (test() === true) {
            callback();
        }
        else {
            window.setTimeout(function () { TemplarFx.Designer.untilTrue(test, callback); }, 200);
        }
    },
    untilFalse: function (test, callback) {
        TemplarFx.Designer.untilTrue(function () { return test() === false; }, callback);
    }
};

function ShowModalPopupWindow(title, url, paramaters, width, height) {
    if (url == null || url == '')
        return false;
    if (paramaters != null && paramaters == '') {
        url = String.format("{0}?{1}", url, paramaters);
    }

    if (window.showModalDialog) {
        var dialogArguments = new Object();
        window.showModalDialog(url, dialogArguments, 'dialogHeight=' + height + 'px,dialogTop=10,dialogWidth=' + width + 'px,center=1,resizable=1,scroll=1');
    }
    else {
        TemplarFx.ShowMsg('Error', "Can't show pop up window", 'Error');
    }
    return false;
}

var GlobalizationDataDisplay = {
    CurrentMode: 'FULL', //can be FULL or NATIVE
    CurrentPage: 1,
    CurrentCulturePage: 1,
    CurrentWidgetInstanceId: 0,
    CurrentSiteId: 0,
    CurrentCultureId: 0,
    CurrentCultureInstanceId: 0,
    CurrentCultureName: '',
    CurrentCultureCount: 0,
    LastCulturePage: 0,
    LastPage: 0,
    ResourceCount: 0,
    GlobalizationdataServicePath: '',
    PageSize: 10,
    CulturePageSize: 10,
    Actions: {
        SubmitChanges: function (key, definedAt) {
            var value = $('#valueDetailForResource').val();
            var comment = '';
            var translationSetting = 'Do Nothing';
            var r = {};
            r.K = key;
            r.V = value;
            r.C = comment;
            r.TS = translationSetting;
            var resource = Sys.Serialization.JavaScriptSerializer.serialize(r);
            var targetUrl = '';
            if (GlobalizationDataDisplay.CurrentMode == 'FULL') {
                if (definedAt.toLowerCase() == 'widgetinstance') {
                    targetUrl = GlobalizationDataDisplay.GlobalizationdataServicePath + "/AddResource/widgetInstance/" + GlobalizationDataDisplay.CurrentWidgetInstanceId + "/" + GlobalizationDataDisplay.CurrentCultureId + "/false";
                }
                else {
                    targetUrl = GlobalizationDataDisplay.GlobalizationdataServicePath + "/AddResource/widgetInstance/" + GlobalizationDataDisplay.CurrentWidgetInstanceId + "/" + GlobalizationDataDisplay.CurrentCultureId + "/true";
                }
            }
            else {
                targetUrl = GlobalizationDataDisplay.GlobalizationdataServicePath + "/AddResource/" + GlobalizationDataDisplay.CurrentCultureId + "/false";
            }
            TemplarFx.jq.ajax({
                type: "POST",
                contentType: "application/json",
                url: targetUrl,
                data: resource,
                cache: false,
                dataType: 'json',
                processData: false,
                success: GlobalizationDataDisplay.Actions.LoadResources,
                error: function () { TemplarFx.ShowMsg('Error Occurred', "Error occurred while adding settings", 'Error'); }
            });
        },
        EnableEditing: function () {
            TemplarFx.jq('.editableText').editable({ submit: 'Save', cancel: 'Cancel', onSubmit: GlobalizationDataDisplay.Actions.SubmitChanges });
        },
        ShowResourcePage: function (pageNumber) {
            GlobalizationDataDisplay.CurrentPage = pageNumber;
            GlobalizationDataDisplay.Actions.LoadResources();
        },
        ShowLastResourcePage: function () {
            GlobalizationDataDisplay.CurrentPage = GlobalizationDataDisplay.LastPage;
            GlobalizationDataDisplay.Actions.LoadResources();
        },
        ShowNextResourcePage: function () {
            GlobalizationDataDisplay.CurrentPage = GlobalizationDataDisplay.CurrentPage + 1;
            GlobalizationDataDisplay.Actions.LoadResources();
        },
        ShowPrevResourcePage: function () {
            GlobalizationDataDisplay.CurrentPage = GlobalizationDataDisplay.CurrentPage - 1;
            GlobalizationDataDisplay.Actions.LoadResources();
        },
        ShowFirstResourcePage: function () {
            GlobalizationDataDisplay.CurrentPage = 1;
            GlobalizationDataDisplay.Actions.LoadResources();
        },
        ShowCulturePage: function (pageNumber) {
            GlobalizationDataDisplay.CurrentCulturePage = pageNumber;
            GlobalizationDataDisplay.Actions.GetCultures();
        },
        ShowLastCulturePage: function () {
            GlobalizationDataDisplay.CurrentCulturePage = GlobalizationDataDisplay.LastPage;
            GlobalizationDataDisplay.Actions.GetCultures();
        },
        ShowNextCulturePage: function () {
            GlobalizationDataDisplay.CurrentCulturePage = GlobalizationDataDisplay.CurrentPage + 1;
            GlobalizationDataDisplay.Actions.GetCultures();
        },
        ShowPrevCulturePage: function () {
            GlobalizationDataDisplay.CurrentCulturePage = GlobalizationDataDisplay.CurrentPage - 1;
            GlobalizationDataDisplay.Actions.GetCultures();
        },
        ShowFirstCulturePage: function () {
            GlobalizationDataDisplay.CurrentCulturePage = 1;
            GlobalizationDataDisplay.Actions.GetCultures();
        },
        Reload: function (mode) {
            GlobalizationDataDisplay.CurrentPage = 1;
            if (mode == 'NATIVE') {
                GlobalizationDataDisplay.CurrentMode = 'NATIVE';
                TemplarFx.jq.ajax({
                    type: "POST",
                    contentType: "application/json",
                    url: "/Templar/Services/GlobalizationDataService.svc/GetCultures/widgetinstance/" + GlobalizationDataDisplay.CurrentWidgetInstanceId + "/0/1",
                    data: null,
                    dataType: 'json',
                    cache: false,
                    processData: false,
                    success:
						function (data) {
						    var i = 0;
						    GlobalizationDataDisplay.CurrentCultureInstanceId = -1;
						    for (; i < data.C.length; i++) {
						        if (GlobalizationDataDisplay.CurrentCultureName == data.C[i].N) {
						            GlobalizationDataDisplay.CurrentCultureInstanceId = data.C[i].CId;
						        }
						    }
						    GlobalizationDataDisplay.Actions.LoadNativeResources();
						},
                    error:
						function () {
						    TemplarFx.ShowMsg('Error Occurred', "Error occurred while getting cultures", 'Error');
						}
                });
            }
            else {
                GlobalizationDataDisplay.CurrentMode = 'FULL';
                GlobalizationDataDisplay.Actions.LoadResources();
            }

        },
        ShowGlobalizationDataContainer: function (widgetTitle, widgetInstanceId, siteId) {
            GlobalizationDataDisplay.CurrentWidgetInstanceId = widgetInstanceId;
            GlobalizationDataDisplay.CurrentSiteId = siteId;
            GlobalizationDataDisplay.Actions.GetCultures();
            TemplarFx.jq('#divGlobalizationDataContainer').dialog({
                resizable: false,
                modal: true,
                width: 557,
                title: 'Globalization data for ' + widgetTitle + ' widget'
            });
            //            TemplarFx.jq.blockUI({
            //                message: TemplarFx.jq('#GlobalizationDataContainer'),
            //                css: { width: 'auto' },
            //                centerX: true,
            //                centerY: true
            //            });
        },
        GetCultures: function () {
            TemplarFx.jq.ajax({
                type: "GET",
                contentType: "application/json",
                url: GlobalizationDataDisplay.GlobalizationdataServicePath + "/GetAvailableCultures/" + GlobalizationDataDisplay.CurrentSiteId + "/" + GlobalizationDataDisplay.CulturePageSize + "/" + GlobalizationDataDisplay.CurrentCulturePage,
                data: null,
                dataType: 'json',
                cache: false,
                processData: false,
                success:
						function (data) {
						    var cultures = {};
						    cultures.C = [];
						    for (var i = 0; i < data.C.length; i++) {
						        data.C[i].Index = GlobalizationDataDisplay.CulturePageSize * (GlobalizationDataDisplay.CurrentCulturePage - 1) + i + 1;
						        cultures.C.push(data.C[i]);
						    }
						    GlobalizationDataDisplay.CurrentCultureCount = data.TCC;
						    GlobalizationDataDisplay.LastCulturePage = parseInt(((GlobalizationDataDisplay.CurrentCultureCount - 1) / GlobalizationDataDisplay.CulturePageSize) + 1);
						    if (GlobalizationDataDisplay.CurrentCulturePage <= 1) {
						        TemplarFx.jq('#divPrevCulturePage').children().slice(0, 1).css('display', 'none');
						        TemplarFx.jq('#divPrevCulturePage').children().slice(1, 2).css('display', 'block');
						        TemplarFx.jq('#divFirstCulturePage').children().slice(0, 1).css('display', 'none');
						        TemplarFx.jq('#divFirstCulturePage').children().slice(1, 2).css('display', 'block');
						    }
						    else {
						        TemplarFx.jq('#divPrevCulturePage').children().slice(0, 1).css('display', 'block');
						        TemplarFx.jq('#divPrevCulturePage').children().slice(1, 2).css('display', 'none');
						        TemplarFx.jq('#divFirstCulturePage').children().slice(0, 1).css('display', 'block');
						        TemplarFx.jq('#divFirstCulturePage').children().slice(1, 2).css('display', 'none');
						    }
						    if (GlobalizationDataDisplay.CurrentCulturePage >= GlobalizationDataDisplay.LastCulturePage) {
						        TemplarFx.jq('#divNextCulturePage').children().slice(0, 1).css('display', 'none');
						        TemplarFx.jq('#divNextCulturePage').children().slice(1, 2).css('display', 'block');
						        TemplarFx.jq('#divLastCulturePage').children().slice(0, 1).css('display', 'none');
						        TemplarFx.jq('#divLastCulturePage').children().slice(1, 2).css('display', 'block');
						    }
						    else {
						        TemplarFx.jq('#divNextCulturePage').children().slice(0, 1).css('display', 'block');
						        TemplarFx.jq('#divNextCulturePage').children().slice(1, 2).css('display', 'none');
						        TemplarFx.jq('#divLastCulturePage').children().slice(0, 1).css('display', 'block');
						        TemplarFx.jq('#divLastCulturePage').children().slice(1, 2).css('display', 'none');
						    }
						    var pages = {};
						    pages.P = [];
						    var page = Math.max(1, GlobalizationDataDisplay.CurrentCulturePage - 2);
						    for (; page <= Math.min(GlobalizationDataDisplay.LastCulturePage, GlobalizationDataDisplay.CurrentCulturePage + 2); page++) {
						        var curPage = {};
						        curPage.PN = page;
						        curPage.CP = false;
						        if (page == GlobalizationDataDisplay.CurrentCulturePage) {
						            curPage.CP = true;
						        }
						        pages.P.push(curPage);
						    }
						    TemplarFx.jq('#divCulturePager').setTemplateElement("templateCulturePager");
						    TemplarFx.jq("#divCulturePager").processTemplate(pages);
						    TemplarFx.jq("#divCultureListing").setTemplateElement("templateCultureBox");
						    TemplarFx.jq("#divCultureListing").processTemplate(cultures);
						    TemplarFx.jq("#divResources").hide();
						    //TemplarFx.jq("#divModeSelector").hide();
						    TemplarFx.jq('#divCultures').show();
						},
                error: function () {
                    TemplarFx.ShowMsg('Error Occurred', "Error occurred while getting cultures", 'Error');
                }
            });
        },
        DeleteResource: function (resourceId) {
            var resource = {};
            resource.Id = resourceId;
            var jsonResource = Sys.Serialization.JavaScriptSerializer.serialize(resource);
            TemplarFx.jq.ajax({
                type: "DELETE",
                contentType: "application/json",
                url: GlobalizationDataDisplay.GlobalizationdataServicePath + "/DeleteResourceById",
                data: jsonResource,
                dataType: 'json',
                cache: false,
                processData: false,
                success: function () {
                    GlobalizationDataDisplay.Actions.LoadResources();
                }
            });
        },
        LoadResources: function () {
            var f = '';
            var filterText = Sys.Serialization.JavaScriptSerializer.serialize(f);
            TemplarFx.jq.ajax({
                type: "POST",
                contentType: "application/json",
                url: GlobalizationDataDisplay.GlobalizationdataServicePath + "/GetResolvedResources/WidgetInstance/" + GlobalizationDataDisplay.CurrentWidgetInstanceId + "/" + GlobalizationDataDisplay.CurrentCultureId + "/" + GlobalizationDataDisplay.PageSize + "/" + GlobalizationDataDisplay.CurrentPage,
                data: filterText,
                dataType: 'json',
                cache: false,
                processData: false,
                success: function (result) {
                    var resources = {};
                    resources.R = [];
                    for (var i = 0; i < result.R.length; i++) {
                        result.R[i].Index = GlobalizationDataDisplay.PageSize * (GlobalizationDataDisplay.CurrentPage - 1) + i + 1;
                        resources.R.push(result.R[i]);
                    }
                    TemplarFx.jq("#divResourceListing").setTemplateElement("templateResourceBox");
                    TemplarFx.jq("#divResourceListing").processTemplate(resources);
                    GlobalizationDataDisplay.ResourceCount = result.TRC;
                    GlobalizationDataDisplay.LastPage = parseInt(((GlobalizationDataDisplay.ResourceCount - 1) / GlobalizationDataDisplay.PageSize) + 1);
                    if (GlobalizationDataDisplay.CurrentPage <= 1) {
                        TemplarFx.jq('#divPrevResourcePage').children().slice(0, 1).css('display', 'none');
                        TemplarFx.jq('#divPrevResourcePage').children().slice(1, 2).css('display', 'block');
                        TemplarFx.jq('#divFirstResourcePage').children().slice(0, 1).css('display', 'none');
                        TemplarFx.jq('#divFirstResourcePage').children().slice(1, 2).css('display', 'block');
                    }
                    else {
                        TemplarFx.jq('#divPrevResourcePage').children().slice(0, 1).css('display', 'block');
                        TemplarFx.jq('#divPrevResourcePage').children().slice(1, 2).css('display', 'none');
                        TemplarFx.jq('#divFirstResourcePage').children().slice(0, 1).css('display', 'block');
                        TemplarFx.jq('#divFirstResourcePage').children().slice(1, 2).css('display', 'none');
                    }
                    if (GlobalizationDataDisplay.CurrentPage >= GlobalizationDataDisplay.LastPage) {
                        TemplarFx.jq('#divNextResourcePage').children().slice(0, 1).css('display', 'none');
                        TemplarFx.jq('#divNextResourcePage').children().slice(1, 2).css('display', 'block');
                        TemplarFx.jq('#divLastResourcePage').children().slice(0, 1).css('display', 'none');
                        TemplarFx.jq('#divLastResourcePage').children().slice(1, 2).css('display', 'block');
                    }
                    else {
                        TemplarFx.jq('#divNextResourcePage').children().slice(0, 1).css('display', 'block');
                        TemplarFx.jq('#divNextResourcePage').children().slice(1, 2).css('display', 'none');
                        TemplarFx.jq('#divLastResourcePage').children().slice(0, 1).css('display', 'block');
                        TemplarFx.jq('#divLastResourcePage').children().slice(1, 2).css('display', 'none');
                    }
                    var pages = {};
                    pages.P = [];
                    var page = Math.max(1, GlobalizationDataDisplay.CurrentPage - 2);
                    for (; page <= Math.min(GlobalizationDataDisplay.LastPage, GlobalizationDataDisplay.CurrentPage + 2); page++) {
                        var curPage = {};
                        curPage.PN = page;
                        curPage.CP = false;
                        if (page == GlobalizationDataDisplay.CurrentPage) {
                            curPage.CP = true;
                        }
                        pages.P.push(curPage);
                    }
                    TemplarFx.jq('#divResourcePager').setTemplateElement("templateResourcePager");
                    TemplarFx.jq("#divResourcePager").processTemplate(pages);
                    //TemplarFx.jq('#divGlobalizationDataContainer').center();
                    TemplarFx.jq('#divGlobalizationDataContainer .deleteIcon').unbind('click').bind('click', function () {
                        var container = $(this).closest('tr');
                        var key = container.attr('id');
                        var resourceId = container.attr('data-rid');
                        TemplarFx.Confirm('Confirm deletion', 'Are you sure want to delete value for ' + key + ' defined at widget instance level ?', null, function (verified) {
                            if (verified) {
                                GlobalizationDataDisplay.Actions.DeleteResource(resourceId);
                            }
                        });
                    });
                    TemplarFx.jq('#divGlobalizationDataContainer .editIcon').unbind('click').bind('click', function () {
                        var container = $(this).closest('tr');
                        var key = container.attr('id');
                        var value = container.find('.spnResourceValue').text();
                        var definedAt = container.find('.spnResourceDefinedAt').text();
                        TemplarFx.jq('#keyDetailForResource').val(key);
                        TemplarFx.jq('#valueDetailForResource').val(value);
                        TemplarFx.jq('#divResourceEditor').dialog({ width: 455, title: 'Edit' });
                        TemplarFx.jq('#spanBtnUpdateResource').unbind('click').bind('click', function () {
                            TemplarFx.jq('#divResourceEditor').dialog('close');
                            GlobalizationDataDisplay.Actions.SubmitChanges(key, definedAt);
                        });
                    });
                },
                error: function () {
                    TemplarFx.ShowMsg('Error Occurred', "Error occurred while getting resources", 'Error');
                }
            });
        },
        LoadNativeResources: function () {
            var f = '';
            var filterText = Sys.Serialization.JavaScriptSerializer.serialize(f);
            TemplarFx.jq.ajax({
                type: "POST",
                contentType: "application/json",
                url: GlobalizationDataDisplay.GlobalizationdataServicePath + "/GetResources/" + GlobalizationDataDisplay.CurrentCultureInstanceId + "/" + GlobalizationDataDisplay.PageSize + "/" + GlobalizationDataDisplay.CurrentPage,
                data: filterText,
                dataType: 'json',
                cache: false,
                processData: false,
                success:
						function (result) {
						    var resources = {};
						    resources.R = [];
						    for (var i = 0; i < result.R.length; i++) {
						        result.R[i].Index = GlobalizationDataDisplay.PageSize * (GlobalizationDataDisplay.CurrentPage - 1) + i + 1;
						        result.R[i].DA = 'WidgetInstance';
						        resources.R.push(result.R[i]);
						    }
						    TemplarFx.jq("#divCultures").hide();
						    //TemplarFx.jq("#divContents").hide();
						    //TemplarFx.jq("#divCultureHeader").hide();
						    //TemplarFx.jq("#divContentHeader").hide();
						    TemplarFx.jq("#divResourceListing").setTemplateElement("templateResourceBox");
						    TemplarFx.jq("#divResourceListing").processTemplate(resources);
						    //TemplarFx.jq("#divResourceHeader").show();
						    //TemplarFx.jq("#divModeSelector").show();
						    TemplarFx.jq("#divResources").show();
						    GlobalizationDataDisplay.ResourceCount = result.TRC;
						    GlobalizationDataDisplay.LastPage = parseInt(((GlobalizationDataDisplay.ResourceCount - 1) / GlobalizationDataDisplay.PageSize) + 1);
						    if (GlobalizationDataDisplay.CurrentPage <= 1) {
						        TemplarFx.jq('#divPrevResourcePage').children().slice(0, 1).css('display', 'none');
						        TemplarFx.jq('#divPrevResourcePage').children().slice(1, 2).css('display', 'block');
						        TemplarFx.jq('#divFirstResourcePage').children().slice(0, 1).css('display', 'none');
						        TemplarFx.jq('#divFirstResourcePage').children().slice(1, 2).css('display', 'block');
						    }
						    else {
						        TemplarFx.jq('#divPrevResourcePage').children().slice(0, 1).css('display', 'block');
						        TemplarFx.jq('#divPrevResourcePage').children().slice(1, 2).css('display', 'none');
						        TemplarFx.jq('#divFirstResourcePage').children().slice(0, 1).css('display', 'block');
						        TemplarFx.jq('#divFirstResourcePage').children().slice(1, 2).css('display', 'none');
						    }
						    if (GlobalizationDataDisplay.CurrentPage >= GlobalizationDataDisplay.LastPage) {
						        TemplarFx.jq('#divNextResourcePage').children().slice(0, 1).css('display', 'none');
						        TemplarFx.jq('#divNextResourcePage').children().slice(1, 2).css('display', 'block');
						        TemplarFx.jq('#divLastResourcePage').children().slice(0, 1).css('display', 'none');
						        TemplarFx.jq('#divLastResourcePage').children().slice(1, 2).css('display', 'block');
						    }
						    else {
						        TemplarFx.jq('#divNextResourcePage').children().slice(0, 1).css('display', 'block');
						        TemplarFx.jq('#divNextResourcePage').children().slice(1, 2).css('display', 'none');
						        TemplarFx.jq('#divLastResourcePage').children().slice(0, 1).css('display', 'block');
						        TemplarFx.jq('#divLastResourcePage').children().slice(1, 2).css('display', 'none');
						    }
						    var pages = {};
						    pages.P = [];
						    var page = Math.max(1, GlobalizationDataDisplay.CurrentPage - 2);
						    for (; page <= Math.min(GlobalizationDataDisplay.LastPage, GlobalizationDataDisplay.CurrentPage + 2); page++) {
						        var curPage = {};
						        curPage.PN = page;
						        curPage.CP = false;
						        if (page == GlobalizationDataDisplay.CurrentPage) {
						            curPage.CP = true;
						        }
						        pages.P.push(curPage);
						    }
						    TemplarFx.jq('#divResourcePager').setTemplateElement("templateResourcePager");
						    TemplarFx.jq("#divResourcePager").processTemplate(pages);
						    //TemplarFx.jq('#divGlobalizationDataContainer').center();
						    $('.editIcon').click(function () { });
						    //GlobalizationDataDisplay.Actions.EnableEditing();
						},
                error:
						function () {
						    TemplarFx.ShowMsg('Error Occurred', "Error occurred while getting resources", 'Error');
						}
            });
            //TemplarFx.jq("#divModeSelector").show();
        },
        GetResources: function (cultureId) {
            GlobalizationDataDisplay.CurrentCultureId = cultureId;
            GlobalizationDataDisplay.CurrentCultureName = TemplarFx.jq('#' + cultureId).attr('name');
            GlobalizationDataDisplay.CurrentPage = 1;
            GlobalizationDataDisplay.Actions.LoadResources();
            TemplarFx.jq("#divCultures").hide();
            TemplarFx.jq("#divResources").show();
        },
        Init: function () {
            GlobalizationDataDisplay.CurrentMode = 'FULL';
            GlobalizationDataDisplay.CurrentPage = 1;
        },
        ChangeMode: function (mode) {
            if (mode.toLowerCase() == 'native') {
                GlobalizationDataDisplay.CurrentMode = 'NATIVE';
                GlobalizationDataDisplay.CurrentPage = 1;
            }
            else if (mode.toLowerCase() == 'full') {
                GlobalizationDataDisplay.CurrentMode = 'FULL';
                GlobalizationDataDisplay.CurrentPage = 1;
            }
            this.GetResources();
        }
    }
};



var CreateDropdownGroups = function ($ddl, startIndex) {

    var inGroup = false,
		newMarkup = '',
		options = $ddl.find('option');
    var i;
    for (i = 0; i < startIndex; i += 1) {
        newMarkup += $(options[i]).outerHTML();
    }

    for (i = startIndex; i < options.length; i += 1) {
        if (!$(options[i]).attr('value')) {
            if (inGroup) {
                newMarkup += '</optgroup>';
            }
            newMarkup += '<optgroup label="' + $(options[i]).text() + '">';
            inGroup = true;
        } else {
            newMarkup += $(options[i]).outerHTML();
        }
    }

    if (inGroup) {
        newMarkup += '</optgroup>';
    }

    $ddl.html(newMarkup);

};


/* WidgetUI.js functions Source */
/*Templar Functions*/
var WidgetContainer = {
    Actions: {
        EventList: new Object(),
        AddListener: function (eventName, observer) {
            if (this.EventList[eventName] === undefined) {
                this.EventList[eventName] = new Array();
            }
            if (jQuery.inArray(observer, this.EventList[eventName]) < 0) {
                this.EventList[eventName].push(observer);
            }
        },
        RemoveListener: function (eventName, observer) {
            if (this.EventList[eventName] !== undefined) {
                var index = jQuery.inArray(observer, this.EventList[eventName]);
                if (index >= 0) {
                    var temp = new Array();
                    for (var i in this.EventList[eventName]) {
                        if (i != index) {
                            temp.push(this.EventList[eventName][i]);
                        }
                    }
                    this.EventList[eventName] = temp;
                }
            }
        },
        RaiseEvent: function (e, source, args) {
            if (this.EventList[e] !== undefined) {
                var event = jQuery.Event(e);
                event.source = source;
                event.args = args;
                $.each(this.EventList[e], function () { $('#' + this).trigger(event); });
            }
        }
    }
};

var TemplarContext = {
    Version: null,
    SiteId: null,
    ServicePath: null,
    Mode: 'design',
    CultureInfo: {
        ResourceManager: {
            GetResourceString: function (keys) {
                var objResult = null;
                var callbackFn = null;
                if (arguments.length > 1)
                    callbackFn = arguments[1];
                try {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json",
                        url: TemplarContext.ServicePath + "/GetResourceString/" + TemplarContext.SiteId + "/" + TemplarContext.CultureInfo.Culture + "/" + TemplarContext.Mode,
                        data: Sys.Serialization.JavaScriptSerializer.serialize(keys),
                        cache: false,
                        processData: false,
                        async: (callbackFn == null ? false : true),
                        success: function (result) {
                            objResult = new Object();
                            for (var i = 0; i < keys.length; i = i + 1) {
                                objResult[keys[i]] = result[i] || '';
                            }
                            if (typeof (callbackFn) == 'function')
                                callbackFn(objResult);
                        },
                        error: function () {
                            if (typeof (callbackFn) == 'function')
                                callbackFn(objResult);
                        }
                    });
                    if (typeof (callbackFn) != 'function')
                        return objResult;
                }
                catch (e) {
                    return objResult;
                }
                return objResult;
            }
        }
    },
    Session: null,
    EventBroker: null,
    Init: function (args) {
        var session = function () {
            this.Add = function (key, value) {
                var retval = false;
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    url: TemplarContext.ServicePath + "/Session/AddItem/" + TemplarContext.SiteId + "/" + key,
                    data: Sys.Serialization.JavaScriptSerializer.serialize(value),
                    cache: false,
                    processData: false,
                    async: false,
                    success: function (result) {
                        retval = result;
                    },
                    error: function () {
                        retval = false;
                    }
                });
                return retval;
            };
            this.Get = function (key) {
                var objResult = null;
                $.ajax({
                    type: "GET",
                    contentType: "application/json",
                    url: TemplarContext.ServicePath + "/Session/GetItem/" + TemplarContext.SiteId + "/" + key,
                    cache: false,
                    async: false,
                    success: function (result) {
                        objResult = result;
                    },
                    error: function () {
                        objResult = null;
                    }
                });
                return objResult;
            };
            this.Remove = function (key) {
                var retval = false;
                $.ajax({
                    type: "GET",
                    contentType: "application/json",
                    url: TemplarContext.ServicePath + "/Session/RemoveItem/" + TemplarContext.SiteId + "/" + key,
                    data: null,
                    cache: false,
                    async: false,
                    processData: false,
                    success: function (result) {
                        retval = result;
                    },
                    error: function () {
                        retval = false;
                    }
                });
                return retval;
            };
        };
        var eventBroker = function (map) {
            var eventMapping = $.parseJSON(map);
            this.RaiseEvent = function(source, eventName, eventArgs, isBroadCast) {
                if (isBroadCast == undefined || typeof(isBroadCast) !== "boolean") {
                    isBroadCast = false;
                }

                var eventMap = eventMapping;
                if (typeof(source) === 'string') {
                    if (source.startsWith('#') === false) {
                        source = '#' + source;
                    }
                }

                var parent = $(source).closest('div[data-instanceId]');
                var srcEvent = { };
                srcEvent.IsBroadcast = isBroadCast;
                srcEvent.EventName = eventName;
                srcEvent.source = parent;
                srcEvent.args = eventArgs;
                var srcId = parseInt(parent.attr('data-instanceId'));

                if (isBroadCast) {
                    $('div[data-instanceId]').each(function() {
                        if (parseInt($(this).attr('data-instanceId')) != srcId) {
                            var bcEvent = $.extend(true, { }, srcEvent);
                            $(this).children(':first').trigger("Templar.Events.Broadcast", bcEvent);
                        }
                    });
                } else {
                    $.each(eventMap, function(i, item) {
                        var cloneEvent = $.extend(true, { }, srcEvent);
                        if (item.SW.EN.toLowerCase() !== cloneEvent.EventName.toLowerCase()) return;
                        var destParent = $('div[data-instanceId=' + item.DW.ID + ']');
                        if (item.SW.ID == srcId) {
                            var transform = item.DW.T.EI;
                            var newArgs = { };
                            if ($.isPlainObject(eventArgs)) {
                                $.each(eventArgs, function(key, value) {
                                    var found = false;
                                    for (var x = 0; x < transform.length; x++) {
                                        /*Event Name is Case Insensitive comparision*/
                                        if (transform[x].N.toLowerCase() === key.toLowerCase()) {
                                            newArgs[transform[x].MK] = value;
                                            found = true;
                                            break;
                                        }
                                    }
                                    if (found === false)
                                        newArgs[key] = value;
                                });
                                cloneEvent.args = newArgs;
                            }

                            if ($.isFunction(eval('window.' + item.DW.T.NEN))) {
                                eval(item.DW.T.NEN + '(cloneEvent)');
                            } else {
                                destParent.children(':first').trigger(item.DW.T.NEN, cloneEvent);
                            }
                        }
                    });
                }
            };
        };
        this.Version = args["Version"];
        this.SiteId = args["SiteId"];
        this.ServicePath = args["ServicePath"];
        $.extend(this.CultureInfo, this.CultureInfo, args["Culture"]);
        this.Mode = args["Mode"];
        this.Session = new session();
        this.EventBroker = new eventBroker(args["EventMap"]);
    }
};