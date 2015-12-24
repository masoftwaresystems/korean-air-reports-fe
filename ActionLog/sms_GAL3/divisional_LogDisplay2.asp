<% ' vi: set foldmethod=marker syn=aspvbs linebreak autoindent tabstop=2 softtabstop=2 shiftwidth=2 expandtab: %>
<!--#include file="includes/security.inc" -->
<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<% ' {{{ Initial Requests
unlockLogs
position = request("position")
if(position = "") then
  startpos = 0
else
  startpos = cint(position)
  if(cint(position) > 0) then
    prevpos = startpos -10
  end if
end if
overflow = request("overflow")
if(overflow = "y") then
  buttonText = "Browser-Friendly"
else
  buttonText = "Printer-Friendly"
end if
if(request("viewDivision") = "") then
  viewDivision = session("division")
else
  viewDivision = request("viewDivision")
end if
filterSelect = request("filterSelect")
searchVal = request("searchVal")
searchType = request("searchType")
divisionSelect = request("divisionSelect")
if(filterSelect = "") then
  filterSelect = "all"
end if
if(divisionSelect = "") then
  divisionSelect = "All"
end if
' }}} %>
<html>
  <head>
<!--#include file="includes/commonhead.inc"-->
    <link href="styles/display.css" rel="stylesheet" type="text/css" />
    <% ' {{{ script %>
    <script type="text/javascript">
<!--#include file="script/divisional_display.asp"-->
    </script>
    <% ' }}} %>
  </head>
  <body onload="init()">
    <center>
    <div style="margin:auto;width:99%;">
      <div id="headerDiv">
<!--#include file="includes/divisional_header.inc"-->
      </div>
      <div class="tableContainer" style="width:98%;margin: auto;">
        <div id="advancedSearchDIV" bgcolor="#ffffff" align="left" style="padding-left:0px;display:none;">
          <% ' {{{ form %>
          <form method="post" action="divisional_LogDisplay.asp">
            <input type="hidden" name="searchType" id="Adv_searchType" value="<%= request("Adv_searchType") %>" >
            <input type="hidden" name="position" id="Adv_position" value="<%= request("Adv_position") %>" >
            <input type="hidden" name="overflow" id="Adv_overflow" value="<%= request("Adv_overflow") %>" >
            <% ' {{{ table %>
            <table cellspacing="0" cellpadding="1" width="100%" border="0" style="margin-bottom:0px;margin-left:10px;">
              <tr>
                <td style="border-top:1px solid black;">&nbsp;</td>
              </tr>
              <% ' {{{ table %>
              <table cellspacing="0" cellpadding="1" width="370" border="0" style="margin-bottom:3px;">
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
                    <input type="text" name="srt_searchvalue2" id="srt_searchvalue2" size="50" maxlength="100" value="<%= request("srt_searchvalue2")  %>" style="border:1px solid black;width:150px;font-size:10pt;" />
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
<% ' {{{ SQL: select division = 'iSRT
if(viewDivision = "ACG") then
    sql = "select divisionalLogNumber, srtlognumber, logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'iSRT_LogInput' and archived = 'n' and active = 'y' and division = 'ACS' and divisionalLogNumber is not null or formname = 'iSRT_LogInput' and archived = 'n' and active = 'y' and division = 'CGO' and divisionalLogNumber is not null order by logNumber desc, recid desc"
else
    sql = "select divisionalLogNumber, srtlognumber, logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'iSRT_LogInput' and archived = 'n' and active = 'y' and division = "& sqltext2(viewDivision) &" and divisionalLogNumber is not null order by logNumber desc, recid desc"
end if
set rs = conn_asap.execute(sql)
' }}} %>
        <% ' {{{ form %>
        <form name="frm" id="frm" action="divisional_LogDisplay.asp" method="post">
          <table cellSpacing="0" cellPadding="1" width="100%" border="0">
            <tr class="LogHead">
              <td width="5%">Log Number</td>
              <td width="25%">Description</td>
              <td width="5%">Cross-div. Nbr.</td>
              <td width="8%">Accountable Leader</td>
              <td width="8%">Risk Value</td>
              <td width="5%">Source</td>
              <td width="6%">Opened</td>
              <td width="6%">Due</td>
              <td width="6%">Completed</td>
              <td width="4%">Days</td>
              <td width="5%">Status</td>
            </tr>
<% ' {{{ if overflow
if(overflow <> "y") then %>
          </table>
          <div id="overflowDiv" style="height:475;overflow:auto;">
          <table cellSpacing="0" cellPadding="1" width="100%" border="0">
<% end if ' }}} %>
            <tr class="LogHead">
              <td width="5%"></td>
              <td width="25%"></td>
              <td width="5%"></td>
              <td width="8%"></td>
              <td width="8%"></td>
              <td width="5%"></td>
              <td width="6%"></td>
              <td width="6%"></td>
              <td width="6%"></td>
              <td width="4%"></td>
              <td width="5%"></td>
            </tr>
<% ' {{{ XML: select safety actions
  set oXML					= CreateObject("Microsoft.XMLDOM")
  oXML.async				= false
  set oXML2					= CreateObject("Microsoft.XMLDOM")
  oXML2.async				= false

  tmpLogNumber = ""
  firstOne = "y"

  currpos = 0
  recsshown = 0

  'response.write("<tr><td colspan='12'>startpos:"& startpos &"<br></td></tr>")

  do while not rs.eof

  searchHit = 0

  'response.write("<tr><td colspan='12'>currpos:"& currpos &"<br></td></tr>")


  loginID					= rs("loginID")
  createDate				= rs("createDate")
  formDataXML				= rs("formDataXML")
  recid						= rs("recid")
  division					= rs("division")

  srtlognumber				= rs("srtlognumber")
  srtlog_number				= srtlognumber
  if(len(srtlog_number) > 0) then
    srtlog_numberStr			= "iSRT"&string(4-len(srtlog_number),"0")&srtlog_number
  end if

  divisionalLogNumber		= rs("divisionalLogNumber")
  log_number				= divisionalLogNumber
  log_numberStr				= string(4-len(log_number),"0")&log_number

  oXML.loadXML(formDataXML)

  safety_action_cnt			= selectNode(oXML,"safety_action_cnt","")
  'log_number				= selectNode(oXML,"log_number","")
  item_description			= rev_xdata2(selectNode(oXML,"item_description",""))
  accountable_leader		= rev_xdata2(selectNode(oXML,"accountable_leader",""))
  source					= rev_xdata2(selectNode(oXML,"source",""))
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


  sql = "select logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'risk' and divisionallogNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' order by logNumber desc, recid desc"
  set rs2 = conn_asap.execute(sql)
  if not rs2.eof then
    formDataXML2				= rs2("formDataXML")
    oXML2.loadXML(formDataXML2)

    risk_value_pre_mitigation		= selectNode(oXML2,"risk_value_pre_mitigation","")
    risk_value_post_mitigation		= selectNode(oXML2,"risk_value_post_mitigation","")

    if(risk_value_post_mitigation <> "") then
      curr_risk = risk_value_post_mitigation
    else
      curr_risk = risk_value_pre_mitigation
    end if

  end if

  divisionStr = ""
  sql = "select division, recid from SRT_LogNumberDivisions where log_number = "& sqlnum(srtlog_number) &" and archived = 'n' order by division asc"
  set rs3 = conn_asap.execute(sql)
  do while not rs3.eof
    tmpdivision				= rs3("division")
    divisionStr = divisionStr &" "& tmpdivision

    rs3.movenext
  loop
  divisionStr = rtrim(divisionStr)

  srtlinksStr = ""
  sql = "select srtLogNumber from EHD_Data where divisionalLogNumber = "& sqlnum(log_number) &" and division = "& sqltext2(division) &" and active = 'y' and srtLogNumber is not null and formname = 'iSRT_LogInput' and archived = 'n' order by srtLogNumber asc"
  set rs4 = conn_asap.execute(sql)
  if not rs4.eof then
    srtLogNumber				= rs4("srtLogNumber")

    srtlinksStr = srtlinksStr &"iSRT"& string(4-len(srtLogNumber),"0")&srtLogNumber &"<br>"

    sql = "select division, divisionalLogNumber from EHD_Data where srtLogNumber = "& sqlnum(srtLogNumber) &" and active = 'y' and archived = 'n' and formname = 'iSRT_LogInput' order by division asc, divisionalLogNumber asc"
    set rs5 = conn_asap.execute(sql)
    do while not rs5.eof
      srtdivision				= rs5("division")
      srtdivisionalLogNumber	= rs5("divisionalLogNumber")
      if((srtdivisionalLogNumber <> log_number) and (srtdivision <> division)) then
        srtlinksStr = srtlinksStr & srtdivision & string(4-len(srtdivisionalLogNumber),"0")&srtdivisionalLogNumber &"<br>"
      end if

      rs5.movenext
    loop
    srtlinksStr = rtrim(srtlinksStr)

  end if

  'response.write("<tr><td colspan='11'>log_number:"& log_number &"<br></td></tr>")
  'response.write("<tr><td colspan='11'>tmpLogNumber:"& tmpLogNumber &"<br></td></tr>")
  if(tmpLogNumber <> log_number) then
    tmpLogNumber = log_number
' }}} %>
<% if(firstOne <> "y") then %>
            <tr>
              <td bgcolor="#ffffff" colspan="12" >
                <div style="height:0px;border:0px solid black;font-size:0px;background-color:#000040;"></div>
              </td>
            </tr>
<% else %>
<% firstOne = "n" %>
<% end if %>
<% ' {{{ Check Log
isLocked = isLogLocked(log_number,division)
if(isLocked = "n") then
  clickloc = "document.location='divisional_LogInput.asp?position="& position &"&log_number="& log_number &"&viewDivision="& division &"'"
else
  clickloc = "alert('"& division & log_numberStr &" locked by "& isLocked &"')"
end if
' }}} %>
            <tr class="LogNumber" style="font-weight: bold; font-size: 8pt; text-align:center" onmouseover="setRowColor(this, '#f0f0f0');this.style.cursor='hand';" onmouseout="setRowColor(this, 'white')">
<% if(isLocked <> "n") then %>
                <td style="font-size:8pt;" align="left">
                <span onclick="<%= clickloc %>"><%= division %><%= log_numberStr %>&nbsp;</span>
                  <br><input type="button" title="Request Unlock" value="Unlock" onclick="requestUnlock('<%= division %>','<%= log_number %>')" style="width:60px;font-size:9pt;">
                </td>
<% else %>
                <td onclick="<%= clickloc %>" style="font-size:8pt;" align="left">
                <span onclick="<%= clickloc %>"><%= division %><%= log_numberStr %>&nbsp;</span>
                </td>
<% end if %>

              <td onclick="<%= clickloc %>" style="text-align:left;padding-right:10pt;padding-bottom:4px;">
                <%= item_description %>&nbsp;
              </td>
              <td onclick="<%= clickloc %>">
                <%= srtlinksStr %>
              </td>
              <td onclick="<%= clickloc %>">
<% ' {{{ Get accountable_leader
Set NodeList = oXML.documentElement.selectNodes("//accountable_leader")
For Each Node In NodeList
  employee_nbr = Node.text
  sql = "select first_name, last_name from Tbl_Logins where employee_number = "& sqltext2(employee_nbr)
  set emprs = conn_asap.execute(sql)
  if not emprs.eof then
' }}} %>
                <%= left(emprs("first_name"),1) %>&nbsp;<%= emprs("last_name") %><br>
<% ' {{{ Loop through accountable_leaders
  end if
Next
' }}} %>
              </td>
              <td onclick="<%= clickloc %>">
                <%= curr_risk %>&nbsp;
              </td>
              <td onclick="<%= clickloc %>">
                <%= source %>&nbsp;
              </td>
              <td onclick="<%= clickloc %>">
                <%= date_opened %>&nbsp;
              </td>
              <td onclick="<%= clickloc %>">
                <%= date_due %>&nbsp;
              </td>
              <td onclick="<%= clickloc %>">
                <%= date_completed %>&nbsp;
              </td>
              <td onclick="<%= clickloc %>">
<% ' {{{ Check if completed
if(date_completed = "") then
  d2 = date
else
  d2 = date_completed
end if
' }}} %>
                <% if(len(date_opened) > 0) then %><%= datediff("d",date_opened,d2) %><% end if %>
              </td>
              <td onclick="<%= clickloc %>">
                <%= item_status %>&nbsp;
              </td>
            </tr>
<% ' {{{ Check if is locked
if(tmpCnt > 0) then
isLocked = isLogLocked(log_number,division)
if(isLocked = "n") then
  clickloc = "document.location='divisional_LogInput.asp?log_number="& log_number &"&viewDivision="& division &"&position="& position &"'"
else
  clickloc = "alert('"& division & log_numberStr &" locked by "& isLocked &"')"
end if
' }}} %>
            <tr class="ItemHead" onclick="<%= clickloc %>"  onmouseover="this.style.cursor='hand';" style="font-weight:bold;text-align:center;background-color: #dcdcdf">
              <td>
                &nbsp;
              </td>
              <td>
                Activity
              </td>
              <td>
                POC
              </td>
              <td>
                Opened
              </td>
              <td>
                Due
              </td>
              <td>
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
              <td>
                &nbsp;
              </td>
              <td>
                &nbsp;
              </td>
            </tr>
            <tr>
              <td>
              </td>
            </tr>
<% end if %>
<% ' {{{ Loop through safety actions
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
  safety_action					= replace(safety_action,vbcrlf,"<br>")
  safety_action_other_name		= rev_xdata2(selectNode(oXML,"safety_action_other_name_"& a,""))
  if(safety_action_poc = "Other") then
    safety_action_poc = safety_action_other_name
  end if
' }}} %>
<% ' {{{ Check if is locked
isLocked = isLogLocked(log_number,division)
if(isLocked = "n") then
  clickloc = "document.location='divisional_LogInput.asp?log_number="& log_number &"&viewDivision="& division &"&position="& position &"'"
else
  clickloc = "alert('"& division & log_numberStr &" locked by "& isLocked &"')"
end if
' }}} %>
            <tr class="ItemHead" onclick="<%= clickloc %>"  onmouseover="setRowColor(this, '#f0f0f0');this.style.cursor='hand';" onmouseout="setRowColor(this, 'white')" style="font-weight:normal;text-align:center;background-color: #ffffff">
              <td>
                <%= division %><%= log_numberStr %>.<%= a %>
              </td>
              <td style="font-weight:normal;text-align:left">
                <span style="font-weight:bold;font-size:8pt;color:#000040;"><%= safety_action_type_ %>:</span><br/><%= safety_action %>
              </td>
              <td>
                <%= safety_action_poc %>
              </td>
              <td>
                <%= safety_action_open %>
              </td>
              <td>
                <%= safety_action_due %>
              </td>
              <td>
                <%= safety_action_completed %>
              </td>
              <td>
<% ' {{{ Check if completed
if(safety_action_completed = "") then
  d2 = date
else
  d2 = safety_action_completed
end if
' }}} %>
                <% if(len(safety_action_open) > 0) then %><%= datediff("d",safety_action_open,d2) %><% end if %>
              </td>
              <td>
                <%= safety_action_status %>
              </td>
              <td>
                &nbsp;
              </td>
              <td>
                &nbsp;
              </td>
              <td>
                &nbsp;
              </td>
            </tr>
            <tr class="LogNumber">
              <td>
              </td>
            </tr>
            <tr class="LogNumber">
              <td style="height:0px;" bgcolor="#dcdcdf" colspan="11">
              </td>
            </tr>
<% ' {{{ Select count of division
next
acnt = 0

if((len(srtLogNumber) = 0) or (isnull(srtLogNumber))) then
  tmpsql = "where a.lognumber = "& sqlnum(log_number)
else
  tmpsql = "where a.srtlognumber = "& sqlnum(srtLogNumber)
end if
sql = ""& _
"select count(*) cnt "& _
"from EHD_Data a, EHD_Attachments b "& _
tmpsql & _
" and a.active = 'y' "& _
"and a.archived = 'n' "& _
"and a.formname = 'iSRT_LogInput' "& _
"and a.division = b.division "& _
"and a.lognumber = b.log_number "& _
"and b.archived = 'n' "
'response.write(sql)
set rscnt = conn_asap.execute(sql)
if not rscnt.eof then
  acnt = cint(rscnt("cnt"))
end if
' }}} %>
            <tr  onclick="<%= clickloc %>" onmouseover="this.style.cursor='hand';" onmouseout="">
              <td class="LogNumber" style="padding-left:5px;text-align:left;" colspan="11">
              <% if(acnt > 0) then %>
                <!--
                <span style="font-weight:normal">
                  <a href="divisional_Attachments.asp?log_number=<%= log_number %>&viewDivision=<%= division %>" style="text-decoration:none;">
                    Attachments(<b><%= acnt %></b>)
                  </a>
                </span>
                -->
                <span style="font-weight:normal;font-size:8pt;">Attachments(<b><%= acnt %></b>)</span>
              <% end if %>
<% ' {{{ Select from SRT_Links
sql = "select * from SRT_Links where primary_log_number = "& sqlnum(log_number) &" and division = "& sqltext2(division) &" and archived = 'n'"
set lrs = conn_asap.execute(sql)
if not lrs.eof then
' }}} %>
                <span style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial;width:120px;">Related to :&nbsp;</span>
<% ' {{{ Get tmp_secondarylognumber
do while not lrs.eof
  tmp_secondarylognumber = string(4-len(lrs("secondary_log_number")),"0")&lrs("secondary_log_number")
  tmp_division = lrs("division")
' }}} %>
                <span style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial;width:30px;"><%= tmp_division %><%= tmp_secondarylognumber %></span>
<% ' {{{ Loop through links
  lrs.movenext
loop
end if
' }}} %>
              </td>
            </tr>
<% ' {{{ End loop through log numbers
  end if
  end if
  end if
  rs.movenext
  loop
' }}} %>
          </table>
<% if(overflow <> "y") then %>
          </div>
<% end if %>
          <div width="100%" style="border-top: 1px solid gray;"></div>
<% if(overflow <> "y") then %>
            <table cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="white">
              <td align="center">
                <span style="font-size:8pt;width:150px;font-weight:bold;">
                <% if(startpos > 0) then %>
                  <a href="divisional_LogDisplay.asp?position=<%= prevpos %>&filterSelect=<%= filterSelect %>&searchVal=<%= searchVal %>&divisionSelect=<%= divisionSelect %>&viewDivision=<%= viewDivision %>">
                    &lt;&lt;prev
                  </a>
                <% else %>
                  &lt;&lt;prev
                <% end if %>
                </span>
                <span style="font-size:8pt;width:150px;font-weight:bold;">
                <% if(recsshown = 11) then %>
                  <a href="divisional_LogDisplay.asp?position=<%= currpos %>&filterSelect=<%= filterSelect %>&searchVal=<%= searchVal %>&divisionSelect=<%= divisionSelect %>&viewDivision=<%= viewDivision %>">
                    next&gt;&gt;
                  </a>
                <% else %>
                  next&gt;&gt;
                <% end if %>
                </span>
              </td>
            </table>
<% end if %>
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
