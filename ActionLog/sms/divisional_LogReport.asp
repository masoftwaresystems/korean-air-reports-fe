<% ' vi: set foldmethod=marker syn=aspvbs linebreak autoindent tabstop=2 softtabstop=2 shiftwidth=2 expandtab: %>
<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/security.inc" -->
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
if(request("viewDivision") = "") then
  viewDivision = session("division")
else
  viewDivision = request("viewDivision")
end if
' }}} %>
<html>
  <head>
<!--#include file="includes/commonhead.inc"-->
    <link href="styles/display.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
<!--#include file="script/nav.js"-->
    <% ' {{{ script %>
    <script type="text/javascript">
<!--#include file="script/display.asp"-->
    </script>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
<!--#include file="script/nav.js"-->
    <% ' }}} %>

<!--
    <% ' {{{ script %>
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
        document.location = "divisional_LogReport.asp?overflow=y&searchVal=<%= searchVal %>&filterSelect=<%= filterSelect %>&divisionSelect=<%= divisionSelect %>";
        <% end if %>
      }
      function printPage2() {
        <% if(overflow = "y") then %>
        //window.print(); orientation='landscape'
        <% else %>
        window.open ("divisional_LogReport.asp?overflow=y&searchVal=<%= searchVal %>&filterSelect=<%= filterSelect %>&divisionSelect=<%= divisionSelect %>","printwindow");
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
        document.location = "divisional_LogReport.asp?viewdivision=<%= viewdivision %>&overflow=y&searchVal=<%= searchVal %>&filterSelect=<%= filterSelect %>&divisionSelect=<%= divisionSelect %>";
        } else {
        document.location = "divisional_LogReport.asp?viewdivision=<%= viewdivision %>&searchVal=<%= searchVal %>&filterSelect=<%= filterSelect %>&divisionSelect=<%= divisionSelect %>";
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
        document.location = "divisional_LogReport.asp?searchVal="+ document.getElementById("searchVal").value +"&filterSelect=<%= filterSelect %>&divisionSelect=<%= divisionSelect %>&overflow=<%= overflow %>";
      }

      function doFilter() {
        document.location = "divisional_LogReport.asp?searchVal=<%= searchVal %>&filterSelect="+ document.getElementById("filterSelect").value +"&divisionSelect=<%= divisionSelect %>&overflow=<%= overflow %>";
      }

      function doDivision() {
        document.location = "divisional_LogReport.asp?searchVal=<%= searchVal %>&filterSelect=<%= filterSelect %>&divisionSelect="+ document.getElementById("divisionSelect").value +"&overflow=<%= overflow %>";
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
        -->
  </head>
<body onload="init()">
      <div id="headerDiv">
<!--#include file="includes/sms_header.inc"-->
      </div>
    <center>

      <div class="tableContainer">
<% ' {{{ SQL: select division = 'iSRT
if(viewDivision = "ACG") then
    sql = "select divisionalLogNumber, srtlognumber, logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'iSRT_LogInput' and archived = 'n' and active = 'y' and division = 'ACS' and divisionalLogNumber is not null or formname = 'iSRT_LogInput' and archived = 'n' and active = 'y' and division = 'CGO' and divisionalLogNumber is not null order by logNumber desc, recid desc"
else
    sql = "select divisionalLogNumber, srtlognumber, logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'iSRT_LogInput' and archived = 'n' and active = 'y' and division = "& sqltext2(viewDivision) &" and divisionalLogNumber is not null order by logNumber desc, recid desc"
end if
set rs = conn_asap.execute(sql)
' }}} %>
        <% ' {{{ form %>
        <form name="frm" id="frm" action="divisional_LogReport.asp" method="post">
          <table cellSpacing="0" cellPadding="1" width="100%" border="0">
            <tr class="LogHead">
              <td width="5%">Divisional Log Nbr.</td>
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
          <div style="height:600;overflow:auto;">
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
<% ' {{{ Check Lock
isLocked = isLogLocked(log_number,division)
if(isLocked = "n") then
  clickloc = "document.location='divisional_LogInput.asp?position="& position &"&log_number="& log_number &"&viewDivision="& division &"'"
else
  clickloc = "alert('Log "& log_number &" locked\nuser "& isLocked &"')"
end if
' }}} %>
            <tr class="LogNumber" style="font-weight: bold; font-size:8pt; text-align:center" onclick="<%= clickloc %>" onmouseover="setRowColor(this, '#f0f0f0');this.style.cursor='hand';" onmouseout="setRowColor(this, 'white')">
              <td style="font-size:8pt;">
                <%= division %><%= log_numberStr %>&nbsp;
              </td>
              <td style="font-size:8pt;text-align:left;padding-right:10pt;padding-bottom:4px;">
                <%= item_description %>&nbsp;
              </td>
              <td>
                <%= srtlinksStr %>
              </td>
              <td>
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
              <td>
                <%= curr_risk %>&nbsp;
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
              <td>
                <%= date_completed %>&nbsp;
              </td>
              <td>
<% ' {{{ Check if completed
if(date_completed = "") then
  d2 = date
else
  d2 = date_completed
end if
' }}} %>
                <% if(len(date_opened) > 0) then %><%= datediff("d",date_opened,d2) %><% end if %>
              </td>
              <td>
                <%= item_status %>&nbsp;
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
                  <a href="divisional_LogReport.asp?position=<%= prevpos %>&filterSelect=<%= filterSelect %>&searchVal=<%= searchVal %>&divisionSelect=<%= divisionSelect %>">
                    &lt;&lt;prev
                  </a>
                <% else %>
                  &lt;&lt;prev
                <% end if %>
                </span>
                <span style="font-size:8pt;width:150px;font-weight:bold;">
                <% if(recsshown = 11) then %>
                  <a href="divisional_LogReport.asp?position=<%= currpos %>&filterSelect=<%= filterSelect %>&searchVal=<%= searchVal %>&divisionSelect=<%= divisionSelect %>">
                    next&gt;&gt;
                  </a>
                <% else %>
                  next&gt;&gt;
                <% end if %>
                </span>
              </td>
            </table>
<% end if %>
<!--#include file="includes/footer.inc"-->
          </form>
          <% ' }}} %>
        </div>
      </center>
  </body>
</html>
<xml id="xmlhttpSvc"></xml>
