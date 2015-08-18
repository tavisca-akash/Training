(function () {

    var _templarFx = TemplarFx || {};
    _templarFx.GetWidgetMetaData = function (id, mode, serviceUrl, callback) {

        var data = null,
            svcUrl = serviceUrl,
            jsonData = null;

        switch (mode.toLowerCase()) {
            case 'page':
                data = id;
                break;
            default:
                break;
        }

        jsonData = Sys.Serialization.JavaScriptSerializer.serialize(data);

        $.ajax({
            type: 'POST',
            contentType: "application/json",
            url: svcUrl,
            data: jsonData,
            dataType: 'json',
            cache: false,
            processData: false,
            success: function (response) {
                if (response && response.status) {
                    if (response.status.success) {
                        callback(response);
                    } else {
                        TemplarFx.ShowMsg('Error Occured', response.status.errormessage, 'Error');
                    }
                } else {
                    TemplarFx.ShowMsg('Error Occured', 'Error occured while communicating with server.', 'Error');
                }
            }
        });

    };

})();