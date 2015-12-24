<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include file ="includes/lockMgr.inc"-->
<%
unlockLogs
if(isLogLocked(request("log_number")) <> "n") then
  response.redirect("iSRT_LogDisplay.asp")
  response.end
end if
lockLog(request("log_number"))

viewDivision = "ACS"
%>
<html><head>
<!--#include file ="includes/commonhead.inc"-->
<%
log_number = request("log_number")
if(log_number = "") then
  log_number = "00001"
else
  'sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and logNumber = "& sqlnum(log_number) &" and archived = 'n' order by logNumber desc, recid desc"
  sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and division = "& sqltext2(viewDivision) &" and divisionalLogNumber = "& sqlnum(log_number) &" and archived = 'n' order by divisionalLogNumber desc, recid desc"
  set rs=conn_asap.execute(sql)
end if

log_numberStr				= string(4-len(log_number),"0")&log_number

set oXML					= CreateObject("Microsoft.XMLDOM")
oXML.async					= false

if not rs.eof then
  loginID					= rs("loginID")
  createDate				= rs("createDate")
  formDataXML				= rs("formDataXML")
  recid						= rs("recid")
  'log_number				= rs("logNumber")
  log_number				= string(4-len(log_number),"0")&log_number


  oXML.loadXML(formDataXML)

  safety_action_cnt			= selectNode(oXML,"safety_action_cnt","")
  item_number				= selectNode(oXML,"item_number","")
  item_description			= rev_xdata2(selectNode(oXML,"item_description",""))
  accountable_leader		= rev_xdata2(selectNode(oXML,"accountable_leader",""))
  source					= rev_xdata2(selectNode(oXML,"source",""))
  date_opened				= selectNode(oXML,"date_opened","")
  date_due					= selectNode(oXML,"date_due","")
  date_completed			= selectNode(oXML,"date_completed","")
  item_status				= selectNode(oXML,"item_status","")

  tmpCnt					= cint(safety_action_cnt)
end if



'sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and logNumber = "& sqlnum(log_number) &" and archived = 'n' order by logNumber desc, recid desc"
sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and division = "& sqltext2(viewDivision) &" and divisionalLogNumber = "& sqlnum(log_number) &" and archived = 'n' order by logNumber desc, recid desc"

set oXML2					= CreateObject("Microsoft.XMLDOM")
oXML2.async					= false

if not rs.eof then
  loginID					= rs("loginID")
  createDate				= rs("createDate")
  formDataXML				= rs("formDataXML")
  recid						= rs("recid")
  division					= rs("division")
  'log_number				= rs("logNumber")
  log_number				= string(4-len(log_number),"0")&log_number
  srtLogNumber				= rs("srtLogNumber")
  if(len(srtLogNumber) > 0) then
    srtLogNumberStr				= "iSRT"&string(4-len(srtLogNumber),"0")&srtLogNumber
  end if


  oXML2.loadXML(formDataXML)

  safety_action_cnt			= selectNode(oXML2,"safety_action_cnt","")
  item_number				= selectNode(oXML2,"item_number","")
  item_description			= rev_xdata2(selectNode(oXML2,"item_description",""))
  accountable_leader		= rev_xdata2(selectNode(oXML2,"accountable_leader",""))
  source					= rev_xdata2(selectNode(oXML2,"source",""))
  date_opened				= selectNode(oXML2,"date_opened","")
  date_due					= selectNode(oXML2,"date_due","")
  date_completed			= selectNode(oXML2,"date_completed","")
  item_status				= selectNode(oXML2,"item_status","")

  tmpCnt					= cint(safety_action_cnt)
end if

%>
<script language="JavaScript">
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


<% if(session("srt_admin") = "y") then %>
  newTD1.innerHTML = "<input type='text' name='safety_action_nbr_"+currCnt+"' size='30'  style='width:73px;'  value='<%= log_number %>."+currCnt+"' required='false' readonly />";
<% else %>
  newTD1.innerHTML = "<input type='text' name='safety_action_nbr_"+currCnt+"' size='30'  style='width:73px;'  value='<%= log_number %>."+currCnt+"' required='false' readonly />";
<% end if %>
  newTD2.innerHTML = "<textarea name='safety_action_"+currCnt+"' style='width:288px;' rows='2'></textarea>";
  newTD3.innerHTML = "<input type='text' name='safety_action_poc_"+currCnt+"' size='30'  style='width:73px;'  value='' required='false' />";
  newTD4.innerHTML = "<input type='text' name='safety_action_poc_email_"+currCnt+"' size='30'  style='width:73px;'  value='' required='false' />";
  newTD5.innerHTML = "<input type='text' name='safety_action_open_"+currCnt+"' size='30'  style='width:73px;'  value='' required='false' onblur=\"calcDueDate('"+currCnt+"')\" />";
  newTD6.innerHTML = "<input type='text' name='safety_action_due_"+currCnt+"' size='30'  style='width:73px;'  value='' required='false' />";
  newTD7.innerHTML = "<input type='text' name='safety_action_completed_"+currCnt+"' size='30'  style='width:73px;'  value='' required='false' />";
  newTD8.innerHTML = "<select name='safety_action_status_"+currCnt+"' style='width:73px;' required='false'><option selected value='Open'>Open</option><option value='Closed'>Closed</option></select>";

}

function setFieldValue(f,v) {
  document.getElementById(f).value = v;
}

function deleteSafetyAction(a) {

  document.getElementById("safety_action_nbr_"+a).name = "x"+document.getElementById("safety_action_nbr_"+a).name;
  document.getElementById("safety_action_"+a).name = "x"+document.getElementById("safety_action_"+a).name;
  document.getElementById("safety_action_poc_"+a).name = "x"+document.getElementById("safety_action_poc_"+a).name;
  document.getElementById("safety_action_poc_email_"+a).name = "x"+document.getElementById("safety_action_poc_email_"+a).name;
  document.getElementById("safety_action_open_"+a).name = "x"+document.getElementById("safety_action_open_"+a).name;
  document.getElementById("safety_action_due_"+a).name = "x"+document.getElementById("safety_action_due_"+a).name;
  document.getElementById("safety_action_completed_"+a).name = "x"+document.getElementById("safety_action_completed_"+a).name;
  document.getElementById("safety_action_status_"+a).name = "x"+document.getElementById("safety_action_status_"+a).name;

  var startNum = a++;
  var endNum = parseInt(document.getElementById("safety_action_cnt").value)

  for (var x = startNum; x <= endNum; x++) {

    newNum = x -1;

    tmpnbr = document.getElementById("safety_action_nbr_"+x).value;
    tmpNbrArr = tmpnbr.split(".");
    tmpnbr = tmpNbrArr[0] +"."+ newNum;
    document.getElementById("safety_action_nbr_"+x).value = tmpnbr;

    document.getElementById("safety_action_nbr_"+x).name = "safety_action_nbr_"+newNum;
    document.getElementById("safety_action_"+x).name = "safety_action_"+newNum;
    document.getElementById("safety_action_poc_"+x).name = "safety_action_poc_"+newNum;
    document.getElementById("safety_action_poc_email_"+x).name = "safety_action_poc_email_"+newNum;
    document.getElementById("safety_action_open_"+x).name = "safety_action_open_"+newNum;
    document.getElementById("safety_action_due_"+x).name = "safety_action_due_"+newNum;
    document.getElementById("safety_action_completed_"+x).name = "safety_action_completed_"+newNum;
    document.getElementById("safety_action_status_"+x).name = "safety_action_status_"+newNum;

  }

  tmpcnt = parseInt(document.getElementById("safety_action_cnt").value);
  tmpcnt--;
  document.getElementById("safety_action_cnt").value = tmpcnt;

  document.getElementById("get_max_recid").value = "y";
  document.getElementById("resultPage").value = "iSRT_LogInput.asp";

  frm.submit();
}

function goToRisk() {
  frm.action = "risk.asp";
  frm.submit();
}

function goToEmail() {
  frm.action = "emailInfo.asp";
  frm.submit();
}

function toggleLink() {
  //alert("test");
  if(document.getElementById("linkDIV").style.display == "none") {
    document.getElementById("linkDIV").style.display = "block";
  } else {
    document.getElementById("linkDIV").style.display = "none";
  }
}

function saveLinks() {
  //frm.action = "saveLinks.asp";
  document.getElementById("resultPage").value = "iSRT_LogInput.asp";
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

  //alert(opendateVal);

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
<!--#include file ="includes/divisional_header.inc"-->

<form action="saveData3.asp" method="post" name="frm" id="frm">

<input type="hidden" id="formname" name="formname" value="iSRT_LogInput">
<input type="hidden" id="safety_action_cnt" name="safety_action_cnt" value="<%= safety_action_cnt %>">
<input type="hidden" id="resultPage" name="resultPage" value="iSRT_LogDisplay.asp">
<input type="hidden" id="get_max_recid" name="get_max_recid" value="">

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
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" colSpan="1" width="8%" align="center" vAlign="top">iSRT Links</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" colSpan="1" width="8%" align="center" vAlign="top">Accountable Leader</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" colSpan="1" width="8%" align="center" vAlign="top">Source</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" colSpan="1" width="8%" align="center" vAlign="top">Date Opened</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" colSpan="1" width="8%" align="center" vAlign="top">Date Due</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" colSpan="1" width="8%" align="center" vAlign="top">Date Completed</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" colSpan="1" width="8%" align="center" vAlign="top">Status</td>
</tr>
<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<%= viewDivision %> <input type="text" name="log_number" size="30"  style="width:73px;"  value="<%= log_number %>" required="false" readonly />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="25%" vAlign="top" rowSpan="1">
<textarea name="item_description" style="width:288px;" rows="6"><%= item_description %></textarea>
</td>
<%
  srtlinksStr = srtLogNumberStr
  sql = "select division, divisionalLogNumber from EHD_Data where srtLogNumber = "& sqlnum(srtLogNumber) &" and active = 'y' and divisionalLogNumber is not null and formname = 'iSRT_LogInput' order by division asc, divisionalLogNumber asc"
  set rs4 = conn_asap.execute(sql)
  do while not rs4.eof
    srtdivision				= rs4("division")
    srtdivisionalLogNumber	= rs4("divisionalLogNumber")
    if((srtdivisionalLogNumber <> log_number) and (srtdivision <> viewDivision)) then
      srtlinksStr = srtlinksStr &"<br>"& srtdivision & string(4-len(srtdivisionalLogNumber),"0")&srtdivisionalLogNumber
    end if

    rs4.movenext
  loop
  srtlinksStr = rtrim(srtlinksStr)
%>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
<%= srtlinksStr %>
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
  <option value="Re-opened" selected>Re-opened</option>
  <option value="Void" selected>Void</option>
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

<tr id="ROWHEADER" <% if(request("log_number") = "") then %>style="display:none;"<% end if %>>
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
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
</tr>


<%
for a = 1 to safety_action_cnt
  safety_action_nbr				= selectNode(oXML,"safety_action_nbr_"& a,"")
  safety_action					= rev_xdata2(selectNode(oXML,"safety_action_"& a,""))
  safety_action_poc				= rev_xdata2(selectNode(oXML,"safety_action_poc_"& a,""))
  safety_action_poc_email		= rev_xdata2(selectNode(oXML,"safety_action_poc_email_"& a,""))
  safety_action_open			= selectNode(oXML,"safety_action_open_"& a,"")
  safety_action_due				= selectNode(oXML,"safety_action_due_"& a,"")
  safety_action_completed		= selectNode(oXML,"safety_action_completed_"& a,"")
  safety_action_status			= selectNode(oXML,"safety_action_status_"& a,"")

%>
<tr>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
<%= viewDivision %> <input type="text" name="safety_action_nbr_<%= a %>" size="30"  style="width:73px;"  value="<%= log_numberStr %>.<%= a %>" required="false" />
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
<input type="text" name="safety_action_open_<%= a %>" size="30"  style="width:73px;"  value="<%= safety_action_open %>" required="false" onblur="calcDueDate('<%= a %>')" />
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
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
</tr>
<%
next
%>

<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="center" width="100%" background="" bgColor="ffffff" colSpan="8">

<table width="100%" cellpadding="0" cellspacing="0" border="0" bgColor="ffffff" >
  <tbody id="markerTABLE">
    <tr id="markerROW" style="height:1px;"><td style="height:1px;" colSpan="8"></td></tr>
  </tbody>
</table>

</td>
</tr>
<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="left" width="100%" background="" bgColor="ffffff" colSpan="8">.
<input  type="button" value="Add Update" style="font-size:10px;background-color:white;width:160px;margin-top:5px;margin-left:10px;" onclick="addRow('markerTABLE','markerROW')">
</td>
</tr>


<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="center" width="100%" background="" bgColor="ffffff" colSpan="8">.
</td>
</tr>






</tbody>
</table>

<%
sql = "select * from SRT_Links where primary_log_number = "& sqlnum(log_number) &" and archived = 'n'"
set lrs = conn_asap.execute(sql)
if not lrs.eof then
%>
<div align="left" style="padding-left:5px;">
<table cellSpacing="0" cellPadding="1" width="470" border="0" style="margin-top:20px;">
<tbody>
<tr valign="top">
<td width="170" align="left"><span style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial">Linked Log Numbers :&nbsp;</span></td>
<td width="300">
<div >
<table border="0" cellspacing="0" cellpadding="0" width="300">
<%
do while not lrs.eof
  tmp_secondarylognumber = string(4-len(lrs("secondary_log_number")),"0")&lrs("secondary_log_number")
  isLocked = isLogLocked(lrs("secondary_log_number"))
  if(isLocked = "n") then
    clickloc = "iSRT_LogInput.asp?log_number="& lrs("secondary_log_number")
  else
    clickloc = "javascript:alert('Log "& log_number &" locked\nuser "& isLocked &"')"
  end if
%>
  <tr valign="top">
  <td><span style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;<a href="<%= clickloc %>"><%= tmp_secondarylognumber %></a></span></td>
  </tr>
<%
  lrs.movenext
loop
%>
</table>
</div>
</td>
</tr>
</tbody>
</table>
</div>
<%
end if
%>

<div align="left" id="linkDIV" style="display:none;padding-left:5px;margin-top:10px;">
<table cellSpacing="0" cellPadding="1" width="80%" border="0" style="margin-top:0px;">
<tbody>
<tr valign="top">
<td align="left"><span style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial">Log Number Links </span></td>
</tr><tr><td >
<div style="border:1px solid black;height:110px;overflow:auto;">
<table border="0" cellspacing="0" cellpadding="0" width="700">
<%
set loXML					= CreateObject("Microsoft.XMLDOM")
loXML.async					= false
tmpLogNumber = ""

sql = "select logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'iSRT_LogInput' and archived = 'n' order by logNumber desc, recid desc"
set lrs=conn_asap.execute(sql)
do while not lrs.eof

  lformDataXML				= lrs("formDataXML")
  llog_number				= lrs("logNumber")

  loXML.loadXML(lformDataXML)

  litem_description			= rev_xdata2(selectNode(loXML,"item_description",""))

  if((tmpLogNumber <> llog_number) and (cint(llog_number) <> cint(log_number))) then
    tmpLogNumber = llog_number

    llog_number				= string(4-len(llog_number),"0")&llog_number
%>
  <tr valign="top" style="padding-bottom:10px;">
  <td width="100"><input type="checkbox" id="links_<%= lrs("logNumber") %>" name="links" value="<%= llog_number %>"><span style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;<%= llog_number %></span></td>
  <td width="600"><span style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial"><%= litem_description %></span></td></tr>
<%
  end if
  lrs.movenext
loop
%>
</table>
</div>
</td>
</tr>
<tr><td><input type="button" value="Save Links" style="background-color:white;width:160px;font-weight:bold;height:20px;margin-top:3px;" onclick="saveLinks()"></td></tr>
</tbody>
</table>
</div>

<table cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="white">

<tr height="30">
<td>
&nbsp;
</td>
</tr>

<tr >
<td align="center">
<input type="submit" value="Save" style="background-color:white;width:160px;font-weight:bold;height:20px;margin-right:3px;"><input type="button" value="Assess Risk" style="background-color:white;width:165px;font-weight:bold;height:20px;" onclick="goToRisk()"><br><input type="button" value="Add Attachments" style="background-color:white;width:165px;font-weight:bold;height:20px;margin-top:3px;margin-right:3px;" onclick="goToAttachments()"><input type="button" value="Link This Item" style="background-color:white;width:165px;font-weight:bold;height:20px;margin-top:3px;" onclick="toggleLink()"><br><input type="button" value="Email this Item" style="background-color:white;width:165px;font-weight:bold;height:20px;margin-right:3px;" onclick="goToEmail()"><input type="button" value="Return To Action Log" style="background-color:white;width:165px;font-weight:bold;height:20px;margin-top:3px;" onclick="document.location='iSRT_LogDisplay.asp'">
</td>
</td>
</tr>

<tr height="20">
<td>
&nbsp;
</td>
</tr>

</table>


</form>

<script>
<%
sql = "select * from SRT_Links where primary_log_number = "& sqlnum(log_number) &" and archived = 'n'"
set lrs = conn_asap.execute(sql)
do while not lrs.eof
%>
document.getElementById("links_<%= lrs("secondary_log_number") %>").checked = true;
<%
  lrs.movenext
loop
%>
</script>

<!--#include file ="includes/footer.inc"-->
</body>
</html>
<!--
<%= formDataXML %>
-->
<xml id="dateXML"></xml>


