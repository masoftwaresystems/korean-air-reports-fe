<!--#include file="showVars.inc"-->
<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/commonUtils.inc" -->

<!--#include file="includes/dbcommon_asap.inc"-->
<%
log_number			= request("log_number")
log_numberStr		= string(4-len(log_number),"0")&log_number

viewDivision			= request("viewDivision")
%>
<%
sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and logNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' and division = "& sqltext2(viewDivision) &" order by logNumber desc, recid desc"
'response.write(sql)
'response.end
set rs        = conn_asap.execute(sql)
set oXML2     = CreateObject("Microsoft.XMLDOM")
oXML2.async   = false
if not rs.eof then
  loginID       = rs("loginID")
  createDate    = rs("createDate")
  formDataXML2  = rs("formDataXML")
  recid         = rs("recid")

  oXML2.loadXML(formDataXML2)

  item_title          = selectNode(oXML2,"item_title","")
  item_number         = selectNode(oXML2,"item_number","")
  item_description    = rev_xdata2(selectNode(oXML2,"item_description",""))
  accountable_leader  = rev_xdata2(selectNode(oXML2,"accountable_leader",""))
  source              = rev_xdata2(selectNode(oXML2,"source",""))
  date_opened         = selectNode(oXML2,"date_opened","")
  date_due            = selectNode(oXML2,"date_due","")
  date_completed      = selectNode(oXML2,"date_completed","")
  item_status         = selectNode(oXML2,"item_status","")
  item_status2				= selectNode(oXML2,"item_status2","")
  endorsed				= selectNode(oXML2,"endorsed","")

  hazard_base         = selectNode(oXML2,"hazard_base","")
  hazard_type         = selectNode(oXML2,"hazard_type","")
  hazard_number         = selectNode(oXML2,"hazard_number","")

  hazard_title         = selectNode(oXML2,"hazard_title","")
  station         = selectNode(oXML2,"station","")
  source         = selectNode(oXML2,"source","")
  divsion         = selectNode(oXML2,"divsion","")
  hazard_owner         = selectNode(oXML2,"hazard_owner","")

  hazard_number = string(4-len(hazard_number),"0") & hazard_number
  hazard_id = viewDivision &"-"& hazard_number

  soi   = selectNode(oXML2,"soi","")
  hl   = selectNode(oXML2,"hl","")
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
end if

if(isnumeric(hazard_owner)) then
sql = "select first_name, last_name from tbl_logins where loginid = "& sqlnum(hazard_owner)
set tmprs = conn_asap.execute(sql)
if not tmprs.eof then
  accountable_leaderStr = tmprs("first_name") &" "& tmprs("last_name")
end if
end if
%>
<!--
<%= oXML2.xml %>
-->
<!--
<%= oXML.xml %>
-->
	<section id="secondary_bar">
<!--#include file="includes/logged_in_user.inc"-->

		<div class="breadcrumbs_container">
			<article class="breadcrumbs"><a href="http://www.masoftwaresystems.us/miat/splash.aspx">Action Log</a> <div class="breadcrumb_divider"></div> <a class="current">Hazard Summary</a></article>
		</div>
	</section><!-- end of secondary bar -->

<!--#include file="includes/sms_header3.inc"-->
<br/><br/>

<article class="module width_full">
<div class="module_content">
<h3>Hazard ID <%= hazard_id %></h3>

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

<div style="padding-left:80px;">

<table cellspacing="0" cellpadding="0" width="100%" border="0">
<tr valign="top" style="padding-top:3px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Hazard ID :</span></td>
<% if((request("framed") = "y") and (proceed = "y")) then %>
<%
isLocked = isLogLocked(request("log_number"),viewDivision)
if(isLocked = "n") then
  clickloc = "window.parent.location.href='divisional_LogInput2.aspx?position=&log_number="& request("log_number") &"&viewDivision="& viewDivision &"'"
else
  clickloc = "alert('Hazard locked by "& isLocked &"')"
end if
%>
  <td width="<%= cell2width %>"><span style="font-weight:bold;"><a href="javascript:<%= clickloc %>"><%= hazard_id %></a></span></td>
<% else %>
  <td width="<%= cell2width %>"><span style="font-weight:bold;"><%= hazard_id %></span></td>
<% end if %>
</tr>
<!--
<tr valign="top" style="padding-top:3px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Internal Log Number :</span></td>
<% if((request("framed") = "y") and (proceed = "y")) then %>
<%
isLocked = isLogLocked(request("log_number"),viewDivision)
if(isLocked = "n") then
  clickloc = "window.parent.location.href='divisional_LogInput2.aspx?position=&log_number="& request("log_number") &"&viewDivision="& viewDivision &"'"
else
  clickloc = "alert('"& division & log_numberStr &" locked by "& isLocked &"')"
end if
%>
  <td width="<%= cell2width %>"><span style="font-weight:bold;"><a href="javascript:<%= clickloc %>"><%= viewDivision %><%= log_numberStr %></a></span></td>
<% else %>
  <td width="<%= cell2width %>"><span style="font-weight:bold;"><%= viewDivision %><%= log_numberStr %></span></td>
<% end if %>
</tr>
-->
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

    'sql = "select division, divisionalLogNumber from EHD_Data where srtLogNumber = "& sqlnum(srtLogNumber) &" and active = 'y' and formname = 'iSRT_LogInput' and archived = 'n' and division <> 'EH:DIV' order by division asc, 'divisionalLogNumber asc"
    'set rs5 = conn_asap.execute(sql)
    'do while not rs5.eof
    '  srtdivision				= rs5("division")
    '  srtdivisionalLogNumber	= rs5("divisionalLogNumber")
    '  if((srtdivisionalLogNumber <> log_number) and (srtdivision <> viewDivision)) then
    '    srtlinksStr = srtlinksStr &"<a href='divisional_LogInput2.aspx?log_number="& srtdivisionalLogNumber &"&viewDivision="& srtdivision &"'>"& srtdivision & string(4-len(srtdivisionalLogNumber),"0")&srtdivisionalLogNumber &"</a><br>"
    '  end if

    '  rs5.movenext
    'loop
    srtlinksStr = rtrim(srtlinksStr)
  end if
%><%= srtlinksStr %>
  </span></td>
</tr>
-->
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Title :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= hazard_title %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Description :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= item_description %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Comments :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= item_comments %></span></td>
</tr>
<% if(equipment <> "") then %>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Aircraft :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= equipment %></span></td>
</tr>
<% end if %>
<% if(mission <> "") then %>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Mission :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= mission %></span></td>
</tr>
<% end if %>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Hazard Owner :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= accountable_leaderStr %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Hazard Editor :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= hazard_editor %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Division :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= divsion %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Station :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= station %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Source :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= source %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">SOI :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= transSOI(soi) %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Date Opened :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= date_openedStr %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Date Due :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= date_dueStr %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Date Completed :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= date_completedStr %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Endorsed :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= transFlag(endorsed) %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Endorsed By :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= endorsed_by %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Next Review Date :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= next_review_dateStr %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">ALARP Statement :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= alarp_statement %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Status :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= item_status %></span></td>
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
<a href="divisional_LogInput2.aspx?log_number=<%= lrs("secondary_log_number") %>&viewDivision=<%= viewDivision %>"><%= tmp_division %><%= tmp_secondarylognumber %></a><br>
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
"select a.division, a.lognumber, b.file_name, b.recid, b.attach_size "& _
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
  asize				= ars("attach_size")
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
  <td width="<%= cell2width %>"><div style="font-weight:normal;"></div></td>
</tr>
<%
for a = 1 to safety_action_cnt
  safety_action_nbr				= selectNode(oXML,"safety_action_nbr_"& a,"")
  safety_action					= rev_xdata2(selectNode(oXML,"safety_action_"& a,""))
  safety_action_poc				= rev_xdata2(selectNode(oXML,"safety_action_poc_"& a,""))
  safety_action_poc_email		= rev_xdata2(selectNode(oXML,"safety_action_poc_email_"& a,""))
  safety_action_open			= selectNode(oXML,"safety_action_open_"& a,"")
  safety_action_due				= selectNode(oXML,"safety_action_due_"& a,"")
  safety_action_completed		= selectNode(oXML,"safety_action_completed_"& a,"")
  safety_action_status			= selectNode(oXML,"safety_action_status_"& a,"")
  safety_action_poc2			= selectNode(oXML,"safety_action_poc2_"& a,"")
  safety_action_type			= selectNode(oXML,"safety_action_type_"& a,"")
  safety_action_other_name			= selectNode(oXML,"safety_action_other_name_"& a,"")
  safety_action_other_email			= selectNode(oXML,"safety_action_other_email_"& a,"")


  if(safety_action_poc <> "") then
    if(safety_action_poc = "Other") then
      safety_action_poc_name = safety_action_other_name
    else
      sql = "select first_name, last_name from Tbl_Logins where loginID = "& sqlnum(safety_action_poc)
      set emprs = conn_asap.execute(sql)
      if not emprs.eof then
        'safety_action_poc_name = left(emprs("first_name"),1) &"&nbsp;"& emprs("last_name")
        safety_action_poc_name = emprs("first_name") &"&nbsp;"& emprs("last_name")
      end if
    end if
  end if
%>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Action Item Number :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= viewdivision %><%= log_numberStr %>.<%= a %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Action Type :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= safety_action_type %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Activity :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= rev_xdata2(safety_action) %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Action Owner :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= safety_action_poc_name %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Opened :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= safety_action_open %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Due :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= safety_action_due %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Completed :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= safety_action_completed %></span></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Status :</span></td>
  <td width="<%= cell2width %>"><span decode style="font-weight:normal;"><%= safety_action_status %></span></td>
</tr>
<%
next
%>

<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold;">Risk</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"></div></td>
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
<div style="font-weight:normal;margin-bottom:6px;"><% if(selectNode(oXML,"factors_type_"& a,"") <> "") then %><span decode style="width:75px;"><%= selectNode(oXML,"factors_type_"& a,"") %> :: </span><% end if %><span  decode><%= selectNode(oXML,"factors_"& a,"") %></span></div>
<% next %>
  </td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Consequences :</span></td>
  <td width="<%= cell2width %>">
<% for a = 1 to cint(selectNode(oXML,"consequences_cnt","0")) %>
<div style="font-weight:normal;padding-bottom:6px;"><span  decode><%= rev_xdata2(selectNode(oXML,"consequences_"& a,"")) %></span></div>
<% next %>
  </td>
</tr>
<!--
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Active Errors :</span></td>
  <td width="<%= cell2width %>">
<% for a = 1 to cint(selectNode(oXML,"active_errors_cnt","0")) %>
<div style="font-weight:normal;"><%= selectNode(oXML,"active_error_"& a,"") %></div>
<% next %>
  </td>
</tr>
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
  <td width="<%= cell2width %>"><div style="font-weight:normal;"></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Current Measures to reduce the risk :</span></td>
  <td width="<%= cell2width %>">
<% for a = 1 to cint(selectNode(oXML,"current_measures_cnt","0")) %>
<div style="font-weight:normal;"><span  decode><%= selectNode(oXML,"current_measures_"& a,"") %></span></div>
<% next %>
  </td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Responsible Team :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><span  decode><%= selectNode(oXML,"current_measures_responsible_person","") %></span></div></td>
</tr>
<%
tmprisk_value_pre_mitigation = selectNode(oXML,"risk_value_pre_mitigation","")
tmpcolor = ""
if(tmprisk_value_pre_mitigation = "Acceptable") then
  tmpcolor = "#336600"
end if
if(URLDecode(tmprisk_value_pre_mitigation) = "Acceptable With Mitigation") then
  tmpcolor = "#ffcc00"
end if
if(tmprisk_value_pre_mitigation = "Unacceptable") then
  tmpcolor = "#8a0808"
end if
%>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold; COLOR: #000080;">Risk Value (Pre-mitigation) :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold; COLOR: <%= tmpcolor %>;"><span  decode><%= selectNode(oXML,"risk_value_pre_mitigation","") %></span></div></td>
</tr>
<%
pre_likelihood = ""
if(URLDecode(selectNode(oXML,"pre_likelihood","")) = "Unknown But Possible In The Aviation Industry") then
  pre_likelihood = "A"
end if
if(URLDecode(selectNode(oXML,"pre_likelihood","")) = "Known In The Avaition Industry") then
  pre_likelihood = "B"
end if
if(URLDecode(selectNode(oXML,"pre_likelihood","")) = "Occurred In The Company") then
  pre_likelihood = "C"
end if
if(URLDecode(selectNode(oXML,"pre_likelihood","")) = "Reported More Than Three Times Per Year Within The Company") then
  pre_likelihood = "D"
end if
if(URLDecode(selectNode(oXML,"pre_likelihood","")) = "Reported More Than Three Times Per Year At A Particular Location") then
  pre_likelihood = "E"
end if

pre_physical_injury = ""
pre_damage_to_the_environment = ""
pre_damage_to_assets = ""
pre_potential_increased_cost = ""
pre_damage_to_corporate_reputation = ""
pre_damage_to_corporate_reputation2 = ""

if(URLDecode(selectNode(oXML,"pre_physical_injury","")) = "No Injury") then
  pre_physical_injury = "Negligible"
end if
if(URLDecode(selectNode(oXML,"pre_damage_to_the_environment","")) = "No Effect") then
  pre_damage_to_the_environment = "Negligible"
end if
if(URLDecode(selectNode(oXML,"pre_damage_to_assets","")) = "No Damage") then
  pre_damage_to_assets = "Negligible"
end if
if(URLDecode(selectNode(oXML,"pre_potential_increased_cost","")) = "No Increased Cost or Lost Revenue") then
  pre_potential_increased_cost = "Negligible"
end if
if(URLDecode(selectNode(oXML,"pre_damage_to_corporate_reputation","")) = "No Implication") then
  pre_damage_to_corporate_reputation = "Negligible"
end if
if(URLDecode(selectNode(oXML,"pre_damage_to_corporate_reputation2","")) = "No Implication") then
  pre_damage_to_corporate_reputation2 = "Negligible"
end if

if(URLDecode(selectNode(oXML,"pre_physical_injury","")) = "Minor Injury") then
  pre_physical_injury = "Minor"
end if
if(URLDecode(selectNode(oXML,"pre_damage_to_the_environment","")) = "Minor Effect") then
  pre_damage_to_the_environment = "Minor"
end if
if(URLDecode(selectNode(oXML,"pre_damage_to_assets","")) = "Minor Damage &lt;US $50K") then
  pre_damage_to_assets = "Minor"
end if
if(URLDecode(selectNode(oXML,"pre_potential_increased_cost","")) = "Minor Loss &lt;US $50K") then
  pre_potential_increased_cost = "Minor"
end if
if(URLDecode(selectNode(oXML,"pre_damage_to_corporate_reputation","")) = "Limited Localized Implication") then
  pre_damage_to_corporate_reputation = "Minor"
end if
if(URLDecode(selectNode(oXML,"pre_damage_to_corporate_reputation2","")) = "Limited Localized Implication") then
  pre_damage_to_corporate_reputation2 = "Minor"
end if

if(URLDecode(selectNode(oXML,"pre_physical_injury","")) = "Serious Injury") then
  pre_physical_injury = "Substantial"
end if
if(URLDecode(selectNode(oXML,"pre_damage_to_the_environment","")) = "Contained Effect") then
  pre_damage_to_the_environment = "Substantial"
end if
if(selectNode(oXML,"pre_damage_to_assets","") = "Substantial+Damage+%3CUS+%24250K") then
  pre_damage_to_assets = "Substantial"
end if
if(URLDecode(selectNode(oXML,"pre_potential_increased_cost","")) = "Substantial Loss &lt;US $250K") then
  pre_potential_increased_cost = "Substantial"
end if
if(URLDecode(selectNode(oXML,"pre_damage_to_corporate_reputation","")) = "Regional Implication") then
  pre_damage_to_corporate_reputation = "Substantial"
end if
if(URLDecode(selectNode(oXML,"pre_damage_to_corporate_reputation2","")) = "Regional Implication") then
  pre_damage_to_corporate_reputation2 = "Substantial"
end if

if(URLDecode(selectNode(oXML,"pre_physical_injury","")) = "Single Fatality") then
  pre_physical_injury = "Major"
end if
if(URLDecode(selectNode(oXML,"pre_damage_to_the_environment","")) = "Minor Effect") then
  pre_damage_to_the_environment = "Major"
end if
if(URLDecode(selectNode(oXML,"pre_damage_to_assets","")) = "Major Damage &lt;US $1M") then
  pre_damage_to_assets = "Major"
end if
if(URLDecode(selectNode(oXML,"pre_potential_increased_cost","")) = "Major Loss &lt;US $1M") then
  pre_potential_increased_cost = "Major"
end if
if(URLDecode(selectNode(oXML,"pre_damage_to_corporate_reputation","")) = "National Implication") then
  pre_damage_to_corporate_reputation = "Major"
end if
if(URLDecode(selectNode(oXML,"pre_damage_to_corporate_reputation2","")) = "National Implication") then
  pre_damage_to_corporate_reputation2 = "Major"
end if

if(URLDecode(selectNode(oXML,"pre_physical_injury","")) = "Multiple Fatalities") then
  pre_physical_injury = "Catastrophic"
end if
if(URLDecode(selectNode(oXML,"pre_damage_to_the_environment","")) = "Massive Effect") then
  pre_damage_to_the_environment = "Catastrophic"
end if
if(URLDecode(selectNode(oXML,"pre_damage_to_assets","")) = "Catastrophic Damage &ge;US $1M") then
  pre_damage_to_assets = "Catastrophic"
end if
if(URLDecode(selectNode(oXML,"pre_potential_increased_cost","")) = "Massive Loss &ge;US $1M") then
  pre_potential_increased_cost = "Catastrophic"
end if
if(URLDecode(selectNode(oXML,"pre_damage_to_corporate_reputation","")) = "International Implication") then
  pre_damage_to_corporate_reputation = "Catastrophic"
end if
if(URLDecode(selectNode(oXML,"pre_damage_to_corporate_reputation2","")) = "International Implication") then
  pre_damage_to_corporate_reputation2 = "Catastrophic"
end if

%>
<% if(selectNode(oXML,"risk_value_pre_mitigation","") <> "") then %>
<%
tmpSeverity = 0
tmpRiskLevel = 0
if(selectNode(oXML,"pre_physical_injury_rating","0") >= tmpRiskLevel) then
  tmpSeverity = 1
  tmpRiskLevel = selectNode(oXML,"pre_physical_injury_rating","0")
end if
if(selectNode(oXML,"pre_damage_to_the_environment_rating","0") >= tmpRiskLevel) then
  tmpSeverity = 2
  tmpRiskLevel = selectNode(oXML,"pre_damage_to_the_environment_rating","0")
end if
if(selectNode(oXML,"pre_damage_to_assets_rating","0") >= tmpRiskLevel) then
  tmpSeverity = 3
  tmpRiskLevel = selectNode(oXML,"pre_damage_to_assets_rating","0")
end if
if(selectNode(oXML,"pre_potential_increased_cost_rating","0") >= tmpRiskLevel) then
  tmpSeverity = 4
  tmpRiskLevel = selectNode(oXML,"pre_potential_increased_cost_rating","0")
end if
if(selectNode(oXML,"pre_damage_to_corporate_reputation_rating","0") >= tmpRiskLevel) then
  tmpSeverity = 5
  tmpRiskLevel = selectNode(oXML,"pre_damage_to_corporate_reputation_rating","0")
end if
if(selectNode(oXML,"pre_damage_to_corporate_reputation2_rating","0") >= tmpRiskLevel) then
  tmpSeverity = 6
  tmpRiskLevel = selectNode(oXML,"pre_damage_to_corporate_reputation2_rating","0")
end if

if(tmpRiskLevel = "0") then
  tmpRiskLevel = "Negligible"
end if
if(tmpRiskLevel = "1") then
  tmpRiskLevel = "Minor"
end if
if(tmpRiskLevel = "2") then
  tmpRiskLevel = "Substantial"
end if
if(tmpRiskLevel = "3") then
  tmpRiskLevel = "Major"
end if
if(tmpRiskLevel = "4") then
  tmpRiskLevel = "Catastrophic"
end if
%>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold; COLOR: #000080;"></span></td>
  <td width="<%= cell2width %>" valign="top">
  <table width="200" cellpadding="0" cellspacing="1" border="0" bgcolor="black">
    <tr>
      <td width="50%" align="center" bgcolor="white"><span style="font-weight:normal;">Severity</span></td>
      <td width="50%" align="center" bgcolor="white"><span style="font-weight:normal;">Probability Level</span></td>
    </tr>
    <tr>
      <td width="50%" align="center" bgcolor="white"><span style="font-weight:normal;"><%= tmpRiskLevel %></span></td>
      <td width="50%" align="center" bgcolor="white"><span decode style="font-weight:normal;"><%= URLDecode(selectNode(oXML,"pre_likelihood","")) %></span></td>
    </tr>
  </table>
  </td>
</tr>
<% end if %>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Physical Injury :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><span  decode><%= pre_physical_injury %></span></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">A/C or Equipment Damage :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><span  decode><%= pre_damage_to_the_environment %></span></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Potential Increased Cost or Revenue Loss :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><span  decode><%= pre_damage_to_assets %></span></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Security Threat :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><span  decode><%= pre_potential_increased_cost %></span></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Regulatory Compliance :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><span  decode><%= pre_damage_to_corporate_reputation %></span></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to the Environment :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><span  decode><%= pre_damage_to_corporate_reputation2 %></span></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Probability Level :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><span  decode><%= URLDecode(selectNode(oXML,"pre_likelihood","")) %></span></div></td>
</tr>
<tr valign="top" style="padding-top:15px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold;">Risk Matrix (Post-mitigation)</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Corrective/Proactive Actions to Mitigate the Risk :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;">
<% for a = 1 to cint(selectNode(oXML,"corrective_actions_cnt","0")) %>
<div style="font-weight:normal;"><% if(selectNode(oXML,"corrective_action_item_"& a,"") <> "") then %><span decode style="width:75px;">(<%= selectNode(oXML,"corrective_action_item_"& a,"") %>)</span><% end if %><span decode><%= selectNode(oXML,"corrective_action_"& a,"") %></span></div>
<% next %>
  </div></td>
</tr>
<!--
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Unintended Consequences :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><span decode><%= selectNode(oXML,"unintended_consequences","") %></span></div></td>
</tr>
-->
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Responsible Team :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><span decode><%= selectNode(oXML,"corrective_actions_responsible_person","") %></span></div></td>
</tr>
<%
tmprisk_value_post_mitigation = selectNode(oXML,"risk_value_post_mitigation","")
tmpcolor = ""
if(tmprisk_value_post_mitigation = "Acceptable") then
  tmpcolor = "#336600"
end if
if(URLDecode(tmprisk_value_post_mitigation) = "Acceptable With Mitigation") then
  tmpcolor = "#ffcc00"
end if
if(tmprisk_value_post_mitigation = "Unacceptable") then
  tmpcolor = "#8a0808"
end if
%>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold; COLOR: #000080;">Risk Value (Post-mitigation) :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:bold; COLOR: <%= tmpcolor %>;"><%= selectNode(oXML,"risk_value_post_mitigation","") %></div></td>
</tr>
<%
post_likelihood = ""
if(URLDecode(selectNode(oXML,"post_likelihood","")) = "Unknown But Possible In The Aviation Industry") then
  post_likelihood = "A"
end if
if(URLDecode(selectNode(oXML,"post_likelihood","")) = "Known In The Avaition Industry") then
  post_likelihood = "B"
end if
if(URLDecode(selectNode(oXML,"post_likelihood","")) = "Occurred In The Company") then
  post_likelihood = "C"
end if
if(URLDecode(selectNode(oXML,"post_likelihood","")) = "Reported More Than Three Times Per Year Within The Company") then
  post_likelihood = "D"
end if
if(URLDecode(selectNode(oXML,"post_likelihood","")) = "Reported More Than Three Times Per Year At A Particular Location") then
  post_likelihood = "E"
end if

post_physical_injury = ""
post_damage_to_the_environment = ""
post_damage_to_assets = ""
post_potential_increased_cost = ""
post_damage_to_corporate_reputation = ""
post_damage_to_corporate_reputation2 = ""

if(URLDecode(selectNode(oXML,"post_physical_injury","")) = "No Injury") then
  post_physical_injury = "Negligible"
end if
if(URLDecode(selectNode(oXML,"post_damage_to_the_environment","")) = "No Effect") then
  post_damage_to_the_environment = "Negligible"
end if
if(URLDecode(selectNode(oXML,"post_damage_to_assets","")) = "No Damage") then
  post_damage_to_assets = "Negligible"
end if
if(URLDecode(selectNode(oXML,"post_potential_increased_cost","")) = "No Increased Cost or Lost Revenue") then
  post_potential_increased_cost = "Negligible"
end if
if(URLDecode(selectNode(oXML,"post_damage_to_corporate_reputation","")) = "No Implication") then
  post_damage_to_corporate_reputation = "Negligible"
end if
if(URLDecode(selectNode(oXML,"post_damage_to_corporate_reputation2","")) = "No Implication") then
  post_damage_to_corporate_reputation2 = "Negligible"
end if

if(URLDecode(selectNode(oXML,"post_physical_injury","")) = "Minor Injury") then
  post_physical_injury = "Minor"
end if
if(URLDecode(selectNode(oXML,"post_damage_to_the_environment","")) = "Minor Effect") then
  post_damage_to_the_environment = "Minor"
end if
if(URLDecode(selectNode(oXML,"post_damage_to_assets","")) = "Minor Damage &lt;US $50K") then
  post_damage_to_assets = "Minor"
end if
if(URLDecode(selectNode(oXML,"post_potential_increased_cost","")) = "Minor Loss &lt;US $50K") then
  post_potential_increased_cost = "Minor"
end if
if(URLDecode(selectNode(oXML,"post_damage_to_corporate_reputation","")) = "Limited Localized Implication") then
  post_damage_to_corporate_reputation = "Minor"
end if
if(URLDecode(selectNode(oXML,"post_damage_to_corporate_reputation2","")) = "Limited Localized Implication") then
  post_damage_to_corporate_reputation2 = "Minor"
end if

if(URLDecode(selectNode(oXML,"post_physical_injury","")) = "Serious Injury") then
  post_physical_injury = "Substantial"
end if
if(URLDecode(selectNode(oXML,"post_damage_to_the_environment","")) = "Contained Effect") then
  post_damage_to_the_environment = "Substantial"
end if
if(URLDecode(selectNode(oXML,"post_damage_to_assets","")) = "Substantial Damage &lt;US $250K") then
  post_damage_to_assets = "Substantial"
end if
if(URLDecode(selectNode(oXML,"post_potential_increased_cost","")) = "Substantial Loss &lt;US $250K") then
  post_potential_increased_cost = "Substantial"
end if
if(URLDecode(selectNode(oXML,"post_damage_to_corporate_reputation","")) = "Regional Implication") then
  post_damage_to_corporate_reputation = "Substantial"
end if
if(URLDecode(selectNode(oXML,"post_damage_to_corporate_reputation2","")) = "Regional Implication") then
  post_damage_to_corporate_reputation2 = "Substantial"
end if

if(URLDecode(selectNode(oXML,"post_physical_injury","")) = "Single Fatality") then
  post_physical_injury = "Major"
end if
if(URLDecode(selectNode(oXML,"post_damage_to_the_environment","")) = "Minor Effect") then
  post_damage_to_the_environment = "Major"
end if
if(URLDecode(selectNode(oXML,"post_damage_to_assets","")) = "Major Damage &lt;US $1M") then
  post_damage_to_assets = "Major"
end if
if(URLDecode(selectNode(oXML,"post_potential_increased_cost","")) = "Major Loss &lt;US $1M") then
  post_potential_increased_cost = "Major"
end if
if(URLDecode(selectNode(oXML,"post_damage_to_corporate_reputation","")) = "National Implication") then
  post_damage_to_corporate_reputation = "Major"
end if
if(URLDecode(selectNode(oXML,"post_damage_to_corporate_reputation2","")) = "National Implication") then
  post_damage_to_corporate_reputation2 = "Major"
end if

if(URLDecode(selectNode(oXML,"post_physical_injury","")) = "Multiple Fatalities") then
  post_physical_injury = "Catastrophic"
end if
if(URLDecode(selectNode(oXML,"post_damage_to_the_environment","")) = "Massive Effect") then
  post_damage_to_the_environment = "Catastrophic"
end if
if(URLDecode(selectNode(oXML,"post_damage_to_assets","")) = "Catastrophic Damage &ge;US $1M") then
  post_damage_to_assets = "Catastrophic"
end if
if(URLDecode(selectNode(oXML,"post_potential_increased_cost","")) = "Massive Loss &ge;US $1M") then
  post_potential_increased_cost = "Catastrophic"
end if
if(URLDecode(selectNode(oXML,"post_damage_to_corporate_reputation","")) = "International Implication") then
  post_damage_to_corporate_reputation = "Catastrophic"
end if
if(URLDecode(selectNode(oXML,"post_damage_to_corporate_reputation2","")) = "International Implication") then
  post_damage_to_corporate_reputation2 = "Catastrophic"
end if

%>
<% if(selectNode(oXML,"risk_value_post_mitigation","") <> "") then %>
<%
tmpSeverity = 0
tmpRiskLevel = 0
if(selectNode(oXML,"post_physical_injury_rating","0") >= tmpRiskLevel) then
  tmpSeverity = 1
  tmpRiskLevel = selectNode(oXML,"post_physical_injury_rating","0")
end if
if(selectNode(oXML,"post_damage_to_the_environment_rating","0") >= tmpRiskLevel) then
  tmpSeverity = 2
  tmpRiskLevel = selectNode(oXML,"post_damage_to_the_environment_rating","0")
end if
if(selectNode(oXML,"post_damage_to_assets_rating","0") >= tmpRiskLevel) then
  tmpSeverity = 3
  tmpRiskLevel = selectNode(oXML,"post_damage_to_assets_rating","0")
end if
if(selectNode(oXML,"post_potential_increased_cost_rating","0") >= tmpRiskLevel) then
  tmpSeverity = 4
  tmpRiskLevel = selectNode(oXML,"post_potential_increased_cost_rating","0")
end if
if(selectNode(oXML,"post_damage_to_corporate_reputation_rating","0") >= tmpRiskLevel) then
  tmpSeverity = 5
  tmpRiskLevel = selectNode(oXML,"post_damage_to_corporate_reputation_rating","0")
end if
if(selectNode(oXML,"post_damage_to_corporate_reputation2_rating","0") >= tmpRiskLevel) then
  tmpSeverity = 6
  tmpRiskLevel = selectNode(oXML,"post_damage_to_corporate_reputation2_rating","0")
end if

if(tmpRiskLevel = "0") then
  tmpRiskLevel = "Negligible"
end if
if(tmpRiskLevel = "1") then
  tmpRiskLevel = "Minor"
end if
if(tmpRiskLevel = "2") then
  tmpRiskLevel = "Substantial"
end if
if(tmpRiskLevel = "3") then
  tmpRiskLevel = "Major"
end if
if(tmpRiskLevel = "4") then
  tmpRiskLevel = "Catastrophic"
end if
%>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:bold; COLOR: #000080;"></span></td>
  <td width="<%= cell2width %>" valign="top">
  <table width="200" cellpadding="0" cellspacing="1" border="0" bgcolor="black">
    <tr>
      <td width="50%" align="center" bgcolor="white"><span style="font-weight:normal;">Severity</span></td>
      <td width="50%" align="center" bgcolor="white"><span style="font-weight:normal;">Probability Level</span></td>
    </tr>
    <tr>
      <td width="50%" align="center" bgcolor="white"><span style="font-weight:normal;"><%= tmpRiskLevel %></span></td>
      <td width="50%" align="center" bgcolor="white"><span style="font-weight:normal;"><%= URLDecode(selectNode(oXML,"post_likelihood","")) %></span></td>
    </tr>
  </table>
  </td>
</tr>
<% end if %>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Physical Injury :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><span decode><%= post_physical_injury %></span></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">A/C or Equipment Damage :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><span decode><%= post_damage_to_the_environment %></span></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Potential Increased Cost or Revenue Loss :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><span decode><%= post_damage_to_assets %></span></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Security Threat :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><span decode><%= post_potential_increased_cost %></span></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Regulatory Compliance :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><span decode><%= post_damage_to_corporate_reputation %></span></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Damage to the Environment :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><span decode><%= post_damage_to_corporate_reputation2 %></span></div></td>
</tr>
<tr valign="top" style="padding-top:7px;">
  <td width="<%= cell1width %>" align="right" style="padding-right:5px;"><span style="font-weight:normal;">Probability Level :</span></td>
  <td width="<%= cell2width %>"><div style="font-weight:normal;"><span decode><%= URLDecode(selectNode(oXML,"post_likelihood","")) %></span></div></td>
</tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:25px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pblack.gif" width="400" height="1"></td></tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="margin-top:15px;margin-left:10px;" bgColor="white" >
  <tr>
    <td width="100%" align="center">
    <%
    if(viewDivision = "EH:DIV") then
      viewPage = "admin"
    else
      viewPage = "divisional"
    end if
    %>
    <% if((request("cookie_editDivision") = "y") or (request("cookie_administrator") = "y")) then %>
            <input type="button" value="Return To Log Input" style="font-size:10px;width:160px;margin-top:5px;margin-left:0px;" onclick="document.location='divisional_LogInput2.aspx?log_number=<%= log_number %>&viewDivision=<%= viewDivision %>'">
    <% end if %>
            <input type="button" value="Return To Short Listing" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-top:3px;" onclick="document.location='divisional_base.aspx?viewdivision=<%= viewdivision %>'">
    </td>
  </tr>
  <tr>
    <td width="100%" align="center" height="50"></td>
  </tr>
</table>

</div>

    </div>
    </article>
<p></p>