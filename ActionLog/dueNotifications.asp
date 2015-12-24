<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include virtual ="/global_includes/emailUtils.inc"-->
<% response.buffer = false  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>SMAL</title>

     <link href="styles/display.css" rel="stylesheet" type="text/css" />
     <link href="css/style.css" rel="stylesheet" type="text/css" />
 <!--#include file="script/nav.js"-->
 <link rel="stylesheet" href="/miat/louis-template-design-elements/css/layout.css" type="text/css" media="screen" />
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
<h3>Action Log Due Notifications</h3>

	</td></tr>
</table>

<%
cell1width = "40%"
cell2width = "60%"
%>

<%
  total_hazards								= 0
  total_hazards2							= 0
  total_hazards3							= 0
  total_hazards4							= 0
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


sql = "select lognumber, division from EHD_Data where active = 'y' and archived = 'n' and formname = 'iSRT_LogInput' and divisionalLogNumber is not null order by lognumber asc"

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

tmpstart_date = request("start_date")
if(tmpstart_date = "") then
  tmpstart_date = date_opened
end if
tmpend_date = request("end_date")
if(tmpend_date = "") then
  tmpend_date = date_opened
end if

if(isdate(date_due)) then
'if((datediff("d",tmpstart_date,date_opened) >= 0) and (datediff("d",tmpend_date,date_opened) <= 0)) then

if(safety_action_cnt = "") then
  safety_action_cnt = 0
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



if((date_due <> "") and (not isnull(date_due)) and (isdate(date_due))) then
  if(instr(date_due,"-") > 0) then
    date_dueArr = split(date_due,"-")
    date_due = date_dueArr(1)&"/"&date_dueArr(0)&"/"&date_dueArr(2)
  end if
  date_dueArr = split(date_due,"/")
  date_due2 = date_dueArr(1)&"/"&date_dueArr(0)&"/"&date_dueArr(2)
  tmp_monthStr = datepart("m",date_due2)
  tmp_dayStr = datepart("d",date_due2)
  tmp_yearStr = datepart("yyyy",date_due2)
  due_dateStr2 = tmp_monthStr &"/"& tmp_dayStr &"/"& tmp_yearStr
else
  due_dateStr2 = date
end if

if((date_completed <> "") and (not isnull(date_completed)) and (isdate(date_completed))) then
  if(instr(date_completed,"-") > 0) then
    date_dueArr = split(date_completed,"-")
    date_completed = date_dueArr(1)&"/"&date_dueArr(0)&"/"&date_dueArr(2)
  end if
  date_completedArr = split(date_completed,"/")
  date_completed2 = date_completedArr(1)&"/"&date_completedArr(0)&"/"&date_completedArr(2)
  tmp_monthStr = datepart("m",date_completed2)
  tmp_dayStr = datepart("d",date_completed2)
  tmp_yearStr = datepart("yyyy",date_completed2)
  date_completedStr2 = tmp_monthStr &"/"& tmp_dayStr &"/"& tmp_yearStr
else
  date_completedStr2 = ""
end if

if((date_opened <> "") and (not isnull(date_opened)) and (isdate(date_opened))) then
  if(instr(date_opened,"-") > 0) then
    date_dueArr = split(date_opened,"-")
    date_opened = date_dueArr(1)&"/"&date_dueArr(0)&"/"&date_dueArr(2)
  end if
  date_openedArr = split(date_opened,"/")
  date_opened2 = date_openedArr(1)&"/"&date_openedArr(0)&"/"&date_openedArr(2)
  tmp_monthStr = datepart("m",date_opened2)
  tmp_dayStr = datepart("d",date_opened2)
  tmp_yearStr = datepart("yyyy",date_opened2)
   date_openedStr2 = tmp_monthStr &"/"& tmp_dayStr &"/"& tmp_yearStr
else
  date_openedStr2 = ""
end if

if((next_review_date <> "") and (not isnull(next_review_date)) and (isdate(next_review_date))) then
  if(instr(next_review_date,"-") > 0) then
    date_dueArr = split(next_review_date,"-")
    next_review_date = date_dueArr(1)&"/"&date_dueArr(0)&"/"&date_dueArr(2)
  end if
  next_review_dateArr = split(next_review_date,"/")
  next_review_date2 = next_review_dateArr(1)&"/"&next_review_dateArr(0)&"/"&next_review_dateArr(2)
  tmp_monthStr = datepart("m",next_review_date2)
  tmp_dayStr = datepart("d",next_review_date2)
  tmp_yearStr = datepart("yyyy",next_review_date2)
  next_review_dateStr2 = tmp_monthStr &"/"& tmp_dayStr &"/"& tmp_yearStr
else
  next_review_dateStr2 = ""
end if

daysStr = ""
if((next_review_date <> "") and (not isnull(next_review_date)) and (isdate(next_review_date))) then
  daysStr = datediff("d",date(),next_review_dateStr2)
else
  if((date_completed <> "") and (not isnull(date_completed)) and (isdate(date_completed))) then
      daysStr = datediff("d",date_openedStr2,date_completedStr2)
  else
      daysStr = datediff("d",date(),due_dateStr2)
  end if
end if



if(clng(daysStr) = 1) then

%>
<!--
<%= viewDivision & log_numberStr %>
Dates:
date_due:<%= date_due %>:
date_opened:<%= date_opened %>:
date_completed:<%= date_completed %>:
-->
<%

total_hazards								= total_hazards +1

'daysStr2 = clng(daysStr) * -1
lateStr = lateStr &"<div style='padding-bottom:3px;width:300px;text-align:left;'><a href='http://www.masoftwaresystems.us/miat//divisional_LogInput2.aspx?position=&log_number="& log_number &"&viewDivision="& viewDivision &"' target='_blank'>&middot;&nbsp;"& hazard_id &" : "& daysStr &" days left</a></div>"


sql = "select email_address from Tbl_Logins where loginID = "& sqlnum(hazard_owner)
set tmprs=conn_asap.execute(sql)
if not tmprs.eof then
  email_toStr = tmprs("email_address")
else
  email_toStr = "yunmnam@koreanair.com"
end if

'email_to = email_toStr
'email_to = "mike.aaron@gmail.com"
email_to = "yunmnam@koreanair.com"
email_bcc = "mike.aaron@gmail.com"
email_subject = "Late Hazard Warning :: "& hazard_id
email_body = "Hazard "& hazard_id &" assigned to you is due tomorrow.<br><br><a href='http://www.masoftwaresystems.us/miat//divisional_LogInput2.aspx?position=&log_number="& log_number &"&viewDivision="& viewDivision &"' target='_blank'>"& hazard_id &"</a>" &" [Email would have gone to "& email_toStr &"]"
email_from = ""
sendEmail email_to, email_cc, email_bcc, email_from, email_subject, email_body

end if



if(clng(daysStr) = -1) then

%>
<!--
<%= viewDivision & log_numberStr %>
Dates:
date_due:<%= date_due %>:
date_opened:<%= date_opened %>:
date_completed:<%= date_completed %>:
-->
<%

total_hazards2								= total_hazards2 +1

daysStr2 = clng(daysStr) * -1
lateStr2 = lateStr2 &"<div style='padding-bottom:3px;width:300px;text-align:left;'><a href='http://www.masoftwaresystems.us/miat//divisional_LogInput2.aspx?position=&log_number="& log_number &"&viewDivision="& viewDivision &"' target='_blank'>&middot;&nbsp;"& hazard_id &" : "& daysStr2 &" days late</a></div>"

sql = "select email_address from Tbl_Logins where loginID = "& sqlnum(hazard_owner)
set tmprs=conn_asap.execute(sql)
if not tmprs.eof then
  email_toStr = tmprs("email_address")
else
  email_toStr = "yunmnam@koreanair.com"
end if

'email_to = email_toStr
'email_to = "mike.aaron@gmail.com"
email_to = "yunmnam@koreanair.com"
email_bcc = "mike.aaron@gmail.com"
email_subject = "Late Hazard :: "& hazard_id
email_body = "Hazard "& hazard_id &" assigned to you is overdue.<br><br><a href='http://www.masoftwaresystems.us/miat//divisional_LogInput2.aspx?position=&log_number="& log_number &"&viewDivision="& viewDivision &"' target='_blank'>"& hazard_id &"</a>" &" [Email would have gone to "& email_toStr &"]"
email_from = ""
sendEmail email_to, email_cc, email_bcc, email_from, email_subject, email_body

end if


'end if
end if


for a = 1 to cint(safety_action_cnt)
  safety_action_due = trim(selectNode(oXML,"safety_action_due_"& a,""))
  safety_action_open = trim(selectNode(oXML,"safety_action_open_"& a,""))
  safety_action_completed = trim(selectNode(oXML,"safety_action_completed_"& a,""))
  safety_action_poc	= trim(selectNode(oXML,"safety_action_poc_"& a,""))

  if(isdate(safety_action_due)) then

  date_due = safety_action_due
  date_completed = safety_action_completed
  date_opened = safety_action_open

if((date_due <> "") and (not isnull(date_due)) and (isdate(date_due))) then
  if(instr(date_due,"-") > 0) then
    date_dueArr = split(date_due,"-")
    date_due = date_dueArr(1)&"/"&date_dueArr(0)&"/"&date_dueArr(2)
  end if
  date_dueArr = split(date_due,"/")
  date_due2 = date_dueArr(1)&"/"&date_dueArr(0)&"/"&date_dueArr(2)
  tmp_monthStr = datepart("m",date_due2)
  tmp_dayStr = datepart("d",date_due2)
  tmp_yearStr = datepart("yyyy",date_due2)
  due_dateStr2 = tmp_monthStr &"/"& tmp_dayStr &"/"& tmp_yearStr
else
  due_dateStr2 = date
end if

if((date_completed <> "") and (not isnull(date_completed)) and (isdate(date_completed))) then
  if(instr(date_completed,"-") > 0) then
    date_dueArr = split(date_completed,"-")
    date_completed = date_dueArr(1)&"/"&date_dueArr(0)&"/"&date_dueArr(2)
  end if
  date_completedArr = split(date_completed,"/")
  date_completed2 = date_completedArr(1)&"/"&date_completedArr(0)&"/"&date_completedArr(2)
  tmp_monthStr = datepart("m",date_completed2)
  tmp_dayStr = datepart("d",date_completed2)
  tmp_yearStr = datepart("yyyy",date_completed2)
  date_completedStr2 = tmp_monthStr &"/"& tmp_dayStr &"/"& tmp_yearStr
else
  date_completedStr2 = ""
end if

if((date_opened <> "") and (not isnull(date_opened)) and (isdate(date_opened))) then
  if(instr(date_opened,"-") > 0) then
    date_dueArr = split(date_opened,"-")
    date_opened = date_dueArr(1)&"/"&date_dueArr(0)&"/"&date_dueArr(2)
  end if
  date_openedArr = split(date_opened,"/")
  date_opened2 = date_openedArr(1)&"/"&date_openedArr(0)&"/"&date_openedArr(2)
  tmp_monthStr = datepart("m",date_opened2)
  tmp_dayStr = datepart("d",date_opened2)
  tmp_yearStr = datepart("yyyy",date_opened2)
   date_openedStr2 = tmp_monthStr &"/"& tmp_dayStr &"/"& tmp_yearStr
else
  date_openedStr2 = ""
end if

daysStr = ""

  if((date_completed <> "") and (not isnull(date_completed)) and (isdate(date_completed))) then
      daysStr = datediff("d",date_openedStr2,date_completedStr2)
  else
      daysStr = datediff("d",date(),due_dateStr2)
  end if


if(clng(daysStr) = 1) then

%>
<!--
<%= viewDivision & log_numberStr %>
Dates:
date_due:<%= date_due %>:
date_opened:<%= date_opened %>:
date_completed:<%= date_completed %>:
-->
<%

total_hazards3								= total_hazards3 +1

'daysStr2 = clng(daysStr) * -1
lateStr3 = lateStr3 &"<div style='padding-bottom:3px;width:300px;text-align:left;'><a href='http://www.masoftwaresystems.us/miat//divisional_risk2.aspx?position=&log_number="& log_number &"&viewDivision="& viewDivision &"' target='_blank'>&middot;&nbsp;"& hazard_id &"."& a &" : "& daysStr &" days left</a></div>"


sql = "select email_address from Tbl_Logins where loginID = "& sqlnum(safety_action_poc)
set tmprs=conn_asap.execute(sql)
if not tmprs.eof then
  email_toStr = tmprs("email_address")
else
  email_toStr = "yunmnam@koreanair.com"
end if

'email_to = email_toStr
'email_to = "mike.aaron@gmail.com"
email_to = "yunmnam@koreanair.com"
'email_cc = email_ccStr
email_bcc = "mike.aaron@gmail.com"
email_subject = "Late Hazard Action Item Warning :: "& hazard_id &"."& a
email_body = "Hazard Action Item "& hazard_id &"."& a &" assigned to you is due tomorrow.<br><br><a href='http://www.masoftwaresystems.us/miat//divisional_risk2.aspx?position=&log_number="& log_number &"&viewDivision="& viewDivision &"' target='_blank'>"& hazard_id &"</a>" &" [Email would have gone to "& email_toStr &"]"
email_from = ""
sendEmail email_to, email_cc, email_bcc, email_from, email_subject, email_body

end if


if(clng(daysStr) = -1) then

%>
<!--
<%= viewDivision & log_numberStr %>
Dates:
date_due:<%= date_due %>:
date_opened:<%= date_opened %>:
date_completed:<%= date_completed %>:
-->
<%

total_hazards4								= total_hazards4 +1

daysStr2 = clng(daysStr) * -1
lateStr4 = lateStr4 &"<div style='padding-bottom:3px;width:300px;text-align:left;'><a href='http://www.masoftwaresystems.us/miat//divisional_risk2.aspx?position=&log_number="& log_number &"&viewDivision="& viewDivision &"' target='_blank'>&middot;&nbsp;"& hazard_id &"."& a &" : "& daysStr2 &" days late</a></div>"


sql = "select email_address from Tbl_Logins where loginID = "& sqlnum(safety_action_poc)
set tmprs=conn_asap.execute(sql)
if not tmprs.eof then
  email_toStr = tmprs("email_address")
else
  email_toStr = "yunmnam@koreanair.com"
end if

sql = "select email_address from Tbl_Logins where loginID = "& sqlnum(hazard_owner)
set tmprs=conn_asap.execute(sql)
if not tmprs.eof then
  email_ccStr = tmprs("email_address")
else
  email_ccStr = "yunmnam@koreanair.com"
end if

'email_to = email_toStr
'email_to = "mike.aaron@gmail.com"
email_to = "yunmnam@koreanair.com"
'email_cc = email_ccStr
email_bcc = "mike.aaron@gmail.com"
email_subject = "Late Hazard Action Item :: "& hazard_id &"."& a
email_body = "Hazard Action Item "& hazard_id &"."& a &" assigned to you is late.<br><br><a href='http://www.masoftwaresystems.us/miat//divisional_risk2.aspx?position=&log_number="& log_number &"&viewDivision="& viewDivision &"' target='_blank'>"& hazard_id &"</a>" &" [Email would have gone to "& email_toStr &", "& email_ccStr &"]"
email_from = ""
sendEmail email_to, email_cc, email_bcc, email_from, email_subject, email_body

end if


  end if

next


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
<a name="TOP"></a>
<table cellspacing="0" cellpadding="0" width="100%" border="0">
<tr valign="top" style="padding-top:3px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"></td>
  <td width="<%= cell2width %>"><span style="font-weight:bold;"></span></td>
</tr>
<% if(request("start_date") <> "") then %>
<tr valign="top" style="padding-top:3px;">
  <td colspan="2" align="center" style="padding-right:5px;"><div style='padding-bottom:0px;width:300px;text-align:left;'><span style="font-weight:normal;color:black;">Start Date :</span><span style="font-weight:bold;"><%= request("start_date") %></span></div></td>
</tr>
<% end if %>
<% if(request("end_date") <> "") then %>
<tr valign="top" style="padding-top:3px;">
  <td colspan="2" align="center" style="padding-right:5px;"><div style='padding-bottom:10px;width:300px;text-align:left;'><span style="font-weight:normal;color:black;">End Date :</span><span style="font-weight:bold;"><%= request("end_date") %></span></div></td>
</tr>
<% end if %>
<tr valign="top" style="padding-top:3px;">
  <td colspan="2" align="center" style="padding-right:5px;"><div style='padding-bottom:10px;width:300px;text-align:left;'><span style="font-weight:normal;color:black;">Total Coming Due Hazards :</span><span style="font-weight:bold;"><%= total_hazards %></span></div><%= lateStr %></td>
</tr>
<tr><td colspan="2" height="10"></td></tr>
<tr valign="top" style="padding-top:3px;">
  <td colspan="2" align="center" style="padding-right:5px;"><div style='padding-bottom:10px;width:300px;text-align:left;'><span style="font-weight:normal;color:black;">Total Late Hazards :</span><span style="font-weight:bold;"><%= total_hazards2 %></span></div><%= lateStr2 %></td>
</tr>
<tr><td colspan="2" height="10"></td></tr>
<tr valign="top" style="padding-top:3px;">
  <td colspan="2" align="center" style="padding-right:5px;"><div style='padding-bottom:10px;width:300px;text-align:left;'><span style="font-weight:normal;color:black;">Total Coming Due Action Items :</span><span style="font-weight:bold;"><%= total_hazards3 %></span></div><%= lateStr3 %></td>
</tr>
<tr><td colspan="2" height="10"></td></tr>
<tr valign="top" style="padding-top:3px;">
  <td colspan="2" align="center" style="padding-right:5px;"><div style='padding-bottom:10px;width:300px;text-align:left;'><span style="font-weight:normal;color:black;">Total Late Action Items :</span><span style="font-weight:bold;"><%= total_hazards4 %></span></div><%= lateStr4 %></td>
</tr>
</table>

</div>
<div style="height:20px;"></div>
</div>
</div>
<script>
document.getElementById("PINWHEEL").style.display = "none";
</script>
</body>
</html>
