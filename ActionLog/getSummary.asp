<!--#include file="includes/security.inc" -->
<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include file="includes/commonUtils.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<!--#include file="showVars.inc"-->
<%
unlockLogs
log_number			= request("log_number")
log_numberStr		= string(4-len(log_number),"0")&log_number

viewDivision			= request("viewDivision")
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
  generic					= selectNode(oXML2,"generic","")

  initial_assessment_date			= selectNode(oXML2,"initial_assessment_date","")
  initial_assessment_occasion		= selectNode(oXML2,"initial_assessment_occasion","")
  current_assessment_date			= selectNode(oXML2,"current_assessment_date","")
  current_assessment_occasion		= selectNode(oXML2,"current_assessment_occasion","")
  post_assessment_date				= selectNode(oXML2,"post_assessment_date","")
  post_assessment_occasion			= selectNode(oXML2,"post_assessment_occasion","")
  further_risk_reduction_needed		= selectNode(oXML2,"further_risk_reduction_needed","")
  hazard_ok_alarp					= selectNode(oXML2,"hazard_ok_alarp","")
  alarp_statement					= selectNode(oXML2,"alarp_statement","")

  mission					= selectNode(oXML2,"mission","")


  hazard_base         = selectNode(oXML2,"hazard_base","")
  hazard_type         = selectNode(oXML2,"hazard_type","")
  hazard_number         = selectNode(oXML2,"hazard_number","")

  hazard_title         = selectNode(oXML2,"hazard_title","")
  station         = selectNode(oXML2,"station","")
  source         = selectNode(oXML2,"source","")
  division         = selectNode(oXML2,"division","")

  hazard_number = string(4-len(hazard_number),"0") & hazard_number
  hazard_id = viewDivision &"-"& hazard_number

end if

sql = "select first_name, last_name from Tbl_Logins where LoginID = "& sqlnum(loginID)
set tmprs=conn_asap.execute(sql)
if not tmprs.eof then
  hazard_editor = tmprs("last_name") &", "& tmprs("first_name")
end if

if((date_opened <> "") and (not isnull(date_opened)) and (isdate(date_opened))) then
  date_openedStr = year(date_opened) &"-"& monthname(month(date_opened),true) &"-"& day(date_opened)
end if
if((date_due <> "") and (not isnull(date_due)) and (isdate(date_due))) then
  date_dueStr = year(date_due) &"-"& monthname(month(date_due),true) &"-"& day(date_due)
end if
if((date_completed <> "") and (not isnull(date_completed)) and (isdate(date_completed))) then
  date_completedStr = year(date_completed) &"-"& monthname(month(date_completed),true) &"-"& day(date_completed)
end if
if((next_review_date <> "") and (not isnull(next_review_date)) and (isdate(next_review_date))) then
  next_review_dateStr = year(next_review_date) &"-"& monthname(month(next_review_date),true) &"-"& day(next_review_date)
end if

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

  current_measures_responsible_person	= selectNode(oXML,"current_measures_responsible_person","")
  risk_value							= selectNode(oXML,"risk_value","")
  physical_injury						= selectNode(oXML,"physical_injury","")
  damage_to_the_environment				= selectNode(oXML,"damage_to_the_environment","")
  damage_to_assets						= selectNode(oXML,"damage_to_assets","")
  potential_increased_cost				= selectNode(oXML,"potential_increased_cost","")
  damage_to_corporate_reputation		= selectNode(oXML,"damage_to_corporate_reputation","")
  likelihood							= selectNode(oXML,"likelihood","")
  comments								= selectNode(oXML,"comments","")

  safety_action_cnt   = selectNode(oXML,"safety_action_cnt","0")
end if

proceed = "n"
if((session_sms_admin = "y") or (session_business_unit = "Global")) then
  proceed = "y"
end if
if((session_business_unit = viewDivision) and ((session_hazard_base = base) or (session_base = base) or (session_base = "All"))) then
  proceed = "y"
end if

if(isnumeric(hazard_owner)) then
sql = "select first_name, last_name from tbl_logins where loginid = "& sqlnum(hazard_owner)
set tmprs = conn_asap.execute(sql)
if not tmprs.eof then
  accountable_leaderStr = tmprs("last_name") &", "& tmprs("first_name")
end if
end if

%>
<!--
session("business_unit"):<%= session("business_unit") %>:
session("base"):<%= session("base") %>:
viewDivision:<%= viewDivision %>:
base:<%= base %>:
session("hazard_base"):<%= session("hazard_base") %>:
-->
<html><head>
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
    <link href="css/style.css" rel="stylesheet" type="text/css" />

<body onload="decode()">
<center>

<table style="BORDER-RIGHT: 1px; PADDING-RIGHT: 3px; BORDER-TOP: 1px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; BORDER-LEFT: 1px; PADDING-TOP: 3px; BORDER-BOTTOM: 1px; BACKGROUND-COLOR: #ffffff" border="0" cellSpacing="0" cellPadding="1" width="100%">
<tr>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial" background="" height="10"></td>
</tr>

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

date_due = urldecode(date_due)
date_opened = urldecode(date_opened)
date_completed = urldecode(date_completed)
date_completed = urldecode(date_completed)
next_review_date = urldecode(next_review_date)

if((next_review_date <> "") and (not isnull(next_review_date)) and (isdate(next_review_date))) then
  if(instr(next_review_date,"-") > 0) then
    next_review_dateArr = split(next_review_date,"-")
    next_review_date2 = next_review_dateArr(2)&"/"&next_review_dateArr(1)&"/"&next_review_dateArr(0)
  else
    next_review_date2 = next_review_date
  end if
  tmp_monthStr = datepart("m",next_review_date2)
  tmp_dayStr = datepart("d",next_review_date2)
  tmp_yearStr = datepart("yyyy",next_review_date)
  next_review_date2 = tmp_monthStr &"/"& tmp_dayStr &"/"& tmp_yearStr
else
  next_review_date2 = date
end if

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
%>

<!--#include file ="hazard.inc"-->

<!--
oXML:<%= oXML.xml %>
-->

</body>
</html>
