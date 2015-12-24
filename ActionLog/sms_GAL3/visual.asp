<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<%
return_field	= request("f")
log_number		= request("log_number")
viewdivision		= request("division")

set oXML					= CreateObject("Microsoft.XMLDOM")
oXML.async					= false

sql = "select logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'risk' and logNumber = "& sqlnum(log_number) &" and archived = 'n' and division = "& sqltext2(viewdivision) &" and active = 'y' order by logNumber desc, recid desc"
set rs = conn_asap.execute(sql)
'response.write(sql)
'response.end
if not rs.eof then
  formDataXML					= rs("formDataXML")

  oXML.loadXML(formDataXML)

  pre_physical_injury							= selectNode(oXML,"pre_physical_injury","")
  pre_damage_to_the_environment					= selectNode(oXML,"pre_damage_to_the_environment","")
  pre_damage_to_assets							= selectNode(oXML,"pre_damage_to_assets","")
  pre_potential_increased_cost					= selectNode(oXML,"pre_potential_increased_cost","")
  pre_damage_to_corporate_reputation			= selectNode(oXML,"pre_damage_to_corporate_reputation","")
  pre_likelihood								= selectNode(oXML,"pre_likelihood","")
  post_physical_injury							= selectNode(oXML,"post_physical_injury","")
  post_damage_to_the_environment				= selectNode(oXML,"post_damage_to_the_environment","")
  post_damage_to_assets							= selectNode(oXML,"post_damage_to_assets","")
  post_potential_increased_cost					= selectNode(oXML,"post_potential_increased_cost","")
  post_damage_to_corporate_reputation			= selectNode(oXML,"post_damage_to_corporate_reputation","")
  post_likelihood								= selectNode(oXML,"post_likelihood","")

  pre_physical_injury_rating					= selectNode(oXML,"pre_physical_injury_rating","")
  pre_damage_to_the_environment_rating			= selectNode(oXML,"pre_damage_to_the_environment_rating","")
  pre_damage_to_assets_rating					= selectNode(oXML,"pre_damage_to_assets_rating","")
  pre_potential_increased_cost_rating			= selectNode(oXML,"pre_potential_increased_cost_rating","")
  pre_damage_to_corporate_reputation_rating		= selectNode(oXML,"pre_damage_to_corporate_reputation_rating","")
  pre_likelihood_level							= selectNode(oXML,"pre_likelihood_level","")
  post_physical_injury_rating					= selectNode(oXML,"post_physical_injury_rating","")
  post_damage_to_the_environment_rating			= selectNode(oXML,"post_damage_to_the_environment_rating","")
  post_damage_to_assets_rating					= selectNode(oXML,"post_damage_to_assets_rating","")
  post_potential_increased_cost_rating			= selectNode(oXML,"post_potential_increased_cost_rating","")
  post_damage_to_corporate_reputation_rating	= selectNode(oXML,"post_damage_to_corporate_reputation_rating","")
  post_likelihood_level							= selectNode(oXML,"post_likelihood_level","")

  pre_damage_to_corporate_reputation2			= selectNode(oXML,"pre_damage_to_corporate_reputation2","")
  post_damage_to_corporate_reputation2			= selectNode(oXML,"post_damage_to_corporate_reputation2","")
  pre_damage_to_corporate_reputation2_rating		= selectNode(oXML,"pre_damage_to_corporate_reputation2_rating","")
  post_damage_to_corporate_reputation2_rating	= selectNode(oXML,"post_damage_to_corporate_reputation2_rating","")

  if(return_field = "pre_risk") then
    physical_injury								= pre_physical_injury
    damage_to_the_environment					= pre_damage_to_the_environment
    damage_to_assets							= pre_damage_to_assets
    potential_increased_cost					= pre_potential_increased_cost
    damage_to_corporate_reputation				= pre_damage_to_corporate_reputation
    damage_to_corporate_reputation2				= pre_damage_to_corporate_reputation2
    likelihood									= pre_likelihood
    physical_injury_rating						= pre_physical_injury_rating
    damage_to_the_environment_rating			= pre_damage_to_the_environment_rating
    damage_to_assets_rating						= pre_damage_to_assets_rating
    potential_increased_cost_rating				= pre_potential_increased_cost_rating
    damage_to_corporate_reputation_rating		= pre_damage_to_corporate_reputation_rating
    damage_to_corporate_reputation2_rating		= pre_damage_to_corporate_reputation2_rating
    likelihood_level							= pre_likelihood_level
  else
    physical_injury								= post_physical_injury
    damage_to_the_environment					= post_damage_to_the_environment
    damage_to_assets							= post_damage_to_assets
    potential_increased_cost					= post_potential_increased_cost
    damage_to_corporate_reputation				= post_damage_to_corporate_reputation
    damage_to_corporate_reputation2				= post_damage_to_corporate_reputation2
    likelihood									= post_likelihood
    physical_injury_rating						= post_physical_injury_rating
    damage_to_the_environment_rating			= post_damage_to_the_environment_rating
    damage_to_assets_rating						= post_damage_to_assets_rating
    potential_increased_cost_rating				= post_potential_increased_cost_rating
    damage_to_corporate_reputation_rating		= post_damage_to_corporate_reputation_rating
    damage_to_corporate_reputation2_rating		= post_damage_to_corporate_reputation2_rating
    likelihood_level							= post_likelihood_level
  end if

end if
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
<!--
<%= sql %>
-->
<script>
function init() {
//alert('<%= return_field %>');
<% if(return_field <> "") then %>
<% if(len(physical_injury_rating) > 0) then %>
  virtual_cellclicked("CELL_<%= physical_injury_rating %>_1","<%= physical_injury %>");
<% end if %>
<% if(len(damage_to_the_environment_rating) > 0) then %>
  virtual_cellclicked("CELL_<%= damage_to_the_environment_rating %>_2","<%= damage_to_the_environment %>");
<% end if %>
<% if(len(damage_to_assets_rating) > 0) then %>
  virtual_cellclicked("CELL_<%= damage_to_assets_rating %>_3","<%= damage_to_assets %>");
<% end if %>
<% if(len(potential_increased_cost_rating) > 0) then %>
  virtual_cellclicked("CELL_<%= potential_increased_cost_rating %>_4","<%= potential_increased_cost %>");
<% end if %>
<% if(len(damage_to_corporate_reputation_rating) > 0) then %>
  virtual_cellclicked("CELL_<%= damage_to_corporate_reputation_rating %>_5","<%= damage_to_corporate_reputation %>");
<% end if %>
<% if(len(damage_to_corporate_reputation2_rating) > 0) then %>
  virtual_cellclicked("CELL_<%= damage_to_corporate_reputation2_rating %>_6","<%= damage_to_corporate_reputation2 %>");
<% end if %>
<% if(len(likelihood_level) > 0) then %>
  virtual_cellclicked("CELL_<%= likelihood_level %>_<%= likelihood_level %>","<%= likelihood %>");
<% end if %>
<% end if %>
}

function virtual_cellclicked(oid,v) {
  //alert("virtual_cellclicked:"+oid+":"+v);
  var o = document.getElementById(oid);
  var currID = oid;
  x = parseRow(currID);
  y = parseCol(currID);
  var currVal = document.getElementById(currID+"_VAL").value;
  clearCol(parseCol(currID));
  if(currVal == "1") {
    o.style.backgroundColor = "#00346B";
    document.getElementById(currID+"_VAL").value = "0";
    if(y == "1") {
      document.getElementById("physical_injury").value = "";
      document.getElementById("physical_injury_rating").value = "";
    }
    if(y == "2") {
      document.getElementById("damage_to_the_environment").value = "";
      document.getElementById("damage_to_the_environment_rating").value = "";
    }
    if(y == "3") {
      document.getElementById("damage_to_assets").value = "";
      document.getElementById("damage_to_assets_rating").value = "";
    }
    if(y == "4") {
      document.getElementById("potential_increased_cost").value = "";
      document.getElementById("potential_increased_cost_rating").value = "";
    }
    if(y == "5") {
      document.getElementById("damage_to_corporate_reputation").value = "";
      document.getElementById("damage_to_corporate_reputation_rating").value = "";
    }
    if(y == "6") {
      document.getElementById("damage_to_corporate_reputation2").value = "";
      document.getElementById("damage_to_corporate_reputation2_rating").value = "";
    }
    if((x == "A")||((x == "B"))||((x == "C"))||((x == "D"))||((x == "E"))) {
      document.getElementById("likelihood").value = "";
      document.getElementById("likelihood_level").value = "";
    }
  } else {
    o.style.backgroundColor = "#a0a0a0";
    document.getElementById(currID+"_VAL").value = "1";
    if(y == "1") {
      document.getElementById("physical_injury").value = v;
      document.getElementById("physical_injury_rating").value = x;
    }
    if(y == "2") {
      document.getElementById("damage_to_the_environment").value = v;
      document.getElementById("damage_to_the_environment_rating").value = x;
    }
    if(y == "3") {
      document.getElementById("damage_to_assets").value = v;
      document.getElementById("damage_to_assets_rating").value = x;
    }
    if(y == "4") {
      document.getElementById("potential_increased_cost").value = v;
      document.getElementById("potential_increased_cost_rating").value = x;
    }
    if(y == "5") {
      document.getElementById("damage_to_corporate_reputation").value = v;
      document.getElementById("damage_to_corporate_reputation_rating").value = x;
    }
    if(y == "6") {
      document.getElementById("damage_to_corporate_reputation2").value = v;
      document.getElementById("damage_to_corporate_reputation2_rating").value = x;
    }
    if((x == "A")||((x == "B"))||((x == "C"))||((x == "D"))||((x == "E"))) {
      document.getElementById("likelihood").value = v;
      document.getElementById("likelihood_level").value = x;
    }
  }
  checkResult();
}


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
      document.getElementById("physical_injury_rating").value = "";
    }
    if(y == "2") {
      document.getElementById("damage_to_the_environment").value = "";
      document.getElementById("damage_to_the_environment_rating").value = "";
    }
    if(y == "3") {
      document.getElementById("damage_to_assets").value = "";
      document.getElementById("damage_to_assets_rating").value = "";
    }
    if(y == "4") {
      document.getElementById("potential_increased_cost").value = "";
      document.getElementById("potential_increased_cost_rating").value = "";
    }
    if(y == "5") {
      document.getElementById("damage_to_corporate_reputation").value = "";
      document.getElementById("damage_to_corporate_reputation_rating").value = "";
    }
    if(y == "6") {
      document.getElementById("damage_to_corporate_reputation2").value = "";
      document.getElementById("damage_to_corporate_reputation2_rating").value = "";
    }
    if((x == "A")||((x == "B"))||((x == "C"))||((x == "D"))||((x == "E"))) {
      document.getElementById("likelihood").value = "";
      document.getElementById("likelihood_level").value = "";
    }
  } else {
    o.style.backgroundColor = "#a0a0a0";
    document.getElementById(currID+"_VAL").value = "1";
    if(y == "1") {
      document.getElementById("physical_injury").value = v;
      document.getElementById("physical_injury_rating").value = x;
    }
    if(y == "2") {
      document.getElementById("damage_to_the_environment").value = v;
      document.getElementById("damage_to_the_environment_rating").value = x;
    }
    if(y == "3") {
      document.getElementById("damage_to_assets").value = v;
      document.getElementById("damage_to_assets_rating").value = x;
    }
    if(y == "4") {
      document.getElementById("potential_increased_cost").value = v;
      document.getElementById("potential_increased_cost_rating").value = x;
    }
    if(y == "5") {
      document.getElementById("damage_to_corporate_reputation").value = v;
      document.getElementById("damage_to_corporate_reputation_rating").value = x;
    }
    if(y == "6") {
      document.getElementById("damage_to_corporate_reputation2").value = v;
      document.getElementById("damage_to_corporate_reputation2_rating").value = x;
    }
    if((x == "A")||((x == "B"))||((x == "C"))||((x == "D"))||((x == "E"))) {
      document.getElementById("likelihood").value = v;
      document.getElementById("likelihood_level").value = x;
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
  parent.setFieldValue("<%= request("prefix") %>damage_to_corporate_reputation2","");
  parent.setFieldValue("<%= request("prefix") %>likelihood","");

  parent.setFieldValue("<%= request("prefix") %>physical_injury_rating","");
  parent.setFieldValue("<%= request("prefix") %>damage_to_the_environment_rating","");
  parent.setFieldValue("<%= request("prefix") %>damage_to_assets_rating","");
  parent.setFieldValue("<%= request("prefix") %>potential_increased_cost_rating","");
  parent.setFieldValue("<%= request("prefix") %>damage_to_corporate_reputation_rating","");
  parent.setFieldValue("<%= request("prefix") %>damage_to_corporate_reputation2_rating","");
  parent.setFieldValue("<%= request("prefix") %>likelihood_level","");
<% end if %>
  if((document.getElementById("CELL_A_A_VAL").value == "1")||(document.getElementById("CELL_B_B_VAL").value == "1")||(document.getElementById("CELL_C_C_VAL").value == "1")||(document.getElementById("CELL_D_D_VAL").value == "1")||(document.getElementById("CELL_E_E_VAL").value == "1")) {
    if((document.getElementById("CELL_0_1_VAL").value == "1")||(document.getElementById("CELL_1_1_VAL").value == "1")||(document.getElementById("CELL_2_1_VAL").value == "1")||(document.getElementById("CELL_3_1_VAL").value == "1")||(document.getElementById("CELL_4_1_VAL").value == "1")) {
      if((document.getElementById("CELL_0_2_VAL").value == "1")||(document.getElementById("CELL_1_2_VAL").value == "1")||(document.getElementById("CELL_2_2_VAL").value == "1")||(document.getElementById("CELL_3_2_VAL").value == "1")||(document.getElementById("CELL_4_2_VAL").value == "1")) {
        if((document.getElementById("CELL_0_3_VAL").value == "1")||(document.getElementById("CELL_1_3_VAL").value == "1")||(document.getElementById("CELL_2_3_VAL").value == "1")||(document.getElementById("CELL_3_3_VAL").value == "1")||(document.getElementById("CELL_4_3_VAL").value == "1")) {
          if((document.getElementById("CELL_0_4_VAL").value == "1")||(document.getElementById("CELL_1_4_VAL").value == "1")||(document.getElementById("CELL_2_4_VAL").value == "1")||(document.getElementById("CELL_3_4_VAL").value == "1")||(document.getElementById("CELL_4_4_VAL").value == "1")) {
            if((document.getElementById("CELL_0_5_VAL").value == "1")||(document.getElementById("CELL_1_5_VAL").value == "1")||(document.getElementById("CELL_2_5_VAL").value == "1")||(document.getElementById("CELL_3_5_VAL").value == "1")||(document.getElementById("CELL_4_5_VAL").value == "1")) {
              if((document.getElementById("CELL_0_6_VAL").value == "1")||(document.getElementById("CELL_1_6_VAL").value == "1")||(document.getElementById("CELL_2_6_VAL").value == "1")||(document.getElementById("CELL_3_6_VAL").value == "1")||(document.getElementById("CELL_4_6_VAL").value == "1")) {
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
              parent.setFieldValue("<%= request("prefix") %>damage_to_corporate_reputation2",document.getElementById("damage_to_corporate_reputation2").value);
              parent.setFieldValue("<%= request("prefix") %>likelihood",document.getElementById("likelihood").value);

              parent.setFieldValue("<%= request("prefix") %>physical_injury_rating",document.getElementById("physical_injury_rating").value);
              parent.setFieldValue("<%= request("prefix") %>damage_to_the_environment_rating",document.getElementById("damage_to_the_environment_rating").value);
              parent.setFieldValue("<%= request("prefix") %>damage_to_assets_rating",document.getElementById("damage_to_assets_rating").value);
              parent.setFieldValue("<%= request("prefix") %>potential_increased_cost_rating",document.getElementById("potential_increased_cost_rating").value);
              parent.setFieldValue("<%= request("prefix") %>damage_to_corporate_reputation_rating",document.getElementById("damage_to_corporate_reputation_rating").value);
              parent.setFieldValue("<%= request("prefix") %>damage_to_corporate_reputation2_rating",document.getElementById("damage_to_corporate_reputation2_rating").value);
              parent.setFieldValue("<%= request("prefix") %>likelihood_level",document.getElementById("likelihood_level").value);
<% end if %>
              if(tmpAcceptability == "Acceptable") {
                tmpColor = "336600";
                tmpAcceptability = "Determination of Risk Acceptability<br><span style='height:10px;width:20px;background-color:#006600;margin-right:5px;border:1px solid white;'>&nbsp;</span>Acceptable<br><span style='font-size:14px;'>Accepted without further action, but maybe an area for continuous improvement.</span>"
              }
              if(tmpAcceptability == "Acceptable With Mitigation") {
                tmpColor = "ffcc00";
                tmpAcceptability = "Determination of Risk Acceptability<br><span style='height:10px;width:20px;background-color:#ffcc00;margin-right:5px;border:1px solid white;'>&nbsp;</span>Acceptable With Mitigation<br><span style='font-size:14px;'>Accepted under defined conditions of mitigation.</span>"
              }
              if(tmpAcceptability == "Unacceptable") {
                tmpColor = "8a0808";
                tmpAcceptability = "Determination of Risk Acceptability<br><span style='height:10px;width:20px;background-color:#8a0808;margin-right:5px;border:1px solid white;'>&nbsp;</span>Unacceptable<br><span style='font-size:14px;'>Further work is required to design an intervention that eliminates the associated hazard or controls the factors that lead to higher risk likelihood or severity. Please refer to Section 5.5 of the SMS Manual for additional requirements.</span>";
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
  document.getElementById("splashtable").style.display = "none";
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
  for (var x = 1; x <= 2; x++) {
    document.getElementById("CELL_"+x+"_E").style.backgroundColor = "yellow";
  }
  for (var x = 3; x <= 4; x++) {
    document.getElementById("CELL_"+x+"_E").style.backgroundColor = "red";
  }
  document.getElementById("splashtable").style.display = "none";
}

function getSeverity() {
  if((document.getElementById("CELL_4_1_VAL").value == "1")||(document.getElementById("CELL_4_2_VAL").value == "1")||(document.getElementById("CELL_4_3_VAL").value == "1")||(document.getElementById("CELL_4_4_VAL").value == "1")||(document.getElementById("CELL_4_5_VAL").value == "1")||(document.getElementById("CELL_4_6_VAL").value == "1")) {
    return 4;
  }
  if((document.getElementById("CELL_3_1_VAL").value == "1")||(document.getElementById("CELL_3_2_VAL").value == "1")||(document.getElementById("CELL_3_3_VAL").value == "1")||(document.getElementById("CELL_3_4_VAL").value == "1")||(document.getElementById("CELL_3_5_VAL").value == "1")||(document.getElementById("CELL_3_6_VAL").value == "1")) {
    return 3;
  }
  if((document.getElementById("CELL_2_1_VAL").value == "1")||(document.getElementById("CELL_2_2_VAL").value == "1")||(document.getElementById("CELL_2_3_VAL").value == "1")||(document.getElementById("CELL_2_4_VAL").value == "1")||(document.getElementById("CELL_2_5_VAL").value == "1")||(document.getElementById("CELL_2_6_VAL").value == "1")) {
    return 2;
  }
  if((document.getElementById("CELL_1_1_VAL").value == "1")||(document.getElementById("CELL_1_2_VAL").value == "1")||(document.getElementById("CELL_1_3_VAL").value == "1")||(document.getElementById("CELL_1_4_VAL").value == "1")||(document.getElementById("CELL_1_5_VAL").value == "1")||(document.getElementById("CELL_1_6_VAL").value == "1")) {
    return 1;
  }
  if((document.getElementById("CELL_0_1_VAL").value == "1")||(document.getElementById("CELL_0_2_VAL").value == "1")||(document.getElementById("CELL_0_3_VAL").value == "1")||(document.getElementById("CELL_0_4_VAL").value == "1")||(document.getElementById("CELL_0_5_VAL").value == "1")||(document.getElementById("CELL_0_6_VAL").value == "1")) {
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
  if((v == "0_A")||(v == "0_B")||(v == "0_C")||(v == "0_D")||(v == "0_E")||(v == "1_A")||(v == "1_B")||(v == "1_C")||(v == "1_D")||(v == "2_A")||(v == "2_B")||(v == "3_A")) {
    acceptability = "Acceptable";
  }
  if((v == "2_E")||(v == "2_C")||(v == "2_D")||(v == "3_B")||(v == "3_C")||(v == "4_A")||(v == "4_B")||(v == "1_E")) {
    acceptability = "Acceptable With Mitigation";
  }
  if((v == "3_D")||(v == "3_E")||(v == "4_C")||(v == "4_D")||(v == "4_E")) {
    acceptability = "Unacceptable";
  }

  return acceptability;
}
</script>
</head>
<body onload="init()">

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
tablewidth = cint(firstcellwidth) + (11 * cint(cellwidth))

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
<input type="hidden" name="CELL_0_6_VAL" id="CELL_0_6_VAL" value="0" valuefield>

<input type="hidden" name="CELL_1_1_VAL" id="CELL_1_1_VAL" value="0" valuefield>
<input type="hidden" name="CELL_1_2_VAL" id="CELL_1_2_VAL" value="0" valuefield>
<input type="hidden" name="CELL_1_3_VAL" id="CELL_1_3_VAL" value="0" valuefield>
<input type="hidden" name="CELL_1_4_VAL" id="CELL_1_4_VAL" value="0" valuefield>
<input type="hidden" name="CELL_1_5_VAL" id="CELL_1_5_VAL" value="0" valuefield>
<input type="hidden" name="CELL_1_6_VAL" id="CELL_1_6_VAL" value="0" valuefield>

<input type="hidden" name="CELL_2_1_VAL" id="CELL_2_1_VAL" value="0" valuefield>
<input type="hidden" name="CELL_2_2_VAL" id="CELL_2_2_VAL" value="0" valuefield>
<input type="hidden" name="CELL_2_3_VAL" id="CELL_2_3_VAL" value="0" valuefield>
<input type="hidden" name="CELL_2_4_VAL" id="CELL_2_4_VAL" value="0" valuefield>
<input type="hidden" name="CELL_2_5_VAL" id="CELL_2_5_VAL" value="0" valuefield>
<input type="hidden" name="CELL_2_6_VAL" id="CELL_2_6_VAL" value="0" valuefield>

<input type="hidden" name="CELL_3_1_VAL" id="CELL_3_1_VAL" value="0" valuefield>
<input type="hidden" name="CELL_3_2_VAL" id="CELL_3_2_VAL" value="0" valuefield>
<input type="hidden" name="CELL_3_3_VAL" id="CELL_3_3_VAL" value="0" valuefield>
<input type="hidden" name="CELL_3_4_VAL" id="CELL_3_4_VAL" value="0" valuefield>
<input type="hidden" name="CELL_3_5_VAL" id="CELL_3_5_VAL" value="0" valuefield>
<input type="hidden" name="CELL_3_6_VAL" id="CELL_3_6_VAL" value="0" valuefield>

<input type="hidden" name="CELL_4_1_VAL" id="CELL_4_1_VAL" value="0" valuefield>
<input type="hidden" name="CELL_4_2_VAL" id="CELL_4_2_VAL" value="0" valuefield>
<input type="hidden" name="CELL_4_3_VAL" id="CELL_4_3_VAL" value="0" valuefield>
<input type="hidden" name="CELL_4_4_VAL" id="CELL_4_4_VAL" value="0" valuefield>
<input type="hidden" name="CELL_4_5_VAL" id="CELL_4_5_VAL" value="0" valuefield>
<input type="hidden" name="CELL_4_6_VAL" id="CELL_4_6_VAL" value="0" valuefield>

<input type="hidden" name="physical_injury" id="physical_injury" value="" >
<input type="hidden" name="damage_to_the_environment" id="damage_to_the_environment" value="" >
<input type="hidden" name="damage_to_assets" id="damage_to_assets" value="" >
<input type="hidden" name="potential_increased_cost" id="potential_increased_cost" value="" >
<input type="hidden" name="damage_to_corporate_reputation" id="damage_to_corporate_reputation" value="" >
<input type="hidden" name="damage_to_corporate_reputation2" id="damage_to_corporate_reputation2" value="" >
<input type="hidden" name="likelihood" id="likelihood" value="" >

<input type="hidden" name="physical_injury_rating" id="physical_injury_rating" value="" >
<input type="hidden" name="damage_to_the_environment_rating" id="damage_to_the_environment_rating" value="" >
<input type="hidden" name="damage_to_assets_rating" id="damage_to_assets_rating" value="" >
<input type="hidden" name="potential_increased_cost_rating" id="potential_increased_cost_rating" value="" >
<input type="hidden" name="damage_to_corporate_reputation_rating" id="damage_to_corporate_reputation_rating" value="" >
<input type="hidden" name="damage_to_corporate_reputation2_rating" id="damage_to_corporate_reputation2_rating" value="" >
<input type="hidden" name="likelihood_level" id="likelihood_level" value="" >

<div style="background-color:<%= panelcolor %>;width:870px;">
<br>
<div align="center">
<span style="padding-bottom:18px;padding-left:30px;color:white;font-weight:bold;font-size:12px;"><%= request("headerprefix") %>RISK ASSESSMENT MATRIX</span>
<br><br>
<table border="0" cellspacing="1" cellpadding="4" bgcolor="<%= tablebordercolor %>" width="<%= tablewidth %>">
  <tr bgcolor="<%= cellbackgroundcolor %>" height="<%= headerheight %>">
    <td rowspan="2" colspan="7" align="center"><span style="color:white;font-weight:bold;">Severity Levels</span>
    </td>
    <td colspan="5" align="center"><span style="color:white;font-weight:bold;">Probability Levels</span>
    </td>
  </tr>
  <tr bgcolor="<%= cellbackgroundcolor %>" height="<%= headerheight %>">
    <td align="center" valign="middle"><span style="color:white;font-weight:bold;">1</span>
    </td>
    <td align="center" valign="middle"><span style="color:white;font-weight:bold;">2</span>
    </td>
    <td align="center" valign="middle"><span style="color:white;font-weight:bold;">3</span>
    </td>
    <td align="center" valign="middle"><span style="color:white;font-weight:bold;">4</span>
    </td>
    <td align="center" valign="middle"><span style="color:white;font-weight:bold;">5</span>
    </td>
  </tr>
  <tr bgcolor="<%= cellbackgroundcolor %>" height="<%= labelheight %>" align="center" valign="bottom">
    <td width="<%= firstcellwidth %>"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Rating</span>
    </td>
    <td width="<%= cellwidth %>"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Physical Injury</span>
    </td>
    <td width="<%= cellwidth %>"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">A/C or Equipment Damage</span>
    </td>
    <td width="<%= cellwidth %>"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Potential Increased Cost or Revenue Loss</span>
    </td>
    <td width="<%= cellwidth %>"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Security Threat</span>
    </td>
    <td width="<%= cellwidth %>"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Regulartory Compliance</span>
    </td>
    <td width="<%= cellwidth %>"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Damage to the Environment</span>
    </td>
    <td id="CELL_A_A" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Unknown But Possible In The Aviation Industry')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Unknown, But Possible In The Industry</span>
    </td>
    <td id="CELL_B_B" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Known In The Avaition Industry')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Known In The Industry</span>
    </td>
    <td id="CELL_C_C" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Occurred In The Company')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Occurred In The Company</span>
    </td>
    <td id="CELL_D_D" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Reported &gt;3x/Yr Within The Company')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Reported More Than Three Times Per Year Within The Company</span>
    </td>
    <td id="CELL_E_E" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Reported &gt;3x/Yr At A Particular Location')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Reported More Than Three Times Per Year At A Particular Location</span>
    </td>
  </tr>
  <tr bgcolor="<%= cellbackgroundcolor %>" height="<%= cellheight %>" align="center" valign="bottom">
    <td width="<%= firstcellwidth %>"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">0</span>
    </td>
    <td id="CELL_0_1" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'No Injury')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">No Injury</span>
    </td>
    <td id="CELL_0_2" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'No Effect')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">No Damage</span>
    </td>
    <td id="CELL_0_3" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'No Damage')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">No Impact</span>
    </td>
    <td id="CELL_0_4" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'No Increased Cost or Lost Revenue')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">No Threat</span>
    </td>
    <td id="CELL_0_5" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'No Implication')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">No Implication</span>
    </td>
    <td id="CELL_0_6" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'No Implication')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Minimal Effect</span>
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
    <td id="CELL_1_2" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Minor Effect')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Less than $10,000</span>
    </td>
    <td id="CELL_1_3" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Minor Damage &lt;US $50K')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Minor Loss</span>
    </td>
    <td id="CELL_1_4" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Minor Loss &lt;US $50K')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Unlikely Threat</span>
    </td>
    <td id="CELL_1_5" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Limited Localized Implication')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Issuance of administrative directives</span>
    </td>
    <td id="CELL_1_6" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Limited Localized Implication')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Minor effect</span>
    </td>
    <td id="CELL_1_A" width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td id="CELL_1_B" width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td id="CELL_1_C" width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td id="CELL_1_D" width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td id="CELL_1_E" width="<%= cellwidth %>" style="background-color:yellow;">
    </td>
  </tr>
  <tr bgcolor="<%= cellbackgroundcolor %>" height="<%= cellheight %>" align="center" valign="bottom">
    <td width="<%= firstcellwidth %>"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">2</span>
    </td>
    <td id="CELL_2_1" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Serious Injury')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Multiple Minor Injuries</span>
    </td>
    <td id="CELL_2_2" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Contained Effect')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">From $10,000 to less than $100,000</span>
    </td>
    <td id="CELL_2_3" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Substantial Damage &lt;US $250K')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Substantial loss</span>
    </td>
    <td id="CELL_2_4" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Substantial Loss &lt;US $250K')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Possible threat</span>
    </td>
    <td id="CELL_2_5" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Regional Implication')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Issuance of administrative fines</span>
    </td>
    <td id="CELL_2_6" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Regional Implication')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Sustantial effect</span>
    </td>
    <td id="CELL_2_A" width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td id="CELL_2_B" width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td id="CELL_2_C" width="<%= cellwidth %>" style="background-color:yellow;">
    </td>
    <td id="CELL_2_D" width="<%= cellwidth %>" style="background-color:yellow;">
    </td>
    <td id="CELL_2_E" width="<%= cellwidth %>" style="background-color:yellow;">
    </td>
  </tr>
  <tr bgcolor="<%= cellbackgroundcolor %>" height="<%= cellheight %>" align="center" valign="bottom">
    <td width="<%= firstcellwidth %>"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">3</span>
    </td>
    <td id="CELL_3_1" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Single Fatality')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Serious Injury</span>
    </td>
    <td id="CELL_3_2" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Minor Effect')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">From $100,000 to less than $10 million</span>
    </td>
    <td id="CELL_3_3" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Major Damage &lt;US $1M')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Major loss</span>
    </td>
    <td id="CELL_3_4" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Major Loss &lt;US $1M')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Probably threat</span>
    </td>
    <td id="CELL_3_5" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'National Implication')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Issuance of heavy fines</span>
    </td>
    <td id="CELL_3_6" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'National Implication')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Major effect</span>
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
    <td id="CELL_4_1" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Multiple Fatalities')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">One Or More Fatalities</span>
    </td>
    <td id="CELL_4_2" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Massive Effect')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">$10 million or more</span>
    </td>
    <td id="CELL_4_3" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Catastrophic Damage &ge;US $1M')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Catastrophic loss</span>
    </td>
    <td id="CELL_4_4" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'Massive Loss &ge;US $1M')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Imminent threat</span>
    </td>
    <td id="CELL_4_5" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'International Implication')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Suspension / revocation of AOC or administrative fines range from</span>
    </td>
    <td id="CELL_4_6" width="<%= cellwidth %>" onmouseover="mouseovercell(this)" onmouseout="mouseoutcell(this)" onclick="cellclicked(this,'International Implication')"><span style="color:white;font-weight:normal;font-size:9px;font-family:Sans serif;">Irreversible effects</span>
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
<table id="splashtable" border="0" cellspacing="0" cellpadding="4" bgcolor="<%= tablebordercolor %>" width="<%= cint(cellwidth) * 5 +1 %>" style="position:absolute;left:454px;top:240px;display:none;">
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
    <td colspan="2" style="background-color:green;"><span style="padding-left:30px;color:white;font-weight:bold;font-size:10px;">Acceptable</span>
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
    <td colspan="2" style="background-color:yellow;" align="center"><span style="color:black;font-weight:bold;font-size:10px;">Acceptable With Mitigation</span>
    </td>
    <td width="<%= cellwidth  %>" style="background-color:red;">
    </td>
  </tr>
  <tr bgcolor="<%= cellbackgroundcolor %>" height="<%= cellheight %>" align="center" valign="bottom">
    <td width="<%= cellwidth %>" style="background-color:green;">
    </td>
    <td colspan="2" style="background-color:yellow;">
    </td>
    <td colspan="2" style="background-color:red;" align="center"><span style="color:black;font-weight:bold;font-size:10px;">Unacceptable</span>
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
