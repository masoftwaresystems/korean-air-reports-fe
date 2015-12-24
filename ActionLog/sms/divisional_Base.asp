<% ' vi: set foldmethod=marker syn=aspvbs linebreak autoindent tabstop=2 softtabstop=2 shiftwidth=2 expandtab: %>
<!--#include file="includes/security.inc" -->
<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include file="includes/commonUtils.inc"-->
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

currbase = request("base")
currtype = request("currtype")
' }}} %>
	<section id="secondary_bar">
<!--#include file="includes/logged_in_user.inc"-->

		<div class="breadcrumbs_container">
			<article class="breadcrumbs"><a href="http://www.masoftwaresystems.us/miat/splash.aspx">Action Log</a> <div class="breadcrumb_divider"></div> <a class="current">Short Listing</a></article>
		</div>
	</section><!-- end of secondary bar -->

<!--#include file="includes/sms_header3.inc"-->
<br/><br/>

      <div align="center">

      <table border="0" cellpadding="0" cellspacing="0" width="98%">
      <tr valign="top"><td width="45%">
      <div style="width:98%;margin: auto;padding-top:15px;padding-left:10px;padding-bottom:10px;border:1px solid silver;height:2000px;overflow:auto;">
      <table border="0" cellspacing="2" cellpadding="0" width="100%">

<%

set oXML				= CreateObject("Microsoft.XMLDOM")
oXML.async				= false

tmpbase = ""
tmphazard_type = ""
sql = "select divisionalLogNumber, srtlognumber, logNumber, division, recid, loginID, createDate, formdataXML, base from EHD_Data where formname = 'iSRT_LogInput' and archived = 'n' and active = 'y' and division = "& sqltext2(viewDivision) &" and divisionalLogNumber is not null order by hazard_number desc"
response.write("<!-- sql: "& sql &" -->")
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

  hazard_title         = selectNode(oXML,"hazard_title","")

  'hazard_number = string(4-len(hazard_number),"0") & hazard_number
  'hazard_id = viewDivision &"-"& hazard_base &"-"& hazard_type &"-"& hazard_number

  hazard_number = string(4-len(hazard_number),"0") & hazard_number
  hazard_id = viewDivision &"-"& hazard_number

  if(tmphazard_type <> hazard_type) then
    tmphazard_type = hazard_type
%>
		<tr valign="bottom" height="20">
		  <td align="left" style="padding-left:40px;"><a href="divisional_Base.aspx?viewdivision=<%= viewdivision %>&viewtype=<%= viewtype %>&base=GEN"><img src="images/collapse.gif" border="0"><span style="font-weight: bold; font-size: 10pt;"><%= viewDivision %></span></a></td>
		</tr>
<%
  end if
%>
		<tr>
		  <td height="5"></td>
		</tr>
		<tr>
		  <td align="left"><span style="padding-left:80px;font-weight: bold; font-size: 8pt;"><% if(request("cookie_administrator") = "y") then %><input type="button" value="delete" style="font-size:10px;font-weight:normal;" onclick="showConfirm('<%= hazard_id %>',this)" id="BTN_<%= hazard_id %>"> <% end if %><a href="getSummary.asp?log_number=<%= log_number%>&viewdivision=<%= viewdivision %>&framed=y&cookie_administrator=<%= request("cookie_administrator") %>&cookie_editDivision=<%= request("cookie_editDivision") %>" target="detailFrame"><%= hazard_id %> : <span decode><%= hazard_title %></span></a>
<% if(request("cookie_administrator") = "y") then %>
<% if(isValidHazardID(hazard_id)) then %>
<div id="CONFIRM_DIV_<%= hazard_id %>" style="margin-left:90px;width:170px;border:1px solid black;background-color:white;font-size:10px;font-weight:bold;text-align:center;padding-top:5px;padding-bottom:5px;display:none;">
Delete <span id="CONFIRM_TITLE_<%= hazard_id %>"></span>?<br><br>
<input type="button" value="yes" style="font-size:10px;font-weight:normal;width:50px;"  onclick="deleteConfirm('<%= hazard_id %>')"> <input type="button" value="no" style="font-size:10px;font-weight:normal;width:50px;" onclick="closeConfirm('<%= hazard_id %>')">
</div>
<% else %>
<div id="CONFIRM_DIV_<%= hazard_id %>" style="margin-left:90px;width:170px;border:1px solid black;background-color:white;font-size:10px;font-weight:bold;text-align:center;padding-top:5px;padding-bottom:5px;display:none;">
<span id="CONFIRM_TITLE_<%= hazard_id %>"></span> cannot be deleted<br>Please contact administrator<br><br>
<input type="button" value="close" style="font-size:10px;font-weight:normal;width:50px;" onclick="closeConfirm('<%= hazard_id %>')">
</div>
<% end if %>
		  </span></td>
		</tr>
<%
  end if
  rs.movenext
loop

%>
      </table>
      </div>
      </td><td width="55%">
      <div style="width:98%;margin: auto;padding-top:3px;padding-bottom:5px;border:1px solid silver;height:2017px;overflow:auto;">
<iframe name="detailFrame" id="detailFrame" src ="blank.asp" width="100%" height="2000px" frameborder="0" marginheight="0" marginwidth="3">
  <p>Your browser does not support iframes.</p>
</iframe>
      </div>
      </td></tr>
      </table>
      </div>
<br />
<% if(request("cookie_administrator") = "y") then %>
<script>
function showConfirm(v,o) {

  document.getElementById("CONFIRM_TITLE_"+v).innerHTML = v;
  document.getElementById("CONFIRM_DIV_"+v).style.display = "block";
}
function closeConfirm(v) {
  document.getElementById("CONFIRM_DIV_"+v).style.display = "none";
}
function deleteConfirm(v) {
  document.location = "deleteHazard.asp?h="+v;
}
</script>
<% end if %>
