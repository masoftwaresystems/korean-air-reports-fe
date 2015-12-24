<%
'###############################################
'#
'# admin_StageList.asp
'#
'# Lists iSRT Stage items
'#
%>
<% ' vi: set foldmethod=marker syn=aspvbs linebreak autoindent tabstop=2 softtabstop=2 shiftwidth=2 expandtab: %>
<!--#include file="includes/security.inc" -->
<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<%
'###############################################
'# Retrieve page "state" variables
'#
%>
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
viewDivision = "iSRT"
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
<%
'###############################################
'# Dynamic menu
'#
%>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
<!--#include file="script/nav.js"-->
    <% ' {{{ script %>
    <script type="text/javascript">
<!--#include file="script/divisional_stagelist.asp"-->
    </script>
    <% ' }}} %>
  </head>
  <body onload="init()">
      <div id="headerDiv">
<!--#include file="includes/sms_header.inc"-->
      </div>
    <center>
    <div style="margin:auto;width:99%;">
      <div class="tableContainer" style="width:98%;margin: auto;">
<%
'###############################################
'# Advanced search div: not used.
'#
%>
        <div id="advancedSearchDIV" bgcolor="#ffffff" align="left" style="padding-left:0px;display:none;">
          <% ' {{{ form %>
          <form method="post" action="admin_LogDisplay.asp">
            <input type="hidden" name="searchType" id="Adv_searchType" value="<%= request("Adv_searchType") %>" >
            <input type="hidden" name="position" id="Adv_position" value="<%= request("Adv_position") %>" >
            <input type="hidden" name="overflow" id="Adv_overflow" value="<%= request("Adv_overflow") %>" >
            <% ' {{{ table %>
            <table cellspacing="0" cellpadding="1" width="100%" border="0" style="margin-bottom:0px;margin-left:10px;margin-top:5px;">
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
'# Retrieve iSRT stage items
'#
%>
<% ' {{{ SQL: select division = 'iSRT
sql = "select srtstagenumber, divisionalLogNumber, srtlognumber, logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'iSRT_LogInput' and archived = 'n' and active = 'y' and division = "& sqltext2(viewDivision) &" and srtlogNumber is null order by srtstagenumber desc, recid desc"
set rs = conn_asap.execute(sql)
' }}} %>
        <% ' {{{ form %>
        <form name="frm" id="frm" action="admin_LogDisplay.asp" method="post">
          <table cellSpacing="0" cellPadding="1" width="100%" border="0" style="margin-top:5px;">
            <tr class="LogHead">
              <td width="10%" align="left">Stage Log Nbr.</td>
              <td width="34%" align="left">Description</td>
              <td width="18%">Risk Value</td>
              <td width="15%">Source</td>
              <td width="6%">Created</td>
            </tr>
<% ' {{{ if overflow
if(overflow <> "y") then %>
          </table>
          <div id="overflowDiv" style="height:475;overflow:auto;">
          <table cellSpacing="0" cellPadding="1" width="100%" border="0">
<% end if ' }}} %>
            <tr class="LogHead">
              <td width="10%"></td>
              <td width="34%"></td>
              <td width="18%"></td>
              <td width="15%"></td>
              <td width="6%"></td>
            </tr>
<%
'###############################################
'# Set up XML objects
'#
%>
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

  createDateArr = split(createDate," ")

  divisionalLogNumber		= rs("srtstagenumber")
  log_number				= divisionalLogNumber
  log_numberStr				= string(4-len(log_number),"0")&log_number

%>
<%
'###############################################
'# Retrieve data from XML objects
'#
%>
<%
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


%>
<%
'###############################################
'# Search filters
'#
%>
<%
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


%>
<%
'###############################################
'# Retrieve the stored risk value
'#
%>
<%
  sql = "select logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'risk' and srtstagenumber = "& sqlnum(log_number) &" and divisionallogNumber is null and archived = 'n' and active = 'y' order by logNumber desc, recid desc"
  set rs2 = conn_asap.execute(sql)
  if not rs2.eof then
    formDataXML2				= rs2("formDataXML")
    oXML2.loadXML(formDataXML2)

    risk_value		= selectNode(oXML2,"risk_value","")

    curr_risk = risk_value

  end if

%>
<%
'###############################################
'# Create display string for linked log items
'#
%>
<%
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
              <td bgcolor="#ffffff" colspan="5" >
                <div style="height:0px;border:0px solid black;font-size:0px;background-color:#000040;"></div>
              </td>
            </tr>
<% else %>
<% firstOne = "n" %>
<% end if %>
<%
'###############################################
'# Loop through log items and list them
'#
%>
<%
clickloc = "document.location='admin_StageInput.asp?position="& position &"&log_number="& log_number &"&viewDivision="& division &"'"
%>
            <tr class="LogNumber" style="font-weight: bold; text-align:center;font-size:8pt;" onmouseover="setRowColor(this, '#f0f0f0');this.style.cursor='hand';" onmouseout="setRowColor(this, 'white')">
                <td onclick="<%= clickloc %>" style="font-size:8pt;" align="left">
                <span onclick="<%= clickloc %>">STG<%= log_numberStr %>&nbsp;</span>
                </td>
              <td onclick="<%= clickloc %>" style="text-align:left;padding-right:8pt;padding-bottom:4px;">
                <%= item_description %>&nbsp;
              </td>
              <td onclick="<%= clickloc %>">
                <%= curr_risk %>&nbsp;
              </td>
              <td onclick="<%= clickloc %>">
                <%= source %>&nbsp;
              </td>
              <td onclick="<%= clickloc %>">
                <%= createDateArr(0) %>&nbsp;
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
<%
'###############################################
'# Previous/Next links
'#
%>
            <table cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="white">
              <td align="center">
                <span style="font-size:8pt;width:150px;font-weight:bold;">
                <% if(startpos > 0) then %>
                  <a href="admin_LogDisplay.asp?position=<%= prevpos %>&filterSelect=<%= filterSelect %>&searchVal=<%= searchVal %>&divisionSelect=<%= divisionSelect %>&viewDivision=<%= viewDivision %>">
                    &lt;&lt;prev
                  </a>
                <% else %>
                  &lt;&lt;prev
                <% end if %>
                </span>
                <span style="font-size:8pt;width:150px;font-weight:bold;">
                <% if(recsshown = 11) then %>
                  <a href="admin_LogDisplay.asp?position=<%= currpos %>&filterSelect=<%= filterSelect %>&searchVal=<%= searchVal %>&divisionSelect=<%= divisionSelect %>&viewDivision=<%= viewDivision %>">
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
