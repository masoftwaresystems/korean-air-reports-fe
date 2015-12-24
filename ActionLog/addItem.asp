'##############################
'# addItem.asp
'#
'# Retired
'#
<!--#include file="includes/security.inc" -->
<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<%
unlockLogs
%>
<html><head>
<!--#include file ="includes/commonhead.inc"-->
<%
division = request("division")
if(division = "") then
  'division = "ACS"
end if
session("division") = division

sql = "select max(logNumber) logNumber from EHD_Data where archived = 'n'"
set rs=conn_asap.execute(sql)
if rs.eof then
  log_number = 0
else
  log_number = rs("logNumber")
end if
if(isnull(log_number)) then
  log_number = 0
end if
log_number = cint(log_number) +1
log_number = string(4-len(log_number),"0")&log_number

%>
<title></title>
<script type="text/javascript">
    function printPage() {
	if(document.all) {
	    document.all.divButtons.style.visibility = 'hidden';
	    window.print();
	    document.all.divButtons.style.visibility = 'visible';
	} else {
	    document.getElementById('divButtons').style.visibility = 'hidden';
	    window.print();
	    document.getElementById('divButtons').style.visibility = 'visible';
	}
    }
function changeForm(v) {
  document.location = "addItem.asp?division="+v;
}

function addRow(t,r) {

  document.getElementById("ROWHEADER").style.display = "block";

  currCnt = parseInt(document.getElementById("safety_action_cnt").value);
  currCnt = currCnt +1;
  document.getElementById("safety_action_cnt").value = currCnt;

  var inputTable = document.getElementById(t);
  var inputTableRow = document.getElementById(r);

  var newTR1 = document.createElement('TR');
  var newTD1 = document.createElement('TD');
  var newTD2 = document.createElement('TD');
  var newTD3 = document.createElement('TD');
  var newTD4 = document.createElement('TD');
  var newTD5 = document.createElement('TD');
  var newTD6 = document.createElement('TD');
  var newTD7 = document.createElement('TD');
  var newTD8 = document.createElement('TD');
  var newTD9 = document.createElement('TD');
  inputTable.insertBefore(newTR1, inputTableRow);

  //newTR1.setAttribute("style","background-color:red;");

  newTR1.appendChild(newTD1);
  newTR1.appendChild(newTD2);
  newTR1.appendChild(newTD3);
  newTR1.appendChild(newTD4);
  newTR1.appendChild(newTD5);
  newTR1.appendChild(newTD6);
  newTR1.appendChild(newTD7);
  newTR1.appendChild(newTD8);
  newTR1.appendChild(newTD9);

  newTD1.setAttribute("style","FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial; background-color:green;");
  newTD1.setAttribute("bgColor","ffffff");
  newTD1.setAttribute("width","8%");
  newTD1.setAttribute("align","center");
  newTD1.setAttribute("vAlign","top");

  newTD2.setAttribute("style","FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial");
  newTD2.setAttribute("bgColor","ffffff");
  newTD2.setAttribute("width","25%");
  newTD2.setAttribute("align","left");
  newTD2.setAttribute("vAlign","top");

  newTD3.setAttribute("style","FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial");
  newTD3.setAttribute("bgColor","ffffff");
  newTD3.setAttribute("width","8%");
  newTD3.setAttribute("align","center");
  newTD3.setAttribute("vAlign","top");

  newTD4.setAttribute("style","FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial");
  newTD4.setAttribute("bgColor","ffffff");
  newTD4.setAttribute("width","8%");
  newTD4.setAttribute("align","center");
  newTD4.setAttribute("vAlign","top");

  newTD5.setAttribute("style","FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial");
  newTD5.setAttribute("bgColor","ffffff");
  newTD5.setAttribute("width","8%");
  newTD5.setAttribute("align","center");
  newTD5.setAttribute("vAlign","top");

  newTD6.setAttribute("style","FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial");
  newTD6.setAttribute("bgColor","ffffff");
  newTD6.setAttribute("width","8%");
  newTD6.setAttribute("align","center");
  newTD6.setAttribute("vAlign","top");

  newTD7.setAttribute("style","FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial");
  newTD7.setAttribute("bgColor","ffffff");
  newTD7.setAttribute("width","8%");
  newTD7.setAttribute("align","center");
  newTD7.setAttribute("vAlign","top");

  newTD8.setAttribute("style","FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial");
  newTD8.setAttribute("bgColor","ffffff");
  newTD8.setAttribute("width","8%");
  newTD8.setAttribute("align","center");
  newTD8.setAttribute("vAlign","top");

  newTD9.setAttribute("style","FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial");
  newTD9.setAttribute("bgColor","ffffff");
  newTD9.setAttribute("width","8%");
  newTD9.setAttribute("align","center");
  newTD9.setAttribute("vAlign","top");


  newTD1.innerHTML = "<input type='text' name='safety_action_nbr_"+currCnt+"' size='30'  style='width:73px;'  value='<%= log_number %>."+currCnt+"' required='false' readonly />";
  newTD2.innerHTML = "<textarea name='safety_action_"+currCnt+"' style='width:288px;' rows='2'></textarea>";
  newTD3.innerHTML = "<input type='text' name='safety_action_poc_"+currCnt+"' size='30'  style='width:73px;'  value='' required='false' />";
  newTD4.innerHTML = "<input type='text' name='safety_action_poc_email_"+currCnt+"' size='30'  style='width:73px;'  value='' required='false' />";
  newTD5.innerHTML = "<input type='text' name='safety_action_open_"+currCnt+"' size='30'  style='width:73px;'  value='' required='false' onblur=\"calcDueDate('"+currCnt+"')\" />";
  newTD6.innerHTML = "<input type='text' name='safety_action_due_"+currCnt+"' size='30'  style='width:73px;'  value='' required='false' />";
  newTD7.innerHTML = "<input type='text' name='safety_action_completed_"+currCnt+"' size='30'  style='width:73px;'  value='' required='false' />";
  newTD8.innerHTML = "<select name='safety_action_status_"+currCnt+"' style='width:73px;' required='false'><option selected value='Open'>Open</option><option value='Closed'>Closed</option></select>";
  newTD9.innerHTML = "&nbsp;";

}

function setFieldValue(f,v) {
  document.getElementById(f).value = v;
}

function goToRisk() {
  frm.action = "risk.asp";
  frm.submit();
}

function goToEmail() {
  frm.action = "emailInfo.asp";
  frm.submit();
}

function goToAttachments() {
  frm.action = "iEHD_Attachments.asp";
  frm.submit();
}

</script>
<script>
function calcDueDate(v) {

  var duedateField;
  var opendateVal;
  var duedateVal;
  var daysToAdd;
  if(v == "") {
    duedateField = document.getElementById("date_due");
    opendateVal = document.getElementById("date_opened").value;
    duedateVal = document.getElementById("date_due").value;
    daysToAdd = 90;
  } else {
    duedateField = document.getElementById("safety_action_due_"+v);
    opendateVal = document.getElementById("safety_action_open_"+v).value;
    duedateVal = document.getElementById("safety_action_due_"+v).value;
    daysToAdd = 45;
  }

  if((opendateVal != "")&&(duedateVal == "")) {

    var currNode;
    vals = "";
    dateXML.async = false;
    dateXML.resolveExternals = false;

    dateXML.load("/matrix/addDays.asp?date="+opendateVal+"&numdays="+daysToAdd);

    if(dateXML.selectSingleNode("//due.date") != null) {
      currNode = dateXML.selectSingleNode("//due.date");
      duedateField.value = currNode.text;
    }
  }

}
</script>

<style>
</style></head>
<body bottomMargin="3" bgColor="#ffffff" leftMargin="3" topMargin="3" rightMargin="3">
<center>
<!--#include file ="includes/srt_header.inc"-->

<form action="saveData.asp" method="post" name="frm" id="frm">

<input type="hidden" id="formname" name="formname" value="iSRT_LogInput">
<input type="hidden" id="safety_action_cnt" name="safety_action_cnt" value="0">
<input type="hidden" id="resultPage" name="resultPage" value="adminDisplay.asp">

<table style="BORDER-RIGHT: 1px; PADDING-RIGHT: 3px; BORDER-TOP: 1px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; BORDER-LEFT: 1px; PADDING-TOP: 3px; BORDER-BOTTOM: 1px; BACKGROUND-COLOR: #ffffff" cellSpacing="0" cellPadding="1" width="100%">
<tr>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial" background="">&nbsp;
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial" align="right" background="">&nbsp;
</td>
</tr>
</table>

<table cellSpacing="0" cellPadding="1" width="100%" border="0">
<tbody>
<tr>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" colSpan="1" width="8%" align="center" vAlign="top">Log Nbr.</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" colSpan="1" width="25%" align="center" vAlign="top">Description</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" colSpan="1" width="8%" align="center" vAlign="top">Division</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" colSpan="1" width="8%" align="center" vAlign="top">Accountable Leader</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" colSpan="1" width="8%" align="center" vAlign="top">Source</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" colSpan="1" width="8%" align="center" vAlign="top">Date Opened</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" colSpan="1" width="8%" align="center" vAlign="top">Date Due</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" colSpan="1" width="8%" align="center" vAlign="top">Date Completed</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" colSpan="1" width="8%" align="center" vAlign="top">Status</td>
</tr>
<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<input type="text" name="log_number" size="30"  style="width:73px;"  value="<%= log_number %>" required="false" readonly />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="25%" vAlign="top" rowSpan="1">
<textarea name="item_description" style="width:288px;" rows="6"><%= item_description %></textarea>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
            <select class="input6" name="division" multiple size="6" style="width:100px;" onchange="">
              <option value="ACS">ACS</option>
			  <option value="CGO">CGO</option>
			  <option value="FOP">FOP</option>
			  <option value="IFS">IFS</option>
			  <option value="OCC">OCC</option>
              <option value="TOP">TOP</option>
            </select>
            <script>
            frm.division.value = "<%= division %>";
            </script>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<input type="text" name="accountable_leader" size="30"   style="width:73px;" value="<%= accountable_leader %>" required="false" />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<input type="text" name="source" size="30"  style="width:73px;"  value="<%= source %>" required="false" />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<input type="text" name="date_opened" size="30"  style="width:73px;"  value="<%= date_opened %>" required="false" onblur="calcDueDate('')" />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<input type="text" name="date_due" size="30"  style="width:73px;"  value="<%= date_due %>" required="false" />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<input type="text" name="date_completed" size="30"  style="width:73px;"  value="<%= date_completed %>" required="false" />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
<select name="item_status" style="width:73px;" required="false">
  <option value="Open" selected>Open</option>
  <option value="Closed">Closed</option>
</select>
<script>
frm.item_status.value = "<%= item_status %>";
</script>
</td>
</tr>

<tr style="height: 5px">
<td colspan="8" bgcolor="#ffffff">
</td>
</tr>

<tr id="ROWHEADER" <% if(request("recid") = "") then %>style="display:none;"<% end if %>>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
Item Nbr.
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="25%" align="center"  vAlign="top" rowSpan="1">
Safety Action
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
POC
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
POC Email
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
Opened
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
Due
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
 Completed
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
Status
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">&nbsp;
</td>
</tr>
</tbody>
</table>


<table cellSpacing="0" cellPadding="1" width="100%" border="0">
<tbody>

<%
for a = 1 to safety_action_cnt
  safety_action_nbr				= selectNode(oXML,"safety_action_nbr_"& a,"")
  safety_action					= selectNode(oXML,"safety_action_"& a,"")
  safety_action_poc				= selectNode(oXML,"safety_action_poc_"& a,"")
  safety_action_poc_email		= selectNode(oXML,"safety_action_poc_email_"& a,"")
  safety_action_open			= selectNode(oXML,"safety_action_open_"& a,"")
  safety_action_due				= selectNode(oXML,"safety_action_due_"& a,"")
  safety_action_completed		= selectNode(oXML,"safety_action_completed_"& a,"")
  safety_action_status			= selectNode(oXML,"safety_action_status_"& a,"")
%>
<tr>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
<input type="text" name="safety_action_nbr_<%= a %>" size="30"  style="width:73px;"  value="<%= safety_action_nbr %>" required="false" />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="25%" vAlign="top" rowSpan="1">
<textarea name="safety_action_<%= a %>" style="width:288px;" rows="2"><%= safety_action %></textarea>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
<input type="text" name="safety_action_poc_<%= a %>" size="30"  style="width:73px;"  value="<%= safety_action_poc %>" required="false" />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
<input type="text" name="safety_action_poc_email_<%= a %>" size="30"  style="width:73px;"  value="<%= safety_action_poc_email %>" required="false" />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<input type="text" name="safety_action_open_<%= a %>" size="30"  style="width:73px;"  value="<%= safety_action_open %>" required="false"  onblur="calcDueDate('<%= a %>')" />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<input type="text" name="safety_action_due_<%= a %>" size="30"  style="width:73px;"  value="<%= safety_action_due %>" required="false" />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<input type="text" name="safety_action_completed_<%= a %>" size="30"  style="width:73px;"  value="<%= safety_action_completed %>" required="false" />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<select name="safety_action_status_<%= a %>" style="width:73px;" required="false">
  <option value=""></option>
  <option value="Open">Open</option>
  <option value="Closed">Closed</option>
</select>
<script>
frm.safety_action_status_<%= a %>.value = "<%= safety_action_status %>";
</script>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">&nbsp;
</td>
</tr>
<%
next
%>

<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="center" width="100%" background="" bgColor="ffffff" colSpan="8">

<table width="100%" cellpadding="0" cellspacing="0" border="0" bgColor="ffffff" >
  <tbody id="markerTABLE">
    <tr id="markerROW" style="height:1px;"><td style="height:1px;" colSpan="9"></td></tr>
  </tbody>
</table>

</td>
</tr>
<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="left" width="100%" background="" bgColor="ffffff" colSpan="8">.
<input  type="button" value="Add Safety Action" style="font-size:10px;background-color:white;width:160px;margin-top:5px;margin-left:10px;" onclick="addRow('markerTABLE','markerROW')">
</td>
</tr>


<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="center" width="100%" background="" bgColor="ffffff" colSpan="8">.
</td>
</tr>






</tbody>
</table>



<table cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="white">

<tr height="30">
<td>
&nbsp;
</td>
</tr>

<tr >
<td align="center">
<input type="submit" value="Save" style="background-color:white;width:165px;font-weight:bold;height:20px;margin-right:3px;"><input type="button" value="Assess Risk" style="background-color:white;width:165px;font-weight:bold;height:20px;" onclick="goToRisk()"><br><input type="button" value="Add Attachments" style="background-color:white;width:165px;font-weight:bold;height:20px;margin-top:3px;margin-right:3px;" onclick="goToAttachments()"><input type="button" value="Link This Item" style="background-color:white;width:165px;font-weight:bold;height:20px;margin-top:3px;" onclick="toggleLink()"><br><input type="button" value="Email This Item" style="background-color:white;width:165px;font-weight:bold;height:20px;margin-right:3px;" onclick="goToEmail()"><input type="button" value="Return To Action Log" style="background-color:white;width:165px;font-weight:bold;height:20px;margin-top:3px;" onclick="document.location='iSRT_LogDisplay.asp'">
</td>
</td>
</tr>


<tr height="50">
<td>
&nbsp;
</td>
</tr>

</table>
</form>

<!--#include file ="includes/footer.inc"-->
</body>
</html>

<xml id="dateXML"></xml>
