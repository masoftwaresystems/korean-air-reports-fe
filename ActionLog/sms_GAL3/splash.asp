<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/security.inc"-->
<!--#include file="includes/loginInfo.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include file="includes/sms_header.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<%
unlockLogs
%>
  <div style="width:100%;padding-top:30px;padding-bottom:30px;margin: 0 auto;">

<table border="0" cellspacing="0" cellpadding="0" width="98%" style="padding-top:0px;margin-left:0px;">
  <tr><td align="center"><span class="fonts4" style="font-size:14px;color:#737579;"><span style="font-weight:bold;color:#116c94;">Hazard Dashboard</span></span><div id="PINWHEEL"><img src="http://www.bristowsafety.com/images/pinwheel.gif">
</div></td></tr>
</table>
<center>
<br><br>
<table border="0" cellspacing="1" cellpadding="0" width="800" bgcolor="silver">
	<tr>
		<td bgcolor="white" width="100" align="center"><b>Legend:</b></td>
		<td bgcolor="white" width="150" align="right">Ongoing&nbsp;</td>
		<td bgcolor="white" width="50" align="left"><img src="http://www.bristowsafety.com/images/1pyellow.png" height="10" width="20" style="border:1px solid black;"></td>
		<td bgcolor="white" width="150" align="right">Overdue&nbsp;</td>
		<td bgcolor="white" width="50" align="left"><img src="http://www.bristowsafety.com/images/1pred.png" height="10" width="20" style="border:1px solid black;"></td>
		<td bgcolor="white" width="150" align="right">Closed&nbsp;</td>
		<td bgcolor="white" width="150" align="left"><img src="http://www.bristowsafety.com/images/1pgreen.png" height="10" width="20" style="border:1px solid black;"></td>
	</tr>
</table>
<br><br>
<table border="0" cellspacing="1" cellpadding="0" width="1100" bgcolor="silver">
	<tr>
<%
sql = "select distinct division, code from division_t order by division asc"
set rs=conn_asap.execute(sql)
do while not rs.eof
  tmpdivision = rs("division")
  tmpcode = rs("code")
%>
		<td bgcolor="white" width="100" align="center"><b><%= tmpcode %></b></td>
<%
  rs.movenext
loop
%>
	</tr>
	<tr>
<%
set oXML2     = CreateObject("Microsoft.XMLDOM")
oXML2.async   = false
%>
<%
sql = "select distinct division, code from division_t order by division asc"
set ors=conn_asap.execute(sql)
do while not ors.eof
  tmpdivision = ors("division")
  tmpcode = ors("code")

total_hazards								= 0
late_hazards								= 0
endorsed_hazards							= 0
loaded_hazards								= 0

sql = "select * from EHD_Data where active = 'y' and archived = 'n' and formname = 'iSRT_LogInput' and division = '"& tmpcode &"' and divisionalLogNumber is not null order by lognumber asc"
set rs = conn_asap.execute(sql)
do while not rs.eof

  formDataXML2  = rs("formDataXML")

  oXML2.loadXML(formDataXML2)

  date_due            	= selectNode(oXML2,"date_due","")
  endorsed				= selectNode(oXML2,"endorsed","")
  date_opened         = selectNode(oXML2,"date_opened","")
  date_completed      = selectNode(oXML2,"date_completed","")
  next_review_date			= selectNode(oXML2,"next_review_date","")

  total_hazards			= total_hazards +1


if((date_due <> "") and (not isnull(date_due)) and (isdate(date_due))) then
  date_dueArr = split(date_due,"-")
  date_due2 = date_dueArr(2)&"/"&date_dueArr(1)&"/"&date_dueArr(0)
  tmp_monthStr = datepart("m",date_due2)
  tmp_dayStr = datepart("d",date_due2)
  tmp_yearStr = datepart("yyyy",date_due2)
  due_dateStr2 = tmp_monthStr &"/"& tmp_dayStr &"/"& tmp_yearStr
else
  due_dateStr2 = date
end if

if((date_opened <> "") and (not isnull(date_opened)) and (isdate(date_opened))) then
  date_openedArr = split(date_opened,"-")
  date_opened2 = date_openedArr(2)&"/"&date_openedArr(1)&"/"&date_openedArr(0)
  tmp_monthStr = datepart("m",date_opened2)
  tmp_dayStr = datepart("d",date_opened2)
  tmp_yearStr = datepart("yyyy",date_opened2)
   date_openedStr2 = tmp_monthStr &"/"& tmp_dayStr &"/"& tmp_yearStr
else
  date_openedStr2 = ""
end if

if((date_completed <> "") and (not isnull(date_completed)) and (isdate(date_completed))) then
  date_completedArr = split(date_completed,"-")
  date_completed2 = date_completedArr(2)&"/"&date_completedArr(1)&"/"&date_completedArr(0)
  tmp_monthStr = datepart("m",date_completed2)
  tmp_dayStr = datepart("d",date_completed2)
  tmp_yearStr = datepart("yyyy",date_completed2)
  date_completedStr2 = tmp_monthStr &"/"& tmp_dayStr &"/"& tmp_yearStr
else
  date_completedStr2 = ""
end if

if((next_review_date <> "") and (not isnull(next_review_date)) and (isdate(next_review_date))) then
  next_review_dateArr = split(next_review_date,"-")
  next_review_date2 = next_review_dateArr(2)&"/"&next_review_dateArr(1)&"/"&next_review_dateArr(0)
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


  if(endorsed = "1") then
    endorsed_hazards = endorsed_hazards +1
  else
    if(clng(daysStr) < 0) then
      late_hazards = late_hazards +1
    else
      loaded_hazards = loaded_hazards +1
    end if
  end if

  rs.movenext
loop
if(total_hazards = 0) then
  total_hazards = 1
end if
redwidth = clng(60*(late_hazards/total_hazards))
yellowwidth = clng(60*(loaded_hazards/total_hazards))
greenwidth = clng(60*(endorsed_hazards/total_hazards))
%>
		<td bgcolor="white" width="100" align="center"><% if(greenwidth > 0) then %><img src="http://www.bristowsafety.com/images/1pgreen.png" height="10" width="<%= greenwidth %>" style="border:1px solid black;"><% end if %><% if(yellowwidth > 0) then %><img src="http://www.bristowsafety.com/images/1pyellow.png" height="10" width="<%= yellowwidth %>" style="border:1px solid black;"><% end if %><% if(redwidth > 0) then %><img src="http://www.bristowsafety.com/images/1pred.png" height="10" width="<%= redwidth %>" style="border:1px solid black;"><% end if %><!-- <br><%= total_hazards %>|<%= endorsed_hazards %>|<%= loaded_hazards %>|<%= late_hazards %> --></td>
<%
  ors.movenext
loop
%>
	</tr>
</table>

<% if((session("division") <> "Global") and (session("base") <> "All")) then %>
<table border="0" cellspacing="1" cellpadding="0" width="500" bgcolor="silver" style="margin-top:30px;">
	<tr>
		<td bgcolor="white" width2="250" align="center"><b>Your Division (<%= session("division") %>)</b></td>
	</tr>
<%
total_hazards								= 0
late_hazards								= 0
endorsed_hazards							= 0
loaded_hazards								= 0

sql = "select * from EHD_Data where active = 'y' and archived = 'n' and formname = 'iSRT_LogInput' and division = "& sqltext2(session("division")) &" and divisionalLogNumber is not null order by lognumber asc"
set rs = conn_asap.execute(sql)
do while not rs.eof

  formDataXML2  = rs("formDataXML")

  oXML2.loadXML(formDataXML2)

  date_due            	= selectNode(oXML2,"date_due","")
  endorsed				= selectNode(oXML2,"endorsed","")
  date_opened         = selectNode(oXML2,"date_opened","")
  date_completed      = selectNode(oXML2,"date_completed","")
  next_review_date			= selectNode(oXML2,"next_review_date","")

  total_hazards			= total_hazards +1
if((date_due <> "") and (not isnull(date_due)) and (isdate(date_due))) then
  date_dueArr = split(date_due,"-")
  date_due2 = date_dueArr(2)&"/"&date_dueArr(1)&"/"&date_dueArr(0)
  tmp_monthStr = datepart("m",date_due2)
  tmp_dayStr = datepart("d",date_due2)
  tmp_yearStr = datepart("yyyy",date_due2)
  due_dateStr2 = tmp_monthStr &"/"& tmp_dayStr &"/"& tmp_yearStr
else
  due_dateStr2 = date
end if

if((date_opened <> "") and (not isnull(date_opened)) and (isdate(date_opened))) then
  date_openedArr = split(date_opened,"-")
  date_opened2 = date_openedArr(2)&"/"&date_openedArr(1)&"/"&date_openedArr(0)
  tmp_monthStr = datepart("m",date_opened2)
  tmp_dayStr = datepart("d",date_opened2)
  tmp_yearStr = datepart("yyyy",date_opened2)
   date_openedStr2 = tmp_monthStr &"/"& tmp_dayStr &"/"& tmp_yearStr
else
  date_openedStr2 = ""
end if

if((date_completed <> "") and (not isnull(date_completed)) and (isdate(date_completed))) then
  date_completedArr = split(date_completed,"-")
  date_completed2 = date_completedArr(2)&"/"&date_completedArr(1)&"/"&date_completedArr(0)
  tmp_monthStr = datepart("m",date_completed2)
  tmp_dayStr = datepart("d",date_completed2)
  tmp_yearStr = datepart("yyyy",date_completed2)
  date_completedStr2 = tmp_monthStr &"/"& tmp_dayStr &"/"& tmp_yearStr
else
  date_completedStr2 = ""
end if

if((next_review_date <> "") and (not isnull(next_review_date)) and (isdate(next_review_date))) then
  next_review_dateArr = split(next_review_date,"-")
  next_review_date2 = next_review_dateArr(2)&"/"&next_review_dateArr(1)&"/"&next_review_dateArr(0)
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


  if(endorsed = "1") then
    endorsed_hazards = endorsed_hazards +1
  else
    if(clng(daysStr) < 0) then
      late_hazards = late_hazards +1
    else
      loaded_hazards = loaded_hazards +1
    end if
  end if

  rs.movenext
loop
if(total_hazards = 0) then
  total_hazards = 1
end if
redwidth = clng(60*(late_hazards/total_hazards))
yellowwidth = clng(60*(loaded_hazards/total_hazards))
greenwidth = clng(60*(endorsed_hazards/total_hazards))
%>
	<tr>
		<td bgcolor="white" width2="250" align="center"><% if(greenwidth > 0) then %><img src="http://www.bristowsafety.com/images/1pgreen.png" height="10" width="<%= greenwidth %>" style="border:1px solid black;"><% end if %><% if(yellowwidth > 0) then %><img src="http://www.bristowsafety.com/images/1pyellow.png" height="10" width="<%= yellowwidth %>" style="border:1px solid black;"><% end if %><% if(redwidth > 0) then %><img src="http://www.bristowsafety.com/images/1pred.png" height="10" width="<%= redwidth %>" style="border:1px solid black;"><% end if %><!-- <br><%= total_hazards %>|<%= endorsed_hazards %>|<%= loaded_hazards %>|<%= late_hazards %> --></td>
	</tr>
<%
next_base_sag								= ""
sql = "select * from EHD_Data where active = 'y' and archived = 'n' and formname = 'iSRT_LogInput' and division = "& sqltext2(session("division")) &" and divisionalLogNumber is not null order by lognumber asc"
set rs = conn_asap.execute(sql)
do while not rs.eof

  formDataXML2  = rs("formDataXML")

  oXML2.loadXML(formDataXML2)

  next_review_date            	= selectNode(oXML2,"next_review_date","")
%>
<!--
next_review_date: <%= next_review_date %>:
next_base_sag: <%= next_base_sag %>:
-->
<%
'response.end
  if(next_review_date <> "") then
    'next_review_dateArr = split(next_review_date,"/")
    'next_review_date = next_review_dateArr(1) &"/"& next_review_dateArr(0) &"/"& next_review_dateArr(2)
    if(next_base_sag = "") then
      next_base_sag = next_review_date
    end if
    'response.write(next_base_sag)
    'response.end
    'if((datediff("d",next_review_date,next_base_sag) > 0) and (datediff("d",date(),next_review_date) > 0)) then
    '  next_base_sag = next_review_date
    'end if

  end if
  rs.movenext
loop
if(next_base_sag <> "") then
  next_base_sagStr = day(next_base_sag) &"-"& monthname(month(next_base_sag),true) &"-"& year(next_base_sag)
else
  next_base_sagStr = "Not Available"
end if
%>
	<tr>
		<td bgcolor="white" width2="250" align="center">Next SAM: <b><%= next_base_sagStr %></b></td>
	</tr>
</table>
<% end if %>
</center>
<br><br><br>
<table border="0" cellspacing="0" cellpadding="0" width="98%" style="padding-top:0px;margin-left:0px;">
  <tr><td align="center"><span class="fonts4" style="font-size:14px;color:#737579;"><span style="font-weight:bold;color:#116c94;">Global Q&S News and Information</span></span></td></tr>
</table>
<table border="0" cellspacing="0" cellpadding="0" width="98%" style="padding-top:0px;margin-left:0px;">
  <tr><td align="center"><div style="font-weight:bold;font-size:12px;color:#116c94;margin-bottom:5px;margin-top:10px;">General News</div></td></tr>
</table>
<%
news = ""
sql = "select * from Bullet_info_t"
set rs = conn_asap.execute(sql)
do while not rs.eof
%>
<center>
<div style="width:1100px;text-align:left;">
<p><b><%= rs("title") %></b></p>
<p><b><%= rs("subject") %></b></p>
</div>
</center>
<%
  rs.movenext
loop
%>

</center>
  </div>
<!--#include file ="includes/footer.inc"-->
<script>
document.getElementById("PINWHEEL").style.display = "none";
</script>
  </body>
</html>
<%
function getBaseStr(b,d)
  baseStr = b
  sql = "select current_base from BUtoBASE where business_unit = "& sqltext2(d) &" and code = "& sqltext2(b)
  'response.write(sql)
  'response.end

  set tmprs = conn_asap.execute(sql)
  if not tmprs.eof then
    baseStr = tmprs("current_base")
  end if

  getBaseStr = baseStr
end function
%>