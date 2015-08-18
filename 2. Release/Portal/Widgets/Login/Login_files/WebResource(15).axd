/*
* @name : PageData
*/

(function ($) {

	$.fn.extend({

		PageData: function () {
			var args = arguments;
			return this.each(function () {
				if ($(this).data('Intialize') === undefined || args.length !== 0) {
					new _PageData(this, args);
				}
			});
		}
	});

	var _PageData = function (rootElement, options) {

		var rootContainer = $(rootElement), myDialog;
		var methods = {
			Populate: function (jsonData) {
				PopulateData(jsonData);
			},
			GetData: function (elementId) {
				RestructureData(elementId);
			}
		};

		var settings = {

			'DialogTitle_Add': 'Add',
			'DialogTitle_Edit': 'Edit',
			'Label_Key': 'Key',
			'Label_Value': 'Value',
			'CustomKeyValidator': function (key) { return true; },
			'KeyValidationFailedMsg': 'Check the key entered'
		};

		/*
		* To Intialize Basic Structure of the page. 
		*/


		var Init = function (cur) {
			$(rootContainer).data('Intialize', true);
			$(rootContainer).data('keyValueMapping', []);
			$(rootContainer).data('rowCounter', 0);
			$(rootContainer).data('currentKey', null);
			$(rootContainer).data('tempref', null);
			rootContainer.addClass('RootIdProvider');
			var markupForTable = "<div id='tablediv' class='DivTableDesign TableDivId ui-widget ui-widget-content ui-corner-all'>" +
									"<table id='dataTable' class='TableDesign' cellpadding='2' cellspacing='2'><thead><tr class='TableRowDesign ui-widget-header ui-corner-all' style='height:15px;'><th class = 'Col1' >" + settings.Label_Key + "<span class='Sort'><span title='Sort ascending' class ='SortAsc ui-icon ui-icon-carat-1-n'></span><span title='Sort Descending' class ='SortDsc ui-icon ui-icon-carat-1-s'></span></span></th><th class = 'Col2'>" + settings.Label_Value + "</th><th class = 'Col3'>Actions</th></tr></thead><tbody></tbody></table>" +
									"<div class='divAddRowBtn ui-state-default ui-corner-all'><ul><li id='btnAddRow'><span style='padding:2px;'>Add</span></li></ul></div>" +
									"<div class='clear'></div>" +
								 "</div>";
			var markupForDialogContainer = "<div id='dialogContents' class='NewStyle'>" +
												"<div>" +
													"<div>" +
														"<span id='keySpan' class='floatLeft' style='width:100%;background:none repeat scroll 0 0 #ECF3F7;border-bottom:1px solid #D0DFF4;color:#333333;font-weight:bold;'><label>" + settings.Label_Key + ":</label></span>" +
														"<div class='spacer5'></div>" +
														"<span id='keyInputSpan' class='floatLeft clearLeft' ><input id='keyDetail' type='text'style='width:424px;' /></span>" +
													"</div>" +
													"<div id='duplicateKeyMessage' class='ErrorMessage' ><label >*" + settings.Lable_Key + " Already Exists</label></div>" +
													"<div id='emptyKeyMessage'class='ErrorMessage' ><label >*" + settings.Lable_Key + " Field is mandatory</label></div>" +
													"<div id='customKeyMessage'class='ErrorMessage' ><label >* " + settings.KeyValidationFailedMsg + "</label></div>" +
													"<div class='spacer10'></div>" +
													"<div>" +
														"<span id='valueSpan' class='floatLeft' style='width:100%;background:none repeat scroll 0 0 #ECF3F7;border-bottom:1px solid #D0DFF4;color:#333333;font-weight:bold;'><label>" + settings.Label_Value + ":</label></span>" +
														"<div class='spacer5'></div>" +
														"<span id='valueInputSpan' class='floatLeft clearLeft' >" +
															"<textarea id='valueDetail' name='S1' rows='2'style='width:424px' ></textarea>" +
														"</span>" +
													"</div>" +
													"<div align='center' style='margin-top: 17px;float:right;'>" +
														"<span id='spanYesBtn' class='ui-state-default dialogBtn' style='width:85px;cursor:pointer;'>" +
															"<span id='btnYes' class='BtnDesign'>Save</span>" +
														"</span>" +
														"<span id='spanNoBtn' class='ui-state-default dialogBtn' style='width:85px;cursor:pointer;margin-left:5px;'>" +
															"<span id='btnNo' class='BtnDesign'>Cancel</span>" +
														"</span>" +
													"</div>" +
												"</div>" +
											"</div>";
			rootContainer.append(markupForTable);
			rootContainer.append(markupForDialogContainer);
		};

		/*
		* Bind elements to specific events.
		*/

		var Bindings = function () {
			/*
			*  Binding for Add Dialog
			*/

			myDialog = $('#dialogContents', rootContainer).dialog({
				autoOpen: false,
				draggable: true,
				modal: false,
				width: 450,
				disabled: false,
				position: 'center',
				resizable: true,
				close: function (event, ui) { $("table tbody tr", rootContainer).removeClass('Highlight'); }

			});
			$(myDialog).parent().appendTo(rootContainer);

			/*
			* Binding for sorting images
			*/

			$(".SortDsc", rootContainer).click(function () {
			    if (!$(this).hasClass('key-sorted')) {
			        $(this).addClass("key-sorted").addClass('ui-icon-triangle-1-s').removeClass('ui-icon-carat-1-s');
			        $('.SortAsc', rootContainer).removeClass('key-sorted').removeClass('ui-icon-triangle-1-n').addClass('ui-icon-carat-1-n');
			        rootContainer = $(this).closest('.RootIdProvider');
			        Sort(false, rootContainer);
			    }
			});

			$(".SortAsc", rootContainer).click(function () {
			    if (!$(this).hasClass("key-sorted")) {
			        $(this).addClass("key-sorted").addClass('ui-icon-triangle-1-n').removeClass('ui-icon-carat-1-n');
			        $(".SortDsc", rootContainer).removeClass("key-sorted").removeClass('ui-icon-triangle-1-s').addClass('ui-icon-carat-1-s');
			        rootContainer = $(this).closest('.RootIdProvider');
			        Sort(true, rootContainer);
			    }
			});

			$(".SortAsc", rootContainer).mouseenter(function () {
			    if (!$(this).hasClass("key-sorted")) { $(this).addClass("Sort-hover"); }
			}).mouseleave(function () { $(this).removeClass("Sort-hover"); });

			$(".SortDsc", rootContainer).mouseenter(function () {
			    if (!$(this).hasClass("key-sorted")) { $(this).addClass("Sort-hover"); }
			}).mouseleave(function () { $(this).removeClass("Sort-hover"); });


			$(".KeyInputSpanDesign input", rootContainer).keydown(function (event) {
				keyStatus = "KeyChanged";
			});

			/*
			* Confirming Dialog Action
			*/

			$('#spanYesBtn', rootContainer).click(function () {

				rootContainer = $(this).closest('.RootIdProvider');
				myDialog = $('#dialogContents', rootContainer);

				var title = myDialog.dialog("option", "title");
				if (title === settings['DialogTitle_Add']) {
					Add(rootContainer);
				}
				else {
					Edit(rootContainer);
				}
			});


			/*
			* Cancelling Dialog Action
			*/

			$('#spanNoBtn', rootContainer).click(function myfunction() {
				rootContainer = $(this).closest('.RootIdProvider');
				var title = myDialog.dialog("option", "title");
				$('#dialogContents', rootContainer).dialog("close");

			});



			/*
			* Adding new row 
			*/


			$('#btnAddRow', rootContainer).click(function () {

				rootContainer = $(this).closest('.RootIdProvider');
				myDialog = $('#dialogContents', rootContainer);
				myDialog.dialog("option", "title", settings['DialogTitle_Add']);
				myDialog.dialog('open');
				$(".ErrorMessage").hide();
				$('#keyDetail', rootContainer).removeAttr('disabled').val("").focus();
				$('#valueDetail', rootContainer).val("");
				return false;
			});


		};


		/*
		* Function to populate table when system is refreshed
		*/

		var PopulateTable = function (rootContainer) {
			$(".TableDivId tbody", rootContainer).empty();
			rootContainer.data('rowCounter', 0);
			$.each(rootContainer.data('keyValueMapping'), function () {
				var tempId = this.id
				var btnEdit = '<ul style="float: left;margin-left:5px;"><li id="btnEdit' + tempId + '" onclick="Editing(this);" class="ui-icon ui-icon-pencil" title="Edit"></li></ul>';
				var btnDelete = '<ul style="float: left;margin-left:10px;"><li id="btnDelete' + tempId + '" onclick="DeleteThisRow(this)" class="ui-icon ui-icon-trash" title="Delete"></li></ul>';
				if (this.dd) {
					btnDelete = '';
				}
				var html = '<tr class = "TableRowDesign RowTopBottomMargin"><td class="Col1"><div  id="key' + tempId + '"class="col1"></div></td><td class="Col2">&nbsp;<div id="value' + tempId + '"class = "Col2"></div></td><td class="Col3" align="center" valign="middle">' + btnEdit + btnDelete + '</td></tr>';
				$('.TableDivId table:last', rootContainer).append(html);
				$("#key" + tempId, rootContainer).text(rootContainer.data('keyValueMapping')[tempId].k);
				if (rootContainer.data('keyValueMapping')[tempId].v.length > 50) {
					$("#value" + tempId, rootContainer).addClass('value1');
				}
				if (rootContainer.data('keyValueMapping')[tempId].k.length > 25) {
					$("#key" + tempId, rootContainer).addClass('value2');
				}
				$("#value" + tempId, rootContainer).text(rootContainer.data('keyValueMapping')[tempId].v);
				$("#btnEdit" + tempId, rootContainer).data("id", tempId);
				if (!this.dd) {
					$("#btnDelete" + tempId, rootContainer).data("id", tempId);
				}
			});
			rootContainer.data('rowCounter', rootContainer.data('keyValueMapping').length);

		};

		/*
		* Function to open Edit Dialog
		*/
		Editing = function (editButtonReference) {
			rootContainer = $(editButtonReference).closest('.RootIdProvider');
			$(editButtonReference).closest('tr').addClass('Highlight');
			myDialog = $('#dialogContents', rootContainer);
			myDialog.dialog("option", "title", settings['DialogTitle_Edit']);
			myDialog.dialog('open');

			var keyToEdit = myDialog.find("#keyDetail");
			var valueToEdit = myDialog.find("#valueDetail");
			keyToEdit.focus();
			var id = $(editButtonReference).data("id");
			rootContainer.data('currentKey', rootContainer.data('keyValueMapping')[id].k);
			rootContainer.data('tempref', editButtonReference);
			keyToEdit.val(rootContainer.data('keyValueMapping')[id].k);
			valueToEdit.val(rootContainer.data('keyValueMapping')[id].v);

			if (rootContainer.data('keyValueMapping')[id].ked) {
				keyToEdit.attr('disabled', 'disabled');
			} else {
				keyToEdit.removeAttr('disabled');
			}

			$(".ErrorMessage").hide();
		};

		/*
		*Function to Update new values to table and object after editing
		*/
		var UpdateNewValues = function (editButtonReference) {
			var checkBit = true;
			rootContainer = $(editButtonReference).closest('.RootIdProvider');
			var tempkey = $('#keyDetail', rootContainer).val();
			var tempvalue = $('#valueDetail', rootContainer).val();
			var id = $(editButtonReference).data("id");
			rootContainer.data('keyValueMapping')[id].k = tempkey;
			rootContainer.data('keyValueMapping')[id].v = tempvalue;
			if (rootContainer.data('keyValueMapping')[id].v.length > 50) {
				$("#value" + id, rootContainer).addClass('value1');
				checkBit = false;
			} else {
				$("#value" + id, rootContainer).removeClass('value1');
			}
			if (rootContainer.data('keyValueMapping')[id].k.length > 25) {
				$("#key" + id, rootContainer).addClass('value2');
				checkBit = false;
			}
			else {
				$("#key" + id, rootContainer).removeClass('value2');

			}
			if (checkBit === false) {
				$("#value" + id, rootContainer).closest('tr').addClass('CustomRow');
			}
			else {
				$("#value" + id, rootContainer).closest('tr').removeClass('CustomRow');
			}

			$("#key" + id, rootContainer).text(tempkey);
			$("#value" + id, rootContainer).text(tempvalue);

			$('#dialogContents', rootContainer).dialog('close');
		};

		/*
		* Function to validate entry to key value pair
		*/

		var KeyValidator = function (field, rootContainer) {
			var temp = $(field).val();
			var statusFlag = 1;

			//check empty keys
			if (temp === "") {
				statusFlag = 2;
			}
			else {
				// check for duplicated keys . . .
				var existingValues = rootContainer.data('keyValueMapping');
				$.each(existingValues, function (index) {
					if (existingValues[index]) {
						if (temp.toLowerCase() === existingValues[index].k.toLowerCase()) {
							statusFlag = 3;
						}
					}
				});
			}

			return statusFlag;
		};

		/*
		*  Function to handle sorting operations
		*/
		var Sort = function (ascOrder, rootContainer) {
			var inverseSetter = (ascOrder === true ? 1 : -1);
			rootContainer.data('keyValueMapping').sort(function (a, b) {
				return (a.k > b.k ? 1 : (a.k < b.k ? -1 : 0)) * inverseSetter;
			});
			var counter = 0;
			var tempArray = [];
			$.each(rootContainer.data('keyValueMapping'), function() {
				if (this.k !== undefined) {
					this.id = counter;
					tempArray[counter] = this;
					counter++;
				}

			});
			rootContainer.data('keyValueMapping', []);
			rootContainer.data('keyValueMapping', tempArray);

			PopulateTable(rootContainer);

		};


		/*
		* Function to add new row
		*/
		var AddNewRow = function (key, value, rootContainer) {
			var btnEdit = '<ul style="float: left;margin-left:5px;"><li id="btnEdit' + rootContainer.data('rowCounter') + '" onclick="Editing(this);" class="ui-icon ui-icon-pencil"></li></ul>';
			var btnDelete = '<ul style="float: left;margin-left:10px;"><li id="btnDelete' + rootContainer.data('rowCounter') + '" onclick="DeleteThisRow(this)" class="ui-icon ui-icon-trash"></li></ul>';
			var html = '<tr class="TableRowDesign  RowTopBottomMargin"><td class="Col1"><div id="key' + rootContainer.data('rowCounter') + '"class="col1"></div></td><td class="Col2">&nbsp;<div id="value' + rootContainer.data('rowCounter') + '"class = "Col2"></div></td><td class="Col3" align="center" valign="middle">' + btnEdit + btnDelete + '</td></tr>';
			var temp = {};
			temp.k = key;
			temp.v = value;
			temp.dd = false;
			temp.ked = false;
			temp.id = rootContainer.data('rowCounter');
			rootContainer.data('keyValueMapping')[temp.id] = temp;
			$('.TableDivId table:last', rootContainer).append(html);
			if (value.length > 50) {
				$("#value" + rootContainer.data('rowCounter'), rootContainer).addClass('value1');
				$("#value" + rootContainer.data('rowCounter'), rootContainer).closest('tr').addClass('CustomRow');
			}
			if (key.length > 25) {
				$("#key" + rootContainer.data('rowCounter'), rootContainer).addClass('value2');
				$("#key" + rootContainer.data('rowCounter'), rootContainer).closest('tr').addClass('CustomRow');
			}
			$("#key" + rootContainer.data('rowCounter'), rootContainer).text(key);
			$("#value" + rootContainer.data('rowCounter'), rootContainer).text(value);
			$("#btnEdit" + rootContainer.data('rowCounter'), rootContainer).data("id", rootContainer.data('rowCounter'));
			$("#btnDelete" + rootContainer.data('rowCounter'), rootContainer).data("id", rootContainer.data('rowCounter'));
			rootContainer.data('rowCounter', rootContainer.data('rowCounter') + 1);
			$('#dialogContents', rootContainer).dialog("close");

		};
		DeleteThisRow = function (element) {
			rootContainer = $(element).closest('.RootIdProvider');
			$(element, rootContainer).closest('tr').addClass('Highlight');
			TemplarFx.Confirm('Confirm Deletion', 'Are you sure you want to delete this key ?', element, function (approved) {
				if (approved) {
					var tempId = $(element).data('id');
					delete rootContainer.data('keyValueMapping')[tempId];
					$(element, rootContainer).closest('tr').remove();
				}
				$("table tbody tr", rootContainer).removeClass('Highlight');
			});
		}

		var Edit = function (rootContainer) {

			var result;
			var customResult = true;
			var editKey = $("#keyDetail", rootContainer).val();
			if (editKey === rootContainer.data('currentKey')) {
				result = 1;
			}
			else {
				result = KeyValidator($("#keyDetail", rootContainer), rootContainer);

				if (typeof (settings['CustomKeyValidator']) == 'function') {
					customResult = settings['CustomKeyValidator'](editKey);
				}
			}

			$(".ErrorMessage", rootContainer).hide();
			if (customResult === false) {
				$("#customKeyMessage", rootContainer).show();
			}
			else if (result > 1) {
				if (result === 2) {
					$("#emptyKeyMessage", rootContainer).show();
				} else if (result === 3) {
					$("#duplicateKeyMessage", rootContainer).show();
				}
			}
			else if (result === 1) {
				UpdateNewValues(rootContainer.data('tempref'));
			}
		};

		var Add = function (rootContainer) {

			$(".ErrorMessage", rootContainer).hide();

			var k = $('#keyDetail', rootContainer).val();
			var v = $('#valueDetail', rootContainer).val();
			var customResult = true;
			var result = KeyValidator($('#keyDetail', rootContainer), rootContainer);
			if (typeof (settings['CustomKeyValidator']) == 'function') {
				customResult = settings['CustomKeyValidator'](k);
			}
			if (customResult === false) {
				$("#customKeyMessage", rootContainer).show();
			}
			else if (result > 1) {
				if (result === 2) {
					$("#emptyKeyMessage", rootContainer).show();
				} else if (result === 3) {
					$("#duplicateKeyMessage", rootContainer).show();
				}
			}
			else if (result === 1) {
				AddNewRow(k, v, rootContainer);
			}
		};

		var PopulateData = function (jsonData) {
			if (!rootContainer.data('Intialize')) {
				Init(rootElement);
				Bindings();
			}
			else {
				rootContainer.data('keyValueMapping', []);
			}

			var keyValuePair = (typeof jsonData) === 'string' ? eval('(' + jsonData + ')') : jsonData;
			for (var i = 0; i < keyValuePair.length; i++) {
				var temp = {};
				temp.k = keyValuePair[i].K;
				temp.v = keyValuePair[i].V;
				temp.dd = keyValuePair[i].DD;
				temp.ked = keyValuePair[i].KED;
				temp.id = i;
				rootContainer.data('keyValueMapping')[temp.id] = temp;
			}

			PopulateTable(rootContainer);
		};
		var RestructureData = function (elementId) {
			var returnArray = [];
			$.each(rootContainer.data('keyValueMapping'), function () {
				if (this.k !== undefined) {
					var temp = {};
					temp.K = this.k;
					temp.V = this.v;
					temp.DD = this.dd;
					temp.KED = this.ked;
					returnArray.push(temp);
				}

			})
			var jsonString = Sys.Serialization.JavaScriptSerializer.serialize(returnArray);
			$('#' + elementId).val(jsonString);

		}

		if (methods[options[0]]) {
			return rootContainer.each(function () {
				methods[options[0]].apply(rootContainer, Array.prototype.slice.call(options, 1));
			});
		}
		else if (typeof options === 'object' || !options) {
			if (rootContainer.data('Intialize') === true) {
				var tempStorage = [];
				tempStorage = rootContainer.data('keyValueMapping');
				rootContainer.empty();
				$.extend(settings, options[0]);
				Init(rootElement);
				Bindings();
				for (var i = 0; i < tempStorage.length; i++) {
					var temp = {};
					temp.k = tempStorage[i].k;
					temp.v = tempStorage[i].v;
					rootContainer.data('keyValueMapping').push(temp);
				}
				PopulateTable(rootContainer);
			}
			else {

				$.extend(settings, options[0]);
				Init(rootElement);
				Bindings();
			}
		}

	};



})(TemplarFx.jq);

/*
* DataDictionary new Key valued UI collection
*/
(function ($) {

	$.fn.extend({
		DataDictionary: function () {
			var args = arguments;
			return this.each(function () {
					if ($(this).data('DataDictionary') != undefined) 
					{
						var methods = $(this).data('DataDictionary');
						if (methods[args[0]]) 
						{
							return methods[args[0]].apply($(this), Array.prototype.slice.call(args, 1));
						}
					}
					else
					{
						new _DataDictionary(this, args[0]);
					}
				});
		}
	});

	var _DataDictionary = function (rootElement, options) {
		var rootContainer = $(rootElement), myDialog;
		var methods = {
			Populate: function (jsonData) {
				PopulateData(jsonData);
			},
			GetData: function (elementId) {
				return RestructureData(elementId);
			},
			Sortable:function(data){
				if(data === true)
				{
					$("ul.dataTable", rootContainer).sortable({axis:'y', containment:'parent',items:'li.dnd'});
					}else
					{$("ul.dataTable", rootContainer).sortable('destroy');
				}
			}
		};

		var settings = $.extend({},  _DataDictionary.Defaults, options);

		/*
		* To Intialize Basic Structure of the page. 
		*/


		var Init = function () {
			$(rootContainer).data('Intialize', true);
			$(rootContainer).data('keyValueMapping', []);
			$(rootContainer).data('rowCounter', 0);
			$(rootContainer).data('currentKey', null);
			$(rootContainer).data('tempref', null);
			var helpEnabled = settings.HelpContent != null;
			var helpIcon='';
			if(helpEnabled)
			{
				helpIcon= "<div class='help' style=\"height: 22px; width: 22px; float: right;\" title=\"Click\"></div>";
			}
			var markupForTable = 
								 "<div><ul class='dataTable'></ul></div>" +
								 "<div class='clear'></div>"+
								 "<div>"+helpIcon+"<input type=\"button\" class=\"btn\" id='btnAddRow' value=\"Add\"></input></div>";
			var markupForDialogContainer = "<div id='dialogContents' class='NewStyle'>" +
												"<div>" +
													"<div>" +
														"<span id='keySpan' style='width:100%;background:none repeat scroll 0 0 #ECF3F7;border-bottom:1px solid #D0DFF4;color:#333333;font-weight:bold;'><label>" + settings.Label_Key + ":</label></span>" +
														"<div class='spacer5'></div>" +
														"<span id='keyInputSpan'><input id='keyDetail' type='text'style='width:99%;' /></span>" +
													"</div>" +
													"<div id='duplicateKeyMessage' class='ErrorMessage' ><label >*" + settings.Lable_Key + " Already Exists</label></div>" +
													"<div id='emptyKeyMessage'class='ErrorMessage' ><label >*" + settings.Lable_Key + " Field is mandatory</label></div>" +
													"<div id='customKeyMessage'class='ErrorMessage' ><label >* " + settings.KeyValidationFailedMsg + "</label></div>" +
													"<div class='spacer10'></div>" +
													"<div>" +
														"<span id='valueSpan' style='width:100%;background:none repeat scroll 0 0 #ECF3F7;border-bottom:1px solid #D0DFF4;color:#333333;font-weight:bold;'><label>" + settings.Label_Value + ":</label></span>" +
														"<div class='spacer5'></div>" +
														"<span id='valueInputSpan'>" +
															"<textarea id='valueDetail' name='S1' rows='2'style='width:99%;' ></textarea>" +
														"</span>" +
													"</div>" +
													"<div align='center' style='margin-top: 17px;float:right;'>" +
														"<span id='spanYesBtn' class='ui-state-default dialogBtn' style='width:85px;cursor:pointer;'>" +
															"<span id='btnYes' class='BtnDesign'>Save</span>" +
														"</span>" +
														"<span id='spanNoBtn' class='ui-state-default dialogBtn' style='width:85px;cursor:pointer;margin-left:5px;'>" +
															"<span id='btnNo' class='BtnDesign'>Cancel</span>" +
														"</span>" +
													"</div>" +
												"</div>" +
											"</div>";
			rootContainer.append(markupForTable);
			rootContainer.append(markupForDialogContainer);

			if(helpEnabled)
			{
				$('div.help:first', rootContainer).click(function() {
					if($(this).data('d') == undefined)
					{
						$("<div>"+ settings.HelpContent +"</div>").dialog({
								title: 'Help',
								resizable:false,
								modal:true,
								width:'375px',
								close:function(event, ui){
									$(this).dialog('destroy').remove();
								}
							});
					}
				});
			}
			/*
			*  Binding for Add Dialog
			*/

			myDialog = $('#dialogContents', rootContainer).dialog({
				autoOpen: false,
				draggable: true,
				modal: false,
				width: 450,
				disabled: false,
				position: 'center',
				resizable: true
			});
			$(myDialog).parent().appendTo(rootContainer);


			/*
			* Confirming Dialog Action
			*/

			$('#spanYesBtn', rootContainer).click(function () {
				myDialog = $('#dialogContents', rootContainer);
				var title = myDialog.dialog("option", "title");
				if (title === settings.DialogTitle_Add) {
					Add();
				}
				else {
					Edit();
				}
			});


			/*
			* Cancelling Dialog Action
			*/

			$('#spanNoBtn', rootContainer).click(function myfunction() {
				var title = myDialog.dialog("option", "title");
				$('#dialogContents', rootContainer).dialog("close");

			});



			/*
			* Adding new row 
			*/


			$('#btnAddRow', rootContainer).click(function () {
				myDialog = $('#dialogContents', rootContainer);
				myDialog.dialog("option", "title", settings.DialogTitle_Add);
				myDialog.dialog('open');
				$(".ErrorMessage").hide();
				$('#keyDetail', rootContainer).removeAttr('disabled').val("").focus();
				$('#valueDetail', rootContainer).val("");
				return false;
			});

			$("ul.dataTable", rootContainer).delegate('div.actions a.edit[id^=btnEdit]','click',function(){ Editing(this);});
			$("ul.dataTable", rootContainer).delegate('div.actions a.delete[id^=btnDelete]','click',function(){ DeleteThisRow(this);});
		};


		/*
		* Function to populate table when system is refreshed
		*/

		var PopulateTable = function () {
			$("ul.dataTable", rootContainer).empty();
			rootContainer.data('rowCounter', 0);
			$.each(rootContainer.data('keyValueMapping'), function () {
				var tempId = this.id
				var liActions = '<div class="actions">';
				liActions = liActions + '<a class="edit" href="#" id="btnEdit' + tempId + '">Edit</a>';
				if (this.dd == undefined || this.dd == false) {
					liActions = liActions + '<a class="delete" href="#" id="btnDelete' + tempId + '">Delete</a>';
				}
				liActions = liActions + '</div>';
				var className = '';
				if(settings.Sortable){className ='dnd';}
				if(this.DisableDnD){className='dnd-disabled';}
				var html = '<li id="key_' + tempId + '" style="display: block;clear:both;" class="'+className+'">' + liActions + '<div title="' + rootContainer.data('keyValueMapping')[tempId].v + '">' + rootContainer.data('keyValueMapping')[tempId].k + '</div></li>'
				$('ul.dataTable', rootContainer).append(html);
				$("#btnEdit" + tempId, rootContainer).data("id", tempId);
				if (!this.dd) {
					$("#btnDelete" + tempId, rootContainer).data("id", tempId);
				}
			});
			rootContainer.data('rowCounter', rootContainer.data('keyValueMapping').length);

		};

		/*
		* Function to open Edit Dialog
		*/
		var Editing = function (editButtonReference) {
			myDialog = $('#dialogContents', rootContainer);
			myDialog.dialog("option", "title", settings.DialogTitle_Edit);
			myDialog.dialog('open');

			var keyToEdit = myDialog.find("#keyDetail");
			var valueToEdit = myDialog.find("#valueDetail");
			keyToEdit.focus();
			var id = $(editButtonReference).data("id");
			rootContainer.data('currentKey', rootContainer.data('keyValueMapping')[id].k);
			rootContainer.data('tempref', editButtonReference);
			keyToEdit.val(rootContainer.data('keyValueMapping')[id].k);
			valueToEdit.val(rootContainer.data('keyValueMapping')[id].v);

			if (rootContainer.data('keyValueMapping')[id].ked) {
				keyToEdit.attr('disabled', 'disabled');
			} else {
				keyToEdit.removeAttr('disabled');
			}

			$(".ErrorMessage").hide();
		};

		/*
		*Function to Update new values to table and object after editing
		*/
		var UpdateNewValues = function (editButtonReference) {
			var tempkey = $('#keyDetail', rootContainer).val();
			var tempvalue = $('#valueDetail', rootContainer).val();
			var id = $(editButtonReference).data("id");
			rootContainer.data('keyValueMapping')[id].k = tempkey;
			rootContainer.data('keyValueMapping')[id].v = tempvalue;
			$("#key_"+id+" div[class !=actions]", rootContainer).attr('title',tempvalue).text(tempkey);
			$('#dialogContents', rootContainer).dialog('close');
		};

		/*
		* Function to validate entry to key value pair
		*/

		var KeyValidator = function (field) {
			var temp = $(field).val();
			var statusFlag = 1;

			//check empty keys
			if (temp === "") {
				statusFlag = 2;
			}
			else {
				// check for duplicated keys . . .
				var existingValues = rootContainer.data('keyValueMapping');
				$.each(existingValues, function (index) {
					if (existingValues[index]) {
						if (temp.toLowerCase() === existingValues[index].k.toLowerCase()) {
							statusFlag = 3;
						}
					}
				});
			}

			return statusFlag;
		};

		/*
		* Function to add new row
		*/
		var AddNewRow = function (key, value) {
			var temp = {};
			temp.k = key;
			temp.v = value;
			temp.dd = false;
			temp.ked = false;
			temp.id = rootContainer.data('rowCounter');
			rootContainer.data('keyValueMapping')[temp.id] = temp;
			var liActions = '<div class="actions">';
			liActions = liActions + '<a class="edit" href="#" id="btnEdit' + temp.id + '">Edit</a>';
			if (this.dd == undefined || this.dd == false) {
				liActions = liActions + '<a class="delete" href="#" id="btnDelete' + temp.id + '">Delete</a>';
			}
			liActions = liActions + '</div>';

			var className = '';
			if(settings.Sortable){className ='dnd';}
			var html = '<li id="key_' + temp.id + '" style="display: block;clear:both;" class="'+className+'">' + liActions + '<div title="' + rootContainer.data('keyValueMapping')[temp.id].v + '">' + rootContainer.data('keyValueMapping')[temp.id].k + '</div></li>'

			
			 $('ul.dataTable', rootContainer).append(html);
			$("#btnEdit" + temp.id, rootContainer).data("id", temp.id);
			if (!this.dd) {
				$("#btnDelete" + temp.id, rootContainer).data("id", temp.id);
				}
			rootContainer.data('rowCounter', rootContainer.data('rowCounter') + 1);
			$('#dialogContents', rootContainer).dialog("close");

		};
		var DeleteThisRow = function (element) {
			TemplarFx.Confirm('Confirm Deletion', 'Are you sure you want to delete this key ?', element, function (approved) {
				if (approved) {
					var tempId = $(element).data('id');
					delete rootContainer.data('keyValueMapping')[tempId];
					$(element, rootContainer).closest('li').remove();
				}
			});
		}

		var Edit = function () {

			var result;
			var customResult = true;
			var editKey = $("#keyDetail", rootContainer).val();
			if (editKey === rootContainer.data('currentKey')) {
				result = 1;
			}
			else {
				result = KeyValidator($("#keyDetail", rootContainer));

				if (typeof (settings.CustomKeyValidator) == 'function') {
					customResult = settings.CustomKeyValidator(editKey);
				}
			}

			$(".ErrorMessage", rootContainer).hide();
			if (customResult === false) {
				$("#customKeyMessage", rootContainer).show();
			}
			else if (result > 1) {
				if (result === 2) {
					$("#emptyKeyMessage", rootContainer).show();
				} else if (result === 3) {
					$("#duplicateKeyMessage", rootContainer).show();
				}
			}
			else if (result === 1) {
				UpdateNewValues(rootContainer.data('tempref'));
			}
		};

		var Add = function () {

			$(".ErrorMessage", rootContainer).hide();

			var k = $('#keyDetail', rootContainer).val();
			var v = $('#valueDetail', rootContainer).val();
			var customResult = true;
			var result = KeyValidator($('#keyDetail', rootContainer));
			if (typeof (settings.CustomKeyValidator) == 'function') {
				customResult = settings.CustomKeyValidator(k);
			}
			if (customResult === false) {
				$("#customKeyMessage", rootContainer).show();
			}
			else if (result > 1) {
				if (result === 2) {
					$("#emptyKeyMessage", rootContainer).show();
				} else if (result === 3) {
					$("#duplicateKeyMessage", rootContainer).show();
				}
			}
			else if (result === 1) {
				AddNewRow(k, v);
			}
		};

		var PopulateData = function (jsonData) {

			rootContainer.data('keyValueMapping', []);
			var keyValuePair = (typeof jsonData) === 'string' ? eval('(' + jsonData + ')') : jsonData;
			for (var i = 0; i < keyValuePair.length; i++) {
				var temp = {};
				temp.k = keyValuePair[i].K;
				temp.v = keyValuePair[i].V;
				temp.dd = keyValuePair[i].DD;
				temp.ked = keyValuePair[i].KED;
				temp.id = i;
				temp.DisableDnD = keyValuePair[i].DisableDnD || false;
				rootContainer.data('keyValueMapping')[temp.id] = temp;
			}

			PopulateTable();
		};
		var RestructureData = function (elementId) {
			var returnArray = [];
			var dataSource = rootContainer.data('keyValueMapping');
			$("ul.dataTable li", rootContainer).each(function()
			{
				var index = $(this).attr('id').replace("key_",'');
				var listItem = dataSource[index];
				if (listItem !== undefined) {
					var temp = {};
					temp.K = listItem.k;
					temp.V = listItem.v;
					temp.DD = listItem.dd;
					temp.KED = listItem.ked;
				    temp.DisableDnD = listItem.DisableDnD;
					returnArray.push(temp);
				}
			});
			var jsonString = window.JSON.stringify(returnArray);
			$('#' + elementId).val(jsonString);
			return jsonString;
		};

		Init();
		rootContainer.data('DataDictionary',methods);
		PopulateData(settings.Data);
		if(settings.Sortable)
		{
			$("ul.dataTable", rootContainer).sortable({axis:'y', containment	:'parent',items:'li.dnd'});
		}
	};

	_DataDictionary.Defaults = {
			DialogTitle_Add: 'Add',
			DialogTitle_Edit: 'Edit',
			'Label_Key': 'Key',
			'Label_Value': 'Value',
			'KeyValidationFailedMsg': 'Check the key entered',
			Sortable:false,
			CustomKeyValidator: function (key) { return true; },
			HelpContent:null
		};
})(TemplarFx.jq);