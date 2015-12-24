<%
if((session("srt_admin") = "y") or (session("srt_admin") = "l") or (session("srt_admin") = "p")) then
  response.redirect "adminDisplay.asp"
  response.end
end if
%>
<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include file ="includes/lockMgr.inc"-->
<%
unlockLogs
%>
<%
overflow = request("overflow")
if(overflow = "y") then
  buttonText = "Browser-Friendly Version"
else
  buttonText = "Printer-Friendly Version"
end if
%>
<html><head>
<!--#include file ="includes/commonhead.inc"-->
<title></title>
<script type="text/javascript">
    var overflow = "<%= overflow %>";
    function printPage() {
	<% if(overflow = "y") then %>
	if(document.all) {
	    document.all.divButtons.style.visibility = 'hidden';
	    //window.print();
	    document.all.divButtons.style.visibility = 'visible';
	} else {
	    document.getElementById('divButtons').style.visibility = 'hidden';
	    //window.print();
	    document.getElementById('divButtons').style.visibility = 'visible';
	}
	<% else %>
	document.location = "adminDisplay.asp?overflow=y";
	<% end if %>
    }
    function printPage2() {
	<% if(overflow = "y") then %>
	//window.print(); orientation='landscape'
	<% else %>
	window.open ("adminDisplay.asp?overflow=y","printwindow");
	<% end if %>
    }
    <% if(overflow = "y") then %>
    printPage2();
    <% end if %>
    function printPage3() {
	window.print(); orientation='landscape';
    }
    function switchView() {
	if(overflow != "y") {
	    document.location = "adminDisplay.asp?overflow=y";
	} else {
	    document.location = "adminDisplay.asp";
	}
    }
</script>

<style>
body{
font-family:arial;
font-size:8pt;
}
input{
font-size:8pt;
}
th{
font-size:8pt;
border-width:1;
border-color:black;
border-style:solid;
}
td{
font-size:8pt;
}
td.left{
border-width:1;
border-color:black;
border-left-style:solid;
}
td.right{
border-width:1;
border-color:black;
border-right-style:solid;
}
td.bottom{
border-width:1;
border-color:black;
border-bottom-style:solid;
}
td.top{
border-width:1;
border-color:black;
border-top-style:solid;
}

p{
margin:0;
}

.text {
width:250pt;
}

@media print{
body{ background-color:#FFFFFF; background-image:none; color:#000000 }
#ad{ display:none;}
#leftbar{ display:none;}
#contentarea{ width:100%;}
.hideprint{ display:none;}

</style>
<script>
function getDaysBetween(d1,d2) {
  var currNode;
  xmlhttpSvc.async = false;
  xmlhttpSvc.resolveExternals = false;
  xmlhttpSvc.load("/ets/acvbusers/getDefaults.asp?eventID=<%= eventid %>");
  currNode = xmlhttpSvc.selectSingleNode("//p.<%= a %>");

  document.frm.percentage_<%= a %>.value = currNode.text;
}
function setRowColor(row, color) {
  cells = row.getElementsByTagName('td');
  for(a=0; a < 11; a++) {
   // alert(color);
    cells[a].setAttribute('bgcolor', color, 0);
  }
}
</script>
</head>
<body bottomMargin="3" bgColor="#ffffff" leftMargin="3" topMargin="3" rightMargin="3">
<center>
<!--#include file ="includes/srt_header.inc"-->

<div class="tableContainer">
<table style="BORDER-RIGHT: 1px; PADDING-RIGHT: 3px; BORDER-TOP: 1px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; BORDER-LEFT: 1px; PADDING-TOP: 3px; BORDER-BOTTOM: 1px; BACKGROUND-COLOR: #ffffff" border="0" cellSpacing="0" cellPadding="1" width="100%">
<tr>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial" background="">&nbsp;
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial" align="right" background="">&nbsp;
</td>
</tr>
<tr><td style="FONT-WEIGHT: normal; FONT-SIZE: 14pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="center" width="10%" background="" bgColor="#ffffff">
&nbsp;
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 14pt; COLOR: #000040; FONT-FAMILY: Arial" align="center" width="80%" background="" bgColor="#ffffff">Integrated Safety Round Table Action Log
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: #000040; FONT-FAMILY: Arial" align="right" width="10%" background="" bgColor="#ffffff">
<span class="hideprint">
<div id="divButtons" name="divButtons">
<input type="button" value="Print" onclick="printPage3()" style="width:175px;font:bold 11px verdana;color:black;background-color:#FFFFFF;" /><br><input type="button" value="<%= buttonText %>" onclick="switchView()" style="width:175px;font:bold 11px verdana;color:black;background-color:#FFFFFF;" /><br><input type="button" value="Refresh Locks" onclick="window.location.reload(true);" style="width:175px;font:bold 11px verdana;color:black;background-color:#FFFFFF;" />
</div></span>
</td>
</tr>
</table>

<%

sql = "select logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'iSRT_LogInput' and archived = 'n' order by logNumber desc, recid desc"
set rs = conn_asap.execute(sql)

%>

<table cellSpacing="0" cellPadding="1" width="100%" border="0">
<tbody>
<tr>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="5%" align="center" vAlign="top">Log Nbr.</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="25%" align="center" vAlign="top">Description</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="5%" align="center" vAlign="top">Division</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="8%" align="center" vAlign="top">Accountable Leader</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="8%" align="center" vAlign="top">Risk Value</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="5%" align="center" vAlign="top">Source</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="6%" align="center" vAlign="top">Date Opened</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="6%" align="center" vAlign="top">Date Due</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="6%" align="center" vAlign="top">Date Completed</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="4%" align="center" vAlign="top">Days</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="5%" align="center" vAlign="top">Status</td>
</tr>
</tbody>
</table>
<div <% if(overflow <> "y") then %>style="height:500px;overflow:auto;"<% end if %>>
<table cellSpacing="0" cellPadding="1" width="100%" border="0">
<tbody>
<tr>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="5%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="25%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="5%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="8%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="8%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="5%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="6%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="6%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="6%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="4%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="5%" align="center" vAlign="top"></td>
</tr>
<%
  set oXML					= CreateObject("Microsoft.XMLDOM")
  oXML.async				= false
  set oXML2					= CreateObject("Microsoft.XMLDOM")
  oXML2.async				= false

  tmpLogNumber = ""
  firstOne = "y"

  do while not rs.eof

  curr_risk = ""

  loginID					= rs("loginID")
  createDate				= rs("createDate")
  formDataXML				= rs("formDataXML")
  recid						= rs("recid")
  division					= rs("division")

  oXML.loadXML(formDataXML)

  safety_action_cnt			= selectNode(oXML,"safety_action_cnt","")
  log_number				= selectNode(oXML,"log_number","")
  item_description			= rev_xdata2(selectNode(oXML,"item_description",""))
  accountable_leader		= rev_xdata2(selectNode(oXML,"accountable_leader",""))
  source					= rev_xdata2(selectNode(oXML,"source",""))
  date_opened				= selectNode(oXML,"date_opened","")
  date_due					= selectNode(oXML,"date_due","")
  date_completed			= selectNode(oXML,"date_completed","")
  item_status				= selectNode(oXML,"item_status","")

  item_description			= replace(item_description,vbcrlf,"<br>")

  tmpCnt					= cint(safety_action_cnt)

  sql = "select logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'risk' and logNumber = "& sqlnum(log_number) &" and archived = 'n' order by logNumber desc, recid desc"
  set rs2 = conn_asap.execute(sql)
  if not rs2.eof then
    formDataXML2				= rs2("formDataXML")
    oXML2.loadXML(formDataXML2)

    risk_value_pre_mitigation		= selectNode(oXML2,"risk_value_pre_mitigation","")
    risk_value_post_mitigation		= selectNode(oXML2,"risk_value_post_mitigation","")

    if(risk_value_post_mitigation <> "") then
      curr_risk = risk_value_post_mitigation
    else
      curr_risk = risk_value_pre_mitigation
    end if

  end if

  divisionStr = ""
  sql = "select division, recid from SRT_LogNumberDivisions where log_number = "& sqlnum(log_number) &" and archived = 'n' order by division desc"
  set rs3 = conn_asap.execute(sql)
  do while not rs3.eof
    division				= rs3("division")
    divisionStr = divisionStr &" "& division

    rs3.movenext
  loop
  divisionStr = rtrim(divisionStr)

  if(tmpLogNumber <> log_number) then
    tmpLogNumber = log_number
%>
<% if(firstOne <> "y") then %>
<tr><td bgcolor="#ffffff" colspan="11" ><div style="height:5px;border:1px solid black;font-size:1px;background-color:#000040;">&nbsp;</div></td></tr>
<% else %>
<% firstOne = "n" %>
<% end if %>
<%
isLocked = isLogLocked(log_number)
if(isLocked = "n") then
  clickloc = "document.location='iSRT_LogInput.asp?log_number="& log_number &"'"
else
  clickloc = "alert('Log "& log_number &" locked\nuser "& isLocked &"')"
end if
%>
<tr onclick="<%= clickloc %>"  onmouseover="setRowColor(this, '#FFFFE7');this.style.cursor='hand';" onmouseout="setRowColor(this, 'white')"><td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;font-size:14px;"><%= log_number %>&nbsp;</span>
<!-- <br /><input  type="button" value="Update" style="font-size:10px;background-color:white;width:50px;margin-top:5px;margin-left:10px;" onclick="document.location='iSRT_LogInput.asp?recid=<%= recid %>'" /> -->
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1"  vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= item_description %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1"  vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= divisionStr %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= accountable_leader %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= curr_risk %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= source %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= date_opened %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= date_due %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= date_completed %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<%
if(date_completed = "") then
  d2 = date
else
  d2 = date_completed
end if
%>
<span style="font-weight:bold;"><% if(len(date_opened) > 0) then %><%= datediff("d",date_opened,d2) %><% end if %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1" align="center"  vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= item_status %>&nbsp;</span>
</td>
</tr>


<% if(tmpCnt > 0) then %>
<%
isLocked = isLogLocked(log_number)
if(isLocked = "n") then
  clickloc = "document.location='iSRT_LogInput.asp?log_number="& log_number &"'"
else
  clickloc = "alert('Log "& log_number &" locked\nuser "& isLocked &"')"
end if
%>
<tr onclick="<%= clickloc %>"  onmouseover="this.style.cursor='hand';" ><td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" rowSpan="1" colSpan="1"  align="center" vAlign="top" >
<span style="font-weight:bold;">Item Nbr.</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" colSpan="1" vAlign="top" rowSpan="1" align="center">
<span style="font-weight:bold;">Safety Action</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" colSpan="1" align="left"  vAlign="top" rowSpan="1">
<span style="font-weight:bold;">POC</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;">Date Opened</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;">Date Completed</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;">Days</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;">Status</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;">&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;">&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;">&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;">&nbsp;</span>
</td>
</tr>
<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 12pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" rowSpan="1" colSpan="7" width="10%" align="right" vAlign="top" >
</td>
</tr>
<% end if %>
<%
for a = 1 to tmpCnt

  safety_action_nbr				= selectNode(oXML,"safety_action_nbr_"& a,"")
  safety_action					= rev_xdata2(selectNode(oXML,"safety_action_"& a,""))
  safety_action_poc				= rev_xdata2(selectNode(oXML,"safety_action_poc_"& a,""))
  safety_action_open			= selectNode(oXML,"safety_action_open_"& a,"")
  safety_action_completed		= selectNode(oXML,"safety_action_completed_"& a,"")
  safety_action_status			= selectNode(oXML,"safety_action_status_"& a,"")

  safety_action			= replace(safety_action,vbcrlf,"<br>")

%>

<%
isLocked = isLogLocked(log_number)
if(isLocked = "n") then
  clickloc = "document.location='iSRT_LogInput.asp?log_number="& log_number &"'"
else
  clickloc = "alert('Log "& log_number &" locked\nuser "& isLocked &"')"
end if
%>
<tr onclick="<%= clickloc %>"  onmouseover="setRowColor(this, '#FFFFE7');this.style.cursor='hand';" onmouseout="setRowColor(this, 'white')"><td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" rowSpan="1" colSpan="1" align="center" vAlign="top" >
<span style="font-weight:normal;"><%= safety_action_nbr %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= safety_action %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1" align="left"  vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= safety_action_poc %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= safety_action_open %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= safety_action_completed %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<%
if(safety_action_completed = "") then
  d2 = date
else
  d2 = safety_action_completed
end if
%>
<span style="font-weight:normal;"><% if(len(safety_action_open) > 0) then %><%= datediff("d",safety_action_open,d2) %><% end if %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= safety_action_status %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;">&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;">&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;">&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;">&nbsp;</span>
</td>
</tr>
<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 12pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" rowSpan="1" colSpan="11" align="right" vAlign="top" ><br>
</td>
</tr>
<tr><td style="height:1px;" bgcolor="#dcdcdf" colspan="11"></td></tr>
<%
next

acnt = 0
sql = "select count(*) cnt from EHD_Attachments where log_number = "& sqlnum(log_number) &" and archived = 'n'"
set rscnt = conn_asap.execute(sql)
if not rscnt.eof then
  acnt = cint(rscnt("cnt"))
end if
%>
<tr><td style="height:25px;FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial;padding-left:5px;" bgcolor="#ffffff" colspan="1" align="left"><% if(acnt > 0) then
%><span style="font-weight:normal;width:150px"><a href="iEHD_Attachments.asp?log_number=<%= log_number %>" style="text-decoration:none;">Attachements(<b><%= acnt %></b>)</a></span></td><td><% end if %>
<%
sql = "select * from SRT_Links where primary_log_number = "& sqlnum(log_number) &" and archived = 'n'"
set lrs = conn_asap.execute(sql)
if not lrs.eof then
%>
<span style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial;width:120px;">Related to :&nbsp;</span>
<%
do while not lrs.eof
  tmp_secondarylognumber = string(4-len(lrs("secondary_log_number")),"0")&lrs("secondary_log_number")
%>
<span style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial;width:30px;"><%= tmp_secondarylognumber %></span>
<%
  lrs.movenext
loop
end if
%>
</td>
</tr>
<tr><td style="height:25px;" bgcolor="#ffffff" colspan="11"></td></tr>
<%

  end if
  rs.movenext
  loop
%>
</tbody>
</table>

</div>

<table cellSpacing="0" cellPadding="0" width="100%" border="1" bgcolor="#dcdcdf">
<tr height="0">
<td>
</td>
</tr>

</table>

</form>

<!--#include file ="includes/footer.inc"-->


</body>
</html>
<xml id="xmlhttpSvc"></xml>
