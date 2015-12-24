<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include file ="includes/wrapformdata2.inc"-->
<%
recid						= request("recid")
log_number					= request("log_number")
viewDivision				= request("viewDivision")


contributing_factors_cnt	= "1"
active_errors_cnt			= "1"
latent_conditions_cnt		= "1"
causal_factors_cnt			= "1"

set oXML					= CreateObject("Microsoft.XMLDOM")
oXML.async					= false

sql = "select logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'risk' and logNumber = "& sqlnum(log_number) &"  and archived = 'n' order by logNumber desc, recid desc"
set rs = conn_asap.execute(sql)
if not rs.eof then
  formDataXML					= rs("formDataXML")

  oXML.loadXML(formDataXML)

  active_errors_cnt						= selectNode(oXML,"active_errors_cnt","")
  contributing_factors_cnt				= selectNode(oXML,"contributing_factors_cnt","")
  latent_conditions_cnt					= selectNode(oXML,"latent_conditions_cnt","")
  causal_factors_cnt					= selectNode(oXML,"causal_factors_cnt","")
  pre_physical_injury					= selectNode(oXML,"pre_physical_injury","")
  pre_damage_to_the_environment			= selectNode(oXML,"pre_damage_to_the_environment","")
  pre_damage_to_assets					= selectNode(oXML,"pre_damage_to_assets","")
  pre_potential_increased_cost			= selectNode(oXML,"pre_potential_increased_cost","")
  pre_damage_to_corporate_reputation	= selectNode(oXML,"pre_damage_to_corporate_reputation","")
  pre_likelihood						= rev_xdata2(selectNode(oXML,"pre_likelihood",""))
  post_physical_injury					= selectNode(oXML,"post_physical_injury","")
  post_damage_to_the_environment		= selectNode(oXML,"post_damage_to_the_environment","")
  post_damage_to_assets					= selectNode(oXML,"post_damage_to_assets","")
  post_potential_increased_cost			= selectNode(oXML,"post_potential_increased_cost","")
  post_damage_to_corporate_reputation	= selectNode(oXML,"post_damage_to_corporate_reputation","")
  post_likelihood						= rev_xdata2(selectNode(oXML,"post_likelihood",""))
  log_number							= selectNode(oXML,"log_number","")
  'accountable_leader					= rev_xdata2(selectNode(oXML,"accountable_leader",""))

  'contributing_factor_1
  'active_error_1
  'latent_condition_1
  'causal_factor_1
  current_measures						= rev_xdata2(selectNode(oXML,"current_measures",""))
  current_measures_responsible_person	= rev_xdata2(selectNode(oXML,"current_measures_responsible_person",""))
  risk_value_pre_mitigation				= rev_xdata2(selectNode(oXML,"risk_value_pre_mitigation",""))
  corrective_actions					= rev_xdata2(selectNode(oXML,"corrective_actions",""))
  unintended_consequences				= rev_xdata2(selectNode(oXML,"unintended_consequences",""))
  corrective_actions_responsible_person	= rev_xdata2(selectNode(oXML,"corrective_actions_responsible_person",""))
  risk_value_post_mitigation			= rev_xdata2(selectNode(oXML,"risk_value_post_mitigation",""))

end if



sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and logNumber = "& sqlnum(log_number) &" and archived = 'n' order by logNumber desc, recid desc"
'sql = "select * from EHD_Data where recid = "& recid
set rs = conn_asap.execute(sql)

set oXML2					= CreateObject("Microsoft.XMLDOM")
oXML2.async					= false

if not rs.eof then
  loginID					= rs("loginID")
  createDate				= rs("createDate")
  formDataXML2				= rs("formDataXML")
  recid						= rs("recid")
  log_number				= rs("logNumber")
  log_number				= string(4-len(log_number),"0")&log_number


  oXML2.loadXML(formDataXML2)

  safety_action_cnt			= selectNode(oXML2,"safety_action_cnt","")
  item_number				= selectNode(oXML2,"item_number","")
  item_description			= rev_xdata2(selectNode(oXML2,"item_description",""))
  accountable_leader		= rev_xdata2(selectNode(oXML2,"accountable_leader",""))
  source					= rev_xdata2(selectNode(oXML2,"source",""))
  date_opened				= selectNode(oXML2,"date_opened","")
  date_due					= selectNode(oXML2,"date_due","")
  date_completed			= selectNode(oXML2,"date_completed","")
  item_status				= selectNode(oXML2,"item_status","")

end if

log_numberStr = string(4-len(log_number),"0")&log_number

%>
<!--
formDataXML:<%= formDataXML %>

formDataXML2:<%= formDataXML2 %>
-->
<html><head>
<!--#include file ="includes/commonhead.inc"-->
<title>Risk Assessment of SRT Action Log Item</title>

<script type="text/javascript">
function toggleSection(o,t){

  if(o.checked) {
    document.getElementById(t).style.display = 'block';
  } else {
    document.getElementById(t).style.display = 'none';
  }
}


var active_errors_cnt = 1;
var contributing_factors_cnt = 1;
var latent_conditions_cnt = 1;
var causal_factors_cnt = 1;

function addTextbox(t,r,f) {

  currCnt = parseInt(document.getElementById(f+"s_cnt").value);
  currCnt = currCnt +1;
  document.getElementById(f+"s_cnt").value = currCnt;
  //alert(f+":"+document.getElementById(f+"s_cnt").value);

  var inputTable = document.getElementById(t);
  //alert(inputTable.id);
  var inputTableRow = document.getElementById(r);
  //alert(inputTableRow.id);

  var newTR1 = document.createElement('TR');
  var newTD1 = document.createElement('TD');
  inputTable.insertBefore(newTR1, inputTableRow);

  newTR1.appendChild(newTD1);
  newTD1.innerHTML = "<textarea name='"+f+"_"+currCnt+"' style='width:540px;margin-left:10px;margin-top:5px;' rows='2'></textarea>";
}

function setFieldValue(f,v) {
  document.getElementById(f).value = v;
}
</script>
<style></style>
     <link href="css/style.css" rel="stylesheet" type="text/css" />
 <!--#include file="script/nav.js"-->
</head>
<body bgColor="white" topmargin="3pt" bottommargin="3pt" leftmargin="3pt" rightmargin="3pt">
       <div id="headerDiv">
 <!--#include file="includes/sms_header.inc"-->
      </div>
<center>
<form action="submit_riskanalysis.asp" method="post" name="frm" id="frm">
<!-- <form action="debugVars.asp" method="post" name="frm" id="frm"> -->

<input type="hidden" id="active_errors_cnt" name="active_errors_cnt" value="<%= active_errors_cnt %>">
<input type="hidden" id="contributing_factors_cnt" name="contributing_factors_cnt" value="<%= contributing_factors_cnt %>">
<input type="hidden" id="latent_conditions_cnt" name="latent_conditions_cnt" value="<%= latent_conditions_cnt %>">
<input type="hidden" id="causal_factors_cnt" name="causal_factors_cnt" value="<%= causal_factors_cnt %>">

<input type="hidden" id="pre_physical_injury" name="pre_physical_injury" value="">
<input type="hidden" id="pre_damage_to_the_environment" name="pre_damage_to_the_environment" value="">
<input type="hidden" id="pre_damage_to_assets" name="pre_damage_to_assets" value="">
<input type="hidden" id="pre_potential_increased_cost" name="pre_potential_increased_cost" value="">
<input type="hidden" id="pre_damage_to_corporate_reputation" name="pre_damage_to_corporate_reputation" value="">
<input type="hidden" id="pre_likelihood" name="pre_likelihood" value="">


<input type="hidden" id="post_physical_injury" name="post_physical_injury" value="">
<input type="hidden" id="post_damage_to_the_environment" name="post_damage_to_the_environment" value="">
<input type="hidden" id="post_damage_to_assets" name="post_damage_to_assets" value="">
<input type="hidden" id="post_potential_increased_cost" name="post_potential_increased_cost" value="">
<input type="hidden" id="post_damage_to_corporate_reputation" name="post_damage_to_corporate_reputation" value="">
<input type="hidden" id="post_likelihood" name="post_likelihood" value="">

<input type="hidden" name="pre_physical_injury_rating" id="pre_physical_injury_rating" value="" >
<input type="hidden" name="pre_damage_to_the_environment_rating" id="pre_damage_to_the_environment_rating" value="" >
<input type="hidden" name="pre_damage_to_assets_rating" id="pre_damage_to_assets_rating" value="" >
<input type="hidden" name="pre_potential_increased_cost_rating" id="pre_potential_increased_cost_rating" value="" >
<input type="hidden" name="pre_damage_to_corporate_reputation_rating" id="pre_damage_to_corporate_reputation_rating" value="" >
<input type="hidden" name="pre_likelihood_level" id="pre_likelihood_level" value="" >

<input type="hidden" name="post_physical_injury_rating" id="post_physical_injury_rating" value="" >
<input type="hidden" name="post_damage_to_the_environment_rating" id="post_damage_to_the_environment_rating" value="" >
<input type="hidden" name="post_damage_to_assets_rating" id="post_damage_to_assets_rating" value="" >
<input type="hidden" name="post_potential_increased_cost_rating" id="post_potential_increased_cost_rating" value="" >
<input type="hidden" name="post_damage_to_corporate_reputation_rating" id="post_damage_to_corporate_reputation_rating" value="" >
<input type="hidden" name="post_likelihood_level" id="post_likelihood_level" value="" >

<input type="hidden" id="formname" name="formname" value="risk">

<input type="hidden" id="log_number" name="log_number" value="<%= log_number %>" >
<input type="hidden" id="viewDivision" name="viewDivision" value="<%= viewDivision %>" >

<input type="hidden" id="accountable_leader" name="accountable_leader" value="<%= accountable_leader %>" >

<table cellSpacing="0" cellPadding="1" width="100%" border="0">
<tbody>
<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 12pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="center" width="100%" background="" bgColor="000080" colSpan="4">Risk Assessment of SRT Action Log Item</td>
</tr>

<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="left" width="100%" background="" bgColor="ffffff" colSpan="4">.</td>
</tr>

<tr>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial" align="right" width="25%" background="" bgColor="ffffff" rowSpan="1">Log Nbr.
</td>

<td style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial;padding-left:10px;" align="left" width="25%" background="" bgColor="ffffff" >
<%= viewDivision %><%= log_numberStr %></td>

<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial" align="right" width="25%" background="" bgColor="ffffff">
</td>

<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial" align="left" width="25%" background="" bgColor="ffffff">

</td>
</tr>
<tr>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial" align="right" width="25%" background="" bgColor="ffffff" rowSpan="1">Accountable Leader
</td>

<td style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial;padding-left:10px;" align="left" width="25%" background="" bgColor="ffffff" >
<%= accountable_leader %></td>

<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial" align="right" width="25%" background="" bgColor="ffffff">
</td>

<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial" align="left" width="25%" background="" bgColor="ffffff">

</td>
</tr>

<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="left" width="100%" background="" bgColor="ffffff" colSpan="4">.</td>
</tr>

<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; COLOR: #00040; FONT-FAMILY: Arial" align="center" width="100%" background="" bgColor="c0c0c0" colSpan="4">Contributing Factors</td>
</tr>

<tr valign="top"><td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: #00040; FONT-FAMILY: Arial; padding-top:5px; padding-left:10px;" align="left" width="25%" background="" bgColor="ffffff">

Factors that directly influence the efficiency of people in the workplace, which include complex interrelationships among its many components.
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: #00040; FONT-FAMILY: Arial" align="left" width="75%" background="" bgColor="ffffff" colSpan="3">

<%
contributing_factors_cntInt = cint(contributing_factors_cnt)
for a = 1 to contributing_factors_cntInt
%>
<textarea name="contributing_factor_<%= contributing_factors_cntInt %>" style="width:540px;margin-left:10px;margin-top:5px;" rows="2"><%= rev_xdata2(selectNode(oXML,"contributing_factor_"& contributing_factors_cntInt,"")) %></textarea>
<%
next
%>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tbody id="contributing_factorTABLE">
    <tr id="contributing_factorROW" style="height:1px;"><td style="height:1px;"></td></tr>
  </tbody>
</table>

<input  type="button" value="Add Contributing Factor" style="font-size:10px;background-color:white;width:160px;margin-top:5px;margin-left:10px;" onclick="addTextbox('contributing_factorTABLE','contributing_factorROW','contributing_factor')">
</td>
</tr>


<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="center" width="100%" background="" bgColor="ffffff" colSpan="4">.
</td>
</tr>

<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; COLOR: #00040; FONT-FAMILY: Arial" align="center" width="100%" background="" bgColor="c0c0c0" colSpan="4">Active Errors</td>
</tr>

<tr valign="top"><td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: #00040; FONT-FAMILY: Arial; padding-top:5px; padding-left:10px;" align="left" width="25%" background="" bgColor="ffffff">

Actions or inactions by frontline employees that typically have an immediate adverse effect.<br />(Example: Procedural error, slip, or lapse.)
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: #00040; FONT-FAMILY: Arial" align="left" width="75%" background="" bgColor="ffffff" colSpan="3">

<%
active_errors_cntInt = cint(active_errors_cnt)
for a = 1 to active_errors_cntInt
%>
<textarea name="active_error_<%= active_errors_cntInt %>" style="width:540px;margin-left:10px;margin-top:5px;" rows="2"><%= rev_xdata2(selectNode(oXML,"active_error_"& active_errors_cntInt,"")) %></textarea>
<%
next
%>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tbody id="active_errorTABLE">
    <tr id="active_errorROW" style="height:1px;"><td style="height:1px;"></td></tr>
  </tbody>
</table>

<input  type="button" value="Add Active Error" style="font-size:10px;background-color:white;width:160px;margin-top:5px;margin-left:10px;" onclick="addTextbox('active_errorTABLE','active_errorROW','active_error')">
</td>
</tr>

<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="center" width="100%" background="" bgColor="ffffff" colSpan="4">.
</td>
</tr>


<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; COLOR: #00040; FONT-FAMILY: Arial" align="center" width="100%" background="" bgColor="c0c0c0" colSpan="4">Latent Conditions</td>
</tr>

<tr valign="top"><td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: #00040; FONT-FAMILY: Arial; padding-top:5px; padding-left:10px;" align="left" width="25%" background="" bgColor="ffffff">

Conditions present in the system before the event occurred; triggering factors made these conditions evident.  These conditions are generally associated with management decisions or actions.  Consequences may not be present for longs periods of time.
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: #00040; FONT-FAMILY: Arial" align="left" width="75%" background="" bgColor="ffffff" colSpan="3">

<%
latent_conditions_cntInt = cint(latent_conditions_cnt)
for a = 1 to latent_conditions_cntInt
%>
<textarea name="latent_condition_<%= latent_conditions_cntInt %>" style="width:540px;margin-left:10px;margin-top:5px;" rows="2"><%= rev_xdata2(selectNode(oXML,"latent_condition_"& latent_conditions_cntInt,"")) %></textarea>
<%
next
%>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tbody id="latent_conditionTABLE">
    <tr id="latent_conditionROW" style="height:1px;"><td style="height:1px;"></td></tr>
  </tbody>
</table>

<input  type="button" value="Add Latent Condition" style="font-size:10px;background-color:white;width:160px;margin-top:5px;margin-left:10px;" onclick="addTextbox('latent_conditionTABLE','latent_conditionROW','latent_condition')">
</td>
</tr>

<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="center" width="100%" background="" bgColor="ffffff" colSpan="4">.
</td>
</tr>



<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; COLOR: #00040; FONT-FAMILY: Arial" align="center" width="100%" background="" bgColor="c0c0c0" colSpan="4">Causal Factors</td>
</tr>

<tr valign="top"><td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: #00040; FONT-FAMILY: Arial; padding-top:5px; padding-left:10px;" align="left" width="25%" background="" bgColor="ffffff">

Causal Factors are actions and conditions that were necessary and sufficient for a given consequence to have occurred. Without this factor the event would have not occurred.

</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: #00040; FONT-FAMILY: Arial" align="left" width="75%" background="" bgColor="ffffff" colSpan="3">

<%
causal_factors_cntInt = cint(causal_factors_cnt)
for a = 1 to causal_factors_cntInt
%>
<textarea name="causal_factor_<%= causal_factors_cntInt %>" style="width:540px;margin-left:10px;margin-top:5px;" rows="2"><%= rev_xdata2(selectNode(oXML,"causal_factor_"& causal_factors_cntInt,"")) %></textarea>
<%
next
%>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tbody id="causal_factorTABLE">
    <tr id="causal_factorROW" style="height:1px;"><td style="height:1px;"></td></tr>
  </tbody>
</table>

<input  type="button" value="Add Causal Factor" style="font-size:10px;background-color:white;width:160px;margin-top:5px;margin-left:10px;" onclick="addTextbox('causal_factorTABLE','causal_factorROW','causal_factor')">
</td>
</tr>

<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="center" width="100%" background="" bgColor="ffffff" colSpan="4">.
</td>
</tr>


</tbody>
</table>


<table cellSpacing="0" cellPadding="1" width="100%" border="0">
<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; COLOR: #00040; FONT-FAMILY: Arial" align="center" width="100%" background="" bgColor="c0c0c0" colSpan="4">Current Measures / Risk Value</td>
</tr>

<tr><td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: #00040; FONT-FAMILY: Arial" align="center" width="100%" background="" bgColor="dcdcdf" colSpan="4">Assign a value to the risk in its current state and describe the existing processes/procedures that are in place to prevent this condition.
</td>
</tr>

<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="center" width="100%" background="" bgColor="ffffff" colSpan="4">.
</td>
</tr>
<tr><td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial" valign="top" align="right" width="25%" background="" bgColor="ffffff">
Current Measures to reduce the risk</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial;padding-left:10px;" align="left" width="75%" background="" bgColor="ffffff" colspan="3">
<textarea name="current_measures" rows="2" required="false" style="width:540px;">
<%= current_measures %></textarea>
</td>
</tr>
<tr><td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial" align="right" width="25%" background="" bgColor="ffffff">
Responsible Person/Functional Area
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial;padding-left:10px;" align="left" width="25%" background="" bgColor="ffffff">
<input type="text" name="current_measures_responsible_person" size="30" style="width:236px;"  value="<%= current_measures_responsible_person %>" required="false" />
</td>

<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial" align="right" width="25%" background="" bgColor="ffffff">
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial" align="left" width="25%" background="" bgColor="ffffff">

</td>
</tr>
<tr><td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial" align="right" width="25%" background="" bgColor="ffffff">
Risk Value (Pre-mitigation)
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial;padding-left:6px;" align="left" width="25%" background="" bgColor="ffffff">
<input onclick="toggleSection(this,'table1')" type="checkbox" value="RAM_Pre" name="RAM_Pre" /><input type="text" id="pre_risk" name="risk_value_pre_mitigation" size="30" readonly  value="<%= risk_value_pre_mitigation %>" required="false" style="width:220px;" />
</td>

<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial" align="right" width="25%" background="" bgColor="ffffff">
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial" align="left" width="25%" background="" bgColor="ffffff">

</td>
</tr>
</table>


<table id="table1" cellSpacing="0" cellPadding="0" width="100%" border="0" style="display:none;">

<tr><td>
<iframe src="visual.asp?log_number=<%= log_number %>&f=pre_risk&prefix=pre_" width="100%" frameborder="0" height="670"></iframe>
</td>
</tr>

</table>


<table cellSpacing="0" cellPadding="1" width="100%" border="0">
<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; COLOR: #00040; FONT-FAMILY: Arial" align="center" width="100%" background="" bgColor="c0c0c0" colSpan="4">Corrective Action / Risk Value</td>
</tr>

<tr><td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: #00040; FONT-FAMILY: Arial" align="center" width="100%" background="" bgColor="dcdcdf" colSpan="4">Describe further corrective/proactive actions to mitigate the risk, the resulting Risk Value, and the person/functional area assigned to maintain oversight of the process.
</td>
</tr>

<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="center" width="100%" background="" bgColor="ffffff" colSpan="4">.
</td>
</tr>
<tr><td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial" valign="top" align="right" width="25%" background="" bgColor="ffffff">
Corrective/Proactive Actions to Mitigate the Risk</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial;padding-left:10px;" align="left" width="75%" background="" bgColor="ffffff" colspan="3">
<textarea name="corrective_actions" rows="2" required="false" style="width:540px;">
<%= corrective_actions %></textarea>
</td>
</tr>
<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="center" width="100%" background="" bgColor="ffffff" colSpan="4">.
</td>
</tr>
<!--
<tr><td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial" valign="top" align="right" width="25%" background="" bgColor="ffffff">
Unintended Consequences</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial;padding-left:10px;" align="left" width="75%" background="" bgColor="ffffff" colspan="3">
<textarea name="unintended_consequences" rows="2" required="false" style="width:540px;">
<%= unintended_consequences %></textarea>
</td>
</tr>
-->
<tr><td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial" align="right" width="25%" background="" bgColor="ffffff">
Responsible Person/Functional Area
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial;padding-left:10px;" align="left" width="25%" background="" bgColor="ffffff">
<input type="text" name="corrective_actions_responsible_person" size="30" style="width:236px;"  value="<%= corrective_actions_responsible_person %>" required="false" />
</td>

<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial" align="right" width="25%" background="" bgColor="ffffff">
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial" align="left" width="25%" background="" bgColor="ffffff">

</td>
</tr>
<tr><td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial" align="right" width="25%" background="" bgColor="ffffff">
Risk Value (Post-mitigation)
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial;padding-left:6px;" align="left" width="25%" background="" bgColor="ffffff">
<input onclick="toggleSection(this,'table2')" type="checkbox" value="RAM_Post" name="RAM_Post" /><input type="text" id="post_risk" name="risk_value_post_mitigation" size="30" readonly  value="<%= risk_value_post_mitigation %>" required="false" style="width:220px;" />
</td>

<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial" align="right" width="25%" background="" bgColor="ffffff">
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial" align="left" width="25%" background="" bgColor="ffffff">

</td>
</tr>

</table>


<table id="table2" cellSpacing="0" cellPadding="0" width="100%" border="0" style="display:none;">

<tr><td>
<iframe src="visual.asp?log_number=<%= log_number %>&f=post_risk&prefix=post_" width="100%" frameborder="0" height="670"></iframe>
</td>
</tr>

</table>

<table cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="white">

<tr height="30">
<td>
&nbsp;
</td>
</tr>

<tr >
<td align="center">
<input type="submit" value="Submit" style="background-color:white;width:150px;font-weight:bold;height:30px;">
</td>
</tr>

<tr height="50">
<td>
&nbsp;
</td>
</tr>

</table>

<!--#include file ="includes/footer.inc"-->
</form>
</body>
</html>


