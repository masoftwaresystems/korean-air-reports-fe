<%
'###############################################
'# admin_LogInput.asp
'#
'# Shows the details of an iSRT log item, or allows for the creation of a new iSRT log item
'#
%>
<% ' vi: set foldmethod=marker syn=aspvbs linebreak softtabstop=2 tabstop=2 shiftwidth=2 expandtab: %>
<!--#include file="includes/security.inc" -->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include virtual="/ASPSpellCheck/ASPSpellInclude.inc"-->
<% ' {{{ Initial Requests
unlockLogs
position        = request("position")
viewDivision    = request("viewDivision")
if(len(viewDivision) = 0) then
  viewDivision  = "iSRT"
end if
if(isLogLocked(request("log_number"),"EH:DIV") <> "n") then
  response.redirect("admin_LogDisplay.asp")
  response.end
end if
%>
<%
'###############################################
'# Get new log number if creating new iSRT log
'#
%>
<%
lockLog request("log_number"),"iSRT"
log_number = request("log_number")
if(log_number = "") then
  sql = "select max(srtLogNumber) srtLogNumber from EHD_Data where division = 'iSRT' and divisionalLogNumber is null and active = 'y' and archived = 'n' and formName = 'iSRT_LogInput'"
  set tmprs=conn_asap.execute(sql)
  if not tmprs.eof then
    log_number = cint(tmprs("srtLogNumber"))
  else
    log_number = 0
  end if
  log_number = log_number +1
end if
log_number      = string(4-len(log_number),"0")&log_number
log_numberStr   = string(4-len(log_number),"0")&log_number
%>
<%
'###############################################
'# Grab iSRT data for existing log into XML object
'#
%>
<%
sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and division = 'iSRT' and divisionalLogNumber is null and archived = 'n' and srtLogNumber = "& sqlnum(log_number) &" and active = 'y'"
set rs=conn_asap.execute(sql)
set oXML                = CreateObject("Microsoft.XMLDOM")
oXML.async              = false
if not rs.eof then
  loginID               = rs("loginID")
  createDate            = rs("createDate")
  formDataXML           = rs("formDataXML")
  recid                 = rs("recid")
  log_number            = string(4-len(log_number),"0")&log_number
  oXML.loadXML(formDataXML)
  safety_action_cnt     = selectNode(oXML,"safety_action_cnt","")
  item_number           = selectNode(oXML,"item_number","")
  item_description      = rev_xdata2(selectNode(oXML,"item_description",""))
  accountable_leader    = rev_xdata2(selectNode(oXML,"accountable_leader",""))
  source                = rev_xdata2(selectNode(oXML,"source",""))
  date_opened           = selectNode(oXML,"date_opened","")
  date_due              = selectNode(oXML,"date_due","")
  date_completed        = selectNode(oXML,"date_completed","")
  item_status           = selectNode(oXML,"item_status","")
end if
if(safety_action_cnt = "") then
  safety_action_cnt     = 0
end if
tmpCnt                  = cint(safety_action_cnt)
sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and division = "& sqltext2(viewDivision) &" and divisionalLogNumber is null and archived = 'n' and active = 'y' and srtLogNumber = "& sqlnum(log_number)
set oXML2               = CreateObject("Microsoft.XMLDOM")
oXML2.async             = false
if not rs.eof then
  loginID               = rs("loginID")
  createDate            = rs("createDate")
  formDataXML           = rs("formDataXML")
  recid                 = rs("recid")
  division              = rs("division")
  log_number            = string(4-len(log_number),"0")&log_number
  srtLogNumber          = rs("srtLogNumber")
  if(len(srtLogNumber) > 0) then
    srtLogNumberStr     = "iSRT"&string(4-len(srtLogNumber),"0")&srtLogNumber
  end if
  oXML2.loadXML(formDataXML)
  safety_action_cnt     = selectNode(oXML2,"safety_action_cnt","")
  item_number           = selectNode(oXML2,"item_number","")
  item_description      = rev_xdata2(selectNode(oXML2,"item_description",""))
  accountable_leader    = rev_xdata2(selectNode(oXML2,"accountable_leader",""))
  source                = rev_xdata2(selectNode(oXML2,"source",""))
  date_opened           = selectNode(oXML2,"date_opened","")
  date_due              = selectNode(oXML2,"date_due","")
  date_completed        = selectNode(oXML2,"date_completed","")
  item_status           = selectNode(oXML2,"item_status","")
end if
if(safety_action_cnt = "") then
  safety_action_cnt     = 0
end if
tmpCnt                  = cint(safety_action_cnt)
' }}} %>
<html>
  <head>
  <!--#include file="includes/commonhead.inc"-->
      <script type="text/javascript">
  <!--#include file="script/admin_input.asp"-->
      </script>
      <script type="text/javascript">
        function init() {
        <% if(request("log_number") = "") then %>
          frm.item_status.value = "Open";
        <% end if %>
        }
      </script>
      <link href="styles/display.css" rel="stylesheet" type="text/css" />
<%
'###############################################
'# Dynamic menu
'#
%>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
<!--#include file="script/nav.js"-->
  </head>
  <body bottomMargin="3" bgColor="#ffffff" leftMargin="3" topMargin="3" rightMargin="3"  onload="init()">
      <div id="headerDiv">
<!--#include file="includes/sms_header.inc"-->
      </div>
    <center>
      <form action="admin_saveData3.asp" method="post" name="frm" id="frm">
        <input type="hidden" id="formname" name="formname" value="iSRT_LogInput">
        <input type="hidden" id="safety_action_cnt" name="safety_action_cnt" value="<%= safety_action_cnt %>">
        <input type="hidden" id="resultPage" name="resultPage" value="admin_LogDisplay.asp">
        <input type="hidden" id="get_max_recid" name="get_max_recid" value="">
        <input type="hidden" id="viewDivision" name="viewDivision" value="<%= viewDivision %>">
        <input type="hidden" id="position" name="position" value="<%= position %>">
        <input type="hidden" id="deleted_item_nbr" name="deleted_item_nbr" value="">
        <input type="hidden" id="deleted_item_division" name="deleted_item_division" value="">
        <table border="0" cellspacing="0" cellpadding="0" width="98%" style="padding-top:0px;padding-bottom:5px;margin-left:0px;">
                  <tr>
                    <td align="center">
                      <span class="fonts4" style="font-size:14px;color:#737579;">
                        <span style="font-weight:bold;color:#000040;">Log Number iSRT<%= log_numberStr %>
                        </span>
                      </span>
                    </td>
                  </tr>
                </table>
        <% ' {{{ table %>
        <table cellSpacing="0" cellPadding="1" width="98%" border="0">
          <tbody id="markerTABLE">
            <tr class="LogHead">
              <td width="19%">Log Nbr.</td>
              <td width="17%">Description</td>
              <td width="8%">Division(s)</td>
              <td width="8%">Divisional Log Nbr.</td>
              <td width="8%">Accountable Leader</td>
              <td width="8%">Source</td>
              <td width="8%">Date Opened <br> mm/dd/yyyy</td>
              <td width="8%">Date Due</td>
              <td width="8%">Date Completed</td>
              <td width="8%">Status</td>
            </tr>
<%
'###############################################
'# iSRT header information
'#
%>
            <tr class="LogNumber">
              <td width="19%">
<% if(session("srt_admin") = "y") then %>
                <input type="button" value="delete" style="font-size:8px;margin-right:5px;margin-left:5px;" onclick="deleteLogNumber()">
<% end if %>
                <span style="font-weight:bold;font-size:9pt;color:#000040;">
                <%= viewDivision %> <input type="text" name="log_number" style="width:50px;"  value="<%= log_number %>" required="false" readonly /></span>
              </td>
              <td width="17%">
                <textarea name="item_description" style="width:230px;" rows="6"><%= item_description %></textarea>
              </td>
<%
'###############################################
'# Build display string for included divisional log numbers
'#
%>
<% ' {{{ Select links
  srtlinksStr       = ""
  assignedDivisions = ""
  divisionOptions   = ""
  optionsCnt        = 0

  sql = "select srtLogNumber from EHD_Data where srtLogNumber = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and active = 'y' and divisionalLogNumber is null and formname = 'iSRT_LogInput' and archived = 'n' order by srtLogNumber asc"
  set rs4 = conn_asap.execute(sql)

  if not rs4.eof then
    srtLogNumber = rs4("srtLogNumber")

    sql = "select division, divisionalLogNumber from EHD_Data where srtLogNumber = "& sqlnum(srtLogNumber) &" and active = 'y' and formname = 'iSRT_LogInput' and archived = 'n' order by division asc, divisionalLogNumber asc"
    set rs5 = conn_asap.execute(sql)

    do while not rs5.eof
      srtdivision               = rs5("division")
      srtdivisionalLogNumber    = rs5("divisionalLogNumber")
      if((srtdivisionalLogNumber <> log_number) and (srtdivision <> viewDivision)) then
        optionsCnt          = optionsCnt +1
        srtlinksStr         = srtlinksStr & "<a href='divisional_logInput.asp?log_number="& srtdivisionalLogNumber &"&viewdivision="& srtdivision &"' target='blank'>" & srtdivision & string(4-len(srtdivisionalLogNumber),"0")&srtdivisionalLogNumber &"</a>" &"<br>"
        assignedDivisions   = assignedDivisions &" "& srtdivision
        if(optionsCnt = 1) then
          divisionOptions   = divisionOptions &"<option value='"& srtdivision &"' selected>"& srtdivision &"</option>"
        else
          divisionOptions   = divisionOptions &"<option value='"& srtdivision &"'>"& srtdivision &"</option>"
        end if
      end if

      rs5.movenext
    loop
    srtlinksStr = rtrim(srtlinksStr)

  end if
' }}} %>
              <td width="8%">
                <select class="input6" name="division" multiple size="6" style="width:60px;" onchange="">
<% if(instr(assignedDivisions,"ACS") = 0) then %>
                  <option value="ACS">ACS</option>
<% end if %>
<% if(instr(assignedDivisions,"CGO") = 0) then %>
                  <option value="CGO">CGO</option>
<% end if %>
<% if(instr(assignedDivisions,"FOP") = 0) then %>
                  <option value="FOP">FOP</option>
<% end if %>
<% if(instr(assignedDivisions,"IFS") = 0) then %>
                  <option value="IFS">IFS</option>
<% end if %>
<% if(instr(assignedDivisions,"OCC") = 0) then %>
                  <option value="OCC">OCC</option>
<% end if %>
<% if(instr(assignedDivisions,"TOP") = 0) then %>
                  <option value="TOP">TOP</option>
<% end if %>
                </select>
              </td>
              <td width="8%"><span style="font-weight:bold;font-size:8pt;color:#000040;">
                <%= srtlinksStr %></span>
              </td>
              <td width="8%">
                <select id="accountable_leader" name="accountable_leader" style="width:90px;" size="6" multiple required="false">
<% ' {{{ Get Employee info
sql = "select * from Tbl_Logins where srt_admin = 'l' order by last_name asc"
set tmprs = conn_asap.execute(sql)
do while not tmprs.eof
  employee_nbr  = tmprs("employee_number")
  first_name    = tmprs("first_name")
  last_name     = tmprs("last_name")

  selected      = ""
  if(obj_exists(oXML.selectSingleNode("//accountable_leader"))) then
    Set NodeList    = oXML.documentElement.selectNodes("//accountable_leader")
    For Each Node In NodeList
      if(Node.text  = employee_nbr) then
        selected    = "selected"
      end if
    Next
  end if
' }}} %>
                  <option value="<%= employee_nbr %>" <%= selected %>><%= left(first_name,1) %>&nbsp;<%= last_name %></option>
<%
  tmprs.movenext
loop
%>
                </select>
              </td>
              <td width="8%">
                <input type="text" name="source" size="30"  style="width:73px;"  value="<%= source %>" required="false" required2 />
              </td>
              <td width="8%">
                <input type="text" name="date_opened" id="date_opened" size="30"  style="width:73px;"  value="<%= date_opened %>" required="false" onblur="if(validateDate(this)){calcDueDate('');}" required2 />
              </td>
              <td width="8%">
                <input type="text" name="date_due" id="date_due" size="30"  style="width:73px;"  value="<%= date_due %>" required="false" required2 onblur="validateDate(this)" />
              </td>
              <td width="8%">
                <input type="text" name="date_completed" size="30"  style="width:73px;"  value="<%= date_completed %>" required="false" onblur="validateDate(this)" />
              </td>
              <td width="8%">
                <select id="item_status" name="item_status" style="width:73px;" required="false">
                  <option value="Open" selected>Open</option>
                  <option value="Closed">Closed</option>
                  <option value="Re-opened">Re-opened</option>
                  <option value="Void">Void</option>
                  <option value="Demoted">Demoted</option>
                  <option value="Not_Accepted">Not Accepted</option>
                </select>
                <script type="text/javascript">
                  document.getElementById("item_status").value = "<%= item_status %>";
                </script>
              </td>
            </tr>
            <tr style="height: 5px">
              <td colspan="10" bgcolor="#ffffff"></td>
            </tr>
<%
'###############################################
'# Log action items
'#
%>
            <tr id="ROWHEADER" class="RowHead" <% if((request("log_number") = "") or (safety_action_cnt = 0)) then %>style="display:none;"<% end if %>>
              <td width="19%">
                &nbsp;
              </td>
              <td width="17%">
                Activity
              </td>
              <td width="8%">
                Division(s)
              </td>
              <td width="8%">
                POC
              </td>
              <td width="8%">
                Opened
              </td>
              <td width="8%">
                Due
              </td>
              <td width="8%">
                Completed
              </td>
              <td>
                Status
              </td>
              <td>
                &nbsp;
              </td>
              <td>
                &nbsp;
              </td>
            </tr>
<%
'###############################################
'# Loop through action items - Grab info from XML object
'#
%>
<% ' {{{ Set Dictionary Fields
dictionaryFields                    = ""
for a = 1 to safety_action_cnt
  safety_action_nbr                 = selectNode(oXML,"safety_action_nbr_"& a,"")
  safety_action_type                = selectNode(oXML,"safety_action_type_"& a,"")
  safety_action                     = rev_xdata2(selectNode(oXML,"safety_action_"& a,""))
  safety_action_division            = rev_xdata2(selectNode(oXML,"safety_action_division_"& a,""))
  safety_action_poc                 = rev_xdata2(selectNode(oXML,"safety_action_poc_"& a,""))
  safety_action_poc2                = rev_xdata2(selectNode(oXML,"safety_action_poc2_"& a,""))
  safety_action_poc_email           = rev_xdata2(selectNode(oXML,"safety_action_poc_email_"& a,""))
  safety_action_open                = selectNode(oXML,"safety_action_open_"& a,"")
  safety_action_due                 = selectNode(oXML,"safety_action_due_"& a,"")
  safety_action_completed           = selectNode(oXML,"safety_action_completed_"& a,"")
  safety_action_status              = selectNode(oXML,"safety_action_status_"& a,"")
  safety_action_assigned_division   = selectNode(oXML,"safety_action_assigned_division_"& a,"")
  safety_action_other_name          = selectNode(oXML,"safety_action_other_name_"& a,"")
  safety_action_other_email         = selectNode(oXML,"safety_action_other_email_"& a,"")

  tmp_division      = safety_action_assigned_division
  if(safety_action_division <> "") then
    tmp_division    = safety_action_division
  end if

  if(safety_action_poc = "Other") then
    otherdisplays   = "block"
  else
    otherdisplays   = "none"
  end if

  dictionaryFields  = dictionaryFields &",safety_action_"& a

' }}} %>
            <tr class="ItemNumber">
              <td width="19%">
                <span style='FONT-WEIGHT: normal; FONT-SIZE: 7pt;  FONT-STYLE: normal; FONT-FAMILY: Arial;'><%= viewDivision %>
                <input type="text" id="safety_action_nbr_<%= a %>" name="safety_action_nbr_<%= a %>" style="width:55px;"  value="<%= log_numberStr %>.<%= a %>" required="false" /><br/><select name="safety_action_type_<%= a %>" style="width:155px;font-size:9pt;" required="false"><option value="">Select Action Type</option><option value="Corrective Action Required">Corrective Action Required</option><option value="Finding">Finding</option><option value="Recommendation">Recommendation</option><option value="Informational">Informational</option><option value='12-Month Follow up'>12-Month Follow up</option></select><script>frm.safety_action_type_<%= a %>.value = "<%= safety_action_type %>";</script><% if(session("srt_admin") = "y") then %><br/><input type="button" value="delete" style="font-size:8px;margin-right:5px;margin-left:5px;" onclick="deleteSafetyAction('<%= a %>')" /><% end if %></span>
              </td>
              <td width="17%">
                <textarea id="safety_action_<%= a %>" name="safety_action_<%= a %>" style="width:230px;" rows="3"><%= safety_action %></textarea>
              </td>
              <td width="8%">
                <%= tmp_division %><br><br><div id="OTHERNAMETITLE_<%= a %>" style="font-weight:bold;font-size:7pt;display:<%= otherdisplays %>;">Other Name</div>
              </td>
              <td width="8%">
<select name="safety_action_poc_<%= a %>" style="width:85px;" required="false" onchange="checkOther(this,'<%= a %>')">
  <option value=""></option>
<%
sql = "select * from Tbl_Logins where srt_admin in ('l','w') and division = "& sqltext2(tmp_division) &"  order by last_name asc"
set tmprs=conn_asap.execute(sql)
do while not tmprs.eof
  employee_nbr  = tmprs("employee_number")
  first_name    = tmprs("first_name")
  last_name     = tmprs("last_name")

  selected      = ""
  if(obj_exists(oXML.selectSingleNode("//safety_action_poc_"& a))) then
    Set NodeList    = oXML.documentElement.selectNodes("//safety_action_poc_"& a)
    For Each Node In NodeList
      if(Node.text  = employee_nbr) then
        selected    = "selected"
      end if
    Next
  end if
%>
  <option value="<%= employee_nbr %>" <%= selected %>><%= left(first_name,1) %>&nbsp;<%= last_name %></option>
<%
  tmprs.movenext
loop
%>
  <option value="Other">Other</option>
</select><div id="OTHERNAME_<%= a %>" style="display:<%= otherdisplays %>;"><input type="text" name="safety_action_other_name_<%= a %>" id="safety_action_other_name_<%= a %>" size="30"  style="width:85px;"  value="<%= safety_action_other_name %>" required="false"  /></div>
                <script>
                  document.getElementById("safety_action_poc_<%= a %>").value = "<%= safety_action_poc %>";
                </script>
              </td>
              <td width="8%">
                <input type="text" name="safety_action_open_<%= a %>" id="safety_action_open_<%= a %>" size="30"  style="width:73px;"  value="<%= safety_action_open %>" required="false" onblur="if(validateDate(this)){calcDueDate('<%= a %>');}" /><div id="OTHEREMAILTITLE_<%= a %>" style="font-weight:bold;font-size:7pt;margin-top:5px;display:<%= otherdisplays %>;">Other Email</div>
              </td>
              <td width="8%">
                <input type="text" name="safety_action_due_<%= a %>" id="safety_action_due_<%= a %>" size="30"  style="width:73px;"  value="<%= safety_action_due %>" required="false" onblur="validateDate(this)" /><div id="OTHEREMAIL_<%= a %>" style="display:<%= otherdisplays %>;"><input type="text" name="safety_action_other_email_<%= a %>" id="safety_action_other_email_<%= a %>" size="30"  style="width:73px;"  value="<%= safety_action_other_email %>" required="false" /></div>
              </td>
              <td width="8%">
                <input type="text" id="safety_action_completed_<%= a %>" name="safety_action_completed_<%= a %>" size="30"  style="width:73px;"  value="<%= safety_action_completed %>" required="false" onblur="validateDate(this)" />
              </td>
              <td width="8%">
                <select id="safety_action_status_<%= a %>" name="safety_action_status_<%= a %>" style="width:73px;" required="false">
                  <option value=""></option>
                  <option value="Open">Open</option>
                  <option value="Closed">Closed</option>
                  <option value="Void">Void</option>
                </select>
                <input type="hidden" name="safety_action_assigned_division_<%= a %>" value="<%= tmp_division %>">
                <script>
                  document.getElementById("safety_action_status_<%= a %>").value = "<%= safety_action_status %>";
                </script>
              </td>
              <td width="8%">
                &nbsp;
              </td>
            </tr>
<% next %>
                    <tr id="markerROW" style="height:1px;"><td style="height:1px;" colSpan="10"></td></tr>
            <tr>
              <td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #000000; FONT-FAMILY: Arial" align="left"  background="" bgColor="ffffff">
                <input  type="button" value="Add Update" style="font-size:10px;width:100px;margin-top:5px;margin-left:10px;" onclick="addRow('markerTABLE','markerROW')">
              </td>
              <td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial;padding-left:25px;" align="left" background="" bgColor="ffffff" colSpan="9">
<%
'###############################################
'# Spell check button
'#
%>
<%
dim myLink
set myLink      = new AspSpellLink
myLink.fields   = "item_description" & dictionaryFields 'Sets the Field id(s) to be spell-checked
response.write myLink.ButtonHTML("Spell Check","buttonclass")' renders an HTML button

set myLink=nothing
%>
              </td>
            </tr>
            <tr>
              <td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="center" background="" bgColor="ffffff" colSpan="10">.
              </td>
            </tr>
          </tbody>
        </table>
        <% ' }}} %>
<%
'###############################################
'# List included divisional log numbers
'#
%>
<% ' {{{ Create XML
set divXML                = CreateObject("Microsoft.XMLDOM")
divXML.async            = false

sql = "select formDataXML, division, divisionalLogNumber from EHD_Data where srtLogNumber = "& sqlnum(srtLogNumber) &" and active = 'y' and formname = 'iSRT_LogInput' and archived = 'n' and divisionalLogNumber is not null order by division asc, divisionalLogNumber asc"
set divrs = conn_asap.execute(sql)
do while not divrs.eof
  tmpformDataXML            = divrs("formDataXML")
  tmpdivision               = divrs("division")
  tmpdivisionalLogNumber    = divrs("divisionalLogNumber")
  tmpdivisionalLogNumberStr = string(4-len(tmpdivisionalLogNumber),"0")&tmpdivisionalLogNumber
  divrs.movenext
loop
' }}} %>
        <table border="0" cellspacing="0" cellpadding="0" width="98%" style="margin-top:20px;margin-bottom:50px;" align="center">
          <tr>
            <td align="center">
              <img src="images/1pgrey.gif" width="98%" height="1" />
            </td>
          </tr>
        </table>
<%
'###############################################
'# List linked iSRT log numbers
'#
%>
<% ' {{{ Select Links
sql = "select * from SRT_Links where primary_log_number = "& sqlnum(log_number) &" and division = 'iSRT' and archived = 'n'"
set lrs = conn_asap.execute(sql)
if not lrs.eof then
' }}} %>
        <div align="left" style="padding-left:5px;">
          <table cellSpacing="0" cellPadding="1" width="470" border="0" style="margin-top:20px;">
            <tbody>
              <tr valign="top">
                <td width="170" align="left">
                  <span style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial">Related Log Numbers :&nbsp;</span>
                </td>
                <td width="300">
                  <div>
                    <table border="0" cellspacing="0" cellpadding="0" width="300">
<% ' {{{
do while not lrs.eof
  tmp_secondarylognumber    = string(4-len(lrs("secondary_log_number")),"0")&lrs("secondary_log_number")
  isLocked                  = isLogLocked(lrs("secondary_log_number"),"EH:DIV")
  if(isLocked   = "n") then
    clickloc    = "iSRT_LogInput.asp?log_number="& lrs("secondary_log_number")
  else
    clickloc    = "javascript:alert('Log "& log_number &" locked\nuser "& isLocked &"')"
  end if
' }}} %>
                      <tr valign="top">
                        <td>
                          <span style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;<a href="<%= clickloc %>">iSRT<%= tmp_secondarylognumber %></a></span>
                        </td>
                      </tr>
<% ' {{{
  lrs.movenext
loop
' }}} %>
                    </table>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
<%
end if
%>
        <div align="left" id="linkDIV" style="display:none;padding-left:5px;margin-top:10px;">
          <table cellSpacing="0" cellPadding="1" width="80%" border="0" style="margin-top:0px;">
            <tbody>
              <tr valign="top">
                <td align="left">
                  <span style="font-weight: bold;">Log Number Links </span>
                </td>
              </tr>
              <tr>
                <td>
                  <div style="border:1px solid black;height:110px;overflow:auto;">
                    <table border="0" cellspacing="5" cellpadding="0" width="98%">
<%
'###############################################
'# Area to link iSRT log numbers
'#
%>
<% ' {{{
set loXML       = CreateObject("Microsoft.XMLDOM")
loXML.async     = false
tmpLogNumber    = ""

sql = "select logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'iSRT_LogInput' and logNumber is not null and archived = 'n' and division = 'iSRT' and active = 'y' order by logNumber desc, recid desc"
set lrs=conn_asap.execute(sql)
do while not lrs.eof

  lformDataXML  = lrs("formDataXML")
  llog_number   = lrs("logNumber")

  loXML.loadXML(lformDataXML)

  litem_description = rev_xdata2(selectNode(loXML,"item_description",""))

  if((tmpLogNumber <> llog_number) and (cint(llog_number) <> cint(log_number))) then
    tmpLogNumber    = llog_number

    llog_number     = string(4-len(llog_number),"0")&llog_number
' }}} %>
                      <tr valign="top" class="Link" style="padding-bottom:10px;">
                        <td width="100">
                          <input type="checkbox" id="links_<%= lrs("logNumber") %>" name="links" value="<%= llog_number %>" />&nbsp;<span style="font-weight:bold;">iSRT<%= llog_number %></span>
                        </td>
                        <td width="100%"><%= litem_description %></td>
                      </tr>
<%
  end if
  lrs.movenext
loop
%>
                    </table>
                  </div>
                </td>
              </tr>
              <tr>
                <td>
                  <input type="button" value="Save Links" style="width:160px;height:20px;margin-top:3px;" onclick="saveLinks()" />
                </td>
              </tr>
            </tbody>
          </table>
        </div>
<%
'###############################################
'# Grab and display attachments
'#
%>
<% ' {{{ Loog through attachments
sql = ""& _
"select a.division, a.lognumber, b.file_name, b.recid, b.attach_size size "& _
"from EHD_Data a, EHD_Attachments b "& _
"where a.srtlognumber = "& sqlnum(log_number) & _
"and a.active = 'y' "& _
"and a.archived = 'n' "& _
"and a.formname = 'iSRT_LogInput' "& _
"and a.division = b.division "& _
"and a.lognumber = b.log_number "& _
"and b.archived = 'n' "& _
"order by division asc"
set ars = conn_asap.execute(sql)
if not ars.eof then
%>
        <div align="left" style="padding-left:5px;">
          <table cellSpacing="0" cellPadding="1" width="470" border="0" style="margin-top:20px;">
            <tbody>
              <tr valign="top">
                <td width="120" align="left">
                  <span style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial;margin-left:20px;">Attachments :&nbsp;</span>
                </td>
                <td width="350">
                  <div>
                    <table border="0" cellspacing="0" cellpadding="0" width="350">
<%
do while not ars.eof
  afile_name        = ars("file_name")
  arecid            = ars("recid")
  adivision         = ars("division")
  asize             = ars("size")
%>
                      <tr valign="top">
                        <td>
                          <span style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial">
                            &nbsp;
                            <a href="retrieveFile3.asp?recid=<%= arecid %>" target="_blank"><%= adivision %>&nbsp;<%= afile_name %></a>
                          </span>
                        </td>
                      </tr>
<%
  ars.movenext
loop
%>
                    </table>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
<%
end if
' }}} %>
<%
'###############################################
'# Action buttons
'#
%>
        <table cellSpacing="0" cellPadding="0" width="98%" border="0" bgcolor="white">
          <tr height="30">
            <td>
              &nbsp;
            </td>
          </tr>
          <tr>
            <td align="center">
              <input type="submit" value="Save" style="font-size:10px;width:165px;font-weight:normal;height:20px;margin-right:3px;" />
              <br />
              <input type="button" value="Add Attachments" style="font-size:10px;width:165px;font-weight:normal;height:20px;margin-top:3px;margin-right:3px;" onclick="goToAttachments()">
              <input type="button" value="Link This Item" style="font-size:10px;width:165px;font-weight:normal;height:20px;margin-top:3px;" onclick="toggleLink()">
              <br />
              <input type="button" value="Email This Item" style="font-size:10px;width:165px;font-weight:normal;height:20px;margin-right:3px;margin-bottom:3px;" onclick="goToEmail()">
              <input type="button" value="Return To Action Log" style="font-size:10px;width:165px;font-weight:normal;height:20px;margin-top:3px;margin-bottom:3px;" onclick="document.location='admin_LogDisplay.asp'"><br>
              <input type="button" value="Log Summary" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-right:3px;margin-bottom:3px;" onclick="viewAssessmentSummary()">
            </td>
          </tr>
          <tr height="20">
            <td>
              &nbsp;
            </td>
          </tr>
        </table>
      </form>
<%
'###############################################
'# Set checkboxes for linked log numbers
'#
%>
      <script>
<% ' {{{ Check linked log numbers
sql = "select * from SRT_Links where primary_log_number = "& sqlnum(log_number) &" and division = 'iSRT' and archived = 'n'"
set lrs = conn_asap.execute(sql)
do while not lrs.eof
%>
        document.getElementById("links_<%= lrs("secondary_log_number") %>").checked = true;
<%
  lrs.movenext
loop
' }}} %>
<%
'###############################################
'# Dynamic action item javascript
'#
%>
    // {{{ addRow
    function addRow(t,r) {
      document.getElementById("ROWHEADER").style.display = "";
        currCnt = parseInt(document.getElementById("safety_action_cnt").value);
        currCnt = currCnt +1;
        document.getElementById("safety_action_cnt").value = currCnt;
        var inputTable = document.getElementById(t);
        var inputTableRow = document.getElementById(r);
        var newTR1 = document.createElement('TR');
        var newTD1 = document.createElement('TD');
        var newTD2 = document.createElement('TD');
        var newTD3 = document.createElement('TD');
        var newTD4 = document.createElement('TD');
        var newTD5 = document.createElement('TD');
        var newTD6 = document.createElement('TD');
        var newTD7 = document.createElement('TD');
        var newTD8 = document.createElement('TD');
        var newTD9 = document.createElement('TD');
        var newTD10 = document.createElement('TD');
        inputTable.insertBefore(newTR1, inputTableRow);
        newTR1.appendChild(newTD1);
        newTR1.appendChild(newTD2);
        newTR1.appendChild(newTD3);
        newTR1.appendChild(newTD4);
        newTR1.appendChild(newTD5);
        newTR1.appendChild(newTD6);
        newTR1.appendChild(newTD7);
        newTR1.appendChild(newTD8);
        newTR1.appendChild(newTD9);
        newTR1.appendChild(newTD10);
        newTD1.setAttribute("style","FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial");
        newTD1.setAttribute("bgColor","ffffff");
        newTD1.setAttribute("width","19%");
        newTD1.setAttribute("align","center");
        newTD1.setAttribute("vAlign","top");
        newTD2.setAttribute("style","FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial");
        newTD2.setAttribute("bgColor","ffffff");
        newTD2.setAttribute("width","17%");
        newTD2.setAttribute("align","left");
        newTD2.setAttribute("vAlign","top");
        newTD3.setAttribute("style","FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial");
        newTD3.setAttribute("bgColor","ffffff");
        newTD3.setAttribute("width","8%");
        newTD3.setAttribute("align","center");
        newTD3.setAttribute("vAlign","top");
        newTD4.setAttribute("style","FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial");
        newTD4.setAttribute("bgColor","ffffff");
        newTD4.setAttribute("width","8%");
        newTD4.setAttribute("align","center");
        newTD4.setAttribute("vAlign","top");
        newTD5.setAttribute("style","FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial");
        newTD5.setAttribute("bgColor","ffffff");
        newTD5.setAttribute("width","8%");
        newTD5.setAttribute("align","center");
        newTD5.setAttribute("vAlign","top");
        newTD6.setAttribute("style","FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial");
        newTD6.setAttribute("bgColor","ffffff");
        newTD6.setAttribute("width","8%");
        newTD6.setAttribute("align","center");
        newTD6.setAttribute("vAlign","top");
        newTD7.setAttribute("style","FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial");
        newTD7.setAttribute("bgColor","ffffff");
        newTD7.setAttribute("width","8%");
        newTD7.setAttribute("align","center");
        newTD7.setAttribute("vAlign","top");
        newTD8.setAttribute("style","FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial");
        newTD8.setAttribute("bgColor","ffffff");
        newTD8.setAttribute("width","8%");
        newTD8.setAttribute("align","center");
        newTD8.setAttribute("vAlign","top");
        newTD9.setAttribute("style","FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial");
        newTD9.setAttribute("bgColor","ffffff");
        newTD9.setAttribute("width","8%");
        newTD9.setAttribute("align","center");
        newTD9.setAttribute("vAlign","top");
        newTD10.setAttribute("style","FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial");
        newTD10.setAttribute("bgColor","ffffff");
        newTD10.setAttribute("width","8%");
        newTD10.setAttribute("align","center");
        newTD10.setAttribute("vAlign","top");

<%
pocSTR = ""
sql = "select * from Tbl_Logins where srt_admin in ('l','w') order by last_name asc"
set tmprs=conn_asap.execute(sql)
do while not tmprs.eof
  employee_nbr  = tmprs("employee_number")
  first_name    = tmprs("first_name")
  last_name     = tmprs("last_name")

  pocSTR        = pocSTR &"<option value='"& employee_nbr &"'>"& left(first_name,1) &"&nbsp;"& last_name &"</option>"

  tmprs.movenext
loop
%>

<% if(session("srt_admin") = "y") then %>
        newTD1.innerHTML = "<span style='FONT-WEIGHT: normal; FONT-SIZE: 7pt;  FONT-STYLE: normal; FONT-FAMILY: Arial;'><%= viewDivision %><input type='text' id='safety_action_nbr_"+currCnt+"' name='safety_action_nbr_"+currCnt+"' style='width:60px;'  value='<%= log_number %>."+currCnt+"' required='false' readonly /></span><br/><select name='safety_action_type_"+currCnt+"' style='width:155px;font-size:10px;' required='true'><option value=''>Select Action Type</option><option value='Corrective Action Required'>Corrective Action Required</option><option value='Finding'>Finding</option><option value='Recommendation'>Recommendation</option><option value='Informational'>Informational</option><option value='12-Month Follow up'>12-Month Follow up</option></select>";
<% else %>
        newTD1.innerHTML = "<span style='FONT-WEIGHT: normal; FONT-SIZE: 7pt;  FONT-STYLE: normal; FONT-FAMILY: Arial;'><%= viewDivision %> <input type='text' id='safety_action_nbr_"+currCnt+"' name='safety_action_nbr_"+currCnt+"' style='width:60px;'  value='<%= log_number %>."+currCnt+"' required='false' readonly /></span><br/><select name='safety_action_type_"+currCnt+"' style='width:155px;font-size:10px;' required='true'><option value=''>Select Action Type</option><option value='Corrective Action Required'>Corrective Action Required</option><option value='Finding'>Finding</option><option value='Recommendation'>Recommendation</option><option value='Informational'>Informational</option><option value='12-Month Follow up'>12-Month Follow up</option></select>";
<% end if %>
        newTD2.innerHTML = "<textarea id='safety_action_"+currCnt+"' name='safety_action_"+currCnt+"' style='width:230px;' rows='3'></textarea>";
        newTD3.innerHTML = "<select class='input6' id='safety_action_division_"+currCnt+"' name='safety_action_division_"+currCnt+"' size='1' style='width:60px;' onchange=''><%= divisionOptions %></select><div id='OTHERNAMETITLE_"+currCnt+"' style='font-weight:bold;font-size:7pt;display:none;margin-top:5px;'>Other Name</div>";
        newTD4.innerHTML = "<select name='safety_action_poc_"+currCnt+"' style='width:85px;' required='false' onchange='checkOther(this,\""+currCnt+"\")'><option value=''></option><%= pocSTR %><option value='Other'>Other</option></select><div id='OTHERNAME_"+currCnt+"' style='display:none;'><input type='text' name='safety_action_other_name_"+currCnt+"' id='safety_action_other_name_"+currCnt+"' size='30'  style='width:85px;'  value='' required='false'  /></div>";
        newTD5.innerHTML = "<input type='text' id='safety_action_open_"+currCnt+"' name='safety_action_open_"+currCnt+"' size='30'  style='width:73px;'  value='' required='false' onblur=\"if(validateDate(this)){calcDueDate('"+currCnt+"');}\" /><div id='OTHEREMAILTITLE_"+currCnt+"' style='font-weight:bold;font-size:7pt;margin-top:5px;display:none;'>Other Email</div>";
        newTD6.innerHTML = "<input type='text' id='safety_action_due_"+currCnt+"' name='safety_action_due_"+currCnt+"' size='30'  style='width:73px;'  value='' required='false' onblur='validateDate(this)' /><div id='OTHEREMAIL_"+currCnt+"' style='display:none;'><input type='text' name='safety_action_other_email_"+currCnt+"' id='safety_action_other_email_"+currCnt+"' size='30'  style='width:73px;'  value='' required='false' /></div>";
        newTD7.innerHTML = "<input type='text' id='safety_action_completed_"+currCnt+"' name='safety_action_completed_"+currCnt+"' size='30'  style='width:73px;'  value='' required='false' onblur='validateDate(this)' />";
        newTD8.innerHTML = "<select id='safety_action_status_"+currCnt+"' name='safety_action_status_"+currCnt+"' style='width:73px;' required='false'><option selected value='Open'>Open</option><option value='Closed'>Closed</option><option value='Re-opened'>Re-opened</option><option value='Void'>Void</option></select>";
        newTD9.innerHTML = "&nbsp;";
        newTD10.innerHTML = "&nbsp;";
    }
    // }}}

    function checkOther(o,i) {
      if(o.value == "Other") {
        document.getElementById("OTHERNAMETITLE_"+i).style.display = "block";
        document.getElementById("OTHERNAME_"+i).style.display = "block";
        document.getElementById("OTHEREMAILTITLE_"+i).style.display = "block";
        document.getElementById("OTHEREMAIL_"+i).style.display = "block";
      } else {
        document.getElementById("OTHERNAMETITLE_"+i).style.display = "none";
        document.getElementById("OTHERNAME_"+i).style.display = "none";
        document.getElementById("OTHEREMAILTITLE_"+i).style.display = "none";
        document.getElementById("OTHEREMAIL_"+i).style.display = "none";
      }
    }

function viewAssessmentSummary() {
  frm.action = "divisional_logPicture.asp";
  checkRequired();
}

      </script>
    </center>
<!--#include file ="includes/footer.inc"-->
  </body>
</html>
<!--
<%= formDataXML %>
-->
<xml id="dateXML"></xml>
