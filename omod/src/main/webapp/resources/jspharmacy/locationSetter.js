var oCache = {
    iCacheLower:-1
};
$j.getJSON("locationSetter.form?drop=drop",
    function (result) {
        if (result == "null") {
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
$j("#locationForm").validate();
getDataLocation();
$j("#hidelocation").hide();
$j("#showlocation").click(function () {
    $j("#hidelocation").show();
    $j("#showlocation").hide();
});
$j("#locationForm").show();
$j("#hidelocation").click(function () {
    $j("#hidelocation").hide();
    $j("#showlocation").show();
    $j("#locationForm").hide();
});
$j("form#locationForm").submit(function () {
    // we want to store the values from the form input box, then send via ajax below
    if ($j("form#locationForm").valid()) {
        dataString = $j("#locationForm").serialize();
        var e = document.getElementById("locationsVal");
        var strUser = e.options[e.selectedIndex].value;
        if (strUser == "No permission") {
        }
        else {
            $j.ajax({
                type:"POST",
                url:"locationSetter.form",
                data:dataString,
                success:function (data) {
                    var dat = data;
                    var path = dataString.substring(dataString.indexOf("=") + 1);
                    var locationURL = path;
                    $j('#current_location').empty();
                    $j(path).appendTo('#current_location');
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
                    $j("#hidelocation").hide();
                    $j("#showlocation").show();
                    $j("#location").hide();
                    $j("#locationError").show("slow");//
                    $j('#locationError .loc').replaceWith("<div id='red'>Location Set<div>");
                    $j("#locationError").delay(5000).hide("slow");
                }
            });
        }

    }
    return true;
});
function getDataLocation() {
    $j.getJSON("drugDetails.form?drop=location",function (result) {
        if (result == "") {
            $j("#spinner").hide();
            $j("#errorDialog").empty();
            $j('<dl><dt></dt><dd >' + "Info: " + "No locations set for you contact your admin" + '</dd></dl> ').appendTo('#errorDialog');
            $j("#errorDialog").dialog("open");
        }
        else {
            $j("#locationsVal").get(0).options.length = 0;
            $j("#locationsVal").get(0).options[0] = new Option("Select","-1");
            $j.each( result,function (index, value) {
                $j("#locationsVal").get(0).options[$j(
                    "#locationsVal").get(0).options.length] = new Option( value, value);
                $j("#spinner").hide();
            });
        }
    });
}