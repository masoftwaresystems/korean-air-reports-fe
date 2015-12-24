<%
if(session("srt_admin") = "y") then
  response.redirect "adminDisplay.asp"
  response.end
end if
%>
<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<html><head>
<!--#include file ="includes/commonhead.inc"-->
<title></title><script language="JavaScript">
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
                                </script><style>
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

</style></head>
<body bottomMargin="3" bgColor="#ffffff" leftMargin="3" topMargin="3" rightMargin="3">
<center>
<!--#include file ="includes/srt_header.inc"-->

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
<td style="FONT-WEIGHT: normal; FONT-SIZE: 14pt; COLOR: navy; FONT-FAMILY: Arial" align="center" width="80%" background="" bgColor="#ffffff">Integrated Safety Round Table Action Log
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: navy; FONT-FAMILY: Arial" align="right" width="10%" background="" bgColor="#ffffff">
<span class="hideprint">
<div id="divButtons" name="divButtons">
<input type="button" name="Update" value="Print" onclick="alert('Please adjust your printer settings to Landscape');printPage()" style="font:bold 11px verdana;color:black;background-color:#FFFFFF;" />
</div>
</span>
</td>
</tr>
</table>

<%
sql = "select division, recid, loginID, createDate, formdataXML from EHD_Data where division = "& sqltext2(session("division")) &" and formname = 'iSRT_LogInput' and archived = 'n' order by logNumber desc, recid desc"
set rs = conn_asap.execute(sql)

if rs.eof then

%>

<table cellSpacing="0" cellPadding="1" width="100%" border="0">
<tbody>
<tr>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="8%" align="center" vAlign="top">Log Nbr.</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="25%" align="center" vAlign="top">Description</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="8%" align="center" vAlign="top">Accountable Leader</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="8%" align="center" vAlign="top">Risk Value</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="8%" align="center" vAlign="top">Source</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="8%" align="center" vAlign="top">Date Opened</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="8%" align="center" vAlign="top">Date Due</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="8%" align="center" vAlign="top">Date Completed</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="4%" align="center" vAlign="top">Elapsed Days</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="8%" align="center" vAlign="top">Status</td>
</tr>

<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#f0f0f0" selected="false" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;">0001</span>
<br /><input  type="button" value="Update" style="font-size:10px;background-color:white;width:50px;margin-top:5px;margin-left:10px;" onclick="document.location='iSRT_LogInput.asp'" />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#f0f0f0" selected="false" colSpan="1" width="25%" vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= request("item_description") %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#f0f0f0" selected="false" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= request("accountable_leader") %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#f0f0f0" selected="false" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= request("acceptability") %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#f0f0f0" selected="false" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= request("ource") %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#f0f0f0" selected="false" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= request("date_opened") %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#f0f0f0" selected="false" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= request("date_due") %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#f0f0f0" selected="false" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= request("date_copleted") %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#f0f0f0" selected="false" colSpan="1" width="4%" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= request("elapsed_days") %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#f0f0f0" selected="false" colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= request("item_status") %></span>
</td>
</tr>
</tbody>
</table>

<table cellSpacing="0" cellPadding="1" width="100%" border="0">
<tbody>

<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" rowSpan="1" colSpan="1" width="10%" align="right" vAlign="top" >
<span style="font-weight:normal;"><%= request("safety_action_nbr") %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1" width="28%" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= request("safety_action") %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1" width="12%" align="center"  vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= request("safety_action_poc") %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1" width="12%" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= request("safety_action_open") %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1" width="12%" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= request("safety_action_completed") %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1" width="5%" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= request("safety_action_days") %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1" width="7.5%" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= request("safety_action_status") %></span>
</td>
</tr>
<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 12pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" rowSpan="1" colSpan="7" width="10%" align="right" vAlign="top" ><br>
</td>
</tr>
</tbody>
</table>

<%

else

  loginID					= rs("loginID")
  createDate				= rs("createDate")
  formDataXML				= rs("formDataXML")
  recid						= rs("recid")
  division					= rs("division")

  set oXML					= CreateObject("Microsoft.XMLDOM")
  oXML.async				= false
  oXML.loadXML(formDataXML)

  safety_action_cnt			= selectNode(oXML,"safety_action_cnt","")
  item_number				= selectNode(oXML,"item_number","")
  item_description			= selectNode(oXML,"item_description","")
  accountable_leader		= selectNode(oXML,"accountable_leader","")
  source					= selectNode(oXML,"source","")
  date_opened				= selectNode(oXML,"date_opened","")
  date_due					= selectNode(oXML,"date_due","")
  date_completed			= selectNode(oXML,"date_completed","")
  item_status				= selectNode(oXML,"item_status","")

  tmpCnt					= cint(safety_action_cnt)

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
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="4%" align="center" vAlign="top">Elapsed Days</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="5%" align="center" vAlign="top">Status</td>
</tr>

<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= item_number %>&nbsp;</span>
<br /><input  type="button" value="Update" style="font-size:10px;background-color:white;width:50px;margin-top:5px;margin-left:10px;" onclick="document.location='iSRT_LogInput.asp?recid=<%= recid %>'" />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1"  vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= item_description %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= division %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= accountable_leader %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= risk_value %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= source %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= date_opened %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= date_due %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= date_completed %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= elapsed_days %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1"  align="center"  vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= item_status %>&nbsp;</span>
</td>
</tr>


<% if(tmpCnt > 0) then %>
<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" rowSpan="1" colSpan="1" align="right" vAlign="top" >
<span style="font-weight:bold;">Item Nbr.</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" colSpan="1" vAlign="top" rowSpan="1">
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
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
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
<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 12pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" rowSpan="1" colSpan="11" align="right" vAlign="top" >
</td>
</tr>
<% end if %>
<%
for a = 1 to tmpCnt

  safety_action_nbr				= selectNode(oXML,"safety_action_nbr_"& a,"")
  safety_action					= selectNode(oXML,"safety_action_"& a,"")
  safety_action_poc				= selectNode(oXML,"safety_action_poc_"& a,"")
  safety_action_open			= selectNode(oXML,"safety_action_open_"& a,"")
  safety_action_completed		= selectNode(oXML,"safety_action_completed_"& a,"")
  safety_action_status			= selectNode(oXML,"safety_action_status_"& a,"")

%>

<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" rowSpan="1" colSpan="1" align="right" vAlign="top" >
<span style="font-weight:normal;"><%= safety_action_nbr %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1" vAlign="top" rowSpan="1">
<span style="font-weight:normal;">&nbsp;&nbsp;<%= safety_action %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1"  align="left"  vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= safety_action_poc %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= safety_action_open %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= safety_action_completed %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= safety_action_days %></span>
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
<%
next
%>
</tbody>
</table>

<%
end if
%>


<table cellSpacing="0" cellPadding="0" width="100%" border="1" bgcolor="#dcdcdf">
<tr height="0">
<td>
</td>
</tr>

</table>

<table cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="white">


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


