<%
'###############################################
'# admin_LogReport.asp
'#
'# Display iSRT items in list/report format (only header data)
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
'# List "state" information
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
<html>
  <head>
<!--#include file="includes/commonhead.inc"-->
<%
'###############################################
'# Dynamic menu
'#
%>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
<!--#include file="script/nav.js"-->
    <% ' {{{ script %>
<%
'###############################################
'# Page utility javascript functions
'#
%>
    <script type="text/javascript">
      var overflow = "<%= overflow %>";
      function printPage() {
        <% if(overflow = "y") then %>
        if(document.all) {
          document.all.divButtons.style.visibility = 'hidden';
          //window.print();
          document.all.divButtons.style.visibility = 'visible';
        } else {
          document.getElementById('divButtons').style.visibility = 'hidden';
          //window.print();
          document.getElementById('divButtons').style.visibility = 'visible';
        }
        <% else %>
        document.location = "admin_LogReport.asp?overflow=y&searchVal=<%= searchVal %>&filterSelect=<%= filterSelect %>&divisionSelect=<%= divisionSelect %>";
        <% end if %>
      }
      function printPage2() {
        <% if(overflow = "y") then %>
        //window.print(); orientation='landscape'
        <% else %>
        window.open ("admin_LogReport.asp?overflow=y&searchVal=<%= searchVal %>&filterSelect=<%= filterSelect %>&divisionSelect=<%= divisionSelect %>","printwindow");
        <% end if %>
      }
      <% if(overflow = "y") then %>
      printPage2();
      <% end if %>
      function printPage3() {
        alert('Please adjust your printer settings to Landscape');window.print(); orientation='landscape';
      }
      function switchView() {
        if(overflow != "y") {
        document.location = "admin_LogReport.asp?overflow=y&searchVal=<%= searchVal %>&filterSelect=<%= filterSelect %>&divisionSelect=<%= divisionSelect %>";
        } else {
        document.location = "admin_LogReport.asp?searchVal=<%= searchVal %>&filterSelect=<%= filterSelect %>&divisionSelect=<%= divisionSelect %>";
        }
      }
      function getDaysBetween(d1,d2) {
        var currNode;
        xmlhttpSvc.async = false;
        xmlhttpSvc.resolveExternals = false;
        xmlhttpSvc.load("/ets/acvbusers/getDefaults.asp?eventID=<%= eventid %>");
        currNode = xmlhttpSvc.selectSingleNode("//p.<%= a %>");

        document.frm.percentage_<%= a %>.value = currNode.text;
      }
      function setRowColor(row, color) {
        cells = row.getElementsByTagName('td');
        for(a=0; a < 11; a++) {
         // alert(color);
        cells[a].style.backgroundColor = color;
        }
      }
      function newWindow(url) {
        var day = new Date();
        var id = day.getTime();
        var win = open(url,id,'width=600,height=200,scrollbars,resizable');
      }
      function doSearch() {
        document.location = "admin_LogReport.asp?searchVal="+ document.getElementById("searchVal").value +"&filterSelect=<%= filterSelect %>&divisionSelect=<%= divisionSelect %>&overflow=<%= overflow %>";
      }

      function doFilter() {
        document.location = "admin_LogReport.asp?searchVal=<%= searchVal %>&filterSelect="+ document.getElementById("filterSelect").value +"&divisionSelect=<%= divisionSelect %>&overflow=<%= overflow %>";
      }

      function doDivision() {
        document.location = "admin_LogReport.asp?searchVal=<%= searchVal %>&filterSelect=<%= filterSelect %>&divisionSelect="+ document.getElementById("divisionSelect").value +"&overflow=<%= overflow %>";
      }

      function toggleSearches(v) {
        if(v == "advanced") {
          //alert("advanced");
          document.getElementById("advancedSearchDIV").style.display = "block";
          document.getElementById("advancedsearchSPAN").style.display = "block";
          document.getElementById("basicsearchSPAN").style.display = "none";
        }
        if(v == "basic") {
          //alert("basic");
          document.getElementById("advancedSearchDIV").style.display = "none";
          document.getElementById("advancedsearchSPAN").style.display = "none";
          document.getElementById("basicsearchSPAN").style.display = "block";
        }
      }
    </script>
    <% ' }}} %>
  </head>
  <body>
<!--#include file="includes/sms_header.inc"-->
    <center>
      <div class="tableContainer">
<%
'###############################################
'# Advanced search div - not used
'#
%>
        <div id="advancedSearchDIV" bgcolor="#ffffff" align="left" style="padding-left:0px;display:none;">
          <% ' {{{ form %>
          <form method="post" action="admin_LogReport.asp">
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
'# Grab all iSRT log items
'#
%>
<% ' {{{ SQL: select division = 'iSRT
sql = "select srtlognumber, logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'iSRT_LogInput' and archived = 'n' and active = 'y' and divisionalLogNumber is null and division = 'iSRT' order by logNumber desc, recid desc"
set rs = conn_asap.execute(sql)
' }}} %>
        <div>
          <% ' {{{ form %>
          <form name="frm" id="frm" action="admin_LogReport.asp" method="post">
            <% ' {{{ table %>
            <table cellSpacing="0" cellPadding="0" width="100%" border="0">
              <tr class="LogHead" style="font-weight:bold">
                <td width="5%">iSRT Log Nbr.</td>
                <td width="25%">Description</td>
                <td width="5%">Divisional<br>Log Nbr.</td>
                <td width="8%">Accountable Leader</td>
                <td width="8%">Risk Value</td>
                <td width="5%">Source</td>
                <td width="6%">Opened</td>
                <td width="6%" style="padding-right:5pt">Due</td>
                <td width="6%" style="padding-right:10pt">Completed</td>
                <td width="4%" style="padding-right:20pt">Days</td>
                <td width="5%" style="padding-right:20pt">Status</td>
              </tr>
<% ' {{{ if overflow
if(overflow <> "y") then %>
            </table>
            <div style="height:425px;overflow:auto;">
            <table cellSpacing="0" cellPadding="0" width="100%" border="0">
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
<%
'###############################################
'# Loop through all iSRT log items, load data into XML object
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
'# Get risk information
'#
%>
<%

  sql = "select logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'risk' and logNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' and division = 'iSRT' order by logNumber desc, recid desc"
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
'# Build included log numbers string for display
'#
%>
<%
  divisionStr = ""
  sql = "select division, recid from SRT_LogNumberDivisions where log_number = "& sqlnum(log_number) &" and division2 = 'iSRT' and archived = 'n' order by division asc"
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
                <div style="height:0px;border:0px solid black;font-size:0px;background-color:#000040;"></div>
              </td>
            </tr>
<% else %>
<% firstOne = "n" %>
<% end if %>
<% ' {{{ Check Lock
isLocked = isLogLocked(log_number,"EH:DIV")
if(isLocked = "n") then
  clickloc = "document.location='admin_LogInput.asp?position="& position &"&log_number="& log_number &"'"
else
  clickloc = "alert('Log "& log_number &" locked\nuser "& isLocked &"')"
end if ' }}} %>
<%
'###############################################
'# iSRT Log item report row
'#
%>
              <tr class="LogNumber" style="font-weight: bold; text-align:center;font-size:8pt;" onclick="<%= clickloc %>" onmouseover="setRowColor(this, '#f0f0f0');this.style.cursor='hand';" onmouseout="setRowColor(this, 'white')">
                <td style="font-size:8pt;">
                  iSRT<%= log_numberStr %>&nbsp;
                </td>
                <td style="text-align:left;padding-right:10pt;padding-bottom:4px;">
                  <%= item_description %>&nbsp;
                </td>
                <td>
                  <%= srtlinksStr %>
                </td>
                <td>
<% ' {{{ SQL: Get employee info
employeeNumberStr = ""
Set NodeList = oXML.documentElement.selectNodes("//accountable_leader")
For Each Node In NodeList
  employeeNumberStr = employeeNumberStr &"'"& Node.text &"',"
Next
employeeNumberStr = employeeNumberStr &"'x'"

sql = "select first_name, last_name from Tbl_Logins where employee_number in ("& employeeNumberStr &") order by division asc, last_name asc"
set emprs = conn_asap.execute(sql)
do while not emprs.eof
' }}} %>
                  <%= left(emprs("first_name"),1) %>&nbsp;<%= emprs("last_name") %><br>
<% ' {{{ Loop through employees
      emprs.movenext
    loop
' }}}%>
                </td>
                <td>
                  <%= curr_risk %>
                </td>
                <td>
                  <%= source %>&nbsp;
                </td>
                <td>
                  <%= date_opened %>&nbsp;
                </td>
                <td>
                  <%= date_due %>&nbsp;
                </td>
                <td selected="false">
                  <%= date_completed %>&nbsp;
                </td>
                <td selected="false">
<% ' {{{ Check if completed
if(date_completed = "") then
  d2 = date
else
  d2 = date_completed
end if
' }}} %>
                  <% if(len(date_opened) > 0) then %><%= datediff("d",date_opened,d2) %><% end if %>
                </td>
                <td selected="false">
                  <%= item_status %>&nbsp;
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
            </div>
<% end if ' }}} %>
            <div width="100%" style="border-top: 1px solid gray;"></div>
<% ' {{{ if overflow
if(overflow <> "y") then %>
              <table cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="white">
                <td align="center">
                  <span style="font-size:8pt;width:150px;font-weight:bold;">
                  <% if(startpos > 0) then %>
                    <a href="admin_LogReport.asp?position=<%= prevpos %>&filterSelect=<%= filterSelect %>&searchVal=<%= searchVal %>&divisionSelect=<%= divisionSelect %>">
                      &lt;&lt;prev
                    </a>
                  <% else %>
                    &lt;&lt;prev
                  <% end if %>
                  </span>
                  <span style="font-size:8pt;width:150px;font-weight:bold;">
                  <% if(recsshown = 11) then %>
                    <a href="admin_LogReport.asp?position=<%= currpos %>&filterSelect=<%= filterSelect %>&searchVal=<%= searchVal %>&divisionSelect=<%= divisionSelect %>">
                      next&gt;&gt;
                    </a>
                  <% else %>
                    next&gt;&gt;
                  <% end if %>
                  </span>
                </td>
              </table>
<% end if ' }}} %>
<!--#include file="includes/footer.inc"-->
          </form>
            <% ' }}} %>
        </div>
      </div>
    </center>
  </body>
</html>
<xml id="xmlhttpSvc"></xml>
