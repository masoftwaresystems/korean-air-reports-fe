<html>
<head>
<title>Risk Accessment Matrix</title>
<style type="text/css">
<!--
body,td,th {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11pt;
	color: #333333;
}
body {
	background-color: #FFFFFF;
	margin-left: 10px;
	margin-top: 10px;
	margin-right: 10px;
	margin-bottom: 0px;
}
-->
</style>

<script>
function parseRow(v) {
  var valArr = v.split("_");
  alert(valArr[1]);
  return valArr[1];
}

function parseCol(v) {
  var valArr = v.split("_");
  alert(valArr[2]);
  return valArr[2];
}

function mouseovercell(o) {
  var currID = o.id;
  o.style.cursor = 'hand';
  if(document.getElementById(currID+"_VAL").value == "0") {
    o.style.backgroundColor = "yellow";
  }
  //alert("mouseovercell");
}

function mouseoutcell(o) {
  var currID = o.id;
  o.style.cursor = 'hand';
  if(document.getElementById(currID+"_VAL").value == "0") {
    o.style.backgroundColor = "#00346B";
  }
}

function cellclicked(o) {
  //alert(o.id);
  var currID = o.id;
  parseRow(currID);
  parseCol(currID);
  var currVal = document.getElementById(currID+"_VAL").value;
  if(currVal == "1") {
    o.style.backgroundColor = "#00346B";
    document.getElementById(currID+"_VAL").value = "0";
  } else {
    o.style.backgroundColor = "yellow";
    document.getElementById(currID+"_VAL").value = "1";
  }

}

function showVals() {
f = frm;
var strError = "";
for (var intLoop = 0; intLoop < f.elements.length; intLoop++)
  if (null!=f.elements[intLoop].getAttribute("valuefield"))
       strError += "  " + f.elements[intLoop].name + ":" + f.elements[intLoop].value + "\n";
  alert(strError);
}
</script>
</head>
<body>

<%
headerheight = "50"
labelheight = "70"
cellheight = "50"

panelcolor = "black"
tablebordercolor = "white"
cellbackgroundcolor = "#00346B"

acceptablecolor = "black"
acceptablecolor2 = "#319A31"
acceptablewithmitigation = "#9C6500"
acceptablewithmitigation2 = "#FFCF00"
unacceptable = "#630000"
unacceptable2 = "#FF0000"


firstcellwidth = "60"
cellwidth = "70"
tablewidth = cint(firstcellwidth) + (10 * cint(cellwidth))

%>

<form name="frm" id="frm" method="post" action="">

<input type="hidden" name="CELL_1_1_VAL" id="CELL_1_1_VAL" value="0" valuefield>
<input type="hidden" name="CELL_1_2_VAL" id="CELL_1_2_VAL" value="0" valuefield>
<input type="hidden" name="CELL_1_3_VAL" id="CELL_1_3_VAL" value="0" valuefield>
<input type="hidden" name="CELL_1_4_VAL" id="CELL_1_4_VAL" value="0" valuefield>
<input type="hidden" name="CELL_1_5_VAL" id="CELL_1_5_VAL" value="0" valuefield>

<div style="background-color:<%= panelcolor %>;width:800px;">
<br>
<div align="center">
<table border="0" cellspacing="1" cellpadding="4" bgcolor="<%= tablebordercolor %>" width="<%= tablewidth %>">
  <tr bgcolor="<%= cellbackgroundcolor %>" height="<%= cellheight %>">
    <td width="<%= firstcellwidth %>">
    </td>
    <td width="<%= cellwidth %>">
    </td>
    <td id="CELL_1_1" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this)">
    </td>
    <td id="CELL_1_2" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this)">
    </td>
    <td id="CELL_1_3" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this)">
    </td>
    <td id="CELL_1_4" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this)">
    </td>
    <td id="CELL_1_5" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this)">
    </td>
    <td width="<%= cellwidth %>">
    </td>
    <td width="<%= cellwidth %>">
    </td>
    <td width="<%= cellwidth %>">
    </td>
    <td width="<%= cellwidth %>">
    </td>
  </tr>
</table>
</div>
<br>
</div>

<input type="button" value="showVals" onclick="showVals()">
</form>

</body>
</html>