<% ' vi: set foldmethod=marker syn=aspvbs linebreak autoindent tabstop=2 softtabstop=2 shiftwidth=2 expandtab: %>
<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<!--#include virtual="/global_includes/utils.inc"-->
<% ' {{{ Initial Requests
unlockLogs
if not(isInternal) then
  response.redirect "index.asp"
  response.end
end if
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

currbase = request("base")
' }}} %>

 <!--#include file="includes/sms_headerInternal.inc"-->

      <div align="center">
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:20px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:14px;color:#737579;">Hazards by Base</span></td></tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;margin-bottom:5px;">
  <tr><td align="center"><img src="images/1pgrey.gif" width="300" height="1"></td></tr>
</table>

      <table border="0" cellpadding="0" cellspacing="0" width="98%">
      <tr valign="top"><td width="45%">
      <div style="width:98%;margin: auto;padding-top:15px;padding-left:10px;padding-bottom:10px;border:1px solid black;height:530px;overflow:auto;">
      <table border="0" cellspacing="2" cellpadding="0" width="100%">

<%

set oXML				= CreateObject("Microsoft.XMLDOM")
oXML.async				= false

if(viewdivision = "") then
  viewdivision = "X"
end if

sql = "select CURRENT_BASE from BUtoBASE where BUSINESS_UNIT = "& sqltext2(viewdivision) &" order by CURRENT_BASE asc"
set ors = conn_asap.execute(sql)

do while not ors.eof

%>
		<tr valign="bottom" height="20">
		  <td align="left"><% if(currbase = ors("CURRENT_BASE")) then %><a href="internalReports.asp?viewdivision=<%= viewdivision %>&viewtype=<%= viewtype %>"><img src="http://www.bristowsafety.com/sms_images/collapse.gif" border="0"><span style="font-weight: bold; font-size: 10pt;"><%= ors("CURRENT_BASE") %></span></a><% else %><a href="internalReports.asp?viewdivision=<%= viewdivision %>&viewtype=<%= viewtype %>&base=<%= ors("CURRENT_BASE") %>"><img src="http://www.bristowsafety.com/sms_images/expand.gif" border="0"><span style="font-weight: bold; font-size: 10pt;"><%= ors("CURRENT_BASE") %></span></a><% end if %></td>
		</tr>
<!--
currbase:<%= currbase %>:
ors("CURRENT_BASE"):<%= ors("CURRENT_BASE") %>:
-->
<%
if((currbase = ors("CURRENT_BASE"))) then

tmpbase = ""
sql = "select divisionalLogNumber, srtlognumber, logNumber, division, recid, loginID, createDate, formdataXML, base from EHD_Data where formname = 'iSRT_LogInput' and archived = 'n' and active = 'y' and division = "& sqltext2(viewDivision) &" and divisionalLogNumber is not null and base in ('All',"& sqltext2(ors("CURRENT_BASE")) &") order by base asc, logNumber desc"
'response.write(sql)
'response.end
set rs = conn_asap.execute(sql)
do while not rs.eof
  base = rs("base")

  loginID					= rs("loginID")
  createDate				= rs("createDate")
  formDataXML				= rs("formDataXML")
  recid						= rs("recid")
  division					= rs("division")

  srtlognumber				= rs("srtlognumber")
  srtlog_number				= srtlognumber
  if(len(srtlog_number) > 0) then
    srtlog_numberStr			= "EH:DIV"&string(4-len(srtlog_number),"0")&srtlog_number
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

  item_title				= rev_xdata2(selectNode(oXML,"item_title",""))

  hazard_base         = selectNode(oXML,"hazard_base","")
  hazard_type         = selectNode(oXML,"hazard_type","")
  hazard_number         = selectNode(oXML,"hazard_number","")

  'hazard_number = string(4-len(hazard_number),"0") & hazard_number
  'hazard_id = viewDivision &"-"& hazard_base &"-"& hazard_type &"-"& hazard_number

  hazard_number = string(4-len(hazard_number),"0") & hazard_number
  hazard_id = viewDivision &"-"& hazard_number
%>
		<tr>
		  <td height="5"></td>
		</tr>
		<tr>
		  <td align="left"><span style="padding-left:40px;font-weight: bold; font-size: 8pt;"><a href="getSummary.asp?log_number=<%= log_number%>&viewdivision=<%= viewdivision %>&framed=y" target="detailFrame"><%= hazard_id %> : <%= item_title %></a></span></td>
		</tr>
<%
  rs.movenext
loop
end if
  ors.movenext
loop

%>
      </table>
      </div>
      </td><td width="55%">
      <div style="width:98%;margin: auto;padding-top:3px;padding-bottom:5px;border:1px solid black;height:547px;overflow:auto;">
<iframe name="detailFrame" id="detailFrame" src ="blank.asp" width="100%" height="520" frameborder="0" marginheight="0" marginwidth="3">
  <p>Your browser does not support iframes.</p>
</iframe>
      </div>
      </td></tr>
      </table>
      </div>
<br />

<!--#include file ="includes/footer.inc"-->

   </body>
</html>