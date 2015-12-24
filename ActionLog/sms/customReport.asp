<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<% response.buffer = false  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>SMAL</title>

     <link href="styles/display.css" rel="stylesheet" type="text/css" />
     <link href="css/style.css" rel="stylesheet" type="text/css" />
 <!--#include file="script/nav.js"-->
 <link rel="stylesheet" href="/louis-template-design-elements/css/layout.css" type="text/css" media="screen" />
 	<!--[if lt IE 9]>
 	<link rel="stylesheet" href="css/ie.css" type="text/css" media="screen" />
 	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
 	<![endif]-->

     <!--[if lt IE 8]>
     <style type="text/css">
 fieldset select {
     border: 1px solid #BBBBBB;
     color: #666666;
     height: 20px;
     margin: 0 12px;
     width: 96%;
 }
 #checkboxes{
 	padding-top:25px;
     padding-left:15px;
     margin-left:0;
 	list-style-type:none;}


     </style>
     <![endif]-->

 <script>
  <!--#include file="script/formatMask.js"-->
  </script>
<!--Add Link to Style Sheet-->
<link rel="stylesheet" href="css/smalStyles.css" type="text/css" media="screen" />
<!--End Link to Style Sheet-->
		<style media="all" type="text/css">@import "css/styles-all.css";</style>
<script>
function decode() {
        var obj;
        var encoded;

        var nodes = document.getElementsByTagName("span");
        for (var intLoop = 0; intLoop < nodes.length; intLoop++) {
	        if (null!=nodes[intLoop].getAttribute("decode")) {
	encoded = nodes[intLoop].innerHTML;
	nodes[intLoop].innerHTML = decodeURIComponent(encoded.replace(/\+/g," "));
	        }
	}

}
</script>
<body onload="decode()">
<div id="page-box">
  <img src="images/ke_header.png"  alt="SMAL" />
<br class="clear">
<div id="mainContent">
<%
base = request("base")
division = request("division")

'response.write("base:"& base)
'response.write("<br>")
'response.write("division:"& division)
'response.end


currdate = date()
currdateStr = year(currdate) &"-"& monthname(month(currdate),true) &"-"& day(currdate)
%>
<table border="0" cellpadding="0" cellspacing="0" width="100%;">
	<tr>
		<td align="center">
<h3>SMAL Safety Report</h3>

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
  divisionStr = "and division in ("& division &")"
else
  divisionStr = ""
end if
if(hazardtypes <> "") then
  hazardtypesStr = "and (hazard_type in ("& hazardtypes &"))"
end if


sql = "select lognumber, division from EHD_Data where active = 'y' and archived = 'n' and formname = 'iSRT_LogInput' "& divisionStr &" and divisionalLogNumber is not null order by lognumber asc"

'response.write(sql)
'response.end

set rrs = conn_asap.execute(sql)
do while not rrs.eof

log_number			= rrs("lognumber")
log_numberStr		= string(4-len(log_number),"0")&log_number

viewDivision			= rrs("division")
%>
<%
sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and logNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' and division = "& sqltext2(viewDivision) &" order by logNumber desc, recid desc"
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

  item_number         = selectNode(oXML2,"item_number","")
  item_description    = rev_xdata2(selectNode(oXML2,"item_description",""))
  accountable_leader  = rev_xdata2(selectNode(oXML2,"accountable_leader",""))
  source              = rev_xdata2(selectNode(oXML2,"source",""))
  date_opened         = selectNode(oXML2,"date_opened","")
  date_due            = selectNode(oXML2,"date_due","")
  date_completed      = selectNode(oXML2,"date_completed","")
  item_status         = selectNode(oXML2,"item_status","")
  item_status2				= selectNode(oXML2,"item_status2","")

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

tmpstart_date = request("start_date")
if(tmpstart_date = "") then
  tmpstart_date = date_opened
end if
tmpend_date = request("end_date")
if(tmpend_date = "") then
  tmpend_date = date_opened
end if


if(isdate(date_opened)) then
if((datediff("d",tmpstart_date,date_opened) >= 0) and (datediff("d",tmpend_date,date_opened) <= 0)) then

set oXML					= CreateObject("Microsoft.XMLDOM")
oXML.async					= false

sql = "select * from EHD_Data where formname = 'risk' and logNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' and division = "& sqltext2(viewDivision) &" order by logNumber desc, recid desc"
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

  safety_action_cnt   = selectNode(oXML,"safety_action_cnt","0")
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
if(URLDecode(risk_value) = "Acceptable With Mitigation") then
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
if(item_status = "Not Considered Credible") then
  hbs_not_considered_credible				= hbs_not_considered_credible +1
end if
if((item_status = "Closed ALARP") or (item_status = "Closed") or (item_status = "ALARP")) then
  hbs_closed_alarp							= hbs_closed_alarp +1
end if
if(item_status = "") then
  hbs_unassessed							= hbs_unassessed +1
end if
if(item_status = "Void") then
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
<div style="padding-left:100px;">
<table cellspacing="0" cellpadding="0" width="100%" border="0">
<% if(request("start_date") <> "") then %>
<tr valign="top" style="padding-top:3px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;color:black;">Start Date :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:bold;"><%= request("start_date") %></span></td>
</tr>
<% end if %>
<% if(request("end_date") <> "") then %>
<tr valign="top" style="padding-top:3px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;color:black;">End Date :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:bold;"><%= request("end_date") %></span></td>
</tr>
<% end if %>
<tr><td colspan="2" height="5"></td></tr>
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
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Closed :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= hbs_closed_alarp %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Void :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= hbs_not_applicable %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Unassessed :</span></td>
  <td width="<%= cell2width %>"><span style="font-weight:normal;"><%= hbs_unassessed %></span></td>
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
<div style="height:40px;"></div>
<%
sql = "select lognumber, division from EHD_Data where active = 'y' and archived = 'n' and formname = 'iSRT_LogInput' "& divisionStr &" and divisionalLogNumber is not null  order by division asc, lognumber asc"

set rrs = conn_asap.execute(sql)
do while not rrs.eof

log_number			= rrs("lognumber")
log_numberStr		= string(4-len(log_number),"0")&log_number

viewDivision			= rrs("division")
%>
<%
sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and logNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' and division = "& sqltext2(viewDivision) &" order by division asc, base asc, hazard_type asc, hazard_number asc"
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

  item_number         = selectNode(oXML2,"item_number","")
  item_description    = rev_xdata2(selectNode(oXML2,"item_description",""))
  accountable_leader  = rev_xdata2(selectNode(oXML2,"accountable_leader",""))
  source              = rev_xdata2(selectNode(oXML2,"source",""))
  date_opened         = selectNode(oXML2,"date_opened","")
  date_due            = selectNode(oXML2,"date_due","")
  date_completed      = selectNode(oXML2,"date_completed","")
  item_status         = selectNode(oXML2,"item_status","")
  item_status2				= selectNode(oXML2,"item_status2","")

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
  hazard_id = viewDivision &"-"& hazard_number

end if

if(safety_action_cnt = "") then
  safety_action_cnt = 0
end if

tmpstart_date = request("start_date")
if(tmpstart_date = "") then
  tmpstart_date = date_opened
end if
tmpend_date = request("end_date")
if(tmpend_date = "") then
  tmpend_date = date_opened
end if

if(isdate(date_opened)) then
if((datediff("d",tmpstart_date,date_opened) >= 0) and (datediff("d",tmpend_date,date_opened) <= 0)) then

if((date_due <> "") and (not isnull(date_due)) and (isdate(date_due))) then
  if(instr(date_due,"-") > 0) then
    date_dueArr = split(date_due,"-")
    date_due2 = date_dueArr(2)&"/"&date_dueArr(1)&"/"&date_dueArr(0)
  else
    date_due2 = date_due
  end if
  tmp_monthStr = datepart("m",date_due2)
  tmp_dayStr = datepart("d",date_due2)
  tmp_yearStr = datepart("yyyy",date_due2)
  due_dateStr2 = tmp_monthStr &"/"& tmp_dayStr &"/"& tmp_yearStr
else
  due_dateStr2 = date
end if

if((date_opened <> "") and (not isnull(date_opened)) and (isdate(date_opened))) then
  if(instr(date_opened,"-") > 0) then
    date_openedArr = split(date_opened,"-")
    date_opened2 = date_openedArr(2)&"/"&date_openedArr(1)&"/"&date_openedArr(0)
  else
    date_opened2 = date_opened
  end if
  tmp_monthStr = datepart("m",date_opened2)
  tmp_dayStr = datepart("d",date_opened2)
  tmp_yearStr = datepart("yyyy",date_opened2)
   date_openedStr2 = tmp_monthStr &"/"& tmp_dayStr &"/"& tmp_yearStr
else
  date_openedStr2 = ""
end if

if((date_completed <> "") and (not isnull(date_completed)) and (isdate(date_completed))) then
  if(instr(date_completed,"-") > 0) then
    date_completedArr = split(date_completed,"-")
    date_completed2 = date_completedArr(2)&"/"&date_completedArr(1)&"/"&date_completedArr(0)
  else
    date_completed2 = date_completed
  end if
  tmp_monthStr = datepart("m",date_completed2)
  tmp_dayStr = datepart("d",date_completed2)
  tmp_yearStr = datepart("yyyy",date_completed2)
  date_completedStr2 = tmp_monthStr &"/"& tmp_dayStr &"/"& tmp_yearStr
else
  date_completedStr2 = ""
end if

daysStr = ""
if((date_completed <> "") and (not isnull(date_completed)) and (isdate(date_completed))) then
  daysStr = datediff("d",date_openedStr2,date_completedStr2)
else
  daysStr = datediff("d",date,due_dateStr2)
end if


date_openedStr = ""
if((date_opened <> "") and (not isnull(date_opened)) and (isdate(date_opened))) then
  'date_openedStr = day(date_opened) &"-"& monthname(month(date_opened),true) &"-"& year(date_opened)
  date_openedStr = year(date_opened) &"-"& monthname(month(date_opened),true) &"-"& day(date_opened)
end if
date_dueStr = ""
if((date_due <> "") and (not isnull(date_due)) and (isdate(date_due))) then
  'date_dueStr = day(date_due) &"-"& monthname(month(date_due),true) &"-"& year(date_due)
  date_dueStr = year(date_due) &"-"& monthname(month(date_due),true) &"-"& day(date_due)
end if
date_completedStr = ""
if((date_completed <> "") and (not isnull(date_completed)) and (isdate(date_completed))) then
  'date_completedStr = day(date_completed) &"-"& monthname(month(date_completed),true) &"-"& year(date_completed)
  date_completedStr = year(date_completed) &"-"& monthname(month(date_completed),true) &"-"& day(date_completed)
end if
next_review_dateStr = ""
if((next_review_date <> "") and (not isnull(next_review_date)) and (isdate(next_review_date))) then
  'next_review_dateStr = day(next_review_date) &"-"& monthname(month(next_review_date),true) &"-"& year(next_review_date)
  next_review_dateStr = year(next_review_date) &"-"& monthname(month(next_review_date),true) &"-"& day(next_review_date)
end if


set oXML					= CreateObject("Microsoft.XMLDOM")
oXML.async					= false

sql = "select * from EHD_Data where formname = 'risk' and logNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' and division = "& sqltext2(viewDivision) &" order by logNumber desc, recid desc"
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

  safety_action_cnt   = selectNode(oXML,"safety_action_cnt","0")
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

sql = "select first_name, last_name from Tbl_Logins where LoginID = "& sqlnum(loginID)
set tmprs=conn_asap.execute(sql)
if not tmprs.eof then
  hazard_editor = tmprs("last_name") &", "& tmprs("first_name")
end if

%>

<!--#include file ="hazard.inc"-->

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:25px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pgrey.gif" width="400" height="1"></td></tr>
</table>
<%
  end if

  end if
  end if

  rrs.movenext
loop
%>
</div>
<div style="height:20px;"></div>
</div>
</div>
<script>
document.getElementById("PINWHEEL").style.display = "none";
</script>
</body>
</html>
