<html><head><title>Analysis of SRT Action Log Item</title>

</head>
<body bgColor="#f0f0f0" topmargin="3pt" bottommargin="3pt" leftmargin="3pt" rightmargin="3pt">
<form>
<table cellSpacing="0" cellPadding="1" width="100%" border="0">
<tbody>
<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 12pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="center" width="100%" background="" bgColor="000080" colSpan="4"><br>Analysis of SRT Action Log Item<br></td>
</tr>

<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 12pt; COLOR: #000040; FONT-FAMILY: Arial" align="center" width="100%" background="" bgColor="dcdcdf" colSpan="4">CONFIRMATION</td>
</tr>
</table>

<%
cell1width = "40%"
cell2width = "60%"
%>

<table cellspacing="0" cellpadding="0" width="100%" border="0">
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Item Number :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:bold;"><%= request("item_number") %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Accountable Manager :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:bold;"><%= request("accountable_manager") %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Active Errors :</span></td>
  <td width="<%= cell2width %>">
<% for a = 1 to cint(request("active_errors_cnt")) %>
<div style="font-weight:bold;"><%= request("active_error_"& a) %></div>
<% next %>
  </td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Contributing Factors :</span></td>
  <td width="<%= cell2width %>">
<% for a = 1 to cint(request("contributing_factors_cnt")) %>
<div style="font-weight:bold;"><%= request("contributing_factor_"& a) %></div>
<% next %>
  </td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Latent Conditions :</span></td>
  <td width="<%= cell2width %>">
<% for a = 1 to cint(request("latent_conditions_cnt")) %>
<div style="font-weight:bold;"><%= request("latent_condition_"& a) %></div>
<% next %>
  </td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Current Measures to reduce the risk :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold;"><%= request("current_measures") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Responsible Person/Functional Area (current measures) :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold;"><%= request("current_measures_responsible_person") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Risk Value (Pre-mitigation) :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold;"><%= request("risk_value_pre_mitigation") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Corrective/Proactive Actions to Mitigate the Risk :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold;"><%= request("corrective_actions") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Responsible Person/Functional Area (corrective actions) :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold;"><%= request("corrective_actions_responsible_person") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Risk Value (Post-mitigation) :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold;"><%= request("risk_value_post_mitigation") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:15px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold;">Risk Matrix Values (Pre-mitigation)</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold;"></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Physical Injury :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold;"><%= request("pre_physical_injury") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to the Environment :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold;"><%= request("pre_damage_to_the_environment") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to Assets :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold;"><%= request("pre_damage_to_assets") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Potential Increased Cost or Revenue Loss :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold;"><%= request("pre_potential_increased_cost") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to Corporate Reputation :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold;"><%= request("pre_damage_to_corporate_reputation") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Likelihood :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold;"><%= request("pre_likelihood") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:15px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold;">Risk Matrix Values (Post-mitigation)</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold;"></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Physical Injury :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold;"><%= request("post_physical_injury") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to the Environment :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold;"><%= request("post_damage_to_the_environment") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to Assets :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold;"><%= request("post_damage_to_assets") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Potential Increased Cost or Revenue Loss :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold;"><%= request("post_potential_increased_cost") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to Corporate Reputation :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold;"><%= request("post_damage_to_corporate_reputation") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Likelihood :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold;"><%= request("post_likelihood") %></div></div></td>
</tr>
</table>
<p>