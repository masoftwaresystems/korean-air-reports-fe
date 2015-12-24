var KA = KA || {Reports: {type: ''}},
    api = 'http://masoftwaresystems.us:5855/',
    type = KA.Reports.type || '';

jQuery.support.cors = true;

/**
 * Controls for display of content
 */
function updateUIReport(data) {
    var created = data.createdAt.split('T');
    jQuery('#controlNo').html(data.controlNo);
    jQuery('#submitter').html(data.submitter);
    jQuery('#createdAt').html('On ' + created[0]);
    jQuery('.created').show();
}

/**
 * Get the user data from the UI
 */
function getUserData() {
    var obj = {
        division: jQuery('#division').val(),
        fields: jQuery('#fields :selected').val(),
        identification: jQuery('#identification').val(),
        location: jQuery('#location').val(),
        title: jQuery('#title').val(),
        description: jQuery('#description').val(),
        feedback: jQuery('#feedback').val()
    };
    switch (type) {
        case 'SCRS':
            obj.email = jQuery('#email').val();
            obj.feedbackRequest = false;
            if (jQuery('#request').attr('checked') === 'checked') {
                obj.feedbackRequest = true;
            }
            break;
        case 'Hazard':
            obj.submitter = jQuery('#name').val();
            obj.department = jQuery('#department').val();
            obj.phone = jQuery('#phone').val();
            break;
    }
    return obj;
}

/**
 * Validates form fields
 */
function validate() {
    var valid = false,
        hasFields,
        hasIdentification,
        hasLocation,
        hasTitle,
        hasDescription;

    hasFields = (jQuery('#fields :selected').val() !== '') ? true : false;
    hasIdentification = (jQuery('#identification').val() !== '') ? true : false;
    hasLocation = (jQuery('#location').val() !== '') ? true : false;
    hasTitle = (jQuery('#title').val() !== '') ? true : false;
    hasDescription = (jQuery('#description').val() !== '') ? true : false;

    jQuery('.required').addClass('invalid');
    if (hasFields && hasIdentification && hasLocation && hasTitle && hasDescription) {
        valid = true;
        jQuery('.required').removeClass('invalid');
    }

    return valid;
}

/**
 * Makes the ajax request to the report service
 */
function requestData(path, userData) {
    var reportType = type.toLowerCase();
    
    jQuery.support.cors = true;
    jQuery.ajax({
        url: api + reportType + path,
        method: 'POST',
        data: JSON.stringify(userData),
        dataType: 'json',
        success: function (data) {
            console.log(data);
            if (data.created) {
                KA.Reports.item = data;
                updateUIReport(data);
            }
        },
        error: function (jqXHR, status, error) {
            console.log(jqXHR.responseText);
            console.log(status);
            console.log(error);
        }
    });
}

/**
 * Sets the api path to create the report
 */
function createReport(userData) {
    var path = '/create';

    requestData(path, userData);
}

/**
 * Sets the api path to submit the report
 */
function submitReport(userData) {
    var path = '/update/submit';

    requestData(path, userData);
}

/**
 * Sets the api path to submit the report
 */
function updateReport(userData) {
    var path = '/update/data';

    requestData(path, userData);
}

KA.Reports = {
    save: function () {
        var userData = getUserData();

        if (!KA.Reports.item) {
            createReport(userData);
        } else {
            userData.controlNo = KA.Reports.item.controlNo;
            updateReport(userData);
        }
    },
    submit: function () {
        var userData = getUserData();

        userData.controlNo = KA.Reports.item.controlNo;
        submitReport(userData);
    },
    init: function () {
        jQuery('#create').click(function () {
            jQuery('#new').hide();
            jQuery('#report').show();
        });

        jQuery('#save').click(function () {
            var isValid = validate();

            jQuery('#submit').addClass('inactive');
            if (isValid) {
                KA.Reports.save();
                jQuery('#submit').removeClass('inactive');
            }
        });

        jQuery('#saveandclose').click(function () {
            var isValid = validate();

            if (isValid) {
                KA.Reports.save();
                location.href = location.pathname;
            }
        });

        jQuery('#submit').click(function () {
            var isValid = validate();

            if (isValid) {
                if (KA.Reports.item.controlNo) {
                    KA.Reports.submit();
                } else {
                    console.log('save first!');
                }
            }
        });

        jQuery('input[type="checkbox"]').on('change', function() {
            jQuery(this).attr('checked', true);
            jQuery(this).siblings('input[type="checkbox"]').prop('checked', false);
        });
    }
};

jQuery(document).ready(function () {
    KA.Reports.init();
});
