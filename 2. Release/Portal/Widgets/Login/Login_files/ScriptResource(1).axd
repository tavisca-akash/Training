var EventMapping =
{
    EventType: null,
    PageId: null,
    SenderWidget: null,
    ListnerWidget: null,
    _senderAnchor: null,
    _listenerAnchor: null,

    Init: function () {
        if (this._senderAnchor != null) {
            $(this._senderAnchor).children('div').attr('class', 'x-tool x-tool-down');
            $(this._senderAnchor).closest('.MyWidget').css("border", "");
        }
        if (this._listenerAnchor != null) {
            $(this._listenerAnchor).children('div').attr('class', 'x-tool x-tool-down');
            $(this._listenerAnchor).closest('.MyWidget').css("border", "");
        }
        this._senderAnchor = null;
        this._listenerAnchor = null;
        this.SenderWidget = null;
        this.ListnerWidget = null;

        $('#sortable11').empty();
        $('#sortable21').empty();
        $('#divCurrentEventMapping div:first > ul').empty();

        this.UI.Reset();
    },
    Register: function (control) {
        var anchor = $(control);

        if (this._senderAnchor == null || (this._senderAnchor != null && this._listenerAnchor != null)) {
            this.Init();
            anchor.children('div').attr('class', 'x-tool x-tool-up');
            anchor.closest('.MyWidget').css("border", "solid 1px red");

            this._senderAnchor = control;
            this.SenderWidget = Sys.Serialization.JavaScriptSerializer.deserialize(anchor.next(':input[type="hidden"]:first').val());
        }
        else {
            anchor.children('div').attr('class', 'x-tool x-tool-up');
            anchor.closest('.MyWidget').css("border", "solid 1px green");
            this._listenerAnchor = control;
            this.ListnerWidget = Sys.Serialization.JavaScriptSerializer.deserialize(anchor.next(':input[type="hidden"]:first').val());
            if (this._senderAnchor === this._listenerAnchor)
                this.Init();
            else {
                $.ajax({
                    type: "GET",
                    contentType: "application/json",
                    url: TemplarFx.TemplarServicePath + "/GetExistingEventMappings/" + EventMapping.PageId + "/" + EventMapping.SenderWidget.ID + "/" + EventMapping.ListnerWidget.ID,
                    data: null,
                    cache: false,
                    dataType: 'json',
                    processData: false,
                    success:
                           function (result) {
                               if (result != null) {
                                   var et = "Server";
                                   for (var i = 0; i < result.length; i++) {
                                       var info = Sys.Serialization.JavaScriptSerializer.serialize(result[i]);
                                       et = (result[i].T == 0 ? "Server" : "Client");
                                       $('#divCurrentEventMapping div:first > ul').append(
					                    String.format('<li class="ui-state-default" id="{0}"><input type="hidden" value=\'{1}\'/><a href="#" onclick="javascript:$(this).parent().remove();" style="float:right;">remove</a><span style="float:left;"> {2} </span><span class="ui-icon ui-icon ui-icon-arrowthick-2-e-w" style="float:left;"></span><span style="float:left;"> {3} </span></li>', result[i].SW.EN + result[i].DW.T.NEN + result[i].T, info, et + " : " + result[i].SW.EN, result[i].DW.T.NEN));

                                   }
                               }
                           },
                    error:
                               function (XMLHttpRequest, textStatus, errorThrown) {
                                   TemplarFx.ShowMsg('Error Occurred', "Failed to fetch previous event mapping, Please try reloading page", 'Error');
                               }
                });

                $.blockUI({
                    message: $('#EventMappingContainer'),
                    centerY: false,

                    css: {
                        top: '10%',
                        width: '670px',
                        left: '25%',
                        border: 'none',
                        backgroundColor: '#000',
                        '-webkit-border-radius': '10px',
                        '-moz-border-radius': '10px',
                        color: '#fff', cursor: 'pointer'
                    }
                });

                $('.blockOverlay').attr('title', 'Click to Close PopUp').click(function () { $.unblockUI(); EventMapping.Init(); });
                this.UI.EventMappingWindow();
            }

        }
    },
    UI:
    {
        sourceEvent: null,
        listenerEvent: null,
        AddItem: function (control, value) {
            var template = '<li class="ui-helper-reset ui-state-highlight ui-corner-all"  key="' + value + '" cd="true" title="Custom Data" style="overflow:hidden;">' +
					            '<span style="padding-left: 20px;">' + value + '</span>' +
					        '</li>';
            $(control).append(template);
            this.InitSourceEventInfoList();
        },
        CreateSortable: function (control) {
            $(control).sortable('destroy').sortable(
				    {
				        cursor: 'move',
				        dropOnEmpty: true,
				        forcePlaceholderSize: true,
				        opacity: 0.6,
				        placeholder: 'ui-state-highlight',
				        revert: false,
				        receive: function (event, ui) {
				            var varEvent = Sys.Serialization.JavaScriptSerializer.deserialize(ui.item.children('input').val());
				            if ($(this).attr("id") == 'sortable12') {
				                EventMapping.UI.sourceEvent = varEvent;
				            }
				            if ($(this).attr("id") == 'sortable22') {
				                EventMapping.UI.listenerEvent = varEvent;
				            }
				            EventMapping.UI.ShowEventInfo();
				            $(this).sortable('disable');
				        }
				    });

        },
        ShowEventList: function (control, eventList) {
            $(control).empty();
            var typeVal = $('#eventType :radio:checked').val()
            for (var i = 0; i < eventList.length; i++) {
                if (typeVal == eventList[i].T) {
                    var info = Sys.Serialization.JavaScriptSerializer.serialize(eventList[i]);
                    var template = $('<li class="ui-helper-reset ui-state-default ui-corner-all" >' +
									    '<span style="padding-left: 20px;"></span>' +
									    '<input type="hidden" value="" />' +
									    '</li>');
                    template.children('span').text(eventList[i].N);
                    template.children('input').val(info);
                    $(control).append(template);
                }

            }
        },
        ShowEventInfo: function () {
            if (this.sourceEvent != null && this.listenerEvent != null) {
                $('#divTransform').show();
                $('#divEventList').hide();
            }
            else {
                return;
            }
            var sei = this.sourceEvent;
            for (var i = 0; i < sei.EI.length; i++) {

                var template = '<li class="ui-helper-reset ui-state-default ui-corner-all"  key="' + sei.EI[i].K + '" cd="false" >' +
									    '<span style="padding-left: 20px;" title="' + sei.EI[i].D + '">' + sei.EI[i].K + '</span>' +
									    '</li>';
                $('#sourceEventInfoList').append(template);
            }
            var lei = this.listenerEvent;
            for (var i = 0; i < lei.EI.length; i++) {

                var template = '<li class="ui-state-default ui-corner-all" style="display: block !important; table-layout: fixed; width: auto;height: auto;"  key="' + lei.EI[i].K + '" defaultValue="' + lei.EI[i].V + '">' +
										    '<a href="javascript:void(0)" title="' + lei.EI[i].D + '">' + lei.EI[i].K + ' </a>' +
										    '<div style="clear: both;"></div>' +
										    '<div class="ui-widget-content  ui-corner-all" >' +
											    '<ul class="sortable"></ul>' +
										    '</div>' +
									    '</li>';

                $('#listenerEventInfoList').append(template);
            }

            this.InitialiaseTransform();

        },
        EventMappingWindow: function () {
            this.ShowEventList($('#sortable11'), EventMapping.SenderWidget.RE);
            this.ShowEventList($('#sortable21'), EventMapping.ListnerWidget.UE);

            $("#sortable11 li").draggable({
                connectToSortable: 'ul.sortable[id="sortable12"]',
                addClasses: false,
                cursor: 'move',
                cursorAt: { left: 5, top: 5 },
                helper: 'clone',
                revert: false
            })


            $("#sortable21 li").draggable({
                connectToSortable: 'ul.sortable[id="sortable22"]',
                addClasses: false,
                cursor: 'move',
                cursorAt: { left: 5, top: 5 },
                helper: 'clone',
                revert: false
            })

            this.CreateSortable('#sortable12');
            this.CreateSortable('#sortable22');

        },
        Reset: function () {
            $('#divTransform').hide();
            $('#divEventList').show();

            $('#sortable12').empty();
            $('#sortable22').empty();
            $('#sortable12').sortable('enable');
            $('#sortable22').sortable('enable');

            this.sourceEvent = null;
            this.listenerEvent = null;
            $('#sourceEventInfoList').empty(); ;
            $('#listenerEventInfoList').empty();
            if (EventMapping.SenderWidget != null && EventMapping.ListnerWidget != null) {
                this.EventMappingWindow();
            }

        },
        InitialiaseTransform: function () {
            this.InitSourceEventInfoList();
            this.InitListenerEventInfoList($("#listenerEventInfoList li div ul"));
        },
        InitSourceEventInfoList: function () {
            $("#sourceEventInfoList li").draggable({
                connectToSortable: '#listenerEventInfoList li ul',
                addClasses: false,
                cursor: 'move',
                cursorAt: { left: 5, top: 5 },
                helper: 'clone',
                revert: false
            });
        },
        InitListenerEventInfoList: function (control) {
            $(control).sortable(
				    {
				        cursor: 'move',
				        dropOnEmpty: true,
				        forcePlaceholderSize: true,
				        opacity: 0.6,
				        placeholder: 'ui-state-highlight',
				        revert: false,
				        update: function (event, ui) {
				            $(this).parent().parent().html('<a id="test" href="#" onclick="javascript:EventMapping.UI.ReCreateParent(this);" style="float:right;">remove</a>' + $(this).parent().parent().html());
				        }
				    });
        },
        ReCreateParent: function (control) {
            $(control).parent().find('div ul li').remove();
            this.InitListenerEventInfoList($(control).parent().find('div ul'));
            $(control).remove();
        },
        OnAddMapping: function () {
            var eventInfo = '';
            $('#listenerEventInfoList > li').each(function () {
                var mappedKey = $(this).attr('key');
                var defaultValue = $(this).attr('defaultValue');
                var attribute = $(this).find('div ul li');
                var name = null;
                var cdFlag = false;
                if (attribute.length == 0 || attribute == undefined || attribute == null) {
                    name = defaultValue;
                    cdFlag = true;
                }
                else {
                    name = attribute.attr('key');
                    cdFlag = attribute.attr('cd');
                }
                eventInfo = String.format("{{\"N\":\"{0}\",\"MK\":\"{1}\",\"CD\":{2}}},{3}", name, mappedKey, cdFlag, eventInfo);

            });
            eventInfo = String.format("[{0}]", eventInfo.substr(0, eventInfo.length - 1));
            var em = String.format("{{\"T\":{0},\"SW\":{{\"ID\":{1},\"EN\":\"{2}\"}},\"DW\":{{\"ID\":{3},\"T\":{{\"NEN\":\"{4}\",\"EI\":{5}}}}}}}",
            this.sourceEvent.T, EventMapping.SenderWidget.ID, this.sourceEvent.N, EventMapping.ListnerWidget.ID, this.listenerEvent.N, eventInfo);


            if ($('#divCurrentEventMapping div:first > ul li[id="' + this.sourceEvent.N + this.listenerEvent.N + this.sourceEvent.T + '"]').length == 0) {
                var et = (this.sourceEvent.T == 0 ? "Server" : "Client");
                $('#divCurrentEventMapping div:first > ul').append(
					    String.format('<li class="ui-state-default" id="{0}"><input type="hidden" value=\'{1}\'/><a href="#" onclick="javascript:$(this).parent().remove();" style="float:right;">remove</a><span style="float:left;"> {2} </span><span class="ui-icon ui-icon ui-icon-arrowthick-2-e-w" style="float:left;"></span><span style="float:left;"> {3} </span></li>', this.sourceEvent.N + this.listenerEvent.N + this.sourceEvent.T, em, et + " : " + this.sourceEvent.N, this.listenerEvent.N));
            }
            else {
                TemplarFx.ShowMsg('Error', 'Event mapping already exists', 'Error');
            }

            this.Reset();
        }
    },
    SaveMapping: function (hfControl) {
        var mappingCollection = '';
        $('#divCurrentEventMapping div:first > ul li input[type="hidden"]').each(function () {
            mappingCollection = mappingCollection + ',' + $(this).val();

        });
        if (mappingCollection.length > 0)
            mappingCollection = mappingCollection.substr(1, mappingCollection.length);
        var tempTotal = "{\"SI\":" + EventMapping.SenderWidget.ID + ",\"DI\":" + EventMapping.ListnerWidget.ID + ",\"EM\":[" + mappingCollection + "]}";
        $(hfControl).val(tempTotal);
        return true;
    }
}






        
   
