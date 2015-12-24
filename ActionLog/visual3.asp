<%
return_field = request("f")
%>
<html>
<head>
<title>Risk Assessment Matrix</title>
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
  //alert(valArr[1]);
  return valArr[1];
}

function parseCol(v) {
  var valArr = v.split("_");
  //alert(valArr[2]);
  return valArr[2];
}

function mouseovercell(o) {
  var currID = o.id;
  o.style.cursor = 'hand';
  if(document.getElementById(currID+"_VAL").value == "0") {
    o.style.backgroundColor = "#a0a0a0";
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

function clearCol(c) {
  if((c != "A")&&(c != "B")&&(c != "C")&&(c != "D")&&(c != "E")) {
    document.getElementById("CELL_0_"+c+"_VAL").value = "0";
    document.getElementById("CELL_0_"+c).style.backgroundColor = "#00346B";
    document.getElementById("CELL_1_"+c+"_VAL").value = "0";
    document.getElementById("CELL_1_"+c).style.backgroundColor = "#00346B";
    document.getElementById("CELL_2_"+c+"_VAL").value = "0";
    document.getElementById("CELL_2_"+c).style.backgroundColor = "#00346B";
    document.getElementById("CELL_3_"+c+"_VAL").value = "0";
    document.getElementById("CELL_3_"+c).style.backgroundColor = "#00346B";
    document.getElementById("CELL_4_"+c+"_VAL").value = "0";
    document.getElementById("CELL_4_"+c).style.backgroundColor = "#00346B";
  } else {
    document.getElementById("CELL_A_A_VAL").value = "0";
    document.getElementById("CELL_A_A").style.backgroundColor = "#00346B";
    document.getElementById("CELL_B_B_VAL").value = "0";
    document.getElementById("CELL_B_B").style.backgroundColor = "#00346B";
    document.getElementById("CELL_C_C_VAL").value = "0";
    document.getElementById("CELL_C_C").style.backgroundColor = "#00346B";
    document.getElementById("CELL_D_D_VAL").value = "0";
    document.getElementById("CELL_D_D").style.backgroundColor = "#00346B";
    document.getElementById("CELL_E_E_VAL").value = "0";
    document.getElementById("CELL_E_E").style.backgroundColor = "#00346B";
  }
}

function cellclicked(o,v) {
  //alert(o.id);
  var currID = o.id;
  x = parseRow(currID);
  y = parseCol(currID);
  var currVal = document.getElementById(currID+"_VAL").value;
  clearCol(parseCol(currID));
  if(currVal == "1") {
    o.style.backgroundColor = "#00346B";
    document.getElementById(currID+"_VAL").value = "0";
    if(y == "1") {
      document.getElementById("physical_injury").value = "";
    }
    if(y == "2") {
      document.getElementById("damage_to_the_environment").value = "";
    }
    if(y == "3") {
      document.getElementById("damage_to_assets").value = "";
    }
    if(y == "4") {
      document.getElementById("potential_increased_cost").value = "";
    }
    if(y == "5") {
      document.getElementById("damage_to_corporate_reputation").value = "";
    }
    if((x == "A")||((x == "B"))||((x == "C"))||((x == "D"))||((x == "E"))) {
      document.getElementById("likelihood").value = "";
    }
  } else {
    o.style.backgroundColor = "#a0a0a0";
    document.getElementById(currID+"_VAL").value = "1";
    if(y == "1") {
      document.getElementById("physical_injury").value = v;
    }
    if(y == "2") {
      document.getElementById("damage_to_the_environment").value = v;
    }
    if(y == "3") {
      document.getElementById("damage_to_assets").value = v;
    }
    if(y == "4") {
      document.getElementById("potential_increased_cost").value = v;
    }
    if(y == "5") {
      document.getElementById("damage_to_corporate_reputation").value = v;
    }
    if((x == "A")||((x == "B"))||((x == "C"))||((x == "D"))||((x == "E"))) {
      document.getElementById("likelihood").value = v;
    }
  }
  checkResult();
}

function checkResult() {
  clearResultCells();
<% if(return_field <> "") then %>
  parent.setFieldValue("<%= return_field %>","");
  parent.setFieldValue("<%= request("prefix") %>physical_injury","");
  parent.setFieldValue("<%= request("prefix") %>damage_to_the_environment","");
  parent.setFieldValue("<%= request("prefix") %>damage_to_assets","");
  parent.setFieldValue("<%= request("prefix") %>potential_increased_cost","");
  parent.setFieldValue("<%= request("prefix") %>damage_to_corporate_reputation","");
  parent.setFieldValue("<%= request("prefix") %>likelihood","");
<% end if %>
  if((document.getElementById("CELL_A_A_VAL").value == "1")||(document.getElementById("CELL_B_B_VAL").value == "1")||(document.getElementById("CELL_C_C_VAL").value == "1")||(document.getElementById("CELL_D_D_VAL").value == "1")||(document.getElementById("CELL_E_E_VAL").value == "1")) {
    if((document.getElementById("CELL_0_1_VAL").value == "1")||(document.getElementById("CELL_1_1_VAL").value == "1")||(document.getElementById("CELL_2_1_VAL").value == "1")||(document.getElementById("CELL_3_1_VAL").value == "1")||(document.getElementById("CELL_4_1_VAL").value == "1")) {
      if((document.getElementById("CELL_0_2_VAL").value == "1")||(document.getElementById("CELL_1_2_VAL").value == "1")||(document.getElementById("CELL_2_2_VAL").value == "1")||(document.getElementById("CELL_3_2_VAL").value == "1")||(document.getElementById("CELL_4_2_VAL").value == "1")) {
        if((document.getElementById("CELL_0_3_VAL").value == "1")||(document.getElementById("CELL_1_3_VAL").value == "1")||(document.getElementById("CELL_2_3_VAL").value == "1")||(document.getElementById("CELL_3_3_VAL").value == "1")||(document.getElementById("CELL_4_3_VAL").value == "1")) {
          if((document.getElementById("CELL_0_4_VAL").value == "1")||(document.getElementById("CELL_1_4_VAL").value == "1")||(document.getElementById("CELL_2_4_VAL").value == "1")||(document.getElementById("CELL_3_4_VAL").value == "1")||(document.getElementById("CELL_4_4_VAL").value == "1")) {
            if((document.getElementById("CELL_0_5_VAL").value == "1")||(document.getElementById("CELL_1_5_VAL").value == "1")||(document.getElementById("CELL_2_5_VAL").value == "1")||(document.getElementById("CELL_3_5_VAL").value == "1")||(document.getElementById("CELL_4_5_VAL").value == "1")) {
              //alert(getSeverity());
              //alert(getLikelihood());
              x = getSeverity();
              y = getLikelihood();
              //alert(x+","+y);
              tmpAcceptability = setAcceptability(x+"_"+y);
              tmpColor = "white";
              //alert(tmpAcceptability);
<% if(return_field <> "") then %>
              parent.setFieldValue("<%= return_field %>",tmpAcceptability);
              parent.setFieldValue("<%= request("prefix") %>physical_injury",document.getElementById("physical_injury").value);
              parent.setFieldValue("<%= request("prefix") %>damage_to_the_environment",document.getElementById("damage_to_the_environment").value);
              parent.setFieldValue("<%= request("prefix") %>damage_to_assets",document.getElementById("damage_to_assets").value);
              parent.setFieldValue("<%= request("prefix") %>potential_increased_cost",document.getElementById("potential_increased_cost").value);
              parent.setFieldValue("<%= request("prefix") %>damage_to_corporate_reputation",document.getElementById("damage_to_corporate_reputation").value);
              parent.setFieldValue("<%= request("prefix") %>likelihood",document.getElementById("likelihood").value);
<% end if %>
              if(tmpAcceptability == "ACCEPTABLE") {
                tmpColor = "336600";
                tmpAcceptability = "Determination of Risk Acceptability<br><span style='height:10px;width:20px;background-color:#006600;margin-right:5px;border:1px solid white;'>&nbsp;</span>ACCEPTABLE<br><span style='font-size:14px;'>Accepted without further action, but maybe an area for continuous improvement.</span>"
              }
              if(tmpAcceptability == "ACCEPTABLE WITH MITIGATION") {
                tmpColor = "ffcc00";
                tmpAcceptability = "Determination of Risk Acceptability<br><span style='height:10px;width:20px;background-color:#ffcc00;margin-right:5px;border:1px solid white;'>&nbsp;</span>ACCEPTABLE WITH MITIGATION<br><span style='font-size:14px;'>Accepted under defined conditions of mitigation.</span>"
              }
              if(tmpAcceptability == "UNACCEPTABLE") {
                tmpColor = "8a0808";
                tmpAcceptability = "Determination of Risk Acceptability<br><span style='height:10px;width:20px;background-color:#8a0808;margin-right:5px;border:1px solid white;'>&nbsp;</span>UNACCEPTABLE<br><span style='font-size:14px;'>Further work is required to design an intervention that eliminates the associated hazard or controls the factors that lead to higher risk likelihood or severity. Please refer to Section 5.5 of the SMS Manual for additional requirements.</span>";
              }
              document.getElementById("ACCEPTABILITY_SPAN").innerHTML = tmpAcceptability;
              document.getElementById("CELL_"+x+"_"+y).style.backgroundColor = tmpColor;
              document.getElementById("splashtable").style.display = "none";
            }
          }
        }
      }
    }
  }
}

function clearResultCells2() {
  return;
  for (var x = 0; x <= 4; x++) {
    document.getElementById("CELL_"+x+"_A").style.backgroundColor = "#00346B";
  }
  for (var x = 0; x <= 4; x++) {
    document.getElementById("CELL_"+x+"_B").style.backgroundColor = "#00346B";
  }
  for (var x = 0; x <= 4; x++) {
    document.getElementById("CELL_"+x+"_C").style.backgroundColor = "#00346B";
  }
  for (var x = 0; x <= 4; x++) {
    document.getElementById("CELL_"+x+"_D").style.backgroundColor = "#00346B";
  }
  for (var x = 0; x <= 4; x++) {
    document.getElementById("CELL_"+x+"_E").style.backgroundColor = "#00346B";
  }
  document.getElementById("ACCEPTABILITY_SPAN").innerHTML = "&nbsp;";
  document.getElementById("splashtable").style.display = "block";
}

function clearResultCells() {
  for (var x = 0; x <= 3; x++) {
    document.getElementById("CELL_"+x+"_A").style.backgroundColor = "green";
  }
  for (var x = 4; x <= 4; x++) {
    document.getElementById("CELL_"+x+"_A").style.backgroundColor = "yellow";
  }
  for (var x = 0; x <= 2; x++) {
    document.getElementById("CELL_"+x+"_B").style.backgroundColor = "green";
  }
  for (var x = 3; x <= 4; x++) {
    document.getElementById("CELL_"+x+"_B").style.backgroundColor = "yellow";
  }
  for (var x = 0; x <= 1; x++) {
    document.getElementById("CELL_"+x+"_C").style.backgroundColor = "green";
  }
  for (var x = 2; x <= 3; x++) {
    document.getElementById("CELL_"+x+"_C").style.backgroundColor = "yellow";
  }
  for (var x = 4; x <= 4; x++) {
    document.getElementById("CELL_"+x+"_C").style.backgroundColor = "red";
  }
  for (var x = 0; x <= 1; x++) {
    document.getElementById("CELL_"+x+"_D").style.backgroundColor = "green";
  }
  for (var x = 2; x <= 2; x++) {
    document.getElementById("CELL_"+x+"_D").style.backgroundColor = "yellow";
  }
  for (var x = 3; x <= 4; x++) {
    document.getElementById("CELL_"+x+"_D").style.backgroundColor = "red";
  }
  for (var x = 0; x <= 1; x++) {
    document.getElementById("CELL_"+x+"_E").style.backgroundColor = "green";
  }
  for (var x = 2; x <= 4; x++) {
    document.getElementById("CELL_"+x+"_E").style.backgroundColor = "red";
  }
  document.getElementById("splashtable").style.display = "block";
}

function getSeverity() {
  if((document.getElementById("CELL_4_1_VAL").value == "1")||(document.getElementById("CELL_4_2_VAL").value == "1")||(document.getElementById("CELL_4_3_VAL").value == "1")||(document.getElementById("CELL_4_4_VAL").value == "1")||(document.getElementById("CELL_4_5_VAL").value == "1")) {
    return 4;
  } 
  if((document.getElementById("CELL_3_1_VAL").value == "1")||(document.getElementById("CELL_3_2_VAL").value == "1")||(document.getElementById("CELL_3_3_VAL").value == "1")||(document.getElementById("CELL_3_4_VAL").value == "1")||(document.getElementById("CELL_3_5_VAL").value == "1")) {
    return 3;
  }
  if((document.getElementById("CELL_2_1_VAL").value == "1")||(document.getElementById("CELL_2_2_VAL").value == "1")||(document.getElementById("CELL_2_3_VAL").value == "1")||(document.getElementById("CELL_2_4_VAL").value == "1")||(document.getElementById("CELL_2_5_VAL").value == "1")) {
    return 2;
  }
  if((document.getElementById("CELL_1_1_VAL").value == "1")||(document.getElementById("CELL_1_2_VAL").value == "1")||(document.getElementById("CELL_1_3_VAL").value == "1")||(document.getElementById("CELL_1_4_VAL").value == "1")||(document.getElementById("CELL_1_5_VAL").value == "1")) {
    return 1;
  } 
  if((document.getElementById("CELL_0_1_VAL").value == "1")||(document.getElementById("CELL_0_2_VAL").value == "1")||(document.getElementById("CELL_0_3_VAL").value == "1")||(document.getElementById("CELL_0_4_VAL").value == "1")||(document.getElementById("CELL_0_5_VAL").value == "1")) {
    return 0;
  } 

}

function getLikelihood() {
  if(document.getElementById("CELL_A_A_VAL").value == "1") {
    return "A";
  } 
  if(document.getElementById("CELL_B_B_VAL").value == "1") {
    return "B";
  } 
  if(document.getElementById("CELL_C_C_VAL").value == "1") {
    return "C";
  } 
  if(document.getElementById("CELL_D_D_VAL").value == "1") {
    return "D";
  } 
  if(document.getElementById("CELL_E_E_VAL").value == "1") {
    return "E";
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


function setAcceptability(v) {
  if((v == "0_A")||(v == "0_B")||(v == "0_C")||(v == "0_D")||(v == "0_E")||(v == "1_A")||(v == "1_B")||(v == "1_C")||(v == "1_D")||(v == "1_E")||(v == "2_A")||(v == "2_B")||(v == "3_A")) {
    acceptability = "ACCEPTABLE";
  }
  if((v == "2_C")||(v == "2_D")||(v == "3_B")||(v == "3_C")||(v == "4_A")||(v == "4_B")) {
    acceptability = "ACCEPTABLE WITH MITIGATION";
  }
  if((v == "2_E")||(v == "3_D")||(v == "3_E")||(v == "4_C")||(v == "4_D")||(v == "4_E")) {
    acceptability = "UNACCEPTABLE";
  }
  
  return acceptability;
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

<input type="hidden" name="CELL_A_A_VAL" id="CELL_A_A_VAL" value="0" valuefield>
<input type="hidden" name="CELL_B_B_VAL" id="CELL_B_B_VAL" value="0" valuefield>
<input type="hidden" name="CELL_C_C_VAL" id="CELL_C_C_VAL" value="0" valuefield>
<input type="hidden" name="CELL_D_D_VAL" id="CELL_D_D_VAL" value="0" valuefield>
<input type="hidden" name="CELL_E_E_VAL" id="CELL_E_E_VAL" value="0" valuefield>

<input type="hidden" name="CELL_0_1_VAL" id="CELL_0_1_VAL" value="0" valuefield>
<input type="hidden" name="CELL_0_2_VAL" id="CELL_0_2_VAL" value="0" valuefield>
<input type="hidden" name="CELL_0_3_VAL" id="CELL_0_3_VAL" value="0" valuefield>
<input type="hidden" name="CELL_0_4_VAL" id="CELL_0_4_VAL" value="0" valuefield>
<input type="hidden" name="CELL_0_5_VAL" id="CELL_0_5_VAL" value="0" valuefield>

<input type="hidden" name="CELL_1_1_VAL" id="CELL_1_1_VAL" value="0" valuefield>
<input type="hidden" name="CELL_1_2_VAL" id="CELL_1_2_VAL" value="0" valuefield>
<input type="hidden" name="CELL_1_3_VAL" id="CELL_1_3_VAL" value="0" valuefield>
<input type="hidden" name="CELL_1_4_VAL" id="CELL_1_4_VAL" value="0" valuefield>
<input type="hidden" name="CELL_1_5_VAL" id="CELL_1_5_VAL" value="0" valuefield>

<input type="hidden" name="CELL_2_1_VAL" id="CELL_2_1_VAL" value="0" valuefield>
<input type="hidden" name="CELL_2_2_VAL" id="CELL_2_2_VAL" value="0" valuefield>
<input type="hidden" name="CELL_2_3_VAL" id="CELL_2_3_VAL" value="0" valuefield>
<input type="hidden" name="CELL_2_4_VAL" id="CELL_2_4_VAL" value="0" valuefield>
<input type="hidden" name="CELL_2_5_VAL" id="CELL_2_5_VAL" value="0" valuefield>

<input type="hidden" name="CELL_3_1_VAL" id="CELL_3_1_VAL" value="0" valuefield>
<input type="hidden" name="CELL_3_2_VAL" id="CELL_3_2_VAL" value="0" valuefield>
<input type="hidden" name="CELL_3_3_VAL" id="CELL_3_3_VAL" value="0" valuefield>
<input type="hidden" name="CELL_3_4_VAL" id="CELL_3_4_VAL" value="0" valuefield>
<input type="hidden" name="CELL_3_5_VAL" id="CELL_3_5_VAL" value="0" valuefield>

<input type="hidden" name="CELL_4_1_VAL" id="CELL_4_1_VAL" value="0" valuefield>
<input type="hidden" name="CELL_4_2_VAL" id="CELL_4_2_VAL" value="0" valuefield>
<input type="hidden" name="CELL_4_3_VAL" id="CELL_4_3_VAL" value="0" valuefield>
<input type="hidden" name="CELL_4_4_VAL" id="CELL_4_4_VAL" value="0" valuefield>
<input type="hidden" name="CELL_4_4_VAL" id="CELL_4_5_VAL" value="0" valuefield>

<input type="hidden" name="physical_injury" id="physical_injury" value="" >
<input type="hidden" name="damage_to_the_environment" id="damage_to_the_environment" value="" >
<input type="hidden" name="damage_to_assets" id="damage_to_assets" value="" >
<input type="hidden" name="potential_increased_cost" id="potential_increased_cost" value="" >
<input type="hidden" name="damage_to_corporate_reputation" id="damage_to_corporate_reputation" value="" >
<input type="hidden" name="likelihood" id="likelihood" value="" >

<div style="background-color:<%= panelcolor %>;width:800px;">
<br>
<div align="center">
<span style="padding-bottom:18px;padding-left:30px;color:white;font-weight:bold;font-size:12px;">RISK ASSESSMENT MATRIX</span>
<br><br>
<table border="0" cellspacing="1" cellpadding="4" bgcolor="<%= tablebordercolor %>" width="<%= tablewidth %>">
  <tr bgcolor="<%= cellbackgroundcolor %>" height="<%= headerheight %>">
    <td colspan="6" align="center"><span style="color:white;font-weight:bold;">SEVERITY LEVELS</span>
    </td>
    <td colspan="5" align="center"><span style="color:white;font-weight:bold;">LIKELIHOOD LEVELS</span>
    </td>
  </tr>
  <tr bgcolor="<%= cellbackgroundcolor %>" height="<%= labelheight %>" align="center" valign="bottom">
    <td width="<%= firstcellwidth %>"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">RATING</span>
    </td>
    <td width="<%= cellwidth %>"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">PHYSICAL INJURY</span>
    </td>
    <td width="<%= cellwidth %>"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">DAMAGE TO THE ENVIRONMENT</span>
    </td>
    <td width="<%= cellwidth %>"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">DAMAGE TO ASSETS</span>
    </td>
    <td width="<%= cellwidth %>"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">POTENTIAL INCREASED COST OR REVENUE LOSS</span>
    </td>
    <td width="<%= cellwidth %>"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">DAMAGE TO CORPORATE REPUTATION</span>
    </td>
    <td id="CELL_A_A" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Unknown But Possible In The Aviation Industry')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">A<br><br><br>UNKNOWN BUT POSSIBLE IN THE AVIATION<br>INDUSTRY</span>
    </td>
    <td id="CELL_B_B" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Known In The Avaition Industry')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">B<br><br><br><br><br>KNOWN IN THE AVAITION INDUSTRY</span>
    </td>
    <td id="CELL_C_C" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Occurred In The Company')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">C<br><br><br><br><br><br>OCCURRED IN THE COMPANY</span>
    </td>
    <td id="CELL_D_D" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Reported >3x/Yr Within The Company')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">D<br><br><br><br>REPORTED >3x/YR WITHIN THE COMPANY</span>
    </td>
    <td id="CELL_E_E" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Reported >3x/Yr At A Particular Location')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">E<br><br><br><br><br>REPORTED >3x/YR AT A PARTICULAR LOCATION</span>
    </td>
  </tr>
  <tr bgcolor="<%= cellbackgroundcolor %>" height="<%= cellheight %>" align="center" valign="bottom">
    <td width="<%= firstcellwidth %>"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">0</span>
    </td>
    <td id="CELL_0_1" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'No Injury')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">No Injury</span>
    </td>
    <td id="CELL_0_2" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'No Effect')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">No Effect</span>
    </td>
    <td id="CELL_0_3" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'No Damage')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">No Damage</span>
    </td>
    <td id="CELL_0_4" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'No Increased Cost or Lost Revenue')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">No Increased Cost or Lost Revenue</span>
    </td>
    <td id="CELL_0_5" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'No Implication')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">No Implication</span>
    </td>
    <td id="CELL_0_A" width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td id="CELL_0_B" width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td id="CELL_0_C" width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td id="CELL_0_D" width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td id="CELL_0_E" width="<%= cellwidth %>" style="background-color:green;">
    </td>
  </tr>
  <tr bgcolor="<%= cellbackgroundcolor %>" height="<%= cellheight %>" align="center" valign="bottom">
    <td width="<%= firstcellwidth %>"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">1</span>
    </td>
    <td id="CELL_1_1" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Minor Injury')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Minor Injury</span>
    </td>
    <td id="CELL_1_2" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Minor Effect')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Minor Effect</span>
    </td>
    <td id="CELL_1_3" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Minor Damage <US $50K')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Minor Damage <US $50K</span>
    </td>
    <td id="CELL_1_4" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Minor Loss <US $50K')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Minor Loss <US $50K</span>
    </td>
    <td id="CELL_1_5" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Limited Localized Implication')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Limited Localized Implication</span>
    </td>
    <td id="CELL_1_A" width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td id="CELL_1_B" width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td id="CELL_1_C" width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td id="CELL_1_D" width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td id="CELL_1_E" width="<%= cellwidth %>" style="background-color:green;">
    </td>
  </tr>
  <tr bgcolor="<%= cellbackgroundcolor %>" height="<%= cellheight %>" align="center" valign="bottom">
    <td width="<%= firstcellwidth %>"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">2</span>
    </td>
    <td id="CELL_2_1" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Serious Injury')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Serious Injury</span>
    </td>
    <td id="CELL_2_2" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Contained Effect')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Contained Effect</span>
    </td>
    <td id="CELL_2_3" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Substantial Damage <US $250K')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Substantial Damage <US $250K</span>
    </td>
    <td id="CELL_2_4" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Substantial Loss <US $250K')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Substantial Loss <US $250K</span>
    </td>
    <td id="CELL_2_5" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Regional Implication')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Regional Implication</span>
    </td>
    <td id="CELL_2_A" width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td id="CELL_2_B" width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td id="CELL_2_C" width="<%= cellwidth %>" style="background-color:yellow;">
    </td>
    <td id="CELL_2_D" width="<%= cellwidth %>" style="background-color:yellow;">
    </td>
    <td id="CELL_2_E" width="<%= cellwidth %>" style="background-color:red;">
    </td>
  </tr>
  <tr bgcolor="<%= cellbackgroundcolor %>" height="<%= cellheight %>" align="center" valign="bottom">
    <td width="<%= firstcellwidth %>"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">3</span>
    </td>
    <td id="CELL_3_1" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Single Fatality')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Single Fatality</span>
    </td>
    <td id="CELL_3_2" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Minor Effect')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Minor Effect</span>
    </td>
    <td id="CELL_3_3" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Major Damage <US $1M')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Major Damage <US $1M</span>
    </td>
    <td id="CELL_3_4" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Major Loss <US $1M')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Major Loss <US $1M</span>
    </td>
    <td id="CELL_3_5" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'National Implication')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">National Implication</span>
    </td>
    <td id="CELL_3_A" width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td id="CELL_3_B" width="<%= cellwidth %>" style="background-color:yellow;">
    </td>
    <td id="CELL_3_C" width="<%= cellwidth %>" style="background-color:yellow;">
    </td>
    <td id="CELL_3_D" width="<%= cellwidth %>" style="background-color:red;">
    </td>
    <td id="CELL_3_E" width="<%= cellwidth %>" style="background-color:red;">
    </td>
  </tr>
  <tr bgcolor="<%= cellbackgroundcolor %>" height="<%= cellheight %>" align="center" valign="bottom">
    <td width="<%= firstcellwidth %>"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">4</span>
    </td>
    <td id="CELL_4_1" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Multiple Fatalities')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Multiple Fatalities</span>
    </td>
    <td id="CELL_4_2" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Massive Effect')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Massive Effect</span>
    </td>
    <td id="CELL_4_3" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Catastrophic Damage &ge;US $1M')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Catastrophic Damage &ge;US $1M</span>
    </td>
    <td id="CELL_4_4" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Massive Loss &ge;US $1M')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Massive Loss &ge;US $1M</span>
    </td>
    <td id="CELL_4_5" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'International Implication')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">International Implication</span>
    </td>
    <td id="CELL_4_A" width="<%= cellwidth %>" style="background-color:yellow;">
    </td>
    <td id="CELL_4_B" width="<%= cellwidth %>" style="background-color:yellow;">
    </td>
    <td id="CELL_4_C" width="<%= cellwidth %>" style="background-color:red;">
    </td>
    <td id="CELL_4_D" width="<%= cellwidth %>" style="background-color:red;">
    </td>
    <td id="CELL_4_E" width="<%= cellwidth %>" style="background-color:red;">
    </td>
  </tr>
</table>
</div>
<br>
<div style="padding-left:30px;"><span id="ACCEPTABILITY_SPAN" style="padding-bottom:18px;color:white;font-weight:bold;font-size:18px;">&nbsp;</span></div>
<br><br>
</div>

<% cellheight = cellheight +2 %>
<table id="splashtable" border="0" cellspacing="0" cellpadding="4" bgcolor="<%= tablebordercolor %>" width="<%= cint(cellwidth) * 5 +1 %>" style="position:absolute;left:454px;top:240px;">
  <tr bgcolor="<%= cellbackgroundcolor %>" align="center" valign="bottom">
    <td colspan="5" style="height:8px;" style="background-color:green;">
    </td>
  </tr>
  <tr bgcolor="<%= cellbackgroundcolor %>" height="<%= cellheight %>" align="center" valign="bottom">
    <td width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td width="<%= cellwidth  %>" style="background-color:green;">
    </td>
  </tr>
  <tr bgcolor="<%= cellbackgroundcolor %>" height="<%= cellheight %>" align="center" valign="top">
    <td width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td colspan="2" style="background-color:green;"><span style="padding-left:30px;color:white;font-weight:bold;font-size:10px;">ACCEPTABLE</span>
    </td>
    <td width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td width="<%= cellwidth  %>" style="background-color:green;">
    </td>
  </tr>
  <tr bgcolor="<%= cellbackgroundcolor %>" height="<%= cellheight %>" align="center" valign="middle">
    <td width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td colspan="2" style="background-color:yellow;" align="center"><span style="color:black;font-weight:bold;font-size:10px;">ACCEPTABLE WITH MITIGATION</span>
    </td>
    <td width="<%= cellwidth  %>" style="background-color:red;">
    </td>
  </tr>
  <tr bgcolor="<%= cellbackgroundcolor %>" height="<%= cellheight %>" align="center" valign="bottom">
    <td width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td colspan="2" style="background-color:yellow;">
    </td>
    <td colspan="2" style="background-color:red;" align="center"><span style="color:black;font-weight:bold;font-size:10px;">UNACCEPTABLE</span>
    </td>
  </tr>
  <tr bgcolor="<%= cellbackgroundcolor %>" height="<%= cellheight -2 %>" align="center" valign="bottom">
    <td colspan="2" style="background-color:yellow;">
    </td>
    <td colspan="3" style="background-color:red;">
    </td>
  </tr>
</table>
</body>
</html>