<!--#include file ="includes/security.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include virtual ="/global_includes/wrapFormData_SRTStage.inc"-->
<%
log_number			= request("log_number")
log_numberStr		= string(4-len(log_number),"0")&log_number

viewDivision			= request("viewDivision")
%>
<%
sql = "select * from EHD_Data where formname = 'risk' and srtStageNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' and division = "& sqltext2(viewDivision) &" order by srtStageNumber desc, recid desc"
set rs        = conn_asap.execute(sql)
set oXML2     = CreateObject("Microsoft.XMLDOM")
oXML2.async   = false
if not rs.eof then
  loginID       = rs("loginID")
  createDate    = rs("createDate")
  formDataXML2  = rs("formDataXML")
  recid         = rs("recid")

  oXML2.loadXML(formDataXML2)

  current_measures_responsible_person	= selectNode(oXML2,"current_measures_responsible_person","")
  risk_value							= selectNode(oXML2,"risk_value","")
  physical_injury						= selectNode(oXML2,"physical_injury","")
  damage_to_the_environment				= selectNode(oXML2,"damage_to_the_environment","")
  damage_to_assets						= selectNode(oXML2,"damage_to_assets","")
  potential_increased_cost				= selectNode(oXML2,"potential_increased_cost","")
  damage_to_corporate_reputation		= selectNode(oXML2,"damage_to_corporate_reputation","")
  likelihood							= selectNode(oXML2,"likelihood","")
  comments								= selectNode(oXML2,"comments","")

end if
%>
<html><head>
<title>Risk Assessment Matrix</title>
<link href="styles/display.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
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
<!--#include file="script/nav.js"-->
</head>
<body bgColor="#ffffff" topmargin="3pt" bottommargin="3pt" leftmargin="3pt" rightmargin="3pt">
      <div id="headerDiv">
<!--#include file="includes/sms_header.inc"-->
      </div>
<center>

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
<td style="FONT-WEIGHT: normal; FONT-SIZE: 14pt; COLOR: navy; FONT-FAMILY: Arial" align="center" width="80%" background="" bgColor="#ffffff">Risk Assessment Summary
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: navy; FONT-FAMILY: Arial" align="right" width="10%" background="" bgColor="#ffffff">
<span class="hideprint">
<div id="divButtons" name="divButtons">
<input type="button" name="Update" value="Print" onclick="window.print();" style="font:bold 11px verdana;color:black;background-color:#FFFFFF;" />
</div>
</span>
</td>
</tr>


</table>
<form>

<%
cell1width = "40%"
cell2width = "60%"
%>

<table cellspacing="0" cellpadding="0" width="100%" border="0">
<tr valign="top" style="padding-top:3px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Item Number :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= viewDivision %><%= request("log_number") %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Responsible Person/Functional Area :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= current_measures_responsible_person %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold; COLOR: #000080;">Risk Value :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold; COLOR: #000080;"><%= risk_value %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Physical Injury :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= physical_injury %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to the Environment :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= damage_to_the_environment %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to Assets :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= damage_to_assets %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Potential Increased Cost or Revenue Loss :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= potential_increased_cost %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to Corporate Reputation :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= damage_to_corporate_reputation %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Likelihood :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= likelihood %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Comments :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= comments %></div></div></td>
</tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:25px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pblack.gif" width="400" height="1"></td></tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="margin-top:15px;margin-left:10px;" bgColor="white" >
  <tr>
    <td width="100%" align="center">
      <input type="button" value="Go To Homepage" style="font-weight:bold;font-size:10px;background-color:white;width:160px;margin-top:5px;margin-left:0px;" onclick="document.location='splash.asp'"><input type="button" value="Go To Action Log" style="font-weight:bold;font-size:10px;background-color:white;width:160px;margin-top:1px;margin-left:0px;" onclick="document.location='divisional_LogDisplay.asp?viewDivision=<%= viewDivision %>'"><br><input type="button" value="Return To Stage List" style="font-weight:bold;font-size:10px;background-color:white;width:160px;margin-top:1px;margin-left:0px;" onclick="document.location='divisional_StageList.asp?viewDivision=<%= viewDivision %>'">
    </td>
  </tr>
  <tr>
    <td width="100%" align="center" height="50"></td>
  </tr>
</table>
<br><br><br>

</body>
</html>
<!--
<%= oXML2.xml %>
-->