<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<% response.buffer = false  %>
<html><head>
<title>Bristow SMAL Hazard Report</title>
<style>
@media print{
.hideprint{ display:none;}
.pagebreak{page-break-before:always}
}
</style>
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
    <link href="css/style.css" rel="stylesheet" type="text/css" />
<body>
<div class="hideprint">
<!-- START: PDF Online Script -->
<script type="text/javascript">
	var authorId = "A4D77A87-9AE1-461B-B12F-B99992EA2045";
	var pageOrientation = "0";
	var topMargin = "0.2";
	var bottomMargin = "0.0";
	var leftMargin = "0.1";
	var rightMargin = "0.5";
</script>
<script type="text/javascript" src="http://web2.pdfonline.com/pdfonline/pdfonline.js">
</script>
<!-- END: PDF Online Script -->
</div>
<table border="0" cellpadding="0" cellspacing="0" width="100%;">
	<tr>
		<td align="center">

<table border="0" cellpadding="0" cellspacing="0" width="850" align="center">
	<tr>
		<td height="80" background2="http://www.bristowgroup.com/images/body_mid.gif" bgcolor="#EFEBE7" align="center">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td width="50%" style="padding-left:30px;" ><a href="http://www.bristowgroup.com"><img width="146" height="40" src="http://www.bristowgroup.com/images/bristow_lofi.gif" alt="Bristow" border="0" /></a></td>
					<td width="50%" align="right" style="padding-right:30px;"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
	</td></tr>
</table>
<%
base = request("base")
division = request("division")

if(base <> "") then
  baseArr1 = split(base,",")
  base = ""
  hazardtypes = ""
  for a = 0 to ubound(baseArr1)
    baseArr = split(baseArr1(a),"|")
    base = base & baseArr(1) &","
    division = division & baseArr(0) &","
    hazardtypes = hazardtypes & baseArr(2) &","
  next
  base = left(base,len(base)-1)
  division = left(division,len(division)-1)
  hazardtypes = left(hazardtypes,len(hazardtypes)-1)
else
  base = "'GLOBAL'"
end if

currdate = date()
currdateStr = day(currdate) &"-"& monthname(month(currdate),true) &"-"& year(currdate)
%>
<table border="0" cellpadding="0" cellspacing="0" width="100%;">
	<tr>
		<td align="center">
<h3>Bristow Safety Report<br>
Divisions&nbsp;::&nbsp;<%= replace(division,"'","") %><br>
Bases&nbsp;::&nbsp;<%= replace(replace(base,"'",""),"BASE","Generic Base") %><br>
Types&nbsp;::&nbsp;<%= replace(hazardtypes,"'","") %>
<% if(request("risk") <> "") then %><br><%= request("risk") %><% end if %>
</h3>
<div id="PINWHEEL"><img src="http://www.bristowsafety.com/images/pinwheel.gif"></div>
<h5><%= currdateStr %><br><font color="">** uncontrolled when printed **</font></h5>
	</td></tr>
</table>

<%
cell1width = "40%"
cell2width = "60%"
%>

<%
  total_hazards								= 0
  rco_acceptable							= 0
  rco_acceptable_with_mitigation			= 0
  rco_unacceptable							= 0
  hbs_open									= 0
  hbs_not_considered_credible				= 0
  hbs_closed_alarp							= 0
  hbs_unassessed							= 0
  hbs_not_applicable						= 0
  hbs_archived								= 0
  hbas_alarp								= 0
  hbas_not_alarp							= 0
  hbes_endorsed								= 0
  hbes_not_endorsed							= 0
  rco_unassessed							= 0

if(aircraft <> "") then
  aircraftStr = " (equipment in ("& aircraft &")) or "
end if

if(base <> "") then
  baseStr = "base in ("& base &")"
else
  baseStr = "base in ('X')"
end if
if(division <> "") then
  divisionStr = "division in ("& division &")"
else
  divisionStr = "division in ('X')"
end if
if(hazardtypes <> "") then
  hazardtypesStr = "and (hazard_type in ("& hazardtypes &"))"
end if

sql = "select lognumber, division from EHD_Data where active = 'y' and archived = 'n' and formname = 'iSRT_LogInput' and (("& baseStr &") and ("& divisionStr &") "& hazardtypesStr &") and divisionalLogNumber is not null order by lognumber asc"

'response.write(sql)
'response.end

set rrs = conn_asap.execute(sql)
do while not rrs.eof

log_number			= rrs("lognumber")
log_numberStr		= string(4-len(log_number),"0")&log_number

viewDivision			= rrs("division")
%>
<%
sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and logNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' and division = "& sqltext2(viewDivision) &" and divisionalLogNumber is not null order by logNumber desc, recid desc"
'response.write(sql)
set rs        = conn_asap.execute(sql)
set oXML2     = CreateObject("Microsoft.XMLDOM")
oXML2.async   = false
if not rs.eof then
  loginID       = rs("loginID")
  createDate    = rs("createDate")
  formDataXML2  = rs("formDataXML")
  recid         = rs("recid")

  oXML2.loadXML(formDataXML2)

  safety_action_cnt   = selectNode(oXML2,"safety_action_cnt","")
  item_number         = selectNode(oXML2,"item_number","")
  item_description    = rev_xdata2(selectNode(oXML2,"item_description",""))
  accountable_leader  = rev_xdata2(selectNode(oXML2,"accountable_leader",""))
  source              = rev_xdata2(selectNode(oXML2,"source",""))
  date_opened         = selectNode(oXML2,"date_opened","")
  date_due            = selectNode(oXML2,"date_due","")
  date_completed      = selectNode(oXML2,"date_completed","")
  item_status         = selectNode(oXML2,"item_status","")
  item_status2				= selectNode(oXML2,"item_status2","")

  if(item_status = "") then
    item_status = item_status2
  end if

  equipment					= selectNode(oXML2,"equipment","")
  item_title				= selectNode(oXML2,"item_title","")
  item_comments				= selectNode(oXML2,"item_comments","")
  base						= selectNode(oXML2,"base","")
  hazard_owner				= selectNode(oXML2,"hazard_owner","")
  hazard_manager			= selectNode(oXML2,"hazard_manager","")
  hazard_editor				= selectNode(oXML2,"hazard_editor","")
  next_review_date			= selectNode(oXML2,"next_review_date","")
  endorsed					= selectNode(oXML2,"endorsed","")
  endorsed_by				= selectNode(oXML2,"endorsed_by","")

  initial_assessment_date			= selectNode(oXML2,"initial_assessment_date","")
  initial_assessment_occasion		= selectNode(oXML2,"initial_assessment_occasion","")
  current_assessment_date			= selectNode(oXML2,"current_assessment_date","")
  current_assessment_occasion		= selectNode(oXML2,"current_assessment_occasion","")
  post_assessment_date				= selectNode(oXML2,"post_assessment_date","")
  post_assessment_occasion			= selectNode(oXML2,"post_assessment_occasion","")
  further_risk_reduction_needed		= selectNode(oXML2,"further_risk_reduction_needed","")
  hazard_ok_alarp					= selectNode(oXML2,"hazard_ok_alarp","")
  alarp_statement					= selectNode(oXML2,"alarp_statement","")


  hazard_base         = selectNode(oXML2,"hazard_base","")
  hazard_type         = selectNode(oXML2,"hazard_type","")
  hazard_number         = selectNode(oXML2,"hazard_number","")

  hazard_number = string(4-len(hazard_number),"0") & hazard_number
  hazard_id = viewDivision &"-"& hazard_number

end if

if(safety_action_cnt = "") then
  safety_action_cnt = 0
end if


set oXML					= CreateObject("Microsoft.XMLDOM")
oXML.async					= false

sql = "select * from EHD_Data where formname = 'risk' and logNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' and division = "& sqltext2(viewDivision) &" and divisionalLogNumber is not null order by logNumber desc, recid desc"
'response.write(sql)
'response.end
set rs        = conn_asap.execute(sql)
set oXML     = CreateObject("Microsoft.XMLDOM")
oXML.async   = false
if not rs.eof then
  loginID       = rs("loginID")
  createDate    = rs("createDate")
  formDataXML2  = rs("formDataXML")
  recid         = rs("recid")

  oXML.loadXML(formDataXML2)

  current_measures_responsible_person	= selectNode(oXML,"current_measures_responsible_person","")
  risk_value							= selectNode(oXML,"risk_value","")
  physical_injury						= selectNode(oXML,"physical_injury","")
  damage_to_the_environment				= selectNode(oXML,"damage_to_the_environment","")
  damage_to_assets						= selectNode(oXML,"damage_to_assets","")
  potential_increased_cost				= selectNode(oXML,"potential_increased_cost","")
  damage_to_corporate_reputation		= selectNode(oXML,"damage_to_corporate_reputation","")
  likelihood							= selectNode(oXML,"likelihood","")
  comments								= selectNode(oXML,"comments","")

  risk_value_pre_mitigation				= selectNode(oXML,"risk_value_pre_mitigation","")
  risk_value_post_mitigation			= selectNode(oXML,"risk_value_post_mitigation","")


end if

if(risk_value_post_mitigation = "") then
  risk_value = risk_value_pre_mitigation
else
  risk_value = risk_value_post_mitigation
end if

proceed = "y"
if((request("risk") <> "") and (request("risk") <> risk_value)) then
  proceed = "n"
end if

if(proceed = "y") then


total_hazards								= total_hazards +1

if(risk_value = "Acceptable") then
  rco_acceptable							= rco_acceptable +1
end if
if(risk_value = "Acceptable With Mitigation") then
  rco_acceptable_with_mitigation			= rco_acceptable_with_mitigation +1
end if
if(risk_value = "Unacceptable") then
  rco_unacceptable							= rco_unacceptable +1
end if
if(risk_value = "") then
  rco_unassessed							= rco_unassessed +1
end if
if(item_status = "Open") then
  hbs_open									= hbs_open +1
end if
if(item_status = "No Considered Credible") then
  hbs_not_considered_credible				= hbs_not_considered_credible +1
end if
if((item_status = "Closed ALARP") or (item_status = "Closed") or (item_status = "ALARP")) then
  hbs_closed_alarp							= hbs_closed_alarp +1
end if
if(item_status = "Unassessed") then
  hbs_unassessed							= hbs_unassessed +1
end if
if(item_status = "Not Applicable") then
  hbs_not_applicable						= hbs_not_applicable +1
end if
if(item_status = "Archived") then
  hbs_archived								= hbs_archived +1
end if
if(hazard_ok_alarp = "1") then
  hbas_alarp								= hbas_alarp +1
else
  hbas_not_alarp							= hbas_not_alarp +1
end if
if(endorsed = "1") then
  hbes_endorsed								= hbes_endorsed +1
else
  hbes_not_endorsed							= hbes_not_endorsed +1
end if

  end if

  rrs.movenext
loop
%>

<!--
Risk Category Overview:
Acceptable
Acceptable With Mitigation
Unacceptable

Hazards By Status:
Open
Not Considered Credible
Closed ALARP
Unassessed
Archived

Hazards By ALARP Status:
ALARP
Not ALARP


Hazards By Endorsed Status:
Endorsed
Not Endorsed
-->

<table cellspacing="0" cellpadding="0" width="100%" border="0">
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold;">Risk Category Overview</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"></div></td>
</tr>
<tr valign="top" style="padding-top:3px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;color:black;">Total Hazards :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:bold;"><%= total_hazards %></span></td>
</tr>
<tr valign="top" style="padding-top:3px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;color:#336600;">Acceptable :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= rco_acceptable %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;color:#ffcc00;">Acceptable With Mitigation :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= rco_acceptable_with_mitigation %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;color:#8a0808;">Unacceptable :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= rco_unacceptable %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;color:black;">Unassessed :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= rco_unassessed %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold;">Hazards By Status</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"></div></td>
</tr>
<tr valign="top" style="padding-top:3px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Open :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= hbs_open %></span></td>
</tr>
<!--
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Not Considered Credible :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= hbs_not_considered_credible %></span></td>
</tr>
-->
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Closed ALARP :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= hbs_closed_alarp %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Unassessed :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= hbs_unassessed %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Not Applicable :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= hbs_not_applicable %></span></td>
</tr>
<!--
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Archived :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= hbs_archived %></span></td>
</tr>
-->
<!--
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold;">Hazards By ALARP Status</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"></div></td>
</tr>
<tr valign="top" style="padding-top:3px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">ALARP :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= hbas_alarp %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Not ALARP :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= hbas_not_alarp %></span></td>
</tr>
-->
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold;">Hazards By Endorsed Status</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"></div></td>
</tr>
<tr valign="top" style="padding-top:3px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Endorsed :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= hbes_endorsed %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Not Endorsed :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= hbes_not_endorsed %></span></td>
</tr>
</table>

<%
sql = "select lognumber, division from EHD_Data where active = 'y' and archived = 'n' and formname = 'iSRT_LogInput' and (("& baseStr &") or ("& divisionStr &") "& hazardtypesStr &") and divisionalLogNumber is not null order by division asc, base asc, hazard_type asc, hazard_number asc"

set rrs = conn_asap.execute(sql)
do while not rrs.eof

log_number			= rrs("lognumber")
log_numberStr		= string(4-len(log_number),"0")&log_number

viewDivision			= rrs("division")
%>
<%
sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and logNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' and division = "& sqltext2(viewDivision) &" and divisionalLogNumber is not null order by logNumber desc, recid desc"
'response.write(sql)
set rs        = conn_asap.execute(sql)
set oXML2     = CreateObject("Microsoft.XMLDOM")
oXML2.async   = false
if not rs.eof then
  loginID       = rs("loginID")
  createDate    = rs("createDate")
  formDataXML2  = rs("formDataXML")
  recid         = rs("recid")

  oXML2.loadXML(formDataXML2)

  safety_action_cnt   = selectNode(oXML2,"safety_action_cnt","")
  item_number         = selectNode(oXML2,"item_number","")
  item_description    = rev_xdata2(selectNode(oXML2,"item_description",""))
  accountable_leader  = rev_xdata2(selectNode(oXML2,"accountable_leader",""))
  source              = rev_xdata2(selectNode(oXML2,"source",""))
  date_opened         = selectNode(oXML2,"date_opened","")
  date_due            = selectNode(oXML2,"date_due","")
  date_completed      = selectNode(oXML2,"date_completed","")
  item_status         = selectNode(oXML2,"item_status","")
  item_status2				= selectNode(oXML2,"item_status2","")

  if(item_status = "") then
    item_status = item_status2
  end if

  soi					= selectNode(oXML2,"soi","")
  hl					= selectNode(oXML2,"hl","")

  equipment					= selectNode(oXML2,"equipment","")
  item_title				= selectNode(oXML2,"item_title","")
  item_comments				= selectNode(oXML2,"item_comments","")
  base						= selectNode(oXML2,"base","")
  hazard_owner				= selectNode(oXML2,"hazard_owner","")
  hazard_manager			= selectNode(oXML2,"hazard_manager","")
  hazard_editor				= selectNode(oXML2,"hazard_editor","")
  next_review_date			= selectNode(oXML2,"next_review_date","")
  endorsed					= selectNode(oXML2,"endorsed","")
  endorsed_by				= selectNode(oXML2,"endorsed_by","")

  initial_assessment_date			= selectNode(oXML2,"initial_assessment_date","")
  initial_assessment_occasion		= selectNode(oXML2,"initial_assessment_occasion","")
  current_assessment_date			= selectNode(oXML2,"current_assessment_date","")
  current_assessment_occasion		= selectNode(oXML2,"current_assessment_occasion","")
  post_assessment_date				= selectNode(oXML2,"post_assessment_date","")
  post_assessment_occasion			= selectNode(oXML2,"post_assessment_occasion","")
  further_risk_reduction_needed		= selectNode(oXML2,"further_risk_reduction_needed","")
  hazard_ok_alarp					= selectNode(oXML2,"hazard_ok_alarp","")
  alarp_statement					= selectNode(oXML2,"alarp_statement","")


  hazard_base         = selectNode(oXML2,"hazard_base","")
  hazard_type         = selectNode(oXML2,"hazard_type","")
  hazard_number         = selectNode(oXML2,"hazard_number","")

  hazard_number = string(4-len(hazard_number),"0") & hazard_number
  hazard_id = viewDivision &"-"& hazard_base &"-"& hazard_type &"-"& hazard_number

end if

if(safety_action_cnt = "") then
  safety_action_cnt = 0
end if

set oXML					= CreateObject("Microsoft.XMLDOM")
oXML.async					= false

sql = "select * from EHD_Data where formname = 'risk' and logNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' and division = "& sqltext2(viewDivision) &" and divisionalLogNumber is not null order by logNumber desc, recid desc"
'response.write(sql)
'response.end
set rs        = conn_asap.execute(sql)
set oXML     = CreateObject("Microsoft.XMLDOM")
oXML.async   = false
if not rs.eof then
  loginID       = rs("loginID")
  createDate    = rs("createDate")
  formDataXML2  = rs("formDataXML")
  recid         = rs("recid")

  oXML.loadXML(formDataXML2)

  current_measures_responsible_person	= selectNode(oXML,"current_measures_responsible_person","")
  risk_value							= selectNode(oXML,"risk_value","")
  physical_injury						= selectNode(oXML,"physical_injury","")
  damage_to_the_environment				= selectNode(oXML,"damage_to_the_environment","")
  damage_to_assets						= selectNode(oXML,"damage_to_assets","")
  potential_increased_cost				= selectNode(oXML,"potential_increased_cost","")
  damage_to_corporate_reputation		= selectNode(oXML,"damage_to_corporate_reputation","")
  likelihood							= selectNode(oXML,"likelihood","")
  comments								= selectNode(oXML,"comments","")

  risk_value_pre_mitigation				= selectNode(oXML,"risk_value_pre_mitigation","")
  risk_value_post_mitigation			= selectNode(oXML,"risk_value_post_mitigation","")
end if


if(risk_value_post_mitigation = "") then
  risk_value = risk_value_pre_mitigation
else
  risk_value = risk_value_post_mitigation
end if

proceed = "y"
if((request("risk") <> "") and (request("risk") <> risk_value)) then
  proceed = "n"
end if

date_openedStr = ""
if(date_opened <> "") then
  date_openedStr = day(date_opened) &"-"& monthname(month(date_opened),true) &"-"& year(date_opened)
end if
date_dueStr = ""
if(date_due <> "") then
  date_dueStr = day(date_due) &"-"& monthname(month(date_due),true) &"-"& year(date_due)
end if
date_completedStr = ""
if(date_completed <> "") then
  date_completedStr = day(date_completed) &"-"& monthname(month(date_completed),true) &"-"& year(date_completed)
end if
next_review_dateStr = ""
if(next_review_date <> "") then
  next_review_dateStr = day(next_review_date) &"-"& monthname(month(next_review_date),true) &"-"& year(next_review_date)
end if

if(proceed = "y") then

%>
<center>

<table class="pagebreak" style="BORDER-RIGHT: 1px; PADDING-RIGHT: 3px; BORDER-TOP: 1px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; BORDER-LEFT: 1px; PADDING-TOP: 3px; BORDER-BOTTOM: 1px; BACKGROUND-COLOR: #ffffff" border="0" cellSpacing="0" cellPadding="1" width="100%">
<tr>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial" background="">&nbsp;
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial" align="right" background="">&nbsp;
</td>
</tr>
<!--
<tr><td style="FONT-WEIGHT: normal; FONT-SIZE: 14pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="center" width="10%" background="" bgColor="#ffffff">
&nbsp;
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 13pt; COLOR: navy; FONT-FAMILY: Arial" align="center" width="80%" background="" bgColor="#ffffff">Log <%= viewdivision %><%= log_numberStr %>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: navy; FONT-FAMILY: Arial" align="right" width="10%" background="" bgColor="#ffffff">
<span class="hideprint">
<div id="divButtons" name="divButtons">
<input type="button" name="Update" value="Print" onclick="window.print();" style="font:bold 11px verdana;color:black;background-color:#FFFFFF;" />
</div>
</span>
</td>
</tr>
-->


</table>
<form>

<%
cell1width = "40%"
cell2width = "60%"
%>

<%
sql = "select * from Tbl_Logins where employee_number = "& sqltext2(request("accountable_leader"))
set tmprs=conn_asap.execute(sql)
if not tmprs.eof then
  employee_nbr = tmprs("employee_number")
  first_name = tmprs("first_name")
  last_name = tmprs("last_name")
end if
%>

<table cellspacing="0" cellpadding="0" width="100%" border="0">
<tr valign="top" style="padding-top:3px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Hazard ID :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:bold;"><%= hazard_id %></span></td>
</tr>
<!--
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Divisional Number :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;">
<%
  is_iSRT = "n"
  srtlinksStr = ""
  if(viewdivision = "EH:DIV") then
    sql = "select srtLogNumber from EHD_Data where logNumber = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and active = 'y' and formname = 'iSRT_LogInput' and archived = 'n' order by srtLogNumber asc"
  else
    sql = "select srtLogNumber from EHD_Data where divisionalLogNumber = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and active = 'y' and srtLogNumber is not null and formname = 'iSRT_LogInput' and archived = 'n' order by srtLogNumber asc"
  end if
  set rs4 = conn_asap.execute(sql)
  if not rs4.eof then
    srtLogNumber				= rs4("srtLogNumber")

    is_iSRT = "y"

    if(viewdivision <> "EH:DIV") then
      srtlinksStr = srtlinksStr &"<a href='admin_LogInput.asp?log_number="& srtLogNumber &"&viewDivision=EH:DIV'>EH:DIV"& string(4-len(srtLogNumber),"0")&srtLogNumber &"</a><br>"
    end if

    sql = "select division, divisionalLogNumber from EHD_Data where srtLogNumber = "& sqlnum(srtLogNumber) &" and active = 'y' and formname = 'iSRT_LogInput' and archived = 'n' and division <> 'EH:DIV' order by division asc, divisionalLogNumber asc"
    set rs5 = conn_asap.execute(sql)
    do while not rs5.eof
      srtdivision				= rs5("division")
      srtdivisionalLogNumber	= rs5("divisionalLogNumber")
      if((srtdivisionalLogNumber <> log_number) and (srtdivision <> viewDivision)) then
        srtlinksStr = srtlinksStr &"<a href='divisional_LogInput.asp?log_number="& srtdivisionalLogNumber &"&viewDivision="& srtdivision &"'>"& srtdivision & string(4-len(srtdivisionalLogNumber),"0")&srtdivisionalLogNumber &"</a><br>"
      end if

      rs5.movenext
    loop
    srtlinksStr = rtrim(srtlinksStr)
  end if
%><%= srtlinksStr %>
  </span></td>
</tr>
-->
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Title :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= rev_xdata2(item_title) %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Description :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= rev_xdata2(item_description) %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Accountable Leader :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= accountable_leader %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Hazard Owner :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= hazard_owner %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">SOI :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= soi %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">HL :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= hl %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Date Opened :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= date_openedStr %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Date Due :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= date_dueStr %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Date Completed :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= date_completedStr %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Status :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= item_status %></span></td>
</tr>
<!--
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Related Log Numbers :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;">
<%
sql = "select * from SRT_Links where primary_log_number = "& sqlnum(log_number) &" and division = "& sqltext2(viewdivision) &" and archived = 'n'"
set lrs = conn_asap.execute(sql)
do while not lrs.eof
  tmp_secondarylognumber = string(4-len(lrs("secondary_log_number")),"0")&lrs("secondary_log_number")
  tmp_division = lrs("division")
  if(tmp_division = "EH:DIV") then
%>
<a href="admin_LogInput.asp?log_number=<%= lrs("secondary_log_number") %>&viewDivision=<%= viewDivision %>"><%= tmp_division %><%= tmp_secondarylognumber %></a><br>
<%
  else
%>
<a href="divisional_LogInput.asp?log_number=<%= lrs("secondary_log_number") %>&viewDivision=<%= viewDivision %>"><%= tmp_division %><%= tmp_secondarylognumber %></a><br>
<%
  end if

  lrs.movenext
loop
%>
  </span></td>
</tr>
-->
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Attachments :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;">
<%
if(viewdivision <> "EH:DIV") then
  tmpsql = "where a.divisionalLogNumber = "& sqlnum(log_number)
else
  tmpsql = "where a.srtlognumber = "& sqlnum(srtLogNumber)
end if
sql = ""& _
"select a.division, a.lognumber, b.file_name, b.recid, b.attach_size size "& _
"from EHD_Data a, EHD_Attachments b "& _
tmpsql & _
" and a.active = 'y' "& _
"and a.archived = 'n' "& _
"and a.formname = 'iSRT_LogInput' "& _
"and a.division = b.division "& _
"and a.lognumber = b.log_number "& _
"and b.archived = 'n' "& _
"order by a.division asc"
'response.write(sql)
set ars = conn_asap.execute(sql)
do while not ars.eof

  afile_name		= ars("file_name")
  arecid			= ars("recid")
  adivision			= ars("division")
  asize				= ars("size")
%>
<a href="retrieveFile3.asp?recid=<%= arecid %>" target="_blank"><%= adivision %>&nbsp;<%= afile_name %></a><br>
<%
  ars.movenext
loop
%>
  </span></td>
</tr>

<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold;">Action Items</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"></div></div></td>
</tr>
<%
for a = 1 to safety_action_cnt
  safety_action_nbr				= selectNode(oXML2,"safety_action_nbr_"& a,"")
  safety_action					= rev_xdata2(selectNode(oXML2,"safety_action_"& a,""))
  safety_action_poc				= rev_xdata2(selectNode(oXML2,"safety_action_poc_"& a,""))
  safety_action_poc_email		= rev_xdata2(selectNode(oXML2,"safety_action_poc_email_"& a,""))
  safety_action_open			= selectNode(oXML2,"safety_action_open_"& a,"")
  safety_action_due				= selectNode(oXML2,"safety_action_due_"& a,"")
  safety_action_completed		= selectNode(oXML2,"safety_action_completed_"& a,"")
  safety_action_status			= selectNode(oXML2,"safety_action_status_"& a,"")
  safety_action_poc2			= selectNode(oXML2,"safety_action_poc2_"& a,"")
  safety_action_type			= selectNode(oXML2,"safety_action_type_"& a,"")
  safety_action_other_name			= selectNode(oXML2,"safety_action_other_name_"& a,"")
  safety_action_other_email			= selectNode(oXML2,"safety_action_other_email_"& a,"")

  if(safety_action_poc <> "") then
    if(safety_action_poc = "Other") then
      safety_action_poc_name = safety_action_other_name
    else
      sql = "select first_name, last_name from Tbl_Logins where employee_number in ('"& safety_action_poc &"') order by division asc, last_name asc"
      set emprs = conn_asap.execute(sql)
      if not emprs.eof then
        safety_action_poc_name = left(emprs("first_name"),1) &"&nbsp;"& emprs("last_name")
      end if
    end if
  end if

if(safety_action_open <> "") then
  safety_action_openStr = day(safety_action_open) &"-"& monthname(month(safety_action_open),true) &"-"& year(safety_action_open)
end if
if(safety_action_due <> "") then
  safety_action_dueStr = day(safety_action_due) &"-"& monthname(month(safety_action_due),true) &"-"& year(safety_action_due)
end if
if(safety_action_completed <> "") then
  safety_action_completedStr = day(safety_action_completed) &"-"& monthname(month(safety_action_completed),true) &"-"& year(safety_action_completed)
end if

%>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Action Item Number :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= viewdivision %><%= log_numberStr %>.<%= a %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Action Type :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= safety_action_type %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Activity :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= rev_xdata2(safety_action) %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Action Owner :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= safety_action_poc %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Opened :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= safety_action_openStr %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Due :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= safety_action_dueStr %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Completed :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= safety_action_completedStr %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Status :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= safety_action_status %></span></td>
</tr>
<%
next
%>

<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold;">Risk</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"></div></div></td>
</tr>
<!--
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Contributing Factors :</span></td>
  <td width="<%= cell2width %>">
<% for a = 1 to cint(selectNode(oXML,"contributing_factors_cnt","0")) %>
<div style="font-weight:normal;"><%= selectNode(oXML,"contributing_factor_"& a,"") %></div>
<% next %>
  </td>
</tr>
-->
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Causes / Threats :</span></td>
  <td width="<%= cell2width %>">
<% for a = 1 to cint(selectNode(oXML,"factors_cnt","0")) %>
<div style="font-weight:normal;margin-bottom:6px;"><% if(selectNode(oXML,"factors_type_"& a,"") <> "") then %><span style="width:75px;"><%= selectNode(oXML,"factors_type_"& a,"") %> :: </span><% end if %><%= rev_xdata2(selectNode(oXML,"factors_"& a,"")) %></div>
<% next %>
  </td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Consequences :</span></td>
  <td width="<%= cell2width %>">
<% for a = 1 to cint(selectNode(oXML,"consequences_cnt","0")) %>
<div style="font-weight:normal;padding-bottom:6px;"><%= rev_xdata2(selectNode(oXML,"consequences_"& a,"")) %></div>
<% next %>
  </td>
</tr>
<!--
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Latent Conditions :</span></td>
  <td width="<%= cell2width %>">
<% for a = 1 to cint(selectNode(oXML,"latent_conditions_cnt","0")) %>
<div style="font-weight:normal;"><%= selectNode(oXML,"latent_condition_"& a,"") %></div>
<% next %>
  </td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Causal Factors :</span></td>
  <td width="<%= cell2width %>">
<% for a = 1 to cint(selectNode(oXML,"causal_factors_cnt","0")) %>
<div style="font-weight:normal;"><%= selectNode(oXML,"causal_factor_"& a,"") %></div>
<% next %>
  </td>
</tr>
-->
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold;">Risk Matrix (Pre-mitigation)</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Current Measures to reduce the risk :</span></td>
  <td width="<%= cell2width %>">
<% for a = 1 to cint(selectNode(oXML,"current_measures_cnt","0")) %>
<div style="font-weight:normal;padding-bottom:6px;"><%= rev_xdata2(selectNode(oXML,"current_measures_"& a,"")) %></div>
<% next %>
  </td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Responsible Person/Functional Area (current measures) :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= selectNode(oXML,"current_measures_responsible_person","") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold; COLOR: #000080;">Risk Value (Pre-mitigation) :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold; COLOR: #000080;"><%= selectNode(oXML,"risk_value_pre_mitigation","") %></div></div></td>
</tr>
<!--
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Physical Injury :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= selectNode(oXML,"pre_physical_injury","") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to the Environment :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= selectNode(oXML,"pre_damage_to_the_environment","") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to Assets :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= selectNode(oXML,"pre_damage_to_assets","") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Potential Increased Cost or Revenue Loss :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= selectNode(oXML,"pre_potential_increased_cost","") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to Corporate Reputation :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= selectNode(oXML,"pre_damage_to_corporate_reputation","") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Likelihood :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= selectNode(oXML,"pre_likelihood","") %></div></div></td>
</tr>
-->
<tr valign="top" style="padding-top:15px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold;">Risk Matrix (Post-mitigation)</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Corrective/Proactive Actions to Mitigate the Risk :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;">
<% for a = 1 to cint(selectNode(oXML,"corrective_actions_cnt","0")) %>
<div style="font-weight:normal;padding-bottom:6px;"><% if(selectNode(oXML,"corrective_action_item_"& a,"") <> "") then %><span style="width:75px;"><%= selectNode(oXML,"corrective_action_item_"& a,"") %> :: </span><% end if %><%= selectNode(oXML,"corrective_action_"& a,"") %></div>
<% next %>
  </div></td>
</tr>
<!--
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Unintended Consequences :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= rev_xdata2(selectNode(oXML,"unintended_consequences","")) %></div></div></td>
</tr>
-->
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Responsible Person/Functional Area (corrective actions) :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= selectNode(oXML,"corrective_actions_responsible_person","") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold; COLOR: #000080;">Risk Value (Post-mitigation) :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold; COLOR: #000080;"><%= selectNode(oXML,"risk_value_post_mitigation","") %></div></div></td>
</tr>
<!--
<tr valign="top" style="padding-top:15px;">
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Physical Injury :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= selectNode(oXML,"post_physical_injury","") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to the Environment :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= selectNode(oXML,"post_damage_to_the_environment","") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to Assets :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= selectNode(oXML,"post_damage_to_assets","") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Potential Increased Cost or Revenue Loss :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= selectNode(oXML,"post_potential_increased_cost","") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to Corporate Reputation :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= selectNode(oXML,"post_damage_to_corporate_reputation","") %></div></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Likelihood :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><%= selectNode(oXML,"post_likelihood","") %></div></div></td>
</tr>
-->
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"></td>
  <td width="<%= cell2width %>"><img src="images/1pgrey.gif" height="1" width="300"></td>
</tr>
</table>
<%

  end if
  rrs.movenext
loop
%>
<script>
document.getElementById("PINWHEEL").style.display = "none";
</script>
</body>
</html>
