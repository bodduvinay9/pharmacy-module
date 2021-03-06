var oCache = {
    iCacheLower:-1
};
var ooTable;
var editTr;
var link;
var aData;
$j("#reportform").validate(); //
$j("#datef").datepicker();
$j("#datet").datepicker();
$j("form#reportform").submit(function () {
    if ($j("#reportform").valid()) {
        ooTable = $j('#treport').dataTable({
            bJQueryUI:true,
            bRetrieve:true,
            bServerSide:true,
            bAutoWidth:false,
            bProcessing:true,
            sAjaxSource: "displayRFPReport.form?" + "datef=" + $j('#datef').val() + "&datet=" + $j('#datet').val(),
            "fnFooterCallback": function (nRow, aaData, iStart, iEnd, aiDisplay) {
                var iTotal =[0,0,0,0,0,0,0];
                for (var i = 0; i < aaData.length; i++) {
                    iTotal[0] += Number(aaData[i][5]);
                    iTotal[1] += Number(aaData[i][7]);
                    iTotal[2] += Number(aaData[i][8]);
                    iTotal[3] += Number(aaData[i][9]);
                    iTotal[4] += Number(aaData[i][10]);
                    iTotal[5] += Number(aaData[i][11]);
                    iTotal[6] += Number(aaData[i][12]);
                }
                /* Modify the footer row to match what we want */
                var nCells = nRow.getElementsByTagName('th');
                nCells[0].innerHTML="Totals";
                nCells[5].innerHTML = iTotal[0];
                nCells[7].innerHTML = iTotal[1];
                nCells[8].innerHTML = iTotal[2];
                nCells[9].innerHTML = iTotal[3];
                nCells[10].innerHTML = iTotal[4];
                nCells[11].innerHTML = iTotal[5];
                nCells[12].innerHTML = iTotal[6];
                nCells[13].innerHTML = iTotal[5]-iTotal[6]-iTotal[2];
            },
            //sAjaxSource: "revolveAdult.form",
            "fnServerData":fnDataTablesPipeline


        });

        return false;
    }

});
(function(){
    var cache = {};

    this.tmpl = function tmpl(str, data){
        // Figure out if we're getting a template, or if we need to
        // load the template - and be sure to cache the result.
        var fn = !/\W/.test(str) ?
            cache[str] = cache[str] ||
                tmpl(document.getElementById(str).innerHTML) :

            // Generate a reusable function that will serve as a template
            // generator (and which will be cached).
            new Function("obj",
                "var p=[],print=function(){p.push.apply(p,arguments);};" +

                    // Introduce the data as local variables using with(){}
                    "with(obj){p.push('" +

                    // Convert the template into pure JavaScript
                    str.replace(/[\r\t\n]/g, " ")
                        .split("{{").join("\t")
                        .replace(/((^|}})[^\t]*)'/g, "$1\r")
                        .replace(/\t=(.*?)}}/g, "',$1,'")
                        .split("\t").join("');")
                        .split("}}").join("p.push('")
                        .split("\r").join("\\'")
                    + "');}return p.join('');");


        // Provide some basic currying to the user
        return data ? fn( data ) : fn;
    };
})();

var tableToExcel = (function() {
    var uri = 'data:application/vnd.ms-excel;base64,',
        template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{{=worksheet}}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body>{{for(var i=0; i<tables.length;i++){ }}<table>{{=tables[i]}}</table>{{ } }}</body></html>',
        base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) },
        format = function(s, c) { return s.replace(/{(\w+)}/g, function(m, p) { return c[p]; }) }
    return function(tableList, name) {
        if (!tableList.length>0 && !tableList[0].nodeType) table = document.getElementById(table)
        var tables = [];
        for(var i=0; i<tableList.length; i++){
            tables.push(tableList[i].innerHTML);
        }
        var ctx = {worksheet: name || 'Worksheet', tables: tables};
        window.location.href = uri + base64(tmpl(template, ctx))
    }
})();
function expTable(tbl)
{
    var tables = [];
    tables.push(tbl);
    tableToExcel(tables,"one");
}
$j("#export").click(function () {
    expTable(document.getElementById("treport"));
});