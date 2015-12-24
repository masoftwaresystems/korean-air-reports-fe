<!--#include file ="includes/security.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<%
unlockLogs
log_number			= request("log_number")
log_numberStr		= string(4-len(log_number),"0")&log_number

viewDivision			= request("viewDivision")
%>
<!--#include file="includes/sms_header.inc"-->
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
  generic					= selectNode(oXML2,"generic","")

  mission					= selectNode(oXML2,"mission","")

  initial_assessment_date			= selectNode(oXML2,"initial_assessment_date","")
  initial_assessment_occasion		= selectNode(oXML2,"initial_assessment_occasion","")
  current_assessment_date			= selectNode(oXML2,"current_assessment_date","")
  current_assessment_occasion		= selectNode(oXML2,"current_assessment_occasion","")
  post_assessment_date				= selectNode(oXML2,"post_assessment_date","")
  post_assessment_occasion			= selectNode(oXML2,"post_assessment_occasion","")
  further_risk_reduction_needed		= selectNode(oXML2,"further_risk_reduction_needed","")
  hazard_ok_alarp					= selectNode(oXML2,"hazard_ok_alarp","")
  alarp_statement					= selectNode(oXML2,"alarp_statement","")

end if

sql = "select first_name, last_name from Tbl_Logins where LoginID = "& sqlnum(loginID)
set tmprs=conn_asap.execute(sql)
if not tmprs.eof then
  hazard_editor = tmprs("first_name") &" "& tmprs("last_name")
end if

if(date_opened <> "") then
  date_openedStr = day(date_opened) &"-"& monthname(month(date_opened),true) &"-"& year(date_opened)
end if
if(date_due <> "") then
  date_dueStr = day(date_due) &"-"& monthname(month(date_due),true) &"-"& year(date_due)
end if
if(date_completed <> "") then
  date_completedStr = day(date_completed) &"-"& monthname(month(date_completed),true) &"-"& year(date_completed)
end if
if(next_review_date <> "") then
  next_review_dateStr = day(next_review_date) &"-"& monthname(month(next_review_date),true) &"-"& year(next_review_date)
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
end if


%>
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
    <link href="css/style.css" rel="stylesheet" type="text/css" />


<table style="BORDER-RIGHT: 1px; PADDING-RIGHT: 3px; BORDER-TOP: 1px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; BORDER-LEFT: 1px; PADDING-TOP: 3px; BORDER-BOTTOM: 1px; BACKGROUND-COLOR: #ffffff" border="0" cellSpacing="0" cellPadding="1" width="100%" align="center">
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
%>

<table cellspacing="2" cellpadding="0" width="100%" border="0" align="center">
<tr valign="top" style="padding-top:3px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Log Number :</span></td>
<% if(request("framed") = "y") then %>
<%
isLocked = isLogLocked(request("log_number"),viewDivision)
if(isLocked = "n") then
  clickloc = "window.parent.location.href='divisional_LogInput.asp?position=&log_number="& request("log_number") &"&viewDivision="& viewDivision &"'"
else
  clickloc = "alert('"& division & log_numberStr &" locked by "& isLocked &"')"
end if
%>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:bold;"><a href="javascript:<%= clickloc %>"><%= viewDivision %><%= log_numberStr %></a></span></td>
<% else %>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:bold;"><%= viewDivision %><%= log_numberStr %></span></td>
<% end if %>
</tr>
<!--
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Divisional Number :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;">
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
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= item_title %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Description :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= item_description %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Generic :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= transFlag(generic) %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Comments :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= item_comments %></span></td>
</tr>
<% if(base <> "") then %>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Base :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= base %></span></td>
</tr>
<% end if %>
<% if(equipment <> "") then %>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Aircraft :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= equipment %></span></td>
</tr>
<% end if %>
<% if(mission <> "") then %>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Mission :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= mission %></span></td>
</tr>
<% end if %>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Hazard Owner :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= hazard_owner %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Hazard Editor :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= hazard_editor %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Accountable Leader :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= accountable_leader %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">SOI :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= transSOI(soi) %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Date Opened :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= date_openedStr %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Date Due :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= date_dueStr %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Date Completed :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= date_completedStr %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Endorsed :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= transFlag(endorsed) %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Endorsed By :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= endorsed_by %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Next Review Date :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= next_review_dateStr %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">ALARP Statement :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= alarp_statement %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Status :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= item_status %></span></td>
</tr>
<!--
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Related Log Numbers :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;">
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
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;">
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
" and a.division = "& sqltext2(viewDivision) & _
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
  <td width="<%= cell2width %>" align="left"><div style="font-weight:normal;"></div></td>
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

%>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Action Item Number :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= viewdivision %><%= log_numberStr %>.<%= a %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Action Type :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= safety_action_type %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Activity :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= safety_action %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Action Owner :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= safety_action_poc %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Opened :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= safety_action_open %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Due :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= safety_action_due %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Completed :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= safety_action_completed %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Status :</span></td>
  <td width="<%= cell2width %>" align="left"><span style="font-weight:normal;"><%= safety_action_status %></span></td>
</tr>
<%
next
%>

<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold;">Risk</span></td>
  <td width="<%= cell2width %>" align="left"><div style="font-weight:normal;"></div></td>
</tr>
<!--
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Contributing Factors :</span></td>
  <td width="<%= cell2width %>" align="left">
<% for a = 1 to cint(selectNode(oXML,"contributing_factors_cnt","0")) %>
<div style="font-weight:normal;"><%= selectNode(oXML,"contributing_factor_"& a,"") %></div>
<% next %>
  </td>
</tr>
-->
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Causes / Threats :</span></td>
  <td width="<%= cell2width %>" align="left">
<% for a = 1 to cint(selectNode(oXML,"factors_cnt","0")) %>
<div style="font-weight:normal;margin-bottom:6px;"><% if(selectNode(oXML,"factors_type_"& a,"") <> "") then %><span style="width:75px;"><%= selectNode(oXML,"factors_type_"& a,"") %> :: </span><% end if %><%= selectNode(oXML,"factors_"& a,"") %></div>
<% next %>
  </td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Consequences :</span></td>
  <td width="<%= cell2width %>" align="left">
<% for a = 1 to cint(selectNode(oXML,"consequences_cnt","0")) %>
<div style="font-weight:normal;padding-bottom:6px;"><%= selectNode(oXML,"consequences_"& a,"") %></div>
<% next %>
  </td>
</tr>
<!--
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Active Errors :</span></td>
  <td width="<%= cell2width %>" align="left">
<% for a = 1 to cint(selectNode(oXML,"active_errors_cnt","0")) %>
<div style="font-weight:normal;"><%= selectNode(oXML,"active_error_"& a,"") %></div>
<% next %>
  </td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Latent Conditions :</span></td>
  <td width="<%= cell2width %>" align="left">
<% for a = 1 to cint(selectNode(oXML,"latent_conditions_cnt","0")) %>
<div style="font-weight:normal;"><%= selectNode(oXML,"latent_condition_"& a,"") %></div>
<% next %>
  </td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Causal Factors :</span></td>
  <td width="<%= cell2width %>" align="left">
<% for a = 1 to cint(selectNode(oXML,"causal_factors_cnt","0")) %>
<div style="font-weight:normal;"><%= selectNode(oXML,"causal_factor_"& a,"") %></div>
<% next %>
  </td>
</tr>
-->
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold;">Risk Matrix (Pre-mitigation)</span></td>
  <td width="<%= cell2width %>" align="left"><div style="font-weight:normal;"></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Current Measures to reduce the risk :</span></td>
  <td width="<%= cell2width %>" align="left">
<% for a = 1 to cint(selectNode(oXML,"current_measures_cnt","0")) %>
<div style="font-weight:normal;"><%= selectNode(oXML,"current_measures_"& a,"") %></div>
<% next %>
  </td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Responsible Person/Functional Area (current measures) :</span></td>
  <td width="<%= cell2width %>" align="left"><div style="font-weight:normal;"><%= selectNode(oXML,"current_measures_responsible_person","") %></div></td>
</tr>
<%
tmprisk_value_pre_mitigation = selectNode(oXML,"risk_value_pre_mitigation","")
tmpcolor = ""
if(tmprisk_value_pre_mitigation = "Acceptable") then
  tmpcolor = "#336600"
end if
if(tmprisk_value_pre_mitigation = "Acceptable With Mitigation") then
  tmpcolor = "#ffcc00"
end if
if(tmprisk_value_pre_mitigation = "Unacceptable") then
  tmpcolor = "#8a0808"
end if
%>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold; COLOR: #000080;">Risk Value (Pre-mitigation) :</span></td>
  <td width="<%= cell2width %>" align="left"><div style="font-weight:bold; COLOR: <%= tmpcolor %>;"><%= selectNode(oXML,"risk_value_pre_mitigation","") %></div></td>
</tr>
<% if(selectNode(oXML,"risk_value_pre_mitigation","") <> "") then %>
<%
tmpSeverity = 0
tmpRiskLevel = 0
if(cint(selectNode(oXML,"pre_physical_injury_rating","0")) >= tmpRiskLevel) then
  tmpSeverity = 1
  tmpRiskLevel = cint(selectNode(oXML,"pre_physical_injury_rating","0"))
end if
if(cint(selectNode(oXML,"pre_damage_to_the_environment_rating","0")) >= tmpRiskLevel) then
  tmpSeverity = 2
  tmpRiskLevel = cint(selectNode(oXML,"pre_damage_to_the_environment_rating","0"))
end if
if(cint(selectNode(oXML,"pre_damage_to_assets_rating","0")) >= tmpRiskLevel) then
  tmpSeverity = 3
  tmpRiskLevel = cint(selectNode(oXML,"pre_damage_to_assets_rating","0"))
end if
if(cint(selectNode(oXML,"pre_potential_increased_cost_rating","0")) >= tmpRiskLevel) then
  tmpSeverity = 4
  tmpRiskLevel = cint(selectNode(oXML,"pre_potential_increased_cost_rating","0"))
end if
if(cint(selectNode(oXML,"pre_damage_to_corporate_reputation_rating","0")) >= tmpRiskLevel) then
  tmpSeverity = 5
  tmpRiskLevel = cint(selectNode(oXML,"pre_damage_to_corporate_reputation_rating","0"))
end if
if(cint(selectNode(oXML,"pre_damage_to_corporate_reputation2_rating","0")) >= tmpRiskLevel) then
  tmpSeverity = 6
  tmpRiskLevel = cint(selectNode(oXML,"pre_damage_to_corporate_reputation2_rating","0"))
end if
%>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold; COLOR: #000080;"></span></td>
  <td width="<%= cell2width %>" valign="top">
  <table width="200" cellpadding="0" cellspacing="1" border="0" bgcolor="black">
    <tr>
      <td width="50%" align="center" bgcolor="white"><span style="font-weight:normal;">Likelihood</span></td>
      <td width="50%" align="center" bgcolor="white"><span style="font-weight:normal;">Severity</span></td>
    </tr>
    <tr>
      <td width="50%" align="center" bgcolor="white"><span style="font-weight:normal;"><%= selectNode(oXML,"pre_likelihood_level","") %></span></td>
      <td width="50%" align="center" bgcolor="white"><span style="font-weight:normal;"><%= tmpRiskLevel %></span></td>
    </tr>
  </table>
  </td>
</tr>
<% end if %>
<!--
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Physical Injury :</span></td>
  <td width="<%= cell2width %>" align="left"><div style="font-weight:normal;"><%= selectNode(oXML,"pre_physical_injury","") %></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to the Environment :</span></td>
  <td width="<%= cell2width %>" align="left"><div style="font-weight:normal;"><%= selectNode(oXML,"pre_damage_to_the_environment","") %></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to Assets :</span></td>
  <td width="<%= cell2width %>" align="left"><div style="font-weight:normal;"><%= selectNode(oXML,"pre_damage_to_assets","") %></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Potential Increased Cost or Revenue Loss :</span></td>
  <td width="<%= cell2width %>" align="left"><div style="font-weight:normal;"><%= selectNode(oXML,"pre_potential_increased_cost","") %></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to Corporate Reputation :</span></td>
  <td width="<%= cell2width %>" align="left"><div style="font-weight:normal;"><%= selectNode(oXML,"pre_damage_to_corporate_reputation","") %></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Likelihood :</span></td>
  <td width="<%= cell2width %>" align="left"><div style="font-weight:normal;"><%= selectNode(oXML,"pre_likelihood","") %></div></td>
</tr>
-->
<tr valign="top" style="padding-top:15px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold;">Risk Matrix (Post-mitigation)</span></td>
  <td width="<%= cell2width %>" align="left"><div style="font-weight:normal;"></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Corrective/Proactive Actions to Mitigate the Risk :</span></td>
  <td width="<%= cell2width %>" align="left"><div style="font-weight:normal;">
<% for a = 1 to cint(selectNode(oXML,"corrective_actions_cnt","0")) %>
<div style="font-weight:normal;"><% if(selectNode(oXML,"corrective_action_item_"& a,"") <> "") then %><span style="width:75px;">(<%= selectNode(oXML,"corrective_action_item_"& a,"") %>)</span><% end if %><%= selectNode(oXML,"corrective_action_"& a,"") %></div>
<% next %>
  </div></td>
</tr>
<!--
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Unintended Consequences :</span></td>
  <td width="<%= cell2width %>" align="left"><div style="font-weight:normal;"><%= selectNode(oXML,"unintended_consequences","") %></div></td>
</tr>
-->
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Responsible Person/Functional Area (corrective actions) :</span></td>
  <td width="<%= cell2width %>" align="left"><div style="font-weight:normal;"><%= selectNode(oXML,"corrective_actions_responsible_person","") %></div></td>
</tr>
<%
tmprisk_value_post_mitigation = selectNode(oXML,"risk_value_post_mitigation","")
tmpcolor = ""
if(tmprisk_value_post_mitigation = "Acceptable") then
  tmpcolor = "#336600"
end if
if(tmprisk_value_post_mitigation = "Acceptable With Mitigation") then
  tmpcolor = "#ffcc00"
end if
if(tmprisk_value_post_mitigation = "Unacceptable") then
  tmpcolor = "#8a0808"
end if
%>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold; COLOR: #000080;">Risk Value (Post-mitigation) :</span></td>
  <td width="<%= cell2width %>" align="left"><div style="font-weight:bold; COLOR: <%= tmpcolor %>;"><%= selectNode(oXML,"risk_value_post_mitigation","") %></div></td>
</tr>
<% if(selectNode(oXML,"risk_value_post_mitigation","") <> "") then %>
<%
tmpSeverity = 0
tmpRiskLevel = 0
if(cint(selectNode(oXML,"post_physical_injury_rating","0")) >= tmpRiskLevel) then
  tmpSeverity = 1
  tmpRiskLevel = cint(selectNode(oXML,"post_physical_injury_rating","0"))
end if
if(cint(selectNode(oXML,"post_damage_to_the_environment_rating","0")) >= tmpRiskLevel) then
  tmpSeverity = 2
  tmpRiskLevel = cint(selectNode(oXML,"post_damage_to_the_environment_rating","0"))
end if
if(cint(selectNode(oXML,"post_damage_to_assets_rating","0")) >= tmpRiskLevel) then
  tmpSeverity = 3
  tmpRiskLevel = cint(selectNode(oXML,"post_damage_to_assets_rating","0"))
end if
if(cint(selectNode(oXML,"post_potential_increased_cost_rating","0")) >= tmpRiskLevel) then
  tmpSeverity = 4
  tmpRiskLevel = cint(selectNode(oXML,"post_potential_increased_cost_rating","0"))
end if
if(cint(selectNode(oXML,"post_damage_to_corporate_reputation_rating","0")) >= tmpRiskLevel) then
  tmpSeverity = 5
  tmpRiskLevel = cint(selectNode(oXML,"post_damage_to_corporate_reputation_rating","0"))
end if
if(cint(selectNode(oXML,"post_damage_to_corporate_reputation2_rating","0")) >= tmpRiskLevel) then
  tmpSeverity = 6
  tmpRiskLevel = cint(selectNode(oXML,"post_damage_to_corporate_reputation2_rating","0"))
end if
%>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold; COLOR: #000080;"></span></td>
  <td width="<%= cell2width %>" valign="top">
  <table width="200" cellpadding="0" cellspacing="1" border="0" bgcolor="black">
    <tr>
      <td width="50%" align="center" bgcolor="white"><span style="font-weight:normal;">Likelihood</span></td>
      <td width="50%" align="center" bgcolor="white"><span style="font-weight:normal;">Severity</span></td>
    </tr>
    <tr>
      <td width="50%" align="center" bgcolor="white"><span style="font-weight:normal;"><%= selectNode(oXML,"pre_likelihood_level","") %></span></td>
      <td width="50%" align="center" bgcolor="white"><span style="font-weight:normal;"><%= tmpRiskLevel %></span></td>
    </tr>
  </table>
  </td>
</tr>
<% end if %>
<!--
<tr valign="top" style="padding-top:15px;">
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Physical Injury :</span></td>
  <td width="<%= cell2width %>" align="left"><div style="font-weight:normal;"><%= selectNode(oXML,"post_physical_injury","") %></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to the Environment :</span></td>
  <td width="<%= cell2width %>" align="left"><div style="font-weight:normal;"><%= selectNode(oXML,"post_damage_to_the_environment","") %></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to Assets :</span></td>
  <td width="<%= cell2width %>" align="left"><div style="font-weight:normal;"><%= selectNode(oXML,"post_damage_to_assets","") %></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Potential Increased Cost or Revenue Loss :</span></td>
  <td width="<%= cell2width %>" align="left"><div style="font-weight:normal;"><%= selectNode(oXML,"post_potential_increased_cost","") %></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to Corporate Reputation :</span></td>
  <td width="<%= cell2width %>" align="left"><div style="font-weight:normal;"><%= selectNode(oXML,"post_damage_to_corporate_reputation","") %></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Likelihood :</span></td>
  <td width="<%= cell2width %>" align="left"><div style="font-weight:normal;"><%= selectNode(oXML,"post_likelihood","") %></div></td>
</tr>
-->
</table>


</body>
</html>
