<% ' vi: set foldmethod=marker syn=aspvbs linebreak autoindent tabstop=2 softtabstop=2 shiftwidth=2 expandtab: %>
<!--#include file="showVars.inc"-->
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
session("position") = startpos
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
	<section id="secondary_bar">
<!--#include file="includes/logged_in_user.inc"-->

		<div class="breadcrumbs_container">
			<article class="breadcrumbs"><a href="http://www.masoftwaresystems.us/miat/splash.aspx">Action Log</a> <div class="breadcrumb_divider"></div> <a class="current">Detail Listing</a></article>
		</div>
	</section><!-- end of secondary bar -->

<!--#include file="includes/sms_header3.inc"-->
<br/><br/>

      <div class="tableContainer" style="width:98%;margin: auto;padding-top:3px;">
        <div id="advancedSearchDIV" bgcolor="#ffffff" align="left" style="padding-left:0px;display:none;">
          <% ' {{{ form %>
          <form method="post" action="divisional_LogDisplay.aspx">
            <input type="hidden" name="searchType" id="Adv_searchType" value="<%= request("Adv_searchType") %>" >
            <input type="hidden" name="position" id="Adv_position" value="<%= request("Adv_position") %>" >
            <input type="hidden" name="overflow" id="Adv_overflow" value="<%= request("Adv_overflow") %>" >
            <% ' {{{ table %>
            <table cellspacing="0" cellpadding="1" width="100%" border="0" style="margin-bottom:0px;margin-left:10px;margin-top:0px;">
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
<% ' {{{ SQL: select division = 'EH:DIV
if(request("searchStr") <> "") then
  if(request("cookie_seeDivision") = "y") then
    sql = "select divisionalLogNumber, srtlognumber, logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'iSRT_LogInput' and active = 'y' and divisionalLogNumber is not null and  formdataXML like '%"& request("searchStr") &"%' and division = "& sqltext2(request("cookie_division")) &" order by logNumber desc, recid desc"
  else
    sql = "select divisionalLogNumber, srtlognumber, logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'iSRT_LogInput' and active = 'y' and divisionalLogNumber is not null and  formdataXML like  '%"& request("searchStr") &"%' order by logNumber desc, recid desc"
  end if

else
    sql = "select divisionalLogNumber, srtlognumber, logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'iSRT_LogInput' and active = 'y' and division = "& sqltext2(viewDivision) &" and divisionalLogNumber is not null order by logNumber desc, recid desc"
end if

'response.write(sql)
'response.end
set rs = conn_asap.execute(sql)

' }}} %>
        <% ' {{{ form %>
        <form name="frm" id="frm" action="divisional_LogDisplay.aspx" method="post">
          <table cellPadding="1" cellspacing="1" width="100%" border="0" bgcolor="silver">
            <tr class="LogHead">
              <td width="10%">Hazard ID</td>
              <td width="24%">Title/Description</td>
              <td width="8%">Hazard Owner</td>
              <td width="8%">Risk Value</td>
              <td width="6%">SOI</td>
              <td width="6%">Opened</td>
              <td width="6%">Due</td>
              <td width="6%">Completed</td>
              <td width="4%">Days</td>
              <td width="5%">Status</td>
            </tr>
<% ' {{{ if overflow
if(overflow <> "y") then %>
<!--
          </table>
          <div id="overflowDiv" style="height:475;overflow:auto;">
          <table cellSpacing="0" cellPadding="1" width="100%" border="0">
-->
<% end if ' }}} %>
<% ' {{{ XML: select safety actions
  set oXML					= CreateObject("Microsoft.XMLDOM")
  oXML.async				= false
  set oXML2					= CreateObject("Microsoft.XMLDOM")
  oXML2.async				= false

  tmpLogNumber = 0
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

  equipment					= selectNode(oXML,"equipment","")

  item_title				= rev_xdata2(selectNode(oXML,"item_title",""))


  item_description			= replace(item_description,vbcrlf,"<br>")


  hazard_base         = selectNode(oXML,"hazard_base","")
  hazard_type         = selectNode(oXML,"hazard_type","")
  hazard_number         = selectNode(oXML,"hazard_number","")

  hazard_owner         = selectNode(oXML,"hazard_owner","")


  hazard_title         = selectNode(oXML,"hazard_title","")

  hazard_number = string(4-len(hazard_number),"0") & hazard_number
  hazard_id = division &"-"& hazard_number

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

  if(divisionSelect <> "All") then
    sql = "select recid from SRT_LogNumberDivisions where log_number = "& sqlnum(log_number) &" and archived = 'n' and division = "& sqltext2(divisionSelect)
    set drs = conn_asap.execute(sql)
    if not drs.eof then
      divisionHit = 1
    else
      divisionHit = 0
    end if
  end if

  if(searchVal <> "") then
    if(instr(lcase(formDataXML),lcase(searchVal)) > 0) then
      searchHit = 1
    else
      if(searchVal = division&log_numberStr) then
        searchHit = 1
      else
        searchHit = 0
      end if
    end if
  end if

  end if

  if(request("advancedsearch") = "y") then
    searchHit = 1


    if(request("item_title") <> "") then
      if(instr(lcase(item_title),lcase(request("item_title"))) = 0) then
        searchHit = 0
      end if
    end if

    if(request("item_description") <> "") then
      if(instr(lcase(item_description),lcase(request("item_description"))) = 0) then
        searchHit = 0
      end if
    end if

    if(request("equipment") <> "") then
      if(instr(lcase(equipment),lcase(request("equipment"))) = 0) then
        searchHit = 0
      end if
    end if

    if(request("accountable_leader") <> "") then
      if(instr(lcase(selectNode(oXML,"accountable_leader","")),lcase(request("accountable_leader"))) = 0) then
        searchHit = 0
      end if
    end if

    if(request("soi") <> "") then
      if(instr(lcase(selectNode(oXML,"soi","")),lcase(request("soi"))) = 0) then
        searchHit = 0
      end if
    end if

    if(request("hl") <> "") then
      if(instr(lcase(selectNode(oXML,"hl","")),lcase(request("hl"))) = 0) then
        searchHit = 0
      end if
    end if

    if(request("soi") <> "") then
      if(instr(lcase(selectNode(oXML,"soi","")),lcase(request("soi"))) = 0) then
        searchHit = 0
      end if
    end if

    if(request("date_opened") <> "") then
      if(instr(lcase(selectNode(oXML,"date_opened","")),lcase(request("date_opened"))) = 0) then
        searchHit = 0
      end if
    end if

    if(request("date_due") <> "") then
      if(instr(lcase(selectNode(oXML,"date_due","")),lcase(request("date_due"))) = 0) then
        searchHit = 0
      end if
    end if

    if(request("date_completed") <> "") then
      if(instr(lcase(selectNode(oXML,"date_completed","")),lcase(request("date_completed"))) = 0) then
        searchHit = 0
      end if
    end if

    if(request("item_status") <> "") then
      if(instr(lcase(selectNode(oXML,"item_status","")),lcase(request("item_status"))) = 0) then
        searchHit = 0
      end if
    end if

    if(request("base") <> "") then
      if(instr(lcase(selectNode(oXML,"base","")),lcase(request("base"))) = 0) then
        searchHit = 0
      end if
    end if

    if(request("mission") <> "") then
      if(instr(lcase(selectNode(oXML,"mission","")),lcase(request("mission"))) = 0) then
        searchHit = 0
      end if
    end if

    if(request("hazard_owner") <> "") then
      if(instr(lcase(selectNode(oXML,"hazard_owner","")),lcase(request("hazard_owner"))) = 0) then
        searchHit = 0
      end if
    end if

    if(request("hazard_editor") <> "") then
      if(instr(lcase(selectNode(oXML,"hazard_editor","")),lcase(request("hazard_editor"))) = 0) then
        searchHit = 0
      end if
    end if

    if(request("next_review_date") <> "") then
      if(instr(lcase(selectNode(oXML,"next_review_date","")),lcase(request("next_review_date"))) = 0) then
        searchHit = 0
      end if
    end if

    if(request("endorsed") <> "") then
      if(instr(lcase(selectNode(oXML,"endorsed","")),lcase(request("endorsed"))) = 0) then
        searchHit = 0
      end if
    end if

    if(request("endorsed_by") <> "") then
      if(instr(lcase(selectNode(oXML,"endorsed_by","")),lcase(request("endorsed_by"))) = 0) then
        searchHit = 0
      end if
    end if

    if(request("item_comments") <> "") then
      if(instr(lcase(selectNode(oXML,"item_comments","")),lcase(request("item_comments"))) = 0) then
        searchHit = 0
      end if
    end if

    if(request("alarp_statement") <> "") then
      if(instr(lcase(selectNode(oXML,"alarp_statement","")),lcase(request("alarp_statement"))) = 0) then
        searchHit = 0
      end if
    end if

    if(request("further_risk_reduction_needed") <> "") then
      if(instr(lcase(selectNode(oXML,"further_risk_reduction_needed","")),lcase(request("further_risk_reduction_needed"))) = 0) then
        searchHit = 0
      end if
    end if

    if(request("hazard_ok") <> "") then
      if(instr(lcase(selectNode(oXML,"hazard_ok","")),lcase(request("hazard_ok"))) = 0) then
        searchHit = 0
      end if
    end if

  end if ' End if(request("advancedsearch") = "y")

  'if((searchHit = 1) and (filterHit = 1) and (divisionHit = 1)) then
  if(1=1) then

  skiprec = "n"
  currpos = currpos +1
  if(startpos > 0) then
    if(startpos >= currpos) then
      skiprec = "y"
    end if
  end if

  if((skiprec <> "y") or (overflow = "y")) then

  'response.write("<tr><td colspan='9'>skiprec:"& skiprec &"<br></td></tr>")
  'response.write("<tr><td colspan='9'>recsshown:"& recsshown &"<br></td></tr>")
  'response.write("<tr><td colspan='9'>currpos:"& currpos &"<br></td></tr>")
  'response.write("<tr><td colspan='9'>hazard_title:"& hazard_title &"<br></td></tr>")
  'response.write("<tr><td colspan='9'>division:"& division &"<br></td></tr>")
  'response.write("<tr><td colspan='9'>log_number:"& log_number &"<br></td></tr>")

  recsshown = recsshown +1
  if((recsshown = 11) and (overflow <> "y")) then
    currpos = currpos -1
    exit do
  end if

  curr_risk = ""


  sql = "select logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'risk' and divisionallogNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' and division = "& sqltext2(viewdivision) &" order by logNumber desc, recid desc"
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

    srtlinksStr = srtlinksStr &"EH:DIV"& string(4-len(srtLogNumber),"0")&srtLogNumber &"<br>"

    'sql = "select division, divisionalLogNumber from EHD_Data where srtLogNumber = "& sqlnum(srtLogNumber) &" and active = 'y' and archived = 'n' and formname = 'iSRT_LogInput' order by division asc, divisionalLogNumber asc"
    'set rs5 = conn_asap.execute(sql)
    'do while not rs5.eof
    '  srtdivision				= rs5("division")
    '  srtdivisionalLogNumber	= rs5("divisionalLogNumber")
    '  if((srtdivisionalLogNumber <> log_number) and (srtdivision <> division)) then
    '    srtlinksStr = srtlinksStr & srtdivision & string(4-len(srtdivisionalLogNumber),"0")&srtdivisionalLogNumber &"<br>"
    '  end if
'
    '  rs5.movenext
    'loop
    srtlinksStr = rtrim(srtlinksStr)

  end if

'response.write("date_due:"&date_due&":")
'response.end

if((date_due <> "") and (not isnull(date_due)) and (isdate(date_due))) then
  if(instr(date_due,"-") > 0) then
    date_dueArr = split(date_due,"-")
    date_due2 = date_dueArr(2)&"/"&date_dueArr(1)&"/"&date_dueArr(0)
  else
    date_due2 = date_due
  end if
  tmp_monthStr = datepart("m",date_due2)
  tmp_dayStr = datepart("d",date_due2)
  tmp_yearStr = datepart("yyyy",date_due2)
  due_dateStr2 = tmp_monthStr &"/"& tmp_dayStr &"/"& tmp_yearStr
else
  due_dateStr2 = date
end if

if((date_opened <> "") and (not isnull(date_opened)) and (isdate(date_opened))) then
  if(instr(date_opened,"-") > 0) then
    date_openedArr = split(date_opened,"-")
    date_opened2 = date_openedArr(2)&"/"&date_openedArr(1)&"/"&date_openedArr(0)
  else
    date_opened2 = date_opened
  end if
  tmp_monthStr = datepart("m",date_opened2)
  tmp_dayStr = datepart("d",date_opened2)
  tmp_yearStr = datepart("yyyy",date_opened2)
   date_openedStr2 = tmp_monthStr &"/"& tmp_dayStr &"/"& tmp_yearStr
else
  date_openedStr2 = ""
end if

if((date_completed <> "") and (not isnull(date_completed)) and (isdate(date_completed))) then
  if(instr(date_completed,"-") > 0) then
    date_completedArr = split(date_completed,"-")
    date_completed2 = date_completedArr(2)&"/"&date_completedArr(1)&"/"&date_completedArr(0)
  else
    date_completed2 = date_completed
  end if
  tmp_monthStr = datepart("m",date_completed2)
  tmp_dayStr = datepart("d",date_completed2)
  tmp_yearStr = datepart("yyyy",date_completed2)
  date_completedStr2 = tmp_monthStr &"/"& tmp_dayStr &"/"& tmp_yearStr
else
  date_completedStr2 = ""
end if

daysStr = ""
if((date_completed <> "") and (isdate(date_openedStr2)) and (not isnull(date_completed)) and (isdate(date_completed))) then
  daysStr = datediff("d",date_openedStr2,date_completedStr2)
else
  daysStr = datediff("d",date,due_dateStr2)
end if

accountable_leaderStr = ""
if(isnumeric(hazard_owner)) then
  sql = "select first_name, last_name from tbl_logins where loginid = "& sqlnum(hazard_owner)
  set acrs = conn_asap.execute(sql)
  if not acrs.eof then
    accountable_leaderStr = acrs("first_name") &" "& acrs("last_name")
  end if
end if

%>
<!--
Dates:
date_due:<%= date_due %>:
date_opened:<%= date_opened %>:
date_completed:<%= date_completed %>:
-->
<%

if((clng(daysStr) < 0) and ((date_completed = "") or (isnull(date_completed)))) then
  lateColor = "red"
else
  lateColor = "black"
end if

date_openedStr = ""
if((date_opened <> "") and (not isnull(date_opened)) and (isdate(date_opened))) then
  'date_openedStr = day(date_opened) &"-"& monthname(month(date_opened),true) &"-"& year(date_opened)
  date_openedStr = year(date_opened) &"-"& monthname(month(date_opened),true) &"-"& day(date_opened)
end if
date_dueStr = ""
if((date_due <> "") and (not isnull(date_due)) and (isdate(date_due))) then
  'date_dueStr = day(date_due) &"-"& monthname(month(date_due),true) &"-"& year(date_due)
  date_dueStr = year(date_due) &"-"& monthname(month(date_due),true) &"-"& day(date_due)
end if
date_completedStr = ""
if((date_completed <> "") and (not isnull(date_completed)) and (isdate(date_completed))) then
  'date_completedStr = day(date_completed) &"-"& monthname(month(date_completed),true) &"-"& year(date_completed)
  date_completedStr = year(date_completed) &"-"& monthname(month(date_completed),true) &"-"& day(date_completed)
end if
next_review_dateStr = ""
if((next_review_date <> "") and (not isnull(next_review_date)) and (isdate(next_review_date))) then
  'next_review_dateStr = day(next_review_date) &"-"& monthname(month(next_review_date),true) &"-"& year(next_review_date)
  next_review_dateStr = year(next_review_date) &"-"& monthname(month(next_review_date),true) &"-"& day(next_review_date)
end if

  'response.write("<tr><td colspan='11'>log_number:"& log_number &"<br></td></tr>")
  'response.write("<tr><td colspan='11'>tmpLogNumber:"& tmpLogNumber &"<br></td></tr>")
  'if(cint(tmpLogNumber) <> cint(log_number)) then
  if(1=1) then
    tmpLogNumber = log_number
' }}} %>
<% if(firstOne <> "y") then %>
<!--
            <tr>
              <td bgcolor="#ffffff" colspan="10" >
                <div style="height:0px;border:0px solid black;font-size:0px;background-color:#000040;"></div>
              </td>
            </tr>
-->
<% else %>
<% firstOne = "n" %>
<% end if %>
<% ' {{{ Check Log
isLocked = isLogLocked(log_number,division)
if((request("cookie_editDivision") <> "y") and (request("cookie_administrator") <> "y")) then
  clickloc = "document.location='divisional_LogPicture.aspx?position="& position &"&log_number="& log_number &"&viewDivision="& division &"'"
else
  if(isLocked = "n") then
    clickloc = "document.location='divisional_LogInput2.aspx?position="& position &"&log_number="& log_number &"&viewDivision="& division &"'"
  else
    clickloc = "alert('Hazard locked by "& isLocked &"')"
  end if
end if
' }}} %>
            <tr class="LogNumber" style="font-weight: normal; font-size: 8pt; text-align:center" onmouseover="setRowColor(this, '#f0f0f0');this.style.cursor='hand';" onmouseout="setRowColor(this, 'white')">
<% if(isLocked <> "n") then %>
                <td style="font-size:8pt;" align="left">
                <span style="font-weight:bold;" onclick="<%= clickloc %>"><%= hazard_id %>&nbsp;</span>
                  <br><input type="button" title="Request Unlock" value="Unlock" onclick="requestUnlock('<%= division %>','<%= log_number %>')" style="width:60px;font-size:9pt;">
                </td>
<% else %>
                <td onclick="<%= clickloc %>" style="font-size:8pt;" align="left">
                <span style="font-weight:bold;" onclick="<%= clickloc %>"><%= hazard_id %>&nbsp;</span>
                </td>
<% end if %>

              <td onclick="<%= clickloc %>" style="text-align:left;padding-right:10pt;padding-bottom:4px;">
                <span decode style="color:<%= lateColor %>;font-weight:bold;"><u><%= hazard_title %></u></span><% if(item_description <> "") then %><span decode>&nbsp;&nbsp;<%= item_description %></span><% end if %>&nbsp;
              </td>
              <td onclick="<%= clickloc %>">
                <span decode>&nbsp;</span>
              </td>
              <td onclick="<%= clickloc %>">
                <span decode><%= curr_risk %>&nbsp;</span>
              </td>
              <td onclick="<%= clickloc %>">
                <span decode><%= transSOI(soi) %>&nbsp;</span>
              </td>
              <td onclick="<%= clickloc %>">
                <span decode><%= date_openedStr %>&nbsp;</span>
              </td>
              <td onclick="<%= clickloc %>">
                <span decode><%= date_dueStr %>&nbsp;</span>
              </td>
              <td onclick="<%= clickloc %>">
                <span decode><%= date_completedStr %>&nbsp;</span>
              </td>
              <td onclick="<%= clickloc %>" style="color:<%= lateColor %>;">
                <span decode><%= daysStr %>&nbsp;</span>
              </td>
              <td onclick="<%= clickloc %>">
                <span decode><%= item_status %>&nbsp;</span>
              </td>
            </tr>
<% ' {{{ Check if is locked
if(tmpCnt > 0) then
isLocked = isLogLocked(log_number,division)
if(request("cookie_employee_type") = "Primary User Level")  then
  clickloc = "document.location='divisional_LogPicture.aspx?position="& position &"&log_number="& log_number &"&viewDivision="& division &"'"
else
  if(isLocked = "n") then
    clickloc = "document.location='divisional_LogInput2.aspx?position="& position &"&log_number="& log_number &"&viewDivision="& division &"'"
  else
    clickloc = "alert('"& division & log_numberStr &" locked by "& isLocked &"')"
  end if
end if
' }}} %>
            <tr class="ItemHead" onclick="<%= clickloc %>"  onmouseover="this.style.cursor='hand';" style="font-weight:normal;text-align:center;background-color: #ffffff">
              <td>
                &nbsp;
              </td>
              <td>
                &nbsp;
              </td>
              <td>
                &nbsp;
              </td>
              <td>
                Opened
              </td>
              <td >
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
              <td>
                &nbsp;
              </td>
            </tr>
            <!--
            <tr><td colspan="10" style="height:4px;background-color2:#dcdcdf;background-color:#ffffff;"></td></tr>
            -->
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
  safety_action_base		= rev_xdata2(selectNode(oXML,"safety_action_base_"& a,""))
  if(safety_action_poc = "Other") then
    safety_action_poc = safety_action_other_name
  end if

if((safety_action_open <> "") and (not isnull(safety_action_open)) and (isdate(safety_action_open))) then
  'safety_action_openStr = day(safety_action_open) &"-"& monthname(month(safety_action_open),true) &"-"& year(safety_action_open)
  safety_action_openStr = year(safety_action_open) &"-"& monthname(month(safety_action_open),true) &"-"& day(safety_action_open)
end if
if((safety_action_due <> "") and (not isnull(safety_action_due)) and (isdate(safety_action_due))) then
  'safety_action_dueStr = day(safety_action_due) &"-"& monthname(month(safety_action_due),true) &"-"& year(safety_action_due)
  safety_action_dueStr = year(safety_action_due) &"-"& monthname(month(safety_action_due),true) &"-"& day(safety_action_due)
end if
if((safety_action_completed <> "") and not(isnull(safety_action_completed)) and (isdate(safety_action_completed))) then
  'safety_action_completedStr = day(safety_action_completed) &"-"& monthname(month(safety_action_completed),true) &"-"& year(safety_action_completed)
  safety_action_completedStr = year(safety_action_completed) &"-"& monthname(month(safety_action_completed),true) &"-"& day(safety_action_completed)
end if

' }}} %>
<% ' {{{ Check if is locked
isLocked = isLogLocked(log_number,division)
if(request("cookie_employee_type") = "Primary User Level")  then
  clickloc = "document.location='divisional_LogPicture.aspx?position="& position &"&log_number="& log_number &"&viewDivision="& division &"'"
else
  if(isLocked = "n") then
    clickloc = "document.location='divisional_LogInput2.aspx?position="& position &"&log_number="& log_number &"&viewDivision="& division &"'"
  else
    clickloc = "alert('"& division & log_numberStr &" locked by "& isLocked &"')"
  end if
end if
' }}} %>
            <tr class="ItemHead" onclick="<%= clickloc %>"  onmouseover="setRowColor2(this, '#f0f0f0');this.style.cursor='hand';" onmouseout="setRowColor2(this, 'white')" style="font-weight:normal;text-align:center;background-color: #ffffff">
              <td>
                <span decode><%= hazard_id %>.<%= a %></span>
              </td>
              <td style="font-weight:normal;text-align:left">
                <!-- <span style="font-weight:bold;font-size:8pt;color:#000040;"><%= safety_action_type_ %>:</span><br/> --><%= safety_action %>&nbsp;
              </td>
              <td>
                <span decode><%= safety_action_base %>&nbsp;</span>
              </td>
              <td>
                <span decode><%= safety_action_openStr %>&nbsp;</span>
              </td>
              <td >
                <span decode><%= safety_action_dueStr %>&nbsp;</span>
              </td>
              <td>
                <span decode><%= safety_action_completedStr %>&nbsp;</span>
              </td>
              <td>
<% ' {{{ Check if completed
if(safety_action_completed = "") then
  d2 = date
else
  d2 = safety_action_completed
end if
' }}} %>
                <% if((len(safety_action_open) > 0) and (isdate(safety_action_due))) then %><%= datediff("d",safety_action_due,date) %><% end if %>&nbsp;
              </td>
              <td>
                <span decode><%= safety_action_status %>&nbsp;</span>
              </td>
              <td>
                &nbsp;
              </td>
              <td>
                &nbsp;
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
" and a.division = '"& viewdivision &"' "& _
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
if(acnt > 0) then
' }}} %>
            <tr  onclick="<%= clickloc %>" onmouseover="this.style.cursor='hand';" onmouseout="">
              <td class2="LogNumber" style="padding-left:5px;text-align:left;" colspan="11">
                <!--
                <span style="font-weight:normal">
                  <a href="divisional_Attachments.aspx?log_number=<%= log_number %>&viewDivision=<%= division %>" style="text-decoration:none;">
                    Attachments(<b><%= acnt %></b>)
                  </a>
                </span>
                -->
                <span style="font-weight:normal;font-size:8pt;">Attachments(<b><%= acnt %></b>)</span>
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
<% end if %>
            <tr><td style="height:1px;background-color:#ADD1FF;" height="1" bgcolor2="#80B7FF;" bgcolor="#ADD1FF;" colspan="10"></td></tr>
<% ' {{{ End loop through log numbers
  end if
  end if
  end if
  rs.movenext
  loop
' }}} %>
          </table>
<% if(overflow <> "y") then %>
<!--
          </div>
-->
<% end if %>
          <div width="100%" style="border-top: 1px solid gray;"></div>
<% if(overflow <> "y") then %>
            <table cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="white">
            <tr>
              <td align="center">
                <span style="font-size:8pt;width:150px;font-weight:bold;">
                <% if(startpos > 0) then %>
                  <a href="divisional_LogDisplay.aspx?position=<%= prevpos %>&filterSelect=<%= filterSelect %>&searchStr=<%= request("searchStr") %>&divisionSelect=<%= divisionSelect %>&viewDivision=<%= viewDivision %>">
                    &lt;&lt;prev
                  </a>
                <% else %>
                  &lt;&lt;prev
                <% end if %>
                </span>
                <span style="font-size:8pt;width:150px;font-weight:bold;">
                <% if(recsshown = 11) then %>
                  <a href="divisional_LogDisplay.aspx?position=<%= currpos %>&filterSelect=<%= filterSelect %>&searchStr=<%= request("searchStr") %>&divisionSelect=<%= divisionSelect %>&viewDivision=<%= viewDivision %>">
                    next&gt;&gt;
                  </a>
                <% else %>
                  next&gt;&gt;
                <% end if %>
                </span>
              </td>
            </tr>
<%
if(searchVal = "") then
%>
            <tr style="padding-top:5px;">
              <td align="center">
                <span style="font-size:8pt;font-weight:bold;">
                Pages:
<%
if(request("searchStr") <> "") then
  if(request("cookie_seeDivision") = "y") then
    sql = "select count(*) cnt from EHD_Data where formname = 'iSRT_LogInput' and active = 'y' and divisionalLogNumber is not null and  formdataXML like  '%"& request("searchStr") &"%' and division = "& sqltext2(request("cookie_division"))
  else
    sql = "select count(*) cnt from EHD_Data where formname = 'iSRT_LogInput' and active = 'y' and divisionalLogNumber is not null and  formdataXML like '%"& request("searchStr") &"%'"
  end if

else
    sql = "select count(*) cnt from EHD_Data where formname = 'iSRT_LogInput' and active = 'y' and division = "& sqltext2(viewDivision) &" and divisionalLogNumber is not null"
end if

  'sql = "select count(*) cnt from EHD_Data where formname = 'iSRT_LogInput' and archived = 'n' and active = 'y' and division = "& sqltext2(viewDivision) &" and divisionalLogNumber is not null"
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
<span style="width:20px;text-align:center;"><a href="divisional_LogDisplay.aspx?position=<%= tmppos %>&filterSelect=<%= filterSelect %>&searchVal=<%= searchVal %>&divisionSelect=<%= divisionSelect %>&viewDivision=<%= viewDivision %>&searchStr=<%= request("searchStr") %>"><%= pagenum %></a></span>
<%
      end if
      tmpcnt = tmpcnt - 10
    loop
  end if
%>
                </span>
              </td>
            </tr>
<%
end if
%>
            </table>
<% end if %>

          </form>
          <% ' }}} %>
        </div>
      </div>
      </center>

<xml id="xmlhttpSvc"></xml>
