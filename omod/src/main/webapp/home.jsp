<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%@ page import="org.openmrs.web.WebConstants" %>

<%@ taglib prefix="openmrs" uri="/WEB-INF/taglibs/openmrs.tld" %>

<openmrs:require privilege="Manage Pharmacy" otherwise="/login.htm"
                 redirect="/module/pharmacy/home.form"/>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/template/include.jsp" %>

<openmrs:htmlInclude file="/openmrs.js" />
<openmrs:htmlInclude file="/scripts/openmrsmessages.js"
                     appendLocale="true" />


<openmrs:htmlInclude file="/style.css" />

<openmrs:htmlInclude file="/dwr/engine.js" />



<openmrs:htmlInclude file="/dwr/interface/DWRAlertService.js" />

<c:if test="${empty DO_NOT_INCLUDE_JQUERY}">
    <openmrs:htmlInclude file="/scripts/jquery/jquery.min.js"/>
    <openmrs:htmlInclude
            file="/scripts/jquery-ui/js/jquery-ui.custom.min.js"/>
    <openmrs:htmlInclude
            file="/scripts/jquery-ui/js/jquery-ui-datepicker-i18n.js"/>
    <link
            href="<openmrs:contextPath/>/scripts/jquery-ui/css/<spring:theme code='jqueryui.theme.name' />/jquery-ui.custom.css"
            type="text/css" rel="stylesheet"/>
</c:if>

<openmrs:htmlInclude file="/scripts/jquery-ui/js/openmrsSearch.js"/>




<openmrs:htmlInclude file="/dwr/interface/DWRPatientService.js" />
<openmrs:htmlInclude file="/dwr/interface/DWRPersonService.js" />
<openmrs:htmlInclude file="/scripts/calendar/calendar.js" />

<openmrs:htmlInclude file="/scripts/jquery-ui/js/openmrsSearch.js" />
<openmrs:htmlInclude file="/dwr/util.js" />



<c:choose>
    <c:when test="${!empty pageTitle}">
        <title>${pageTitle}</title>
    </c:when>
    <c:otherwise>
        <title><spring:message code="openmrs.title" /></title>
    </c:otherwise>
</c:choose>



<openmrs:extensionPoint pointId="org.openmrs.headerMinimalIncludeExt"
                        type="html"
                        requiredClass="org.openmrs.module.web.extension.HeaderIncludeExt">
    <c:forEach var="file" items="${extension.headerFiles}">
        <openmrs:htmlInclude file="${file}" />
    </c:forEach>
</openmrs:extensionPoint>


<%--Css for datatables and for openmrs tweak for pharmacy--%>




<link
        href="${pageContext.request.contextPath}/moduleResources/pharmacy/css/pharmacy_openmrs.css"
        type="text/css" rel="stylesheet"/>
<link
        href="${pageContext.request.contextPath}/moduleResources/pharmacy/css/datatables.css"
        type="text/css" rel="stylesheet"/>

<%--Css for pharamcy module--%>
<link rel="stylesheet" type="text/css"
      href="${pageContext.request.contextPath}/moduleResources/pharmacy/css/style.css"/>

<%--jquery --%>

<script type="text/javascript"
        src="${pageContext.request.contextPath}/moduleResources/pharmacy/scripts/jquery.jeditable.js"></script>


<script type="text/javascript"
        src="${pageContext.request.contextPath}/moduleResources/pharmacy/scripts/jquery.dataTables.rowGrouping.js"></script>


<script type="text/javascript"
        src="${pageContext.request.contextPath}/moduleResources/pharmacy/scripts/jquery.layout-latest.js"></script>

<script type="text/javascript"
        src="${pageContext.request.contextPath}/moduleResources/pharmacy/scripts/jquery.dform-0.1.3.min.js"></script>


<%--<script type="text/javascript"--%>
<%--src="${pageContext.request.contextPath}/moduleResources/pharmacy/scripts/jquery.layout.resizePaneAccordions-1.0.js"></script>--%>

<script type="text/javascript"
        src="${pageContext.request.contextPath}/moduleResources/pharmacy/scripts/debug.js"></script>


<script type="text/javascript"
        src="${pageContext.request.contextPath}/moduleResources/pharmacy/scripts/jquery.dataTables.min.js"></script>

<script type="text/javascript"
        src="${pageContext.request.contextPath}/moduleResources/pharmacy/scripts/jquery.validate.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/moduleResources/pharmacy/scripts/jquery.easy-confirm-dialog.js"></script>




<%--jspdf plugin--%>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/moduleResources/pharmacy/jspdf/jspdf.js"></script>

<script type="text/javascript"
        src="${pageContext.request.contextPath}/moduleResources/pharmacy/jspdf/jspdf.plugin.standard_fonts_metrics.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/moduleResources/pharmacy/jspdf/jspdf.plugin.split_text_to_size.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/moduleResources/pharmacy/jspdf/jspdf.plugin.from_html.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/moduleResources/pharmacy/scripts/jquery.validate.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/moduleResources/pharmacy/scripts/jquery.easy-confirm-dialog.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/moduleResources/pharmacy/scripts/jquery-jForm-plugin.js">  </script>
<script type="text/javascript" src="${pageContext.request.contextPath}/moduleResources/pharmacy/scripts/Serialize.js">  </script>

<script type="text/javascript">
    <c:if test="${empty DO_NOT_INCLUDE_JQUERY}">
        var $j = jQuery.noConflict();
    </c:if>
    /* variable used in js to know the context path */

    $j("#patient").show();
    var openmrsContextPath = '${pageContext.request.contextPath}';
    var dwrLoadingMessage = '<spring:message code="general.loading" />';
    var jsDateFormat = '<openmrs:datePattern localize="false"/>';
    var jsLocale = '<%= org.openmrs.api.context.Context.getLocale() %>';

    /* prevents users getting false dwr errors msgs when leaving pages */
    var pageIsExiting = false;
    if (jQuery)
        jQuery(window).bind('beforeunload', function () { pageIsExiting = true; } );

    var handler = function(msg, ex) {
        if (!pageIsExiting) {
            var div = document.getElementById("openmrs_dwr_error");
            div.style.display = ""; // show the error div
            var msgDiv = document.getElementById("openmrs_dwr_error_msg");
            msgDiv.innerHTML = '<spring:message code="error.dwr"/>' + " <b>" + msg + "</b>";
        }
    };
    dwr.engine.setErrorHandler(handler);
    dwr.engine.setWarningHandler(handler);

    var lastSearch;
    $j.validator.addMethod(
            "selectNone",
            function (value, element) {
                if (element.value == "-1") {
                    return false;
                }
                else return true;
            }

    );
    var path = ${pageContext.request.contextPath}/;

    function selectedChwProvider(userId, provider) {
        if (provider != null) {
            var prov = provider.userId;
        }
        $j("#requisitiono").val(prov);
        $j("#requisitionp").val(prov);
        $j("#requisition").val(prov)
    }
    function stopRKey(evt) {
        var evt = (evt) ? evt : ((event) ? event : null);
        var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null);
        if ((evt.keyCode == 13) && (node.type == "text")) {
            return false;
        }
    }
    document.onkeypress = stopRKey;
    function selectedChwProvider1(userId, provider) {
        if (provider != null) {
            var prov = provider.userId;
        }
        $j("#issuedo").val(prov);
        $j("#issuedp").val(prov);
        $j("#issued").val(prov);
    }
    function selectedChwProvider2(userId, provider) {
        if (provider != null) {
            var prov = provider.userId;
        }
        $j("#authorized").val(prov);
        $j("#authorizedo").val(prov);
        $j("#authorizedp").val(prov);
    }
    jQuery.Page = {
        context:path
    };
</script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/moduleResources/pharmacy/scripts/themeswitchertool.js"></script>
<script type="text/javascript">

var oCache = {
    iCacheLower:-1
};
function fnSetKey(aoData, sKey, mValue) {
    for (var i = 0, iLen = aoData.length; i < iLen; i++) {
        if (aoData[i].name == sKey) {
            aoData[i].value = mValue;
        }
    }
}

function fnGetKey(aoData, sKey) {
    for (var i = 0, iLen = aoData.length; i < iLen; i++) {
        if (aoData[i].name == sKey) {
            return aoData[i].value;
        }
    }
    return null;
}

function fnDataTablesPipeline(sSource, aoData, fnCallback) {
    var iPipe = 5;
    /* Ajust the pipe size */

    var bNeedServer = false;
    var sEcho = fnGetKey(aoData, "sEcho");
    var iRequestStart = fnGetKey(aoData, "iDisplayStart");
    var iRequestLength = fnGetKey(aoData, "iDisplayLength");
    var iRequestEnd = iRequestStart + iRequestLength;
    oCache.iDisplayStart = iRequestStart;

    /* outside pipeline? */
    if (oCache.iCacheLower < 0 || iRequestStart < oCache.iCacheLower || iRequestEnd > oCache.iCacheUpper) {
        bNeedServer = true;
    }

    /* sorting etc changed? */
    if (oCache.lastRequest && !bNeedServer) {
        for (var i = 0, iLen = aoData.length; i < iLen; i++) {
            if (aoData[i].name != "iDisplayStart" && aoData[i].name != "iDisplayLength" && aoData[i].name != "sEcho") {
                if (aoData[i].value != oCache.lastRequest[i].value) {
                    bNeedServer = true;
                    break;
                }
            }
        }
    }

    /* Store the request for checking next time around */
    oCache.lastRequest = aoData.slice();

    if (bNeedServer) {
        if (iRequestStart < oCache.iCacheLower) {
            iRequestStart = iRequestStart - (iRequestLength * (iPipe - 1));
            if (iRequestStart < 0) {
                iRequestStart = 0;
            }
        }

        oCache.iCacheLower = iRequestStart;
        oCache.iCacheUpper = iRequestStart + (iRequestLength * iPipe);
        oCache.iDisplayLength = fnGetKey(aoData, "iDisplayLength");
        fnSetKey(aoData, "iDisplayStart", iRequestStart);
        fnSetKey(aoData, "iDisplayLength", iRequestLength * iPipe);

        $j.getJSON(sSource, aoData, function (json) {
            /* Callback processing */
            oCache.lastJson = jQuery.extend(true, {}, json);

            if (oCache.iCacheLower != oCache.iDisplayStart) {
                json.aaData.splice(0, oCache.iDisplayStart - oCache.iCacheLower);
            }
            json.aaData.splice(oCache.iDisplayLength, json.aaData.length);

            fnCallback(json)
        });
    }
    else {
        json = jQuery.extend(true, {}, oCache.lastJson);
        json.sEcho = sEcho;
        /* Update the echo for each response */
        json.aaData.splice(0, iRequestStart - oCache.iCacheLower);
        json.aaData.splice(iRequestLength, json.aaData.length);
        fnCallback(json);
        return;
    }
}

$j("#themeSwitcher").themeswitcher(
        {
            "loadTheme":"Flick"
        });

$j(document).ajaxError(function(e, xhr, settings, exception) {
    $j("#errorDialog").empty();
    $j('<dl><dt></dt><dd >' + "Error: " +  'error in:' + settings.url + '-' + exception + '</dd></dl> ').appendTo('#errorDialog');
    $j("#errorDialog").dialog("open");
});
$j(document).ready(
        function() {
//            Variables used in the module
            var pageToDisplay;
            var patientID;
            var patientName;
            var url;
            var dateGiven;
            var quantity;
            var price;
            var valgiven;
            var method;
            var priceOne;
            var valgivenOne;
            var methodOne;
            $j("#patientInfo").hide();//
            new OpenmrsSearch("findPatients", false, doPatientSearch, doSelectionHandler,
                    [	{fieldName:"identifier", header:omsgs.identifier},
                        {fieldName:"givenName", header:omsgs.givenName},
                        {fieldName:"middleName", header:omsgs.middleName},
                        {fieldName:"familyName", header:omsgs.familyName},
                        {fieldName:"age", header:omsgs.age},
                        {fieldName:"gender", header:omsgs.gender},
                        {fieldName:"birthdateString", header:omsgs.birthdate},
                    ],
                    {
                        searchLabel: '<spring:message code="Patient.searchBox" javaScriptEscape="true"/>'
                                <c:if test="${not empty param.phrase}">
                    , searchPhrase: '<spring:message text="${ param.phrase }" javaScriptEscape="true"/>'
            </c:if>
        });
$j.getJSON("locationSetter.form?drop=drop", function (result) {
    if (result == "null") {
        <%
    if (org.openmrs.api.context.Context.getAuthenticatedUser().hasRole("Pharmacy Administrator") ) {
        %>
        $j("#ui").show();
        $j("#ui8").show();

        $j("#ui1").show();
        $j("#ui18").show();

        $j("#ui2").show();
        $j("#ui28").show();

        $j("#ui3").show();
        $j("#ui38").show();

        $j("#ui4").show();
        $j("#ui48").show();


        <%
    }
    else {
        %>


        $j("#ui").hide();
        $j("#ui8").hide();

        $j("#ui1").hide();
        $j("#ui18").hide();

        $j("#ui2").hide();
        $j("#ui28").hide();

        $j("#ui3").hide();
        $j("#ui38").hide();

        $j("#ui4").hide();
        $j("#ui48").hide();

        <%
        }
        %>


    }
    else {
        $j("#ui").show();
        $j("#ui8").show();

        $j("#ui1").show();
        $j("#ui18").show();

        $j("#ui2").show();
        $j("#ui28").show();

        $j("#ui3").show();
        $j("#ui38").show();

        $j("#ui4").show();
        $j("#ui48").show();


    }
});


/*Generic datatable refresh function*/
function RefreshTable(tableId) {
    table = $j(tableId).dataTable();
    table.fnDraw();
}
/*Fucntion to be called when a patient is selected*/
function doSelectionHandler(index, data) {
    patientID = data.patientId;
    $j.getJSON("dispense.form?Pid=" + patientID,function (result) { $j.each(result,function (index, value) {
        $j("#patientInfo").show("slow");//
        $j('#patientInfo .locc').replaceWith("<div id='red'>" + "Patient Name:" + value + "</div>");
    });
    });
    url = data.patientId;
    $j("#patient").show();
    $j("#corn").hide();
    var oFormObject = document.forms['cornform'];
    oFormObject.reset();
    var path = ${pageContext.request.contextPath}/;
    jQuery.Pid = {
        id:url
    };

    jQuery.Page = {
        context:path
    };
    $j('#tab_1psychiatry').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/dispensePage.jsp #disp', function () {

        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/dispensePage.js", function () {
        });


    });

    $j("#newEncounter").show();
    $j("#parent_div_2").hide();
}


//searchHandler for the Search widget
function doPatientSearch(text, resultHandler, getMatchCount, opts) {
    lastSearch = text;
    DWRPatientService.findCountAndPatients(text, opts.start, opts.length, getMatchCount, resultHandler);
}


$j('a.ui-dialog-titlebar-close').remove();


$j("#patient").show();

$j("#newEncounter").hide();


$j("#dialog").dialog({ position:[350, 100],
    modal:false,
    draggable:false,
    width:400
});

$j("#dialog1").dialog({
    position:[900, 100],
    modal:false,
    draggable:false,
    width:400
});


function test() {
    $j("#dialog-confirm").dialog('open');
}

function CloseDialog() {


    $j("#dialog").dialog('close');
    $j("#dialog1").dialog('close');

}



function CloseAll() {


    $j("#Approved").dialog('close');
    $j("#Requests").dialog('close');
    $j("#Pending").dialog('close');

}
/*To show elements meant to be in the dashboard e.g graphs etc*/
$j("#dashboard").click(function () {


});


//hide center elements

$j("#store").hide();
$j("#stock").hide();
$j("#Barcode").hide();
$j("#Batchsetter").hide();
$j("#drugSetUp").hide();
$j("#druglow").hide();
$j("#drughigh").hide();
$j("#errorDiv").hide();
$j("#errorDivStore").hide();
$j("#spinner").hide();
$j("#incomingData").hide();
$j("#incomingDatanew").hide();
$j("#locationsetter").hide();//
$j("#outgoing").hide();
$j("#locationNames").hide();
$j("#locationUsers").hide();
$j("#transactionsSetting").hide();
$j("#supplierSettings").hide();
$j("#settings").hide();
$j("#dispenseContainer").hide();//
$j("#maxmin").hide();//
// $j("#outgoingperm").hide();//
$j("#approvedperm").hide();//
$j("#incomingperm").hide();//
$j("#drugusagepage").hide();//
$j("#requestsumpage").hide();//
$j("#rfpreportpage").hide();
$j("#fmapreportpage").hide();

$j("#dataDiv").hide();//

$j("#approvedData").hide();

$j("#DrugCategory").hide();//

$j("#General").hide();//


$j("#strengthvoid").hide();//


$j("#psychiatrysec").hide();
$j("#locationError").hide();
$j("#transactionsLogs").hide();
$j("#doseManagement").hide();
$j("#name").hide();//
$j("#namevoid").hide();//

//tabs

//tab_1requestsum


$j("#center").tabs();
$j("#transactionsLogs").tabs();
$j("#settings").tabs();
$j("#store").tabs();
$j("#stock").tabs();
$j("#Batchsetter").tabs();
$j("#drugSetUp").tabs();
$j("#Barcode").tabs();
$j("#druglow").tabs();
$j("#drughigh").tabs();
$j("#incomingData").tabs();
$j("#incomingDatanew").tabs();

$j("#outgoing").tabs();
$j("#supplierSettings").tabs();
$j("#transactionsSetting").tabs();
$j("#dispenseContainer").tabs();
$j("#psychiatrysec").tabs();
$j("#locationsetter").tabs();//


$j("#drugusagepage").tabs();//
$j("#requestsumpage").tabs();//
$j("#rfpreportpage").tabs();
$j("#fmapreportpage").tabs();


$j("#DrugCategory").tabs();//
$j("#locationNames").tabs();
$j("#locationUsers").tabs();
$j("#General").tabs();//

$j("#maxmin").tabs();//
$j("#approvedData").tabs();//

$j("drugtotaltable").hide();


$j("backinventory").hide();


//form validation
$j("#formulationvoid").validate();
$j("#drugs").validate({
    rules:{
        drugsformulation:{
            selectNone:true
        },
        drugsstrength:{
            selectNone:true
        },
        drugsunits:{
            selectNone:true
        }
    }
});


$j("#doses").validate({
    rules:{
        dosesdrug:{
            selectNone:true
        },
        dosesfrequency:{
            selectNone:true
        },
        dosequantity:{
            required:true,
            digits:true
        }
    }
});

$j("#binvoid").validate();

$j("#bincard").validate({
    rules:{
        bindrug:{
            selectNone:true
        },
        binquantityin:{
            required:true,
            digits:true
        },
        binmin:{

            digits:true
        },
        binmax:{

            digits:true
        }
    }
});
/*Layout */
myLayout = $j("body")
        .layout(
        {
            west__size:300
        });

// ACCORDION - in the West pane
$j("#accordion1").accordion({
//    heightStyle: "fill" ,
//    autoHeight: false,
//    navigation: true,
    heightStyle: "content"
//    fillSpace:true, active:1 // set active accordion-panel
});

$j("#ts").click(function () {
    // load about page on click

    //$j("#myform").buildForm("m/sample.json");
    $j("#store").show("slow");
    $j("#stock").hide();

});


$j("#DGeneral").click(function() {





    $j('#tab_1General').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/pharmacyGeneral.jsp #dnames' , function() {
        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/pharmacyGeneral.js", function(){
        });
    });



    $j("#drugusagepage").hide();//
    $j("#requestsumpage").hide();//
    CloseAll();

    $j("#General").show();//
    $j("#DrugCategory").hide();//
    $j("#rfpreportpage").hide();
    $j("#fmapreportpage").hide();
    $j("#spinner").hide();
    $j("#Batchsetter").hide();
    $j("#drugSetUp").hide();
    $j("#Barcode").hide();
    $j("#druglow").hide();
    $j("#drughigh").hide();
    $j("#dispenseContainer").hide();
    $j("#locationsetter").hide();
    $j("#psychiatrysec").hide();
    $j("#settings").hide();
    $j("#transactionsLogs").hide();
    $j("#doseManagement").hide();
    $j("#store").hide();//
    $j("#stock").hide();
    $j("#dashboarddata").hide();//
    $j("#incomingData").hide();
    $j("#incomingDatanew").hide();

    $j("#outgoing").hide();
    $j("#transactionsSetting").hide();
    $j("#supplierSettings").hide();
    $j("#locationNames").hide();
    $j("#maxmin").hide();//
    //	CloseDialog();
    $j("#approvedData").hide();//


});
/*shows drug categories view*/

$j("#DCategories").click(function () {


    $j('#tab_1Drug').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/drugCategories.jsp #dnames', function () {
        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/drugCategories.js", function () {
        });
    });

    $j("#drugusagepage").hide();//
    $j("#requestsumpage").hide();//


    CloseAll();

    $j("#rfpreportpage").hide();
    $j("#fmapreportpage").hide();
    $j("#DrugCategory").show();//
    $j("#General").hide();//
    $j("#spinner").hide();
    $j("#Batchsetter").hide();
    $j("#drugSetUp").hide();
    $j("#Barcode").hide();
    $j("#druglow").hide();
    $j("#drughigh").hide();
    $j("#dispenseContainer").hide();
    $j("#locationsetter").hide();
    $j("#psychiatrysec").hide();
    $j("#settings").hide();
    $j("#transactionsLogs").hide();
    $j("#doseManagement").hide();
    $j("#store").hide();//
    $j("#stock").hide();
    $j("#dashboarddata").hide();//
    $j("#incomingData").hide();
    $j("#incomingDatanew").hide();

    $j("#outgoing").hide();
    $j("#transactionsSetting").hide();
    $j("#supplierSettings").hide();
    $j("#locationNames").hide();
    $j("#locationUsers").hide();
    $j("#maxmin").hide();
    $j("#approvedData").hide();//

});
/*show Dispense Batch settings view*/
$j("#DBatch").click(function () {
    $j("#parent_div_2").hide();
    $j("#parent_div_1").hide();
    $j("#spinner").show();
    /*Check if location has been set */
    $j.getJSON("locationSetter.form", function (result) {
        if (result == "none") {
            $j("#errorDiv").show();

            $j("#errorDiv").delay(5000).hide("slow");
            $j("#spinner").delay(5000).hide("slow");
        }
        else {
            $j('#tab_1batch').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/dispenseSettings.jsp #dtab_1', function () {
                $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/dispenseSettings.js", function () {
                });
            });
            CloseAll();

            $j("#drugusagepage").hide();//
            $j("#requestsumpage").hide();//
            $j("#rfpreportpage").hide();
            $j("#fmapreportpage").hide();
            $j("#General").hide();//
            $j("#spinner").hide();
            $j("#Batchsetter").show();
            $j("#drugSetUp").hide();
            $j("#Barcode").hide();
            $j("#druglow").hide();
            $j("#drughigh").hide();
            $j("#dispenseContainer").hide();
            $j("#locationsetter").hide();
            $j("#psychiatrysec").hide();
            $j("#settings").hide();
            $j("#transactionsLogs").hide();
            $j("#doseManagement").hide();
            $j("#store").hide();//
            $j("#stock").hide();
            $j("#dashboarddata").hide();//
            $j("#incomingData").hide();
            $j("#incomingDatanew").hide();

            $j("#outgoing").hide();
            $j("#transactionsSetting").hide();
            $j("#supplierSettings").hide();
            //	CloseDialog();
            $j("#maxmin").hide();//
            $j("#locationNames").hide();
            $j("#locationUsers").hide();
            $j("#DrugCategory").hide();//
            $j("#approvedData").hide();//

        }
    });
});
$j("#dSetUp").click(function () {
    $j("#parent_div_2").hide();
    $j("#parent_div_1").hide();
    $j("#spinner").show();
    /*Check if location has been set */
    $j.getJSON("locationSetter.form", function (result) {
        if (result == "none") {
            $j("#errorDiv").show();

            $j("#errorDiv").delay(5000).hide("slow");
            $j("#spinner").delay(5000).hide("slow");
        }
        else {
            $j('#tab_1drugSetUp').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/drugAdministration.JSP #dtab_1', function () {
                $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/drugAdministration.js", function () {
                });
            });
            CloseAll();

            $j("#drugusagepage").hide();//
            $j("#requestsumpage").hide();//
            $j("#rfpreportpage").hide();
            $j("#fmapreportpage").hide();
            $j("#General").hide();//
            $j("#spinner").hide();
            $j("#Batchsetter").hide();
            $j("#drugSetUp").show();
            $j("#Barcode").hide();
            $j("#druglow").hide();
            $j("#drughigh").hide();
            $j("#dispenseContainer").hide();
            $j("#locationsetter").hide();
            $j("#psychiatrysec").hide();
            $j("#settings").hide();
            $j("#transactionsLogs").hide();
            $j("#doseManagement").hide();
            $j("#store").hide();//
            $j("#stock").hide();
            $j("#dashboarddata").hide();//
            $j("#incomingData").hide();
            $j("#incomingDatanew").hide();

            $j("#outgoing").hide();
            $j("#transactionsSetting").hide();
            $j("#supplierSettings").hide();
            //	CloseDialog();
            $j("#maxmin").hide();//
            $j("#locationNames").hide();
            $j("#locationUsers").hide();
            $j("#DrugCategory").hide();//
            $j("#approvedData").hide();//

        }
    });
});
/*show barcode generation page*/
$j("#DBarcode").click(function () {


    $j("#parent_div_2").hide();


    $j("#parent_div_1").hide();
    $j("#spinner").show();
    $j.getJSON("locationSetter.form", function (result) {
        if (result == "none") {
            $j("#errorDiv").show();

            $j("#errorDiv").delay(5000).hide("slow");
            $j("#spinner").delay(5000).hide("slow");
        }
        else {
            $j('#tab_1barcode').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/barcode.jsp #dtab_1', function () {
                $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/barcode.js", function () {
                });
            });

            $j("#drugusagepage").hide();//
            $j("#requestsumpage").hide();//
            CloseAll();
            $j("#rfpreportpage").hide();
            $j("#fmapreportpage").hide();
            $j("#General").hide();//
            $j("#spinner").hide();
            $j("#Batchsetter").hide();
            $j("#drugSetUp").hide();
            $j("#Barcode").show();
            $j("#druglow").hide();
            $j("#drughigh").hide();
            $j("#dispenseContainer").hide();
            $j("#locationsetter").hide();
            $j("#psychiatrysec").hide();
            $j("#settings").hide();
            $j("#transactionsLogs").hide();
            $j("#doseManagement").hide();
            $j("#store").hide();//
            $j("#stock").hide();
            $j("#dashboarddata").hide();//
            $j("#incomingData").hide();
            $j("#incomingDatanew").hide();

            $j("#outgoing").hide();
            $j("#transactionsSetting").hide();
            $j("#supplierSettings").hide();
            //	CloseDialog();
            $j("#maxmin").hide();//
            $j("#locationNames").hide();
            $j("#locationUsers").hide();
            $j("#DrugCategory").hide();//
            $j("#approvedData").hide();//

        }
    });
});

/*Shows regimens set view*/
$j("#regimenlink").click(function () {
    $j('#regimentab_1').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/dispenseForm.jsp #dtab_1', function () {
        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/dispenseForm.js", function () {

        });
    });
    $j("#drugusagepage").hide();//
    $j("#requestsumpage").hide();//
    CloseAll();
    $j("#rfpreportpage").hide();
    $j("#fmapreportpage").hide();
    $j("#General").hide();
    $j("#Batchsetter").hide();
    $j("#drugSetUp").hide();
    $j("#Barcode").hide();
    $j("#druglow").hide();
    $j("#drughigh").hide();
    $j("#dispenseContainer").show("slow");
    $j("#locationsetter").hide();
    $j("#psychiatrysec").hide();
    $j("#settings").hide();
    $j("#transactionsLogs").hide();
    $j("#doseManagement").hide();
    $j("#store").hide();//
    $j("#stock").hide();
    $j("#dashboarddata").hide();//
    $j("#incomingData").hide();
    $j("#incomingDatanew").hide();

    $j("#outgoing").hide();
    $j("#transactionsSetting").hide();
    $j("#supplierSettings").hide();
    $j("#DrugCategory").hide();//
    $j("#locationNames").hide();
    $j("#locationUsers").hide();
    $j("#maxmin").hide();//
    $j("#approvedData").hide();//

});

/*show Bincard Totals view*/
$j("#bincardtotaldrugs").click(function () {


    $j('#tab_1totaldrugs').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/bincardTotal.jsp #dtotal', function () {


        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/drugbincardtotal.js", function () {

        });


    });


});

/*show stock take interface*/
$j("#dstock").click(function () {
    $j("#spinner").show();
    $j.getJSON("locationSetter.form", function (result) {
        if (result == "none") {
            $j("#errorDiv").show();

            $j("#errorDiv").delay(5000).hide("slow");
            $j("#spinner").delay(5000).hide("slow");
        }
        else {

            $j('#tab_1stock').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/bincardStock.jsp #dtab_1', function () {


                $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/drugbincardStock2.js", function () {

                });

            });
            $j("#drugusagepage").hide();//
            $j("#requestsumpage").hide();//
            CloseAll();
            $j("#rfpreportpage").hide();
            $j("#fmapreportpage").hide();
            $j("#Batchsetter").hide();
            $j("#drugSetUp").hide();
            $j("#Barcode").hide();
            $j("#spinner").hide();
            $j("#store").hide();
            $j("#stock").show("slow");
            $j("#druglow").hide();
            $j("#drughigh").hide();
            $j("#locationsetter").hide();
            $j("#psychiatrysec").hide();
            $j("#settings").hide();
            $j("#transactionsLogs").hide();
            $j("#doseManagement").hide();
            $j("#dashboarddata").hide();//
            $j("#incomingData").hide();
            $j("#incomingDatanew").hide();

            $j("#dispenseContainer").hide();//
            $j("#outgoing").hide();
            $j("#DrugCategory").hide();//
            $j("#General").hide();//
            $j("#locationNames").hide();
            $j("#locationUsers").hide();
            $j("#transactionsSetting").hide();
            $j("#supplierSettings").hide();
            $j("#maxmin").hide();//
            $j("#approvedData").hide();//

            //	CloseDialog();

        }
    });

});
/*show bincard view*/
$j("#dstore").click(function () {
    $j("#spinner").show();
    $j.getJSON("locationSetter.form", function (result) {
        if (result == "none") {
            $j("#errorDiv").show();

            $j("#errorDiv").delay(5000).hide("slow");
            $j("#spinner").delay(5000).hide("slow");
        }
        else {

            $j('#tab_1storee').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/bincard.jsp #dtab_1', function () {


                $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/drugbincard.js", function () {

                });

            });
            //	$j('#storelocation #instorelocation').replaceWith("	Drug management: Location-"+result);

            var data = '<strong>Drug management: Location1-' + result + '</strong>';
            $j('#instorelocation').empty();
            $j(data).appendTo(' #instorelocation');
            $j("#drugusagepage").hide();//
            $j("#requestsumpage").hide();//
            CloseAll();
            $j("#rfpreportpage").hide();
            $j("#fmapreportpage").hide();
            $j("#Batchsetter").hide();
            $j("#drugSetUp").hide();
            $j("#Barcode").hide();
            $j("#spinner").hide();
            $j("#store").show("slow");
            $j("#stock").hide();
            $j("#druglow").hide();
            $j("#drughigh").hide();
            $j("#locationsetter").hide();
            $j("#psychiatrysec").hide();
            $j("#settings").hide();
            $j("#transactionsLogs").hide();
            $j("#doseManagement").hide();
            $j("#dashboarddata").hide();//
            $j("#incomingData").hide();
            $j("#incomingDatanew").hide();

            $j("#dispenseContainer").hide();//
            $j("#outgoing").hide();
            $j("#DrugCategory").hide();//
            $j("#General").hide();//
            $j("#locationNames").hide();
            $j("#locationUsers").hide();
            $j("#transactionsSetting").hide();
            $j("#supplierSettings").hide();
            $j("#maxmin").hide();//
            $j("#approvedData").hide();//

            //	CloseDialog();

        }
    });


});
/*low stock view*/
$j("#dlow").click(function () {
    $j("#spinner").show();


    $j.getJSON("locationSetter.form", function (result) {
        if (result == "none") {
            $j("#errorDiv").show();

            $j("#errorDiv").delay(5000).hide("slow");
            $j("#spinner").delay(5000).hide("slow");
        }
        else {


            $j('#tab_1low').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/lowbincard.jsp #dtab_1', function () {


                $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/druglowbincard.js", function () {

                });

            });
            //	$j('#storelocation #instorelocation').replaceWith("	Drug management: Location-"+result);

            var data = '<strong>Drug Low levels: Location2-' + result + '</strong>';

            $j("#drugusagepage").hide();//
            $j("#requestsumpage").hide();//
            CloseAll();
            $j("#rfpreportpage").hide();
            $j("#fmapreportpage").hide();
            $j('#inlowlocation').empty();
            $j(data).appendTo(' #inlowlocation');
            $j("#Batchsetter").hide();
            $j("#drugSetUp").hide();
            $j("#Barcode").hide();
            $j("#spinner").hide();
            $j("#druglow").show("slow");
            $j("#drughigh").hide();
            $j("#store").hide();
            $j("#stock").hide();
            $j("#locationsetter").hide();
            $j("#psychiatrysec").hide();
            $j("#settings").hide();
            $j("#transactionsLogs").hide();
            $j("#doseManagement").hide();
            $j("#dashboarddata").hide();//
            $j("#incomingData").hide();
            $j("#incomingDatanew").hide();

            $j("#dispenseContainer").hide();//
            $j("#DrugCategory").hide();//
            $j("#General").hide();//
            $j("#outgoing").hide();
            $j("#maxmin").hide();//
            $j("#locationNames").hide();
            $j("#locationUsers").hide();
            $j("#transactionsSetting").hide();
            $j("#supplierSettings").hide();
            $j("#approvedData").hide();//

            //	CloseDialog();

        }
    });


});


/*Short to expire stock*/
$j("#dhigh").click(function () {
    $j("#spinner").show();
    $j.getJSON("locationSetter.form", function (result) {
        if (result == "none") {
            $j("#errorDiv").show();

            $j("#errorDiv").delay(5000).hide("slow");
            $j("#spinner").delay(5000).hide("slow");
        }
        else {

            $j('#tab_1high').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/highbincard.jsp #dtab_1', function () {


                $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/drughighbincard.js", function () {

                });

            });
            //	$j('#storelocation #instorelocation').replaceWith("	Drug management: Location-"+result);

            var data = '<strong>Drug high levels: Location3-' + result + '</strong>';

            $j("#drugusagepage").hide();//
            $j("#requestsumpage").hide();//
            CloseAll();
            $j("#rfpreportpage").hide();
            $j("#fmapreportpage").hide();
            $j('#inhighlocation').empty();
            $j(data).appendTo(' #inhighlocation');
            $j("#drughigh").show("slow");
            $j("#spinner").hide();
            $j("#druglow").hide();
            $j("#Batchsetter").hide();
            $j("#drugSetUp").hide();
            $j("#Barcode").hide();
            $j("#store").hide();
            $j("#stock").hide();
            $j("#locationsetter").hide();
            $j("#psychiatrysec").hide();
            $j("#settings").hide();
            $j("#transactionsLogs").hide();
            $j("#doseManagement").hide();
            $j("#dashboarddata").hide();//
            $j("#incomingData").hide();
            $j("#incomingDatanew").hide();

            $j("#dispenseContainer").hide();//
            $j("#outgoing").hide();
            $j("#DrugCategory").hide();//
            $j("#General").hide();//
            $j("#transactionsSetting").hide();
            $j("#supplierSettings").hide();
            $j("#approvedData").hide();//

            //	CloseDialog();
            $j("#maxmin").hide();//
            $j("#locationNames").hide();
            $j("#locationUsers").hide();
        }
    });


});

/*View to choose location*/
$j("#locationsetterid").click(function () {
    $j("#spinner").show();

    $j('#tab_1locationid').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/locationSetter.jsp #dlocation', function () {
        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/locationSetter.js", function () {

        });


    });

    $j("#drugusagepage").hide();//
    $j("#requestsumpage").hide();//
    CloseAll();
    $j("#rfpreportpage").hide();
    $j("#fmapreportpage").hide();
    $j("#druglow").hide();
    $j("#drughigh").hide();
    $j("#Batchsetter").hide();
    $j("#drugSetUp").hide();
    $j("#Barcode").hide();
    $j("#locationsetter").show("slow");
    $j("#locationError").hide();//
    $j("#store").hide();
    $j("#stock").hide();
    $j("#psychiatrysec").hide();
    $j("#settings").hide();
    $j("#transactionsLogs").hide();
    $j("#doseManagement").hide();
    $j("#dashboarddata").hide();//
    $j("#incomingData").hide();
    $j("#incomingDatanew").hide();

    $j("#maxmin").hide();//
    $j("#outgoing").hide();
    $j("#transactionsSetting").hide();
    $j("#supplierSettings").hide();
    $j("#dispenseContainer").hide();
    $j("#DrugCategory").hide();//
    $j("#General").hide();//
    $j("#locationNames").hide();
    $j("#locationUsers").hide();
    $j("#approvedData").hide();//

    //CloseDialog();
});





/*View to choose location*/
$j("#requestsum").click(function () {
    $j("#spinner").show();

    $j('#tab_1requestsum').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/AdultRevolveForm.jsp #dispensed', function () {
        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/adultRevolve.js", function () {

        });


    });
    $j("#drugusagepage").hide();//
    $j("#requestsumpage").hide();//
    CloseAll();

    $j("#requestsumpage").show();
    $j("#rfpreportpage").hide();
    $j("#fmapreportpage").hide();
    $j("#druglow").hide();
    $j("#drughigh").hide();
    $j("#Batchsetter").hide();
    $j("#drugSetUp").hide();
    $j("#Barcode").hide();
    $j("#locationsetter").hide();
    $j("#locationError").hide();//
    $j("#store").hide();
    $j("#stock").hide();
    $j("#psychiatrysec").hide();
    $j("#settings").hide();
    $j("#transactionsLogs").hide();
    $j("#doseManagement").hide();
    $j("#dashboarddata").hide();//
    $j("#incomingData").hide();
    $j("#incomingDatanew").hide();

    $j("#maxmin").hide();//
    $j("#outgoing").hide();
    $j("#transactionsSetting").hide();
    $j("#supplierSettings").hide();
    $j("#dispenseContainer").hide();
    $j("#DrugCategory").hide();//
    $j("#General").hide();//
    $j("#locationNames").hide();
    $j("#locationUsers").hide();
    $j("#approvedData").hide();//

    //CloseDialog();
});

/*View to choose location*/
$j("#rfpreport").click(function () {
    $j("#spinner").show();

    $j('#tab_1rfpreport').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/rfpGeneralReport.jsp #report', function () {
        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/rfpGeneralReport.js", function () {

        });


    });
    $j("#drugusagepage").hide();//
    $j("#requestsumpage").hide();//
    CloseAll();

    $j("#rfpreportpage").show();
    $j("#requestsumpage").hide();
    $j("#druglow").hide();
    $j("#drughigh").hide();
    $j("#Batchsetter").hide();
    $j("#drugSetUp").hide();
    $j("#Barcode").hide();
    $j("#locationsetter").hide();
    $j("#locationError").hide();//
    $j("#store").hide();
    $j("#stock").hide();
    $j("#psychiatrysec").hide();
    $j("#settings").hide();
    $j("#transactionsLogs").hide();
    $j("#doseManagement").hide();
    $j("#dashboarddata").hide();//
    $j("#incomingData").hide();
    $j("#incomingDatanew").hide();

    $j("#maxmin").hide();//
    $j("#outgoing").hide();
    $j("#transactionsSetting").hide();
    $j("#supplierSettings").hide();
    $j("#dispenseContainer").hide();
    $j("#DrugCategory").hide();//
    $j("#General").hide();//
    $j("#locationNames").hide();
    $j("#locationUsers").hide();
    $j("#approvedData").hide();//

    //CloseDialog();
});





/*View to choose location*/
$j("#fmapreport").click(function () {
    $j("#spinner").show();

    $j('#tab_1fmapreport').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/FmapReport.jsp #report', function () {
        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/f-maps.js", function () {

        });


    });
    $j("#drugusagepage").hide();//
    $j("#requestsumpage").hide();//
    CloseAll();
    $j("#fmapreportpage").show();
    $j("#rfpreportpage").hide();
    $j("#requestsumpage").hide();
    $j("#druglow").hide();
    $j("#drughigh").hide();
    $j("#Batchsetter").hide();
    $j("#drugSetUp").hide();
    $j("#Barcode").hide();
    $j("#locationsetter").hide();
    $j("#locationError").hide();//
    $j("#store").hide();
    $j("#stock").hide();
    $j("#psychiatrysec").hide();
    $j("#settings").hide();
    $j("#transactionsLogs").hide();
    $j("#doseManagement").hide();
    $j("#dashboarddata").hide();//
    $j("#incomingData").hide();
    $j("#incomingDatanew").hide();

    $j("#maxmin").hide();//
    $j("#outgoing").hide();
    $j("#transactionsSetting").hide();
    $j("#supplierSettings").hide();
    $j("#dispenseContainer").hide();
    $j("#DrugCategory").hide();//
    $j("#General").hide();//
    $j("#locationNames").hide();
    $j("#locationUsers").hide();
    $j("#approvedData").hide();//

    //CloseDialog();
});

/*View to choose location*/
$j("#drugusage").click(function () {
    $j("#spinner").show();

    $j('#tab_1drugusage').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/locationSetter.jsp #dlocation', function () {
        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/locationSetter.js", function () {

        });


    });

    $j("#requestsumpage").hide();//
    CloseAll();
    $j("#rfpreportpage").hide();
    $j("#fmapreportpage").hide();
    $j("#drugusagepage").show();
    $j("#druglow").hide();
    $j("#drughigh").hide();
    $j("#Batchsetter").hide();
    $j("#drugSetUp").hide();
    $j("#Barcode").hide();
    $j("#locationsetter").hide();
    $j("#locationError").hide();//
    $j("#store").hide();
    $j("#stock").hide();
    $j("#psychiatrysec").hide();
    $j("#settings").hide();
    $j("#transactionsLogs").hide();
    $j("#doseManagement").hide();
    $j("#dashboarddata").hide();//
    $j("#incomingData").hide();
    $j("#incomingDatanew").hide();

    $j("#maxmin").hide();//
    $j("#outgoing").hide();
    $j("#transactionsSetting").hide();
    $j("#supplierSettings").hide();
    $j("#dispenseContainer").hide();
    $j("#DrugCategory").hide();//
    $j("#General").hide();//
    $j("#locationNames").hide();
    $j("#locationUsers").hide();
    $j("#approvedData").hide();//

    //CloseDialog();
});

/*View incoming requests*/
$j("#dincoming").click(function () {

    $j("#spinner").show();


    $j.getJSON("locationSetter.form", function (result) {
        if (result == "none") {

            $j("#errorDiv").show();

            $j("#errorDiv").delay(5000).hide("slow");
            $j("#spinner").delay(5000).hide("slow");
        }
        else {
            $j('#tab_1incoming').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/incoming.jsp #dtab_1', function () {


                $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/drugincoming.js", function () {

                });

            });
            var data = '<strong>Drug  requests: Location4-' + result + '</strong>';
            $j('#inincominglocation').empty();
            $j("#drugusagepage").hide();//
            $j("#requestsumpage").hide();//
            CloseAll();

            $j(data).appendTo(' #inincominglocation');
            $j("#Batchsetter").hide();
            $j("#drugSetUp").hide();
            $j("#Barcode").hide();
            $j("#incomingData").show("slow");
            $j("#incomingDatanew").hide();
            $j("#rfpreportpage").hide();
            $j("#fmapreportpage").hide();
            $j("#druglow").hide();
            $j("#drughigh").hide();
            $j("#spinner").hide();
            $j("#locationsetter").hide();
            $j("#dispenseContainer").hide();//
            $j("#outgoing").hide();
            $j("#transactionsSetting").hide();
            $j("#supplierSettings").hide();
            $j("#store").hide();
            $j("#stock").hide();
            $j("#psychiatrysec").hide();
            $j("#settings").hide();
            $j("#DrugCategory").hide();//
            $j("#General").hide();//
            $j("#transactionsLogs").hide();
            $j("#doseManagement").hide();
            $j("#dashboarddata").hide();//
            $j("#maxmin").hide();//
            $j("#locationNames").hide();
            $j("#locationUsers").hide();
            $j("#approvedData").hide();//
        }
    });

});
$j("#dincomingnew").click(function () {
    $j("#spinner").show();


    $j.getJSON("locationSetter.form", function (result) {
        if (result == "none") {

            $j("#errorDiv").show();

            $j("#errorDiv").delay(5000).hide("slow");
            $j("#spinner").delay(5000).hide("slow");
        }
        else {
            $j('#tab_1incomingnew').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/incomingnew.jsp #dtab_1', function () {


                $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/drugincomingnew.js", function () {

                });

            });
            var data = '<strong>Drug  requests: Location5-' + result + '</strong>';
            $j('#inincominglocation').empty();
            $j("#drugusagepage").hide();//
            $j("#requestsumpage").hide();//
            CloseAll();
            $j("#rfpreportpage").hide();
            $j("#fmapreportpage").hide();
            $j(data).appendTo(' #inincominglocation');
            $j("#Batchsetter").hide();
            $j("#drugSetUp").hide();
            $j("#Barcode").hide();
            $j("#incomingData").hide();
            $j("#incomingDatanew").show("slow");

            $j("#druglow").hide();
            $j("#drughigh").hide();
            $j("#spinner").hide();
            $j("#locationsetter").hide();
            $j("#dispenseContainer").hide();//
            $j("#outgoing").hide();
            $j("#transactionsSetting").hide();
            $j("#supplierSettings").hide();
            $j("#store").hide();
            $j("#stock").hide();
            $j("#psychiatrysec").hide();
            $j("#settings").hide();
            $j("#DrugCategory").hide();//
            $j("#General").hide();//
            $j("#transactionsLogs").hide();
            $j("#doseManagement").hide();
            $j("#dashboarddata").hide();//
            $j("#maxmin").hide();//
            $j("#locationNames").hide();
            $j("#locationUsers").hide();
            $j("#approvedData").hide();//

            //CloseDialog();

        }
    });

});


/*Veiw approved request*/


$j("#dapproved").click(function () {
    $j("#spinner").show();


    $j.getJSON("locationSetter.form", function (result) {


        if (result == "none") {

            $j("#errorDiv").show();

            $j("#errorDiv").delay(5000).hide("slow");
            $j("#spinner").delay(5000).hide("slow");
        }
        else {
            $j('#tab_1approved').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/approved.jsp #dtab_1', function () {


                $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/drugapproved.js", function () {

                });

            });
            // $j('#outgoinglocation #inoutgoinglocation').replaceWith(" Drug Outgoing requests: Location-"+result);
            var data = '<strong>Drug approved requests: Location6-' + result + '</strong>';
            $j('#approvedlocation').empty();
            $j(data).appendTo(' #approvedlocation');
            $j("#drugusagepage").hide();//
            $j("#requestsumpage").hide();//

            CloseAll();
            $j("#rfpreportpage").hide();
            $j("#fmapreportpage").hide();
            $j("#outgoing").hide();
            $j("#spinner").hide();
            $j("#druglow").hide();
            $j("#drughigh").hide();
            $j("#incomingData").hide();
            $j("#incomingDatanew").hide();

            $j("#locationsetter").hide();
            $j("#Batchsetter").hide();
            $j("#drugSetUp").hide();
            $j("#Barcode").hide();
            $j("#store").hide();
            $j("#stock").hide();
            $j("#DrugCategory").hide();// locationNames
            $j("#locationNames").hide();
            $j("#psychiatrysec").hide();
            $j("#settings").hide();
            $j("#transactionsLogs").hide();
            $j("#doseManagement").hide();
            $j("#dashboarddata").hide();//
            $j("#dispenseContainer").hide();//
            $j("#General").hide();//
            $j("#transactionsSetting").hide();
            $j("#supplierSettings").hide();
            $j("#locationNames").hide();
            $j("#locationUsers").hide();
            $j("#approvedData").show();//
            $j("#maxmin").hide();//
            //		CloseDialog();
        }
    });

});
/*outgoing requests view*/
$j("#doutgoing").click(function () {
    $j("#spinner").show();


    $j.getJSON("locationSetter.form", function (result) {


        if (result == "none") {

            $j("#errorDiv").show();

            $j("#errorDiv").delay(5000).hide("slow");
            $j("#spinner").delay(5000).hide("slow");
        }
        else {
            $j('#tab_1outgoing').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/outgoing.jsp #dtab_1', function () {


                $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/drugoutgoing.js", function () {

                });

            });
            var data = '<strong>Drug requests from other sites: Location7-' + result + '</strong>';
            $j('#inoutgoinglocation').empty();
            $j(data).appendTo(' #inoutgoinglocation');

            $j("#drugusagepage").hide();//
            $j("#requestsumpage").hide();//
            CloseAll();
            $j("#rfpreportpage").hide();
            $j("#fmapreportpage").hide();
            $j("#outgoing").show("slow");
            $j("#spinner").hide();
            $j("#druglow").hide();
            $j("#drughigh").hide();
            $j("#incomingData").hide();
            $j("#incomingDatanew").hide();

            $j("#locationsetter").hide();
            $j("#Batchsetter").hide();
            $j("#drugSetUp").hide();
            $j("#Barcode").hide();
            $j("#store").hide();
            $j("#stock").hide();
            $j("#DrugCategory").hide();// locationNames

            $j("#psychiatrysec").hide();
            $j("#settings").hide();
            $j("#transactionsLogs").hide();
            $j("#doseManagement").hide();
            $j("#dashboarddata").hide();//
            $j("#dispenseContainer").hide();//
            $j("#General").hide();//
            $j("#transactionsSetting").hide();
            $j("#supplierSettings").hide();
            $j("#locationNames").hide();
            $j("#locationUsers").hide();
            $j("#approvedData").hide();//

            $j("#maxmin").hide();//

        }
    });

});

/*view transaction logs*/
$j("#dtransactions").click(function () {
    $j("#spinner").show();
    $j.getJSON("locationSetter.form", function (result) {
        if (result == "none") {
            $j("#errorDiv").show();
            $j("#errorDiv").delay(5000).hide("slow");
            $j("#spinner").delay(5000).hide("slow");
        }
        else {
            $j('#transactionstab_1').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/drugtransactions.jsp #dtransactionsdiv', function () {

                $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/drugtransactions.js", function () {

                });
            });
            //	 $j('#transactionslocation #intransactionslocation').replaceWith(" Drug transactions : Location-"+result);
            var data = '<strong>Drug transactions: Location8-' + result + '</strong>';
            $j('#intransactionslocation').empty();
            $j(data).appendTo(' #intransactionslocation');

            $j("#drugusagepage").hide();//
            $j("#requestsumpage").hide();//
            CloseAll();
            $j("#rfpreportpage").hide();
            $j("#fmapreportpage").hide();
            $j("#transactionsLogs").show("slow");
            $j("#doseManagement").hide();
            $j("#druglow").hide();
            $j("#drughigh").hide();
            $j("#spinner").hide();
            $j("#locationsetter").hide();
            $j("#incomingData").hide();
            $j("#incomingDatanew").hide();

            $j("#psychiatrysec").hide();
            $j("#store").hide();
            $j("#stock").hide();
            $j("#settings").hide();
            $j("#dashboarddata").hide();//
            $j("#dispenseContainer").hide();//
            $j("#General").hide();//
            $j("#Batchsetter").hide();
            $j("#drugSetUp").hide();
            $j("#Barcode").hide();
            $j("#outgoing").hide();
            $j("#DrugCategory").hide();//
            $j("#locationNames").hide();
            $j("#locationUsers").hide();
            $j("#transactionsSetting").hide();
            $j("#supplierSettings").hide();
            $j("#maxmin").hide();//
            $j("#approvedData").hide();//
        }
    });
});
$j("#dmanager").click(function () {
    $j("#spinner").show();
    $j.getJSON("locationSetter.form", function (result) {
        if (result == "none") {
            $j("#errorDiv").show();
            $j("#errorDiv").delay(5000).hide("slow");
            $j("#spinner").delay(5000).hide("slow");
        }
        else {
            $j('#doseManagerDisplay').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/doseForm.jsp #dnames', function () {
                $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/doseForm.js", function () {
                });
            });
            //	 $j('#transactionslocation #intransactionslocation').replaceWith(" Drug transactions : Location-"+result);
            var data = '<strong>Drug transactions: Location9-' + result + '</strong>';
            $j('#intransactionslocation').empty();
            $j(data).appendTo(' #intransactionslocation');
            $j("#drugusagepage").hide();//
            $j("#requestsumpage").hide();//
            CloseAll();
            $j("#rfpreportpage").hide();
            $j("#fmapreportpage").hide();
            $j("#transactionsLogs").hide();
            $j("#doseManagement").show();
            $j("#druglow").hide();
            $j("#drughigh").hide();
            $j("#spinner").hide();
            $j("#locationsetter").hide();
            $j("#incomingData").hide();
            $j("#incomingDatanew").hide();
            $j("#psychiatrysec").hide();
            $j("#store").hide();
            $j("#stock").hide();
            $j("#settings").hide();
            $j("#dashboarddata").hide();//
            $j("#dispenseContainer").hide();//
            $j("#General").hide();//
            $j("#Batchsetter").hide();
            $j("#drugSetUp").hide();
            $j("#Barcode").hide();
            $j("#outgoing").hide();
            $j("#DrugCategory").hide();//
            $j("#locationNames").hide();
            $j("#locationUsers").hide();
            $j("#transactionsSetting").hide();
            $j("#supplierSettings").hide();
            $j("#maxmin").hide();//
            $j("#approvedData").hide();//
        }
    });
});
$j("#patient").click(function () {
    $j("#patientInfo").hide();
    $j("#patient").hide();
    $j("#corn").show();
});
$j("#edit_encounter").click(function () {
    $j('#tab_1transactions').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/editPrescription.jsp #edit_prescription', function () {});
});

$j("#cstrength").click(function () {
    $j('#tab_2').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/drugstrength.jsp #dstrength', function () {

        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/drugstrength.js", function () {

        });

    });
});

$j("#cdnames").click(function () {

    $j('#tab_4').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/drugnames.jsp #dnames', function () {

        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/drugnames.js", function () {

        });
    });

});

$j("#cunits").click(function () {
    $j('#tab_3').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/drugunits.jsp #dunits', function () {


        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/drugunit.js", function () {

        });

    });

});
$j("#rnames").click(function () {


    $j('#regimentab_1').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/regimenname.jsp #rnamediv', function () {


        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/regimennames.js", function () {

        });


    });


});
$j("#combinationnames").click(function () {

    $j('#regimentab_2').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/regimencombinations.jsp #rcombidiv', function () {


        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/drugregimen.js", function () {

        });
    });
});
$j("#cnames").click(function () {

    $j('#tab_6').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/drugdetails.jsp #details', function () {


        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/drugdetails.js", function () {

        });

    });


});

$j("#cdoses").click(function () {

    $j('#tab_7').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/drugdoses.jsp #ddoses', function () {


        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/drugdoses.js", function () {

        });

    });
});

$j("#cfrequency").click(function () {


    $j('#tab_5').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/drugfrequency.jsp #dfrequency', function () {


        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/drugfrequency.js", function () {

        });

    });


});

/*Drug settings*/
$j("#dsettings").click(function () {
    $j('#tab_1').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/drugformulation.jsp #dformulation', function () {


        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/drugformulation.js", function () {
        });
    });

    $j("#drugusagepage").hide();//
    $j("#requestsumpage").hide();//

    $j("#maxmin").hide();//
    $j("#settings").show("slow");
    $j("#druglow").hide();
    $j("#drughigh").hide();
    $j("#incomingData").hide();
    $j("#incomingDatanew").hide();

    $j("#locationNames").hide();
    $j("#locationUsers").hide();
    $j("#locationsetter").hide();
    $j("#psychiatrysec").hide();
    $j("#store").hide();
    $j("#stock").hide();
    $j("#transactionsLogs").hide();
    $j("#doseManagement").hide();
    $j("#dispenseContainer").hide();//
    $j("#dashboarddata").hide();//
    $j("#incoming").hide();
    $j("#Batchsetter").hide();
    $j("#drugSetUp").hide();
    $j("#Barcode").hide();
    $j("#outgoing").hide();
    $j("#locationsetter").hide();//
    $j("#transactionsSetting").hide();
    $j("#supplierSettings").hide();
    $j("#DrugCategory").hide();//
    $j("#approvedData").hide();//
    $j("#General").hide();//

    //loseDialog();
});

/*View suppliers*/
$j("#Asupplier").click(function () {
    $j('#tab_1Supplier').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/suppliernames.jsp #dnames', function () {


        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/suppliers.js", function () {
        });
    });
    $j("#drugusagepage").hide();//
    $j("#requestsumpage").hide();//

    $j("#druglow").hide();
    $j("#drughigh").hide();
    $j("#incomingData").hide();
    $j("#incomingDatanew").hide();

    $j("#incoming").hide();
    $j("#locationNames").hide();
    $j("#locationUsers").hide();
    $j("#outgoing").hide();
    $j("#Batchsetter").hide();
    $j("#drugSetUp").hide();
    $j("#Barcode").hide();
    $j("#supplierSettings").show("slow");
    $j("#locationsetter").hide();//
    $j("#settings").hide();
    $j("#psychiatrysec").hide();
    $j("#store").hide();
    $j("#stock").hide();
    $j("#transactionsLogs").hide();
    $j("#doseManagement").hide();
    $j("#dispenseContainer").hide();//
    $j("#dashboarddata").hide();//
    $j("#DrugCategory").hide();//
    $j("#maxmin").hide();//
    $j("#transactionsSetting").hide();
    $j("#approvedData").hide();//
    $j("#General").hide();//
    //	CloseDialog();
});
/*tt---> for transaction types view*/


$j("#tt").click(function () {


    $j("#parent_div_2").hide();


    $j("#parent_div_1").hide();
    $j("#spinner").show();
    /*Check if location has been set */
    $j.getJSON("locationSetter.form", function (result) {
        if (result == "none") {
            $j("#errorDiv").show();

            $j("#errorDiv").delay(5000).hide("slow");
            $j("#spinner").delay(5000).hide("slow");
        }
        else {

            $j('#tab_1transactions').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/transactiontypenames.jsp #dnames', function () {


                $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/transactiontypes.js", function () {
                });
            });
            $j("#drugusagepage").hide();//
            $j("#requestsumpage").hide();//

            $j("#druglow").hide();
            $j("#drughigh").hide();
            $j("#incomingData").hide();
            $j("#incomingDatanew").hide();

            $j("#incoming").hide();
            $j("#Batchsetter").hide();
            $j("#drugSetUp").hide();
            $j("#Barcode").hide();
            $j("#outgoing").hide();
            $j("#transactionsSetting").show("slow");
            $j("#locationsetter").hide();//
            $j("#supplierSettings").hide();
            $j("#settings").hide();
            $j("#psychiatrysec").hide();
            $j("#store").hide();
            $j("#stock").hide();
            $j("#transactionsLogs").hide();
            $j("#doseManagement").hide();
            $j("#dispenseContainer").hide();//
            $j("#dashboarddata").hide();//
            $j("#DrugCategory").hide();//
            $j("#locationNames").hide();
            $j("#locationUsers").hide();
            $j("#locationUsers").hide();
            $j("#maxmin").hide();//
            $j("#approvedData").hide();//
            $j("#General").hide();//
            //CloseDialog();
        }
    });
});
/*View locations names*/
$j("#locationName").click(function () {
    $j('#tab_1location').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/locationNames.jsp #dnames', function () {


        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/locationNames.js", function () {
        });
    });
    $j("#drugusagepage").hide();//
    $j("#requestsumpage").hide();//

    $j("#locationNames").show("slow");
    $j("#locationUsers").hide();
    $j("#druglow").hide();
    $j("#drughigh").hide();
    $j("#incomingData").hide();   $j("#incomingDatanew").hide();


    $j("#incoming").hide();
    $j("#Batchsetter").hide();
    $j("#drugSetUp").hide();
    $j("#Barcode").hide();
    $j("#outgoing").hide();
    $j("#transactionsSetting").hide();
    $j("#locationsetter").hide();//
    $j("#supplierSettings").hide();
    $j("#settings").hide();
    $j("#psychiatrysec").hide();
    $j("#store").hide();
    $j("#stock").hide();
    $j("#transactionsLogs").hide();
    $j("#doseManagement").hide();
    $j("#dispenseContainer").hide();//
    $j("#dashboarddata").hide();//
    $j("#DrugCategory").hide();//
    $j("#maxmin").hide();//
    $j("#approvedData").hide();//
    $j("#General").hide();//
    //CloseDialog();
});
/*Tie users to specificlocations*/
$j("#locationUser").click(function () {
    $j('#tab_1locationuser').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/locationUsers.jsp #dnames', function () {


        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/locationUsers.js", function () {
        });
    });
    $j("#drugusagepage").hide();//
    $j("#requestsumpage").hide();//

    $j("#locationNames").hide();
    $j("#locationUsers").show("slow");
    $j("#druglow").hide();
    $j("#drughigh").hide();
    $j("#incomingData").hide()
    $j("#incomingDatanew").hide();

    $j("#incoming").hide();
    $j("#Batchsetter").hide();
    $j("#drugSetUp").hide();
    $j("#Barcode").hide();
    $j("#outgoing").hide();
    $j("#transactionsSetting").hide();
    $j("#locationsetter").hide();//
    $j("#supplierSettings").hide();
    $j("#settings").hide();
    $j("#psychiatrysec").hide();
    $j("#store").hide();
    $j("#stock").hide();
    $j("#transactionsLogs").hide();
    $j("#doseManagement").hide();
    $j("#dispenseContainer").hide();//
    $j("#dashboarddata").hide();//
    $j("#DrugCategory").hide();//
    $j("#maxmin").hide();//
    $j("#approvedData").hide();//
    $j("#General").hide();//
    //CloseDialog();
});

/*View max and min level setters*/
$j("#Dmaxmin").click(function () {
    $j('#tab_1maxmin').load('${pageContext.request.contextPath}/moduleResources/pharmacy/subpages/drugMaxMin.jsp #dnames', function () {


        $j.getScript("${pageContext.request.contextPath}/moduleResources/pharmacy/jspharmacy/drugMaxMin.js", function () {
        });
    });
    $j("#drugusagepage").hide();//
    $j("#requestsumpage").hide();//

    $j("#maxmin").show("slow");
    $j("#locationNames").hide();
    $j("#locationUsers").hide();
    $j("#druglow").hide();
    $j("#drughigh").hide();
    $j("#incomingData").hide();
    $j("#incomingDatanew").hide();

    $j("#incoming").hide();
    $j("#Batchsetter").hide();
    $j("#drugSetUp").hide();
    $j("#Barcode").hide();
    $j("#outgoing").hide();
    $j("#transactionsSetting").hide();
    $j("#locationsetter").hide();//
    $j("#supplierSettings").hide();
    $j("#settings").hide();
    $j("#psychiatrysec").hide();
    $j("#store").hide();
    $j("#stock").hide();
    $j("#transactionsLogs").hide();
    $j("#doseManagement").hide();
    $j("#dispenseContainer").hide();//
    $j("#dashboarddata").hide();//
    $j("#DrugCategory").hide();//
    $j("#approvedData").hide();//

    $j("#General").hide();//
    //CloseDialog();
});
/*get form data just a test*/
function getData() {


    $j.getJSON("jsonforms.form?datajson=cf7f7bd6-8407-47bb-8846-06af87557323",
            function (result) {

                $j("#psychiatryform").buildForm(JSON.parse(result));
            });

}
/*Generic error dialog */
$j("#errorDialog").dialog({
    autoOpen:false,
    height:250,
    width:300,
    cache:false,
    modal:true,
    buttons:{

        Ok:function () {
            $j(this).dialog('close');
        }
    }
});

/*Start Dispensing view */
$j("#psychiatry").click(function () {

    $j("#spinner").show();


    $j.getJSON("locationSetter.form", function (result) {


        if (result == "none") {

            $j("#errorDiv").show();

            $j("#errorDiv").delay(5000).hide("slow");
            $j("#spinner").delay(5000).hide("slow");
        }
        else {

            $j("#drugusagepage").hide();//
            $j("#requestsumpage").hide();//

            //	getData();
            $j("#spinner").hide();
            $j("#psychiatrysec").show();
            $j("#locationsetter").hide();//

            $j("#druglow").hide();
            $j("#drughigh").hide();
            $j("#incomingData").hide();



            $j("#incomingDatanew").hide();

            $j("#incoming").hide();
            $j("#Batchsetter").hide();
            $j("#drugSetUp").hide();
            $j("#Barcode").hide();
            $j("#outgoing").hide();
            $j("#transactionsSetting").hide();
            $j("#locationNames").hide();
            $j("#locationUsers").hide();
            $j("#transactionsLogs").hide();
            $j("#doseManagement").hide();
            $j("#store").hide();
            $j("#stock").hide();
            $j("#settings").hide();
            $j("#dispenseContainer").hide();//
            $j("#dashboarddata").hide();//
            $j("#supplierSettings").hide();
            $j("#DrugCategory").hide();//
            $j("#maxmin").hide();//
            $j("#approvedData").hide();//

            CloseDialog();

            $j("#General").hide();//
        }


    });

});

/*Generic form when a user submits from it */
$j("form#generalform").submit(function () {

    if ($j("#medication").val() != "") {

        var values = $j("input[id='medication']")
                .map(
                function () {
                    return $j(this).val().substring($j(this).val().indexOf("#") + 1);
                }).get();
        var values2 = $j("input[id='month1']")
                .map(
                function () {
                    return $j(this).val();
                }).get();


        var vals = values.toString().split(",");
        var vals2 = values2.toString().split(",");
        var size = vals.length;
        var json = {};
        for (i = 0; i < size; i++) {


            if (json.hasOwnProperty(vals[i])) {


                var tot = parseInt(json[vals[i]]) + parseInt(vals2[i]);

                json[vals[i]] = tot;

            }
            else
                json[vals[i]] = vals2[i];


        }


        $j.ajax({
            type:"GET",
            url:"dispense.form",

            data:{drugCheck:JSON.stringify(json) },
            dataType:"json",
            success:function (result) {

                if (result.toString() == 'true') {

                    var fields = $j("#generalform").serializeArray();


                    $j.ajax({
                        type:"POST",
                        url:"hiv.form",

                        data:{values:JSON.stringify(fields) },
                        dataType:"json",
                        beforeSend:function (x) {
                            if (x && x.overrideMimeType) {
                                x.overrideMimeType("application/j-son;charset=UTF-8");
                            }
                        },
                        success:function () {

                            clear_form_elements("#generalform");
                        }
                    });

                }
                else {


                    $j("#info").text("Cannot dispense now you have not set batch no !!!!!");

                    $j("#info").css("color", "red");
                    setTimeout(function () {
                        $j("#info").css("color", "white");
                    }, 10000);


                }

            }
        });


    }
    else {
        $j("#info").text("You must add drugs ");

        $j("#info").css("color", "red");
        setTimeout(function () {
            $j("#info").css("color", "white");
        }, 5000);

    }


    return false;
});
/*Function to clear form elements*/
function clear_form_elements(ele) {

    $j(ele).find(':input').each(function () {


        switch (this.type) {
            case 'password':
            case 'select-multiple':
            case 'select-one':
            case 'text':
            case 'hidden':
            case 'textarea':
                $j(this).val('');
                break;
            case 'checkbox':
            case 'radio':
                this.checked = false;
        }
    });

}



CloseDialog();


})
;
</script>
</head>
<body>
<DIV id="center" class="ui-layout-center">
<DIV id="dashboarddata">
    <div id="dialog" title="Inventory">
        <table cellpadding="0" cellspacing="0" border="0" class="display"
               id="tdialog">
            <thead>
            <tr>
                <th>Drug</th>
                <th>Quantity</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th></th>
                <th></th>
            </tr>
            </tbody>

        </table>
    </div>
    <div id="dialog1" title="Patient regimen use">Nevirapine : 5</div>
</DIV>
<div id="errorDialog" title="Error">
</div>
<DIV id="locationErrorb" class="header-footer ui-state-default ui-corner-all"
     style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
    <DIV id="inoutgoinglocationb">
    </DIV>
</DIV>
<DIV id="dataDiv" class="header-footer ui-state-default ui-corner-all"
     style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
    <DIV class="loc"> test</DIV>
</DIV>
<div id="spinner">
    <img id="img-spinner" src="${pageContext.request.contextPath}/moduleResources/pharmacy/images/pharmacyloader.gif"
         alt="Loading"/></div>
<DIV id="store">
    <DIV id="storelocation" class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        <DIV id="instorelocation">
            Drug
            management
        </DIV>
    </DIV>
    <UL style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1storee" id="bincardlink"><SPAN>Bincard</SPAN> </A> </LI>
        <LI><A href="#tab_1totaldrugs" id="bincardtotaldrugs"><SPAN>Bincard Totals</SPAN></A></LI>
    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">
        <DIV id="tab_1storee"></DIV>
        <DIV id="tab_1totaldrugs"></DIV>
    </DIV>
</DIV>
<DIV id="stock">
    <DIV id="storelocation" class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        <DIV id="instorelocationstcok">Stock take</DIV>
    </DIV>
    <UL style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1stock" id="bincardlink"><SPAN>Stock take</SPAN></A> </LI>
    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom" style="border-top: 0; padding-bottom: 1em;">
        <DIV id="tab_1stock"></DIV> </DIV>
</DIV>
<DIV id="druglow"> <DIV id="storelocation" class="header-footer ui-state-default ui-corner-all"
                        style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
    <DIV id="inlowlocation">Drug Low level</DIV>
</DIV>
    <UL style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1low" id="bincardlink"><SPAN>Low Levels</SPAN></A></LI>
    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">
        <DIV id="tab_1low"></DIV>
    </DIV>
</DIV>
<DIV id="drughigh">
    <DIV id="storelocation" class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        <DIV id="inhighlocation"> Drug high levels </DIV>
    </DIV>
    <UL
            style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1high" id="bincardlink"><SPAN>High Levels</SPAN>
        </A>
        </LI>

    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">
        <DIV id="tab_1high"></DIV>

    </DIV>
</DIV>
<DIV id="incomingData">

    <DIV id="incominglocation" class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">


        <DIV id="inincominglocation">
            Drug
            Incoming requests

        </DIV>
    </DIV>
    <DIV id="incomingInfo" class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">


        <DIV class="loc">

            test
        </DIV>

    </DIV>
    <UL
            style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1storee" id="bincardlink"><SPAN>Incoming</SPAN>
        </A>
        </LI>

    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">

        <div id="incomingperm">
            <form id="Permissionincoming" action="#">

                <fieldset>

                    <legend>Permission</legend>

                    <label>Requisition officer:</label>
                    <openmrs_tag:userField formFieldName="providerId"
                                           roles="Trusted+External+Application,Lab+Technician,Community+Health+Worker+Nutritionist,Clinician,Nurse,Psychosocial+Support+Staff,Pharmacist,HCT+Nurse,Outreach+Worker,Community+Health+Extension+Worker,Clinical+Officer,Provider"
                                           callback="selectedChwProvider"/><br/>
                    <input type="hidden" name="requisition" id="requisition" value=" "/> <br/>
                    <label> Issued by:</label>
                    <openmrs_tag:userField formFieldName="providerId1"
                                           roles="Trusted+External+Application,Lab+Technician,Community+Health+Worker+Nutritionist,Clinician,Nurse,Psychosocial+Support+Staff,Pharmacist,HCT+Nurse,Outreach+Worker,Community+Health+Extension+Worker,Clinical+Officer,Provider"
                                           callback="selectedChwProvider1"/><br/>
                    <input type="hidden" name="issued" id="issued" value=" "/> <br/>
                    <label> Authorized by:</label>
                    <openmrs_tag:userField formFieldName="providerId2"
                                           roles="Trusted+External+Application,Lab+Technician,Community+Health+Worker+Nutritionist,Clinician,Nurse,Psychosocial+Support+Staff,Pharmacist,HCT+Nurse,Outreach+Worker,Community+Health+Extension+Worker,Clinical+Officer,Provider"
                                           callback="selectedChwProvider2"/><br/>
                    <input type="hidden" name="authorized" id="authorized" value=" "/>

                </fieldset>
            </form>

        </div>
        <DIV id="tab_1incoming"></DIV>

    </DIV>
</DIV>
<DIV id="incomingDatanew">

    <DIV id="incominglocationnew" class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">


        <DIV id="inincominglocationnew">
            Drug
            Incoming requests

        </DIV>
    </DIV>
    <DIV id="incomingInfonew" class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">


        <DIV class="loc">

            test
        </DIV>

    </DIV>
    <UL
            style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1storee" id="bincardlinknew"><SPAN>Incoming</SPAN>
        </A>
        </LI>

    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">


        <DIV id="tab_1incomingnew"></DIV>

    </DIV>
</DIV>

<DIV id="approvedData">

    <DIV id="approvedlocation" class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">


        <DIV id="approvedlocation">
            Approved requests

        </DIV>
    </DIV>

    <UL
            style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1storee" id="bincardlink"><SPAN>Approved</SPAN>
        </A>
        </LI>

    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">
        <div id="approvedperm">
            <%--<form id="Permissionapproved" action="#">--%>

            <%--<fieldset>--%>

            <%--<legend>Permission</legend>--%>

            <%--<label>Requisition officer:</label>--%>
            <%--<openmrs_tag:userField formFieldName="providerIdp"   roles="Trusted+External+Application,Lab+Technician,Community+Health+Worker+Nutritionist,Clinician,Nurse,Psychosocial+Support+Staff,Pharmacist,HCT+Nurse,Outreach+Worker,Community+Health+Extension+Worker,Clinical+Officer,Provider" callback="selectedChwProvider" /><br />--%>
            <%--<input type="hidden" name="requisitionp" id="requisitionp" value=" " />	<br />--%>
            <%--&lt;%&ndash;<label> Issued by:</label>&ndash;%&gt;--%>
            <%--&lt;%&ndash;<openmrs_tag:userField formFieldName="providerId1p"   roles="Trusted+External+Application,Lab+Technician,Community+Health+Worker+Nutritionist,Clinician,Nurse,Psychosocial+Support+Staff,Pharmacist,HCT+Nurse,Outreach+Worker,Community+Health+Extension+Worker,Clinical+Officer,Provider" callback="selectedChwProvider1" /><br />&ndash;%&gt;--%>
            <%--&lt;%&ndash;<input type="hidden" name="issuedp" id="issuedp" value=" " />	<br />&ndash;%&gt;--%>
            <%--<label>  Authorized by:</label>--%>
            <%--<openmrs_tag:userField formFieldName="providerId2p"   roles="Trusted+External+Application,Lab+Technician,Community+Health+Worker+Nutritionist,Clinician,Nurse,Psychosocial+Support+Staff,Pharmacist,HCT+Nurse,Outreach+Worker,Community+Health+Extension+Worker,Clinical+Officer,Provider" callback="selectedChwProvider2" /><br />--%>
            <%--<input type="hidden" name="authorizedp" id="authorizedp" value=" " />	<br />--%>

            <%--</fieldset>--%>
            <%--</form>--%>

        </div>

        <DIV id="tab_1approved"></DIV>

    </DIV>
</DIV>

<DIV id="outgoing">


    <DIV id="outgoinglocation" class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">


        <DIV id="inoutgoinglocation">
            Drug
            Outgoing requests

        </DIV>
    </DIV>


    <DIV id="outgoingInfo" class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">


        <DIV id="inoutgoingInfo">

            <div id='red'>Its already approved</div>
        </DIV>

    </DIV>
    <UL
            style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1storee" id="bincardlink"><SPAN>Outgoing</SPAN>
        </A>
        </LI>


    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">

        <div id="outgoingperm">
            <%--<form id="Permission" action="#">--%>

            <%--<fieldset>--%>

            <%--<legend>Permission</legend>--%>

            <%--<label>Requisition officer:</label>--%>
            <%--<openmrs_tag:userField formFieldName="providerIdo"   roles="Trusted+External+Application,Lab+Technician,Community+Health+Worker+Nutritionist,Clinician,Nurse,Psychosocial+Support+Staff,Pharmacist,HCT+Nurse,Outreach+Worker,Community+Health+Extension+Worker,Clinical+Officer,Provider" callback="selectedChwProvider" /><br />--%>
            <%--<input type="hidden" name="requisitiono" id="requisitiono" value=" " />	<br />--%>
            <%--&lt;%&ndash;<label> Issued by:</label>&ndash;%&gt;--%>
            <%--&lt;%&ndash;<openmrs_tag:userField formFieldName="providerId1o"   roles="Trusted+External+Application,Lab+Technician,Community+Health+Worker+Nutritionist,Clinician,Nurse,Psychosocial+Support+Staff,Pharmacist,HCT+Nurse,Outreach+Worker,Community+Health+Extension+Worker,Clinical+Officer,Provider" callback="selectedChwProvider1" /><br />&ndash;%&gt;--%>
            <%--&lt;%&ndash;<input type="hidden" name="issuedo" id="issuedo" value=" " />	<br />&ndash;%&gt;--%>
            <%--<label>  Authorized by:</label>--%>
            <%--<openmrs_tag:userField formFieldName="providerId2o"   roles="Trusted+External+Application,Lab+Technician,Community+Health+Worker+Nutritionist,Clinician,Nurse,Psychosocial+Support+Staff,Pharmacist,HCT+Nurse,Outreach+Worker,Community+Health+Extension+Worker,Clinical+Officer,Provider" callback="selectedChwProvider2" /><br />--%>
            <%--<input type="hidden" name="authorizedo" id="authorizedo" value=" " />	<br />--%>

            <%--</fieldset>--%>
            <%--</form>--%>

        </div>

        <br/>

        <DIV id="tab_1outgoing">


        </DIV>

    </DIV>
</DIV>
<DIV id="settings">

    <DIV class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        Drug settings
    </DIV>
    <UL
            style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1"><SPAN>Formulations</SPAN> </A>
        </LI>
        <LI><A href="#tab_2" id="cstrength"><SPAN>Strength</SPAN>
        </A>
        </LI>
        <LI><A href="#tab_3" id="cunits"><SPAN>Units</SPAN> </A>
        </LI>
        <LI><A href="#tab_4" id="cdnames"><SPAN>Drug names</SPAN>
        </A>
        </LI>


        <LI><A href="#tab_5" id="cfrequency"><SPAN>Frequency</SPAN>
        </A>
        </LI>
        <LI><A href="#tab_6" id="cnames"><SPAN>Drug details</SPAN>
        </A>
        </LI>
        <LI><A href="#tab_7" id="cdoses"><SPAN>Doses</SPAN> </A>
        </LI>


    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">
        <DIV id="tab_1"></DIV>

        <DIV id="tab_2"></DIV>
        <DIV id="tab_3"></DIV>


        <DIV id="tab_4"></DIV>

        <DIV id="tab_5"></DIV>

        <DIV id="tab_6"></DIV>
        <DIV id="tab_7"></DIV>


    </DIV>
</DIV>

<DIV id="errorDiv" class="header-footer ui-state-default ui-corner-all"
     style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
    Location not set! set first to proceed
</DIV>


<DIV id="transactionsLogs">

    <DIV id="transactionslocation" class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        <DIV id="intransactionslocation">Drug Outgoing requests</DIV>
    </DIV>
    <UL style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#transactionstab_1"><SPAN>Drug transactions </SPAN> </A></LI>
    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">
        <DIV id="transactionstab_1"></DIV>
    </DIV>
</DIV>
<DIV id="doseManagement">
    <DIV  class="ui-layout-content ui-widget-content ui-corner-bottom" style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        <DIV id="doseManagerDisplay">Dose Management</DIV>
    </DIV>
</DIV>
<DIV id="dispenseContainer">

    <DIV class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        General Dispensing Form
    </DIV>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">


        <DIV id="regimentab_1"></DIV>

        <DIV id="regimentab_2"></DIV>


    </DIV>
</DIV>
<DIV id="psychiatrysec">

    <DIV class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        Dispensing forms
    </DIV>
    <UL
            style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1psychiatry"><SPAN>Dispense </SPAN> </A>
        </LI>
        <DIV id="patientInfo" class="header-footer ui-state-default ui-corner-all"
             style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
            <DIV class="locc">
                test
            </DIV>
        </DIV>
    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom" style="border-top: 0; padding-bottom: 1em;">
        <fieldset id="parent_field">
            <A href="#" class="top" id="patient"> Search patient</A>
        </fieldset>
        <div id="corn">
            <form id="cornform">
                <fieldset>
                    <legend>
                        <c:if test="${empty patient}">Enter and select the patient:</c:if>
                        <c:if test="${not empty patient}">Profile</c:if>
                    </legend>
                    <input id="hiddenfield" type="hidden" name="fieldCount"/>
                    <div>
                        <div>
                            <c:choose>
                                <c:when test="${empty patient}">
                                    <style>
                                        #openmrsSearchTable_wrapper {
                                            /* Removes the empty space between the widget and the Create New Patient section if the table is short */
                                            /* Over ride the value set by datatables */
                                            min-height: 0px;
                                            height: auto !important;
                                        }
                                    </style>
                                    <script type="text/javascript">
                                    </script>
                                    <div>
                                        <div class="searchWidgetContainer" id="findPatients"></div>
                                    </div>

                                </c:when>
                                <c:otherwise>
                                    <c:if test="${not empty patient}">
                                        <table border="0" style="background-color: #B4D1B6;">
                                            <tr>
                                                <td><b>Name: &nbsp;</b> <c:if
                                                        test="${not empty patient.givenName}">${patient.givenName}
                                                    &nbsp;</c:if>
                                                    <c:if test="${not empty patient.middleName}">${patient.middleName}
                                                        &nbsp;</c:if>
                                                    <c:if test="${not empty patient.familyName}">${patient.familyName}</c:if>
                                                </td>
                                                <td><b>DOB (Age): &nbsp;</b> <c:if
                                                        test="${not empty patient.birthdate}">${patient.birthdate}
                                                    &nbsp;(${patient.age} )</c:if>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><b>Identifiers : &nbsp;</b> <c:if
                                                        test="${not empty patient.identifiers}">${patient.identifiers} </c:if>
                                                </td>
                                                <td><b>Gender : &nbsp;</b> <c:if
                                                        test="${not empty patient.gender}">${patient.gender} </c:if>
                                                </td>
                                            </tr>


                                        </table>

                                    </c:if>
                                </c:otherwise>
                            </c:choose>
                        </div>
                </fieldset>
            </form>
        </div>
        <div id="dispenseform" title="Dispense to:">
            <form id="psychiatryform"></form>
            <form id="generalform"></form>
            <div id="pregimen"><form id="hivform"></form></div>
            <form id="hivAdultOiForm"></form>
            <form id="hivpedsform"></form>
            <form id="revolvingPedsform"></form>
            <form id="revolvingAdultform"></form>
            <form id="cadiovascularform"></form>
        </div>
        <div id="encountform" title="Information"></div>
        <DIV id="tab_1psychiatry">
        </DIV>
    </DIV>
</DIV>
<DIV id="supplierSettings">

    <DIV class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        Supplier Settings
    </DIV>
    <UL
            style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1"><SPAN>Supplier </SPAN> </A>
        </LI>

    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">
        <DIV id="tab_1Supplier"></DIV>

    </DIV>
</DIV>
<DIV id="transactionsSetting">

    <DIV class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        Transactions Types
    </DIV>
    <UL
            style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1"><SPAN>transactions </SPAN> </A>
        </LI>
    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">
        <DIV id="tab_1transactions"></DIV>

    </DIV>
</DIV>

<DIV id="locationNames">

    <DIV class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        Location name
    </DIV>
    <UL
            style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1"><SPAN>Locations </SPAN> </A>
        </LI>
    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">
        <DIV id="tab_1location"></DIV>

    </DIV>
</DIV>
<DIV id="locationUsers">

    <DIV class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        Location Users
    </DIV>
    <UL
            style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1"><SPAN>Locations and their users </SPAN> </A>
        </LI>
    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">
        <DIV id="tab_1locationuser"></DIV>

    </DIV>
</DIV>


<DIV id="locationsetter">

    <DIV class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        Location Types
    </DIV>

    <UL
            style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1"><SPAN>Location </SPAN> </A>
        </LI>
    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">
        <DIV id="tab_1locationid"></DIV>

    </DIV>
</DIV>


<DIV id="drugusagepage">

    <DIV class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        Location Types
    </DIV>

    <UL
            style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1"><SPAN>Location </SPAN> </A>
        </LI>
    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">
        <DIV id="tab_1drugusage"></DIV>

    </DIV>
</DIV>

<DIV id="requestsumpage">

    <DIV class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        Drug Dispensed page
    </DIV>

    <UL
            style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1"><SPAN>Dispensed drugs between range </SPAN> </A>
        </LI>
    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">
        <DIV id="tab_1requestsum"></DIV>


    </DIV>
</DIV>

<DIV id="rfpreportpage">

    <DIV class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        RFP General Report
    </DIV>

    <UL
            style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1"><SPAN>RFP General Report </SPAN> </A>
        </LI>
    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">
        <DIV id="tab_1rfpreport"></DIV>


    </DIV>
</DIV>

<DIV id="fmapreportpage">

    <DIV class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        F-map Report
    </DIV>

    <UL
            style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1"><SPAN>F-map Report </SPAN> </A>
        </LI>
    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">
        <DIV id="tab_1fmapreport"></DIV>


    </DIV>
</DIV>


<DIV id="maxmin">

    <DIV class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        Drug max and min setter
    </DIV>

    <UL
            style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1"><SPAN>Max and min </SPAN> </A>
        </LI>
    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">
        <DIV id="tab_1maxmin"></DIV>

    </DIV>
</DIV>


<DIV id="Batchsetter">

    <DIV class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        Batch Types
    </DIV>

    <UL
            style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1"><SPAN>Drug Batch </SPAN> </A>
        </LI>
    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">
        <DIV id="tab_1batch"></DIV>

    </DIV>
</DIV>
<DIV id="drugSetUp">

    <DIV class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        Manage Drugs
    </DIV>

    <UL
            style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1"><SPAN>Manage Drugs </SPAN> </A>
        </LI>
    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">
        <DIV id="tab_1drugSetUp"></DIV>

    </DIV>
</DIV>

<DIV id="Barcode">

    <DIV class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        Bar code
    </DIV>

    <UL
            style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1"><SPAN>Bar code</SPAN> </A>
        </LI>
    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">
        <DIV id="tab_1barcode"></DIV>

    </DIV>
</DIV>


<DIV id="DrugCategory">

    <DIV class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        Drug Categories
    </DIV>

    <UL
            style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1"><SPAN>Drug  Categories</SPAN> </A>
        </LI>
    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">
        <DIV id="tab_1Drug">


        </DIV>

    </DIV>
</DIV>


<DIV id="General">

    <DIV class="header-footer ui-state-default ui-corner-all"
         style="padding: 3px 5px 5px; text-align: center; margin-bottom: 1ex;">
        Dispense Amount Settings
    </DIV>

    <UL
            style="-moz-border-radius-bottomleft: 0; -moz-border-radius-bottomright: 0;">
        <LI><A href="#tab_1"><SPAN>Dispense Amount Settings</SPAN> </A>
        </LI>
    </UL>
    <DIV class="ui-layout-content ui-widget-content ui-corner-bottom"
         style="border-top: 0; padding-bottom: 1em;">
        <DIV id="tab_1General">


        </DIV>

    </DIV>
</DIV>

</DIV>
<DIV class="ui-layout-north">

    <div id="pageBodyP">

        <div id="userBar">
            <openmrs:authentication>
                <c:if test="${authenticatedUser != null}">
					<span id="userLoggedInAs" class="firstChild"> <spring:message
                            code="header.logged.in"/> ${authenticatedUser.personName} </span>
					<span id="userLogout"> <a
                            href='${pageContext.request.contextPath}/logout'><spring:message
                            code="header.logout"/>
                    </a> </span>
					<span> <a
                            href="${pageContext.request.contextPath}/options.form"><spring:message
                            code="Navigation.options"/>
                    </a> </span>
                </c:if>
                <c:if test="${authenticatedUser == null}">
					<span id="userLoggedOut" class="firstChild"> <spring:message
                            code="header.logged.out"/> </span>
					<span id="userLogIn"> <a
                            href='${pageContext.request.contextPath}/login.htm'><spring:message
                            code="header.login"/>
                    </a> </span>
                </c:if>
            </openmrs:authentication>

			<span id="userHelp"> <a
                    href='<%= request.getContextPath() %>/help.htm'><spring:message
                    code="header.help"/>
            </a> </span>

        </div>

        <%@ include file="/WEB-INF/template/banner.jsp" %>


    </div>

</DIV>


<DIV class="ui-layout-west">
    <div id="accordion1" class="basic">



        <h3>
            <a href="#">Reports </a>
        </h3>

        <div class="ui-layout-content">
            <UL>
                <!-- 						<LI><A href="#" id="dashboard">View</A> -->
                <!-- 						</LI> -->

                <LI><A href="#" id="requestsum">Detailed Dispensed Drugs Report</A></LI>
                <LI><A href="#" id="rfpreport">General RFP Report</A></LI>
                <LI><A href="#" id="fmapreport">F-map Report</A></LI>
                <%--<LI><A href="#" id="drugusage">Drug usage</A>--%>
                <%--</LI>--%>


            </UL>


        </div>

        <h3>
            <a href="#">Location </a>
        </h3>

        <div class="ui-layout-content">
            <UL>
                <!-- 						<LI><A href="#" id="dashboard">View</A> -->
                <!-- 						</LI> -->
                <LI><A href="#" id="locationsetterid">Select location</A>
                </LI>


            </UL>


        </div>

        <%


            if (org.openmrs.api.context.Context.hasPrivilege("Pharmacy inventory")) {

        %>
        <h3>
            <div id="ui">
                <a href="#">Inventory</a>
            </div>
        </h3>
        <div class="ui-layout-content">
            <div id="ui8">
                <UL>


                    <LI><A href="#" id="dincoming">Add requests</A>
                    </LI>
                    <LI><A href="#" id="doutgoing">Approve requests from other sites</A></LI>

                    <LI><A href="#" id="dapproved">Approved Requests</A></LI>
                    <LI><A href="#" id="dstore">Inventory</A></LI>
                    <LI><A href="#" id="dlow">Low stock</A></LI>
                    <LI><A href="#" id="dhigh">Short Expire Stock</A></LI>
                    <LI><A href="#" id="dstock">Stock take</A></LI>
                    <LI><A href="#" id="dtransactions">Transactions Logs</A></LI>
                    <LI><A href="#" id="dmanager">Dose Management</A></LI>
                </UL>
            </div>
        </div>


        <%
            } else {

            }
        %>


        <%


            if (org.openmrs.api.context.Context.hasPrivilege("Pharmacy regimen")) {

        %>

        <h3>
            <div id="ui1">
                <a href="#">General Dispense Form</a>
            </div>

        </h3>
        <div class="ui-layout-content">
            <div id="ui18">
                <UL>
                    <LI><A href="#" id="regimenlink">Dispense Form</A>
                    </LI>


                </UL>


            </div>
        </div>
        <%
            } else {

            }
        %>
        <%


            if (org.openmrs.api.context.Context.hasPrivilege("Pharmacy dispense")) {

        %>

        <h3>
            <div id="ui2">
                <a href="#">Dispense</a>
            </div>
        </h3>
        <div class="ui-layout-content">
            <div id="ui28">
                <LI><A href="#" id="psychiatry">Start Dispensing</A>
                </LI>
            </div>


        </div>


        <%
            } else {

            }
        %>


        <%


            if (org.openmrs.api.context.Context.hasPrivilege("Pharmacy Admin")) {

        %>

        <h3>
            <div id="ui3">
                <a href="#">Admin functions</a>
            </div>
        </h3>
        <div>
            <div class="ui-layout-content">
                <div id="ui38">
                    <!-- 					<LI><A href="#" id="dsettings">Drug settings</A> -->
                    <!-- 					</LI> -->
                    <LI><A href="#" id="Asupplier">Suppliers</A>
                    </LI>
                    <LI><A href="#" id="tt">Transaction Types</A>
                    </LI>

                    <LI><A href="#" id="locationName">Location names</A>
                    </LI>


                    <LI><A href="#" id="locationUser">Location Users</A>
                    </LI>


                    <LI><A href="#" id="DCategories">Drug Categories</A>
                    </LI>

                    <LI><A href="#" id="Dmaxmin">Drug Max Min setter</A>
                    </LI>


                    <LI><A href="#" id="DGeneral">Dispense variables</A>
                    </LI>

                    <LI><A href="#" id="DBatch">Dispense Batch settings</A>
                    <LI><A href="#" id="dSetUp">Drug admin settings</A>
                    </LI>

                </div>
                <%--<LI><A href="#" id="DBarcode">Bar code </A>--%>
                <%--</LI>--%>
            </div>
        </div>
        <%
            } else {

            }
        %>


    </div>
</DIV>
<DIV class="ui-layout-south">
    <div id="footer">
        <div id="footerInner">

			<span id="localeOptions">
				<% //removes last instance of lang= from querystring and encodes the url to avoid xml problems
                    String qs = org.apache.commons.lang.StringEscapeUtils.escapeXml(request.getQueryString());
                    if (qs == null)
                        qs = "";
                    int i = qs.lastIndexOf("&amp;lang=");
                    if (i == -1)
                        i = qs.length();
                    pageContext.setAttribute("qs", qs.substring(0, i));
                    pageContext.setAttribute("locales", org.openmrs.api.context.Context.getAdministrationService().getPresentationLocales());
                    pageContext.setAttribute("openmrsVersion", org.openmrs.util.OpenmrsConstants.OPENMRS_VERSION);
                    pageContext.setAttribute("locale", org.openmrs.api.context.Context.getLocale());
                %>

				<c:forEach items="${locales}" var="loc" varStatus="status">
                    <%
                        java.util.Locale locTmp = (java.util.Locale) pageContext.getAttribute("loc");
                        pageContext.setAttribute("locDisplayName", locTmp.getDisplayName(locTmp));
                    %>
                    <c:if test="${status.index != 0}">| </c:if>
                    <c:if test="${fn:toLowerCase(locale) == fn:toLowerCase(loc)}">${locDisplayName}</c:if>
                    <c:if test="${fn:toLowerCase(locale) != fn:toLowerCase(loc)}"><a
                            href="?${qs}&amp;lang=${loc}">${locDisplayName}</a></c:if>
                </c:forEach>
			</span>

            <span id="buildDate"><spring:message
                    code="footer.lastBuild"/>: <%= org.openmrs.web.WebConstants.BUILD_TIMESTAMP %></span>

            <span id="codeVersion"><spring:message code="footer.version"/>: ${openmrsVersion}</span>

            <span id="poweredBy"><a href="http://openmrs.org"><spring:message code="footer.poweredBy"/> <img border="0"
                                                                                                             align="top"
                                                                                                             src="<%= request.getContextPath() %>/images/openmrs_logo_tiny.png"/></a></span>
        </div>
    </div>
</DIV>
</body>

</html>