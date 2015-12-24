<%
'###############################################
'# admin_LogDisplay.asp
'#
'# Listing of all iSRT log items
'#
%>
<% ' vi: set foldmethod=marker syn=aspvbs linebreak autoindent tabstop=2 softtabstop=2 shiftwidth=2 expandtab: %>
<!--#include file="includes/security.inc" -->
<!--#include file="includes/loginInfo.inc"-->
<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<%
'###############################################
'# Log list "state" arguments
'#
%>
<% ' {{{ Initial Requests
unlockLogs
position = request("position")
if(position = "") then
  position = 0
  startpos = 0
else
  startpos = cint(position)
  if(cint(position) > 0) then
    prevpos = startpos -10
  end if
end if

viewDivision = request("viewDivision")

overflow = request("overflow")
if(overflow = "y") then
  buttonText = "Browser-Friendly"
else
  buttonText = "Printer-Friendly"
end if

filterSelect = request("filterSelect")
searchVal = request("searchVal")
searchType = request("searchType")
divisionSelect = request("divisionSelect")

searchVal = replace(searchVal,"""","")

if(filterSelect = "") then
  filterSelect = "all"
end if
if(divisionSelect = "") then
  divisionSelect = "All"
end if
' }}} %>
<!--#include file="includes/sms_header.inc"-->

    <center>
    <div style="margin:auto;width:99%;">
      <div class="tableContainer" style="width:98%;margin: auto;padding-top:3px;">
<%
'###############################################
'# Advanced Search DIV - hidden, not used.
'#
%>
        <div id="advancedSearchDIV" bgcolor="#ffffff" align="left" style="padding-left:0px;display:none;">
          <% ' {{{ form %>
          <form method="post" action="admin_LogDisplay.asp">
            <input type="hidden" name="searchType" id="Adv_searchType" value="<%= request("Adv_searchType") %>" >
            <input type="hidden" name="position" id="Adv_position" value="<%= request("Adv_position") %>" >
            <input type="hidden" name="overflow" id="Adv_overflow" value="<%= request("Adv_overflow") %>" >
            <% ' {{{ table %>
            <table cellspacing="0" cellpadding="1" width="98%" border="0" style="margin-bottom:0px;margin-left:10px;">
              <tr>
                <td style="border-top:1px solid black;">&nbsp;</td>
              </tr>
              <% ' {{{ table %>
              <table cellspacing="0" cellpadding="1" width="98%" border="0" style="margin-bottom:3px;">
                <tr>
                  <td style="font-weight:normal;font-size:8pt;font-family:Arial" align="right" width="20%" bgcolor="#ffffff">Search by:</td>
                  <td style="font-weight:normal;font-size:8pt;font-family:Arial" align="left" width="8%" bgcolor="#ffffff">
                    <select name="srt_searchfield1" id="srt_searchfield1" style="border:1px solid black;width:150px;font-size:10px;">
                      <option value=""></option>
                      <option value="log_number">Log Nbr.</option>
                      <option value="item_description">Description</option>
                      <option value="division">Division</option>
                      <option value="accountable_leader">Accountable Leader</option>
                      <option value="risk_value_mitigation">Risk Value</option>
                      <option value="source">Source</option>
                      <option value="date_opened">Opened</option>
                      <option value="date_completed">Completed</option>
                      <option value="item_status">Status</option>
                    </select>
                  </td>
                  <td>
                    <input type="text" id="srt_searchvalue1" name="srt_searchvalue1" size="50" width="70%" value="<%= request("srt_searchvalue1")  %>" style="border:1px solid black;width:150px;font-size:10px;" />
                  </td>
                </tr>
                <tr>
                  <td align="right" width="15%">
                    <select name="srt_boolean2" style="border:1px solid black;font-size:10px;width:55px;">
                      <option value="And">And</option>
                      <option value="Or">Or</option>
                    </select>
                  </td>
                  <td style="font-weight:normal;font-size:8pt;font-family:Arial" align="left" width="8%" bgcolor="#ffffff">
                    <select name="srt_searchfield2" id="srt_searchfield2" style="border:1px solid black;width:150px;font-size:10px;">
                      <option value=""></option>
                      <option value="log_number">Log Nbr.</option>
                      <option value="item_description">Description</option>
                      <option value="division">Division</option>
                      <option value="accountable_leader">Accountable Leader</option>
                      <option value="risk_value_pre_mitigation">Risk Value Pre.</option>
                      <option value="risk_value_post_mitigation">Risk Value post.</option>
                      <option value="source">Source</option>
                      <option value="date_opened">Opened</option>
                      <option value="date_completed">Completed</option>
                      <option value="item_status">Status</option>
                    </select>
                  </td>
                  <td>
                    <input type="text" name="srt_searchvalue2" id="srt_searchvalue2" size="50" maxlength="100" value="<%= request("srt_searchvalue2")  %>" style="border:1px solid black;width:150px;font-size:10px;" />
                  </td>
                </tr>
              </table>
              <% ' }}} %>
            </table>
            <% ' }}} %>
            <input type="submit" value="Search" style="margin-left:10px;" />
            <script type="text/javascript">
              document.getElementById("srt_searchfield1").value = "<%= request("srt_searchfield1") %>";
              document.getElementById("srt_searchvalue1").value = "<%= request("srt_searchvalue1") %>";
            <% if(srt_boolean2 <> "") then %>
              document.getElementById("srt_boolean2").value = "<%= request("srt_boolean2") %>";
            <% end if %>
              document.getElementById("srt_searchfield2").value = "<%= request("srt_searchfield2") %>";
              document.getElementById("srt_searchvalue2").value = "<%= request("srt_searchvalue2") %>";
            </script>
          </form>
          <% ' }}} %>
        </div>
<%
'###############################################
'# Retrieve all iSRT log items.
'#
%>
<% ' {{{ SQL: select division = 'iSRT
sql = "select srtlognumber, logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'iSRT_LogInput' and archived = 'n' and active = 'y' and divisionalLogNumber is null and division = 'EH:DIV' order by logNumber desc, recid desc"
set rs = conn_asap.execute(sql)
' }}} %>
          <% ' {{{ form %>
          <form name="frm" id="frm" action="admin_LogDisplay.asp" method="post">
            <% ' {{{ table %>
            <table cellSpacing="0" cellPadding="0" width="100%" border="1">
              <tr class="LogHead" style="font-weight:bold">
                <td width="8%">Log Number</td>
                <td width="21%">Description</td>
                <td width="5%">Business Unit</td>
                <td width="8%">Accountable Leader</td>
                <td width="8%">Risk Value</td>
                <td width="3%">SOI</td>
                <td width="3%">HL</td>
                <td width="6%">Opened</td>
                <td width="6%" style="padding-right:5pt">Due</td>
                <td width="6%" style="padding-right:10pt">Completed</td>
                <td width="4%" style="padding-right:20pt">&nbsp;Days</td>
                <td width="5%" style="padding-right:20pt">&nbsp;Status</td>
              </tr>
<% ' {{{ if overflow
if(overflow <> "y") then %>
<!--
            </table>
            <div id="overflowDiv" style="height:475px;overflow:auto;" >
            <table cellSpacing="0" cellPadding="0" width="100%" border="1">
-->
<% end if ' }}} %>
              <tr class="LogHead">
                <td ></td>
                <td ></td>
                <td ></td>
                <td ></td>
                <td ></td>
                <td ></td>
                <td ></td>
                <td ></td>
                <td ></td>
                <td ></td>
                <td ></td>
                <td ></td>
              </tr>
<%
'###############################################
'# Loop through log items, and load detail information into XML objects
'#
%>
<% ' {{{ XML: select safety actions
  set oXML					= CreateObject("Microsoft.XMLDOM")
  oXML.async				= false
  set oXML2					= CreateObject("Microsoft.XMLDOM")
  oXML2.async				= false
  set oXML3					= CreateObject("Microsoft.XMLDOM")
  oXML3.async				= false

  tmpLogNumber = ""
  firstOne = "y"

  currpos = 0
  recsshown = 0

  'response.write("<tr><td colspan='11'>startpos:"& startpos &"<br></td></tr>")

  do while not rs.eof

  searchHit = 0

  'response.write("<tr><td colspan='11'>currpos:"& currpos &"<br></td></tr>")


  loginID					= rs("loginID")
  createDate				= rs("createDate")
  formDataXML				= rs("formDataXML")
  recid						= rs("recid")
  division					= rs("division")

  srtlognumber				= rs("srtlognumber")
  log_number				= srtlognumber
  if(len(log_number) > 0) then
    log_numberStr				= string(4-len(log_number),"0")&log_number
  end if

  oXML.loadXML(formDataXML)

%>
<%
'###############################################
'# Grab high level (header) log information from XML object
'#
%>
<%

  safety_action_cnt			= selectNode(oXML,"safety_action_cnt","")
  'log_number				= selectNode(oXML,"log_number","")
  item_description			= rev_xdata2(selectNode(oXML,"item_description",""))
  accountable_leader		= rev_xdata2(selectNode(oXML,"accountable_leader",""))
  soi						= rev_xdata2(selectNode(oXML,"soi",""))
  hl						= rev_xdata2(selectNode(oXML,"hl",""))
  date_opened				= selectNode(oXML,"date_opened","")
  date_due					= selectNode(oXML,"date_due","")
  date_completed			= selectNode(oXML,"date_completed","")
  item_status				= selectNode(oXML,"item_status","")
  item_status2				= selectNode(oXML,"item_status2","")

  if(len(item_status) = 0) then
    item_status = item_status2
  end if

  item_description			= replace(item_description,vbcrlf,"<br>")

  if(len(safety_action_cnt) = 0) then
    safety_action_cnt = 0
  end if
  tmpCnt					= cint(safety_action_cnt)

  filterHit = 1
  searchHit = 1
  divisionHit = 1

  if(searchType = "advanced") then

		'srt_searchfield1		= request("srt_searchfield1")
		'srt_searchvalue1		= request("srt_searchvalue1")
		'srt_boolean2			= request("srt_boolean2")
		'srt_searchfield2		= request("srt_searchfield2")
		'srt_searchvalue2		= request("srt_searchvalue2")

  else

%>
<%
'###############################################
'# Search filters
'#
%>
<%

  if(filterSelect <> "") then

    if(filterSelect = "all") then
      filterHit = 1
    else
      if(lcase(item_status) = lcase(filterSelect)) then
        filterHit = 1
      else
        filterHit = 0
      end if
    end if
  end if

  if(searchVal <> "") then
    if(instr(lcase(formDataXML),lcase(searchVal)) > 0) then
      searchHit = 1
    else
      searchHit = 0
    end if
  end if

%>
<%
'###############################################
'# Grab divisional log number mappings
'#
%>
<%
  if(divisionSelect <> "All") then
    sql = "select recid from SRT_LogNumberDivisions where log_number = "& sqlnum(log_number) &" and archived = 'n' and division = "& sqltext2(divisionSelect)
    set drs = conn_asap.execute(sql)
    if not drs.eof then
      divisionHit = 1
    else
      divisionHit = 0
    end if
  end if

  end if

  if((searchHit = 1) and (filterHit = 1) and (divisionHit = 1)) then

  skiprec = "n"
  currpos = currpos +1
  if(startpos > 0) then
    if(startpos >= currpos) then
      skiprec = "y"
    end if
  end if

  if((skiprec <> "y") or (overflow = "y")) then

  'response.write("<tr><td colspan='11'>skiprec:"& skiprec &"<br></td></tr>")
  'response.write("<tr><td colspan='11'>recsshown:"& recsshown &"<br></td></tr>")

  recsshown = recsshown +1
  if((recsshown = 11) and (overflow <> "y")) then
    currpos = currpos -1
    exit do
  end if

  curr_risk = ""

%>
<%
'###############################################
'# Grab risk information from XML object
'#
%>
<%
  sql = "select logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'risk' and logNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' and division = 'EH:DIV' order by logNumber desc, recid desc"
  set rs2 = conn_asap.execute(sql)
  if not rs2.eof then
    formDataXML2				= rs2("formDataXML")
    oXML2.loadXML(formDataXML2)

    risk_value_pre_mitigation		= selectNode(oXML2,"risk_value_pre_mitigation","")
    risk_value_post_mitigation		= selectNode(oXML2,"risk_value_post_mitigation","")
    if(risk_value_post_mitigation <> "") then
      curr_risk = risk_value_post_mitigation
    elseif(risk_value_pre_mitigation <> "") then
      curr_risk = risk_value_pre_mitigation
    end if
  end if

%>
<%
'###############################################
'# Create display string for all divisional log numbers contained within iSRT log
'#
%>
<%
  divisionStr = ""
  sql = "select division, recid from SRT_LogNumberDivisions where log_number = "& sqlnum(log_number) &" and division2 = 'EH:DIV' and archived = 'n' order by division asc"
  set rs3 = conn_asap.execute(sql)
  do while not rs3.eof
    division				= rs3("division")
    divisionStr = divisionStr &" "& division

    rs3.movenext
  loop
  divisionStr = rtrim(divisionStr)

  srtlinksStr = ""
  if(curr_risk = "") then
    get_div_risks = "y"
  else
    get_div_risks = "n"
  end if
  sql = "select division, divisionalLogNumber from EHD_Data where srtLogNumber = "& sqlnum(log_number) &" and active = 'y' and divisionalLogNumber is not null and formname = 'iSRT_LogInput' and archived = 'n' order by division asc, divisionalLogNumber asc"
  set rs4 = conn_asap.execute(sql)
  do while not rs4.eof
    srtdivision				= rs4("division")
    srtdivisionalLogNumber	= rs4("divisionalLogNumber")
    srtlinksStr = srtlinksStr & srtdivision & string(4-len(srtdivisionalLogNumber),"0")&srtdivisionalLogNumber &"<br>"
    if(get_div_risks = "y") then
      sql = "select formDataXML from EHD_Data where divisionalLogNumber = "& sqlnum(srtdivisionalLogNumber) &" and division = '"& srtdivision &"' and formname = 'risk' and archived = 'n' and active = 'y'"
      set rs5 = conn_asap.execute(sql)
      do while not rs5.eof
        formDataXML3 = rs5("formDataXML")
        oXML3.loadXML(formDataXML3)

        risk_value_pre_mitigation2	    = selectNode(oXML3,"risk_value_pre_mitigation","")
        risk_value_post_mitigation2    = selectNode(oXML3,"risk_value_post_mitigation","")
        if(risk_value_post_mitigation2 <> "") then
          curr_risk = curr_risk & risk_value_post_mitigation2 & "<br>"
        elseif(risk_value_pre_mitigation2 <> "") then
          curr_risk = curr_risk & risk_value_pre_mitigation2 & "<br>"
        end if
        rs5.movenext
      loop
    end if

    rs4.movenext
  loop
  srtlinksStr = rtrim(srtlinksStr)


  'response.write("<tr><td colspan='11'>log_number:"& log_number &"<br></td></tr>")
  'response.write("<tr><td colspan='11'>tmpLogNumber:"& tmpLogNumber &"<br></td></tr>")
  if(tmpLogNumber <> log_number) then
    tmpLogNumber = log_number
' }}} %>
<% if(firstOne <> "y") then %>
              <tr>
                <td bgcolor="#ffffff" colspan="12" >
                  <div style="height:0px;font-weight:normal;border-top:0px solid black;font-size:0px;background-color:#000040;">
                    &nbsp;
                  </div>
                </td>
              </tr>
<% else %>
<% firstOne = "n" %>
<% end if %>
<% ' {{{ Check Lock
isLocked = isLogLocked(log_number,"EH:DIV")
if(session("admin") = "r") then
  clickloc = "document.location='divisional_LogPicture.asp?position="& position &"&log_number="& log_number &"&viewDivision="& division &"'"
else
  if(isLocked = "n") then
    clickloc = "document.location='admin_LogInput.asp?position="& position &"&log_number="& log_number &"&viewDivision="& division &"'"
  else
    clickloc = "alert('EH:DIV"& log_numberStr &" locked by "& isLocked &"')"
  end if
end if
' }}} %>
<%
'###############################################
'# Display iSRT log item header row
'#
%>
              <tr id="ROW_<%= log_number %>" class="LogNumber" style="font-weight: bold; text-align:center;font-size:8pt;" onmouseover="setRowColor(this, '#f0f0f0');this.style.cursor='hand';" onmouseout="setRowColor(this, 'white')">
<% if(isLocked <> "n") then %>
                <td style="font-size:8pt;" align="left">
                  <span onclick="<%= clickloc %>">EH:DIV<%= log_numberStr %>&nbsp;</span>
                  <br><input type="button" value="Unlock" title="Request Unlock" onclick="requestUnlock('EH:DIV','<%= log_number %>')" style="width:60px;font-size:9px;">
                </td>
<% else %>
                <td onclick="<%= clickloc %>" style="font-size:8pt;" align="left">
                  <span onclick="<%= clickloc %>">EH:DIV<%= log_numberStr %>&nbsp;</span>
                </td>
<% end if %>
                <td onclick="<%= clickloc %>" style="text-align:left;padding-right:10px;padding-bottom:4px;">
                  <%= item_description %>&nbsp;
                </td>
                <td onclick="<%= clickloc %>">
                  <%= srtlinksStr %>&nbsp;
                </td>
                <td onclick="<%= clickloc %>">
                  <%= accountable_leader %>&nbsp;
                </td>
                <td onclick="<%= clickloc %>">
                  <%= curr_risk %>&nbsp;
                </td>
                <td onclick="<%= clickloc %>">
                  <%= soi %>&nbsp;
                </td>
                <td onclick="<%= clickloc %>">
                  <%= hl %>&nbsp;
                </td>
                <td onclick="<%= clickloc %>">
                  <%= date_opened %>&nbsp;
                </td>
                <td onclick="<%= clickloc %>">
                  <%= date_due %>&nbsp;
                </td>
                <td onclick="<%= clickloc %>" selected="false">
                  <%= date_completed %>&nbsp;
                </td>
                <td onclick="<%= clickloc %>" selected="false">
<% ' {{{ Check if completed
if(date_completed = "") then
  d2 = date
else
  d2 = date_completed
end if
' }}} %>
                  <% if(len(date_opened) > 0) then %><%= datediff("d",date_opened,d2) %><% end if %>&nbsp;
                </td>
                <td onclick="<%= clickloc %>" selected="false">
                  <%= item_status %>&nbsp;
                </td>
              </tr>
<% ' {{{ Check if locked
if(tmpCnt > 0) then
isLocked = isLogLocked(log_number,"EH:DIV")
if(session("admin") = "r") then
  clickloc = "document.location='divisional_LogPicture.asp?position="& position &"&log_number="& log_number &"&viewDivision="& division &"'"
else
  if(isLocked = "n") then
    clickloc = "document.location='admin_LogInput.asp?position="& position &"&log_number="& log_number &"&viewDivision="& division &"'"
  else
    clickloc = "alert('EH:DIV"& log_numberStr &" locked by "& isLocked &"')"
  end if
end if
' }}} %>
<%
'###############################################
'# Display iSRT log item action items
'#
%>
              <tr class="ItemHead" onclick="<%= clickloc %>"  onmouseover="this.style.cursor='hand';" style="font-weight:bold;text-align:center;background-color: #ffffff">
                <td>
                  &nbsp;
                </td>
                <td>
                  Activity
                </td>
                <td>
                  B.Unit
                </td>
                </td>
                <td>
                  Base
                </td>
                <td>
                  POC
                </td>
                <td colspan="2">
                  Opened
                </td>
                <td>
                  Due
                </td>
                <td >
                  Completed
                </td>
                <td>
                  Days
                </td>
                <td>
                  Status
                </td>
                <td>
                  &nbsp;
                </td>
              </tr>
<% end if %>
<%
'###############################################
'# Grab safety action items from XML object
'#
%>
<%  ' {{{ Loop through safety actions
for a = 1 to tmpCnt

  safety_action_nbr				= selectNode(oXML,"safety_action_nbr_"& a,"")
  safety_action					= rev_xdata2(selectNode(oXML,"safety_action_"& a,""))
  safety_action_type_			= rev_xdata2(selectNode(oXML,"safety_action_type_"& a,""))
  safety_action_poc				= rev_xdata2(selectNode(oXML,"safety_action_poc_"& a,""))
  safety_action_poc_email		= rev_xdata2(selectNode(oXML,"safety_action_poc_email_"& a,""))
  safety_action_open			= selectNode(oXML,"safety_action_open_"& a,"")
  safety_action_due				= selectNode(oXML,"safety_action_due_"& a,"")
  safety_action_completed		= selectNode(oXML,"safety_action_completed_"& a,"")
  safety_action_status			= selectNode(oXML,"safety_action_status_"& a,"")
  safety_action_division		= selectNode(oXML,"safety_action_division_"& a,"")
  safety_action_assigned_division		= selectNode(oXML,"safety_action_assigned_division_"& a,"")
  safety_action_other_name		= rev_xdata2(selectNode(oXML,"safety_action_other_name_"& a,""))
  if(safety_action_poc = "Other") then
    safety_action_poc = safety_action_other_name
  end if

  safety_action_base		= rev_xdata2(selectNode(oXML,"safety_action_base_"& a,""))

  tmp_division = safety_action_assigned_division
  if(safety_action_division <> "") then
    tmp_division = safety_action_division
  end if

  safety_action			= replace(safety_action,vbcrlf,"<br>")
  safety_action_poc = safety_action_poc & ""
'sql = "select first_name, last_name from Tbl_Logins where employee_number in ("& safety_action_poc &") order by division asc, last_name asc"
'set poc_emprs = conn_asap.execute(sql)

' }}} %>
<% ' {{{ Check if locked
isLocked = isLogLocked(log_number,"EH:DIV")
if(session("admin") = "r") then
  clickloc = "document.location='divisional_LogPicture.asp?position="& position &"&log_number="& log_number &"&viewDivision="& division &"'"
else
  if(isLocked = "n") then
    clickloc = "document.location='admin_LogInput.asp?position="& position &"&log_number="& log_number &"&viewDivision="& division &"'"
  else
    clickloc = "alert('EH:DIV"& log_numberStr &" locked by "& isLocked &"')"
  end if
end if
' }}} %>
              <tr><td colspan="12" style="height:4px;background-color:#dcdcdf;"></td></tr>
              <!--
              <tr>
                <td bgcolor="#ffffff" colspan="12" >
                  <div style="height:1px;font-weight:normal;border-top:1px solid #cfcfcf;font-size:0px;background-color:#cfcfcf;">
                    &nbsp;
                  </div>
                </td>
              </tr>
              -->
              <tr class="ItemNumber" style="text-align:center;" onclick="<%= clickloc %>"  onmouseover="setRowColor(this, '#f0f0f0');this.style.cursor='hand';" onmouseout="setRowColor(this, 'white')">
                <td style="padding-right:5pt;">
                  EH:DIV<%= safety_action_nbr %>
                </td>
                <td style="text-align:left;padding-right:10pt;padding-bottom:4px;">
                  <!-- <span style="font-weight:bold;font-size:8pt;color:#000040;"><%= safety_action_type_ %>:</span><br/> --><%= safety_action %>
                </td>
                <td>
                  <%= tmp_division %>
                </td>
                <td>
                  <%= safety_action_base %>
                </td>
                <td>
                  <%= safety_action_poc %>&nbsp;
                </td>
                <td colspan="2">
                  <%= safety_action_open %>&nbsp;
                </td>
                <td>
                  <%= safety_action_due %>&nbsp;
                </td>
                <td >
                  <%= safety_action_completed %>&nbsp;
                </td>
                <td>
<% ' {{{ Check if completed
if(safety_action_completed = "") then
  d2 = date
else
  d2 = safety_action_completed
end if
' }}} %>
                  <span style="font-weight:normal;">
                  <% if(len(safety_action_open) > 0) then %>
                    <%= datediff("d",safety_action_open,d2) %>
                  <% end if %>
                  </span>&nbsp;
                </td>
                <td>
                  <span style="font-weight:normal;"><%= safety_action_status %></span>
                </td>
                <td>
                  <span style="font-weight:normal;">&nbsp;</span>
                </td>
              </tr>
              <tr><td colspan="12" style="height:1px;background-color:black;"></td></tr>
<%
'###############################################
'# Grab attachments for log item
'#
%>
<% ' {{{ Select count of division = 'EH:DIV'
next

acnt = 0
sql = "select count(*) cnt "& _
" from EHD_Data a, EHD_Attachments b "& _
" where a.srtlognumber = "& sqlnum(log_number) & _
" and a.active = 'y' "& _
"and a.archived = 'n' "& _
"and a.formname = 'iSRT_LogInput' "& _
"and a.division = b.division "& _
"and a.lognumber = b.log_number "& _
"and b.archived = 'n' "
set rscnt = conn_asap.execute(sql)
if not rscnt.eof then
  acnt = cint(rscnt("cnt"))
end if
' }}} %>
              <tr onclick="<%= clickloc %>" onmouseover="this.style.cursor='hand';" onmouseout="">
                <td class2="LogNumber" style="padding-left:5px;text-align:left;" colspan="12">
                <% if(acnt > 0) then %>
                  <!--
                  <span style="font-weight:normal;">
                    <a href="admin_Attachments.asp?log_number=<%= log_number %>&viewdivision=EH:DIV" style="text-decoration:none;">
                      Attachments(<b><%= acnt %></b>)
                    </a>&nbsp;&nbsp;&nbsp;
                  </span>
                  -->
                  <span style="font-weight:normal;font-size:8pt;">
                      Attachments(<b><%= acnt %></b>)&nbsp;&nbsp;&nbsp;
                  </span>
                <% end if %>
<%
'###############################################
'# Grab linked log numbers
'#
%>
<%  ' {{{ Select from SRT_Links
sql = "select * from SRT_Links where primary_log_number = "& sqlnum(log_number) &" and archived = 'n' and division = 'EH:DIV'"
set lrs = conn_asap.execute(sql)
if not lrs.eof then
' }}} %>
                  <span style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial;">Related to: </span>
<% ' {{{ get tmp_secondarylognumber
do while not lrs.eof
  tmp_secondarylognumber = string(4-len(lrs("secondary_log_number")),"0")&lrs("secondary_log_number")
' }}} %>
                  <span style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial;"><%= tmp_secondarylognumber %>&nbsp;</span>
<% ' {{{ Loop through links
  lrs.movenext
loop
end if
' }}} %>
                </td>
              </tr>
<% ' {{{ End loop through Log Numbers
  end if
  end if
  end if
  rs.movenext
  loop
' }}} %>
            </table>
            <% ' }}} %>
<% ' {{{ if overflow
if(overflow <> "y") then %>
<!--
            </div>
-->
<% end if ' }}} %>
            <div width="100%" style="border-top: 1px solid gray;"></div>
<% ' {{{ if overflow
if(overflow <> "y") then %>
<%
'###############################################
'# Previous/Next page links
'#
%>
              <table cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="white">
              <tr>
                <td align="center">
                  <span style="font-size:8pt;width:150px;font-weight:bold;">
                  <% if(startpos > 0) then %>
                    <a href="admin_LogDisplay.asp?position=<%= prevpos %>&filterSelect=<%= filterSelect %>&searchVal=<%= searchVal %>&divisionSelect=<%= divisionSelect %>">
                      &lt;&lt;prev
                    </a>
                  <% else %>
                    &lt;&lt;prev
                  <% end if %>
                  </span>
                  <span style="font-size:8pt;width:150px;font-weight:bold;">
                  <% if(recsshown = 11) then %>
                    <a href="admin_LogDisplay.asp?position=<%= currpos %>&filterSelect=<%= filterSelect %>&searchVal=<%= searchVal %>&divisionSelect=<%= divisionSelect %>">
                      next&gt;&gt;
                    </a>
                  <% else %>
                    next&gt;&gt;
                  <% end if %>
                  </span>
                </td>
              </tr>
            <tr style="padding-top:5px;">
              <td align="center">
                <span style="font-size:8pt;font-weight:bold;">
                Pages:
<%
  sql = "select count(*) cnt from EHD_Data where formname = 'iSRT_LogInput' and archived = 'n' and active = 'y' and divisionalLogNumber is null and division = 'EH:DIV'"
  set tmprs = conn_asap.execute(sql)
  if not tmprs.eof then
    tmpcnt = cint(tmprs("cnt"))
    cntdown = 0
    pagenum = 0
    do while tmpcnt > -9
      tmppos = pagenum * 10
      pagenum = pagenum +1
      if(tmppos = startpos) then
%>
<span style="width:20px;text-align:center;"><%= pagenum %></span>
<%
      else
%>
<span style="width:20px;text-align:center;"><a href="admin_LogDisplay.asp?position=<%= tmppos %>&filterSelect=<%= filterSelect %>&searchVal=<%= searchVal %>&divisionSelect=<%= divisionSelect %>"><%= pagenum %></a></span>
<%
      end if
      tmpcnt = tmpcnt - 10
    loop
  end if
%>
                </span>
              </td>
            </tr>
              </table>
<% end if ' }}} %>
            <div id="footerDiv">
<!--#include file="includes/footer.inc"-->
            </div>
          </form>
            <% ' }}} %>
      </div>
    </div>
    </center>
  </body>
</html>
<xml id="xmlhttpSvc"></xml>
