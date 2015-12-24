<%
'###############################################
'#
'# admin_submitRiskanalysis.asp
'#
'# Shows data saved from risk form (data saved by wrapformdata2.inc)
'#
%>
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include file ="includes/wrapformdata2.inc"-->
<%
log_number			= request("log_number")
log_numberStr		= string(4-len(log_number),"0")&log_number

viewDivision			= request("viewDivision")
%>
<html><head>
<!--#include file ="includes/commonhead.inc"-->
<title>Analysis of iSRT Action Log Item</title>
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

</style>
</head>
<body bgColor="#ffffff" topmargin="3pt" bottommargin="3pt" leftmargin="3pt" rightmargin="3pt">
<center>
<!--#include file ="includes/banner.inc"-->
<!--#include file ="includes/profile_menu.inc"-->

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
<%
'###############################################
'# List of saved risk fields
'#
%>
<table cellspacing="0" cellpadding="0" width="100%" border="0">
<tr valign="top" style="padding-top:3px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Item Number :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= request("log_number") %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Accountable Leader :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= request("accountable_leader") %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Contributing Factors :</span></td>
  <td width="<%= cell2width %>">
<% for a = 1 to cint(request("contributing_factors_cnt")) %>
<div style="font-weight:normal;"><%= request("contributing_factor_"& a) %></div>
<% next %>
  </td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Active Errors :</span></td>
  <td width="<%= cell2width %>">
<% for a = 1 to cint(request("active_errors_cnt")) %>
<div style="font-weight:normal;"><%= request("active_error_"& a) %></div>
<% next %>
  </td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Latent Conditions :</span></td>
  <td width="<%= cell2width %>">
<% for a = 1 to cint(request("latent_conditions_cnt")) %>
<div style="font-weight:normal;"><%= request("latent_condition_"& a) %></div>
<% next %>
  </td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Causal Factors :</span></td>
  <td width="<%= cell2width %>">
<% for a = 1 to cint(request("causal_factors_cnt")) %>
<div style="font-weight:normal;"><%= request("causal_factor_"& a) %></div>
<% next %>
  </td>
</tr>

<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold;">Risk Matrix (Pre-mitigation)</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Current Measures to reduce the risk :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= request("current_measures") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Responsible Person/Functional Area (current measures) :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= request("current_measures_responsible_person") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold; COLOR: #000080;">Risk Value (Pre-mitigation) :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold; COLOR: #000080;"><%= request("risk_value_pre_mitigation") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Physical Injury :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= request("pre_physical_injury") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to the Environment :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= request("pre_damage_to_the_environment") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to Assets :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= request("pre_damage_to_assets") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Potential Increased Cost or Revenue Loss :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= request("pre_potential_increased_cost") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to Corporate Reputation :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= request("pre_damage_to_corporate_reputation") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Likelihood :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= request("pre_likelihood") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:15px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold;">Risk Matrix (Post-mitigation)</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Corrective/Proactive Actions to Mitigate the Risk :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= request("corrective_actions") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">CUnintended Consequences :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= request("unintended_consequences") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Responsible Person/Functional Area (corrective actions) :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= request("corrective_actions_responsible_person") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold; COLOR: #000080;">Risk Value (Post-mitigation) :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold; COLOR: #000080;"><%= request("risk_value_post_mitigation") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:15px;">
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Physical Injury :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= request("post_physical_injury") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to the Environment :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= request("post_damage_to_the_environment") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to Assets :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= request("post_damage_to_assets") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Potential Increased Cost or Revenue Loss :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= request("post_potential_increased_cost") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to Corporate Reputation :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= request("post_damage_to_corporate_reputation") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Likelihood :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= request("post_likelihood") %></div></div></td>
</tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:25px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pblack.gif" width="400" height="1"></td></tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="margin-top:15px;margin-left:10px;" bgColor="white" >
  <tr>
    <td width="100%" align="center">
      <input type="button" value="Return To Log Input" style="font-weight:bold;font-size:10px;width:160px;margin-top:5px;margin-left:0px;" onclick="document.location='admin_LogInput.asp?log_number=<%= log_number %>'"><input type="button" value="Return To Action Log" style="font-weight:bold;font-size:10px;width:160px;margin-top:1px;margin-left:0px;" onclick="document.location='admin_LogDisplay.asp'">
    </td>
  </tr>
  <tr>
    <td width="100%" align="center" height="50"></td>
  </tr>
</table>
<br><br><br>

<!--#include file ="includes/footer.inc"-->

</body>
</html>
