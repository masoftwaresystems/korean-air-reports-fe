<!--#include file="showVars.inc"-->
<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/commonUtils.inc" -->
<!--#include file="includes/security.inc" -->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include file="includes/lockMgr.inc"-->
 <script>
$(function() {
var availableTags = [
<%
stationOpts = "<option value=''></option>"
sql = "select distinct station from station_t order by station asc"
set tmprs=conn_asap.execute(sql)
do while not tmprs.eof
%>
"<%= tmprs("station")  %>",
<%
  tmprs.movenext
loop
%>
""
];
$( "#station" ).autocomplete({
source: availableTags
});
});
</script>
<%

unlockLogs
if(isLogLocked(request("log_number"),request("viewDivision")) <> "n") then
  response.redirect("divisional_LogDisplay.aspx")
  response.end
end if
lockLog request("log_number"),request("viewDivision")
viewDivision = request("viewDivision")
if(len(viewDivision) = 0) then
  'viewDivision = "ACS"
  viewDivision = request("cookie_division")
end if

log_number = request("log_number")
position = request("position")

newlog = "n"
if(log_number = "") then
  newlog = "y"
  if( (viewDivision = "ACSx") or (viewDivision = "CGOx") ) then
    sql = "select max(divisionalLogNumber) maxlognumber from EHD_Data where division in ('ACS','CGO') and divisionalLogNumber is not null and formName = 'iSRT_LogInput'"
  else
    sql = "select max(divisionalLogNumber) maxlognumber from EHD_Data where division = "& sqltext2(viewDivision) &" and divisionalLogNumber is not null and formName = 'iSRT_LogInput'"
  end if
  set tmprs=conn_asap.execute(sql)
  if not tmprs.eof then
    if(isnull(tmprs("maxlognumber"))) then
      log_number = 0
    else
      log_number = cint(tmprs("maxlognumber"))
    end if
  else
    log_number = 0
  end if
  log_number = log_number +1

end if

log_number				= string(4-len(log_number),"0")&log_number

hazard_type = request("type")
hazard_number = 0
if(hazard_type <> "") then

baseStr = ""
sql = "select current_base, code from BUtoBASE where business_unit = "& sqltext2(viewDivision) &" order by code asc"
set tmprs = conn_asap.execute(sql)
do while not tmprs.eof
  baseStr = baseStr & sqltext2(tmprs("code")) &","
  tmprs.movenext
loop
baseStr = baseStr &"'X'"

  sql = "select max(hazard_number) max_hazard_number from EHD_Data where formname = 'iSRT_LogInput' and division = "& sqltext2(viewDivision) &" and hazard_type = "& sqltext2(request("type"))
  set tmprs=conn_asap.execute(sql)
  if not tmprs.eof then
    if(isnull(tmprs("max_hazard_number"))) then
      hazard_number = 0
    else
      hazard_number = cint(tmprs("max_hazard_number"))
    end if
  else
    hazard_number = 0
  end if
    hazard_base = request("base")
    hazard_type = request("type")
  hazard_number = hazard_number +1

  base = request("base")

else

  sql = "select hazard_base, hazard_type, hazard_number from EHD_Data where formname = 'iSRT_LogInput' and division = "& sqltext2(viewDivision) &" and divisionalLogNumber = "& sqlnum(log_number) &" and active = 'y'"
  set tmprs=conn_asap.execute(sql)
  if not tmprs.eof then
    hazard_base = tmprs("hazard_base")
    hazard_type = tmprs("hazard_type")
    if(isnull(tmprs("hazard_number"))) then
      hazard_number = 0
    else
      hazard_number = cint(tmprs("hazard_number"))
    end if
  end if
end if

'response.write(sql)
'response.end

hazard_number = string(4-len(hazard_number),"0") & hazard_number
hazard_id = viewDivision &"-"& hazard_number

sql = "select current_base from BUtoBASE where business_unit = "& sqltext2(viewDivision) &" and code = "& sqltext2(hazard_base)
set tmprs = conn_asap.execute(sql)
if not tmprs.eof then
  baseStr = tmprs("current_base")
end if

sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and division = "& sqltext2(viewDivision) &" and divisionalLogNumber = "& sqlnum(log_number) &" order by divisionalLogNumber desc, recid desc"
  set rs=conn_asap.execute(sql)

log_numberStr				= string(4-len(log_number),"0")&log_number

set oXML					= CreateObject("Microsoft.XMLDOM")
oXML.async					= false

if not rs.eof then
  loginID					= rs("loginID")
  createDate				= rs("createDate")
  formDataXML				= rs("formDataXML")
  recid						= rs("recid")
  generic					= rs("generic")
  'log_number				= rs("logNumber")
  log_number				= string(4-len(log_number),"0")&log_number


  oXML.loadXML(formDataXML)

  safety_action_cnt			= selectNode(oXML,"safety_action_cnt","")
  item_number				= selectNode(oXML,"item_number","")
  item_description			= rev_xdata2(selectNode(oXML,"item_description",""))
  accountable_leader		= rev_xdata2(selectNode(oXML,"accountable_leader",""))
  soi						= rev_xdata2(selectNode(oXML,"soi",""))
  hl						= rev_xdata2(selectNode(oXML,"hl",""))
  date_opened				= selectNode(oXML,"date_opened","")
  date_due					= selectNode(oXML,"date_due","")
  date_completed			= selectNode(oXML,"date_completed","")
  item_status				= selectNode(oXML,"item_status","")
  equipment					= selectNode(oXML,"equipment","")
  item_title				= selectNode(oXML,"item_title","")
  item_comments				= selectNode(oXML,"item_comments","")
  base						= selectNode(oXML,"base","")
  hazard_owner				= selectNode(oXML,"hazard_owner","")
  hazard_manager			= selectNode(oXML,"hazard_manager","")
  hazard_editor				= selectNode(oXML,"hazard_editor","")
  next_review_date			= selectNode(oXML,"next_review_date","")
  endorsed					= selectNode(oXML,"endorsed","")
  endorsed_by				= selectNode(oXML,"endorsed_by","")
  mission					= selectNode(oXML,"mission","")

  initial_assessment_date			= selectNode(oXML,"initial_assessment_date","")
  initial_assessment_occasion		= selectNode(oXML,"initial_assessment_occasion","")
  current_assessment_date			= selectNode(oXML,"current_assessment_date","")
  current_assessment_occasion		= selectNode(oXML,"current_assessment_occasion","")
  post_assessment_date				= selectNode(oXML,"post_assessment_date","")
  post_assessment_occasion			= selectNode(oXML,"post_assessment_occasion","")
  further_risk_reduction_needed		= selectNode(oXML,"further_risk_reduction_needed","")
  hazard_ok_alarp					= selectNode(oXML,"hazard_ok_alarp","")
  alarp_statement					= selectNode(oXML,"alarp_statement","")

  hazard_title					= selectNode(oXML,"hazard_title","")

end if

if(safety_action_cnt = "") then
  safety_action_cnt = 0
end if

tmpCnt					= cint(safety_action_cnt)

'sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and logNumber = "& sqlnum(log_number) &" and archived = 'n' order by logNumber desc, recid desc"
sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and division = "& sqltext2(viewDivision) &" and divisionalLogNumber = "& sqlnum(log_number) &" order by logNumber desc, recid desc"
set rs=conn_asap.execute(sql)
set oXML2					= CreateObject("Microsoft.XMLDOM")
oXML2.async					= false

if not rs.eof then
  loginID					= rs("loginID")
  createDate				= rs("createDate")
  formDataXML				= rs("formDataXML")
  recid						= rs("recid")
  division					= rs("division")
  'log_number				= rs("logNumber")
  log_number				= string(4-len(log_number),"0")&log_number
  srtLogNumber				= rs("srtLogNumber")
  if(len(srtLogNumber) > 0) then
    srtLogNumberStr				= "EH:DIV"&string(4-len(srtLogNumber),"0")&srtLogNumber
  end if


  oXML2.loadXML(formDataXML)

  safety_action_cnt			= selectNode(oXML2,"safety_action_cnt","")
  item_number				= selectNode(oXML2,"item_number","")
  item_description			= rev_xdata2(selectNode(oXML2,"item_description",""))
  hazard_related_to			= rev_xdata2(selectNode(oXML2,"hazard_related_to",""))

  accountable_leader		= rev_xdata2(selectNode(oXML2,"accountable_leader",""))
  soi						= rev_xdata2(selectNode(oXML2,"soi",""))
  hl						= rev_xdata2(selectNode(oXML2,"hl",""))
  date_opened				= selectNode(oXML2,"date_opened","")
  date_due					= selectNode(oXML2,"date_due","")
  date_completed			= selectNode(oXML2,"date_completed","")
  item_status				= selectNode(oXML2,"item_status","")
  item_status2				= selectNode(oXML2,"item_status2","")
  equipment					= selectNode(oXML2,"equipment","")
  item_title				= selectNode(oXML2,"item_title","")
  item_comments				= selectNode(oXML2,"item_comments","")
  base						= selectNode(oXML2,"base","")
  hazard_owner				= selectNode(oXML2,"hazard_owner","")
  hazard_manager			= selectNode(oXML2,"hazard_manager","")
  hazard_editor				= selectNode(oXML2,"hazard_editor","")
  next_review_date			= selectNode(oXML2,"next_review_date","")
  endorsed					= selectNode(oXML2,"endorsed","")
  endorsed_by				= selectNode(oXML2,"endorsed_by","")
  mission					= selectNode(oXML2,"mission","")
  'generic					= selectNode(oXML2,"generic","")

  summary_description		= rev_xdata2(selectNode(oXML2,"summary_description",""))

  original_date_opened		= selectNode(oXML2,"original_date_opened","")

  initial_assessment_date			= selectNode(oXML2,"initial_assessment_date","")
  initial_assessment_occasion		= selectNode(oXML2,"initial_assessment_occasion","")
  current_assessment_date			= selectNode(oXML2,"current_assessment_date","")
  current_assessment_occasion		= selectNode(oXML2,"current_assessment_occasion","")
  post_assessment_date				= selectNode(oXML2,"post_assessment_date","")
  post_assessment_occasion			= selectNode(oXML2,"post_assessment_occasion","")
  further_risk_reduction_needed		= selectNode(oXML2,"further_risk_reduction_needed","")
  hazard_ok_alarp					= selectNode(oXML2,"hazard_ok_alarp","")
  alarp_statement					= selectNode(oXML2,"alarp_statement","")

  station							= selectNode(oXML2,"station","")
  source							= selectNode(oXML2,"source","")

  hazard_title					= selectNode(oXML2,"hazard_title","")

end if

proceed = "n"
if((request("cookie_sms_admin") = "y") or (request("cookie_business_unit") = "Global"))then
  proceed = "y"
end if
if((request("cookie_business_unit") = viewDivision) and ((request("cookie_hazard_base") = base) or (request("cookie_base") = base) or (request("cookie_base") = "All"))) then
  proceed = "y"
end if

if(proceed = "n") then
  'response.redirect "getSummary2.aspx?log_number="& request("log_number") &"&viewdivision="& request("viewDivision")
  'response.end
end if

if(request("log_number") = "") then
  original_date_opened = year(date()) &"-"& month(date()) &"-"& day(date())
  date_opened = original_date_opened
  date_due = year(dateadd("m",1,date())) &"-"& month(dateadd("m",1,date())) &"-"& day(dateadd("m",1,date()))
end if

if (not(isdate(next_review_date))) then
	'next_review_date = ""
end if

if((date_opened <> "") and (not isnull(date_opened)) and (isdate(date_opened))) then
  date_openedStr = day(date_opened) &"-"& monthname(month(date_opened),true) &"-"& year(date_opened)
end if
if((date_due <> "") and (not isnull(date_due)) and (isdate(date_due))) then
  date_dueStr = day(date_due) &"-"& monthname(month(date_due),true) &"-"& year(date_due)
end if
if((date_completed <> "") and (not isnull(date_completed)) and (isdate(date_completed))) then
  date_completedStr = day(date_completed) &"-"& monthname(month(date_completed),true) &"-"& year(date_completed)
end if
if((next_review_date <> "") and (not isnull(next_review_date)) and (isdate(next_review_date))) then
  next_review_dateStr = day(next_review_date) &"-"& monthname(month(next_review_date),true) &"-"& year(next_review_date)
end if
if((original_date_opened <> "") and (not isnull(original_date_opened)) and (isdate(original_date_opened))) then
  original_date_openedStr = day(original_date_opened) &"-"& monthname(month(original_date_opened),true) &"-"& year(original_date_opened)
end if

if(safety_action_cnt = "") then
  safety_action_cnt = 0
end if

tmpCnt					= cint(safety_action_cnt)

set rXML                    = CreateObject("Microsoft.XMLDOM")
rXML.async                  = false
sql = "select logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'risk' and logNumber = "& sqlnum(log_number) &" order by logNumber desc, recid desc"
set rs = conn_asap.execute(sql)
if not rs.eof then
  formDataXML                           = rs("formDataXML")

  rXML.loadXML(formDataXML)

  active_errors_cnt                     = selectNode(rXML,"active_errors_cnt","")
  contributing_factors_cnt              = selectNode(rXML,"contributing_factors_cnt","")
  latent_conditions_cnt                 = selectNode(rXML,"latent_conditions_cnt","")
  causal_factors_cnt                    = selectNode(rXML,"causal_factors_cnt","")
  pre_physical_injury                   = selectNode(rXML,"pre_physical_injury","")
  pre_damage_to_the_environment         = selectNode(rXML,"pre_damage_to_the_environment","")
  pre_damage_to_assets                  = selectNode(rXML,"pre_damage_to_assets","")
  pre_potential_increased_cost          = selectNode(rXML,"pre_potential_increased_cost","")
  pre_damage_to_corporate_reputation    = selectNode(rXML,"pre_damage_to_corporate_reputation","")
  pre_likelihood                        = rev_xdata2(selectNode(rXML,"pre_likelihood",""))
  post_physical_injury                  = selectNode(rXML,"post_physical_injury","")
  post_damage_to_the_environment        = selectNode(rXML,"post_damage_to_the_environment","")
  post_damage_to_assets                 = selectNode(rXML,"post_damage_to_assets","")
  post_potential_increased_cost         = selectNode(rXML,"post_potential_increased_cost","")
  post_damage_to_corporate_reputation   = selectNode(rXML,"post_damage_to_corporate_reputation","")
  post_likelihood                       = rev_xdata2(selectNode(rXML,"post_likelihood",""))
  'log_number                            = selectNode(rXML,"log_number","")
  current_measures                      = rev_xdata2(selectNode(rXML,"current_measures",""))
  current_measures_responsible_person   = rev_xdata2(selectNode(rXML,"current_measures_responsible_person",""))
  risk_value_pre_mitigation             = rev_xdata2(selectNode(rXML,"risk_value_pre_mitigation",""))
  corrective_actions                    = rev_xdata2(selectNode(rXML,"corrective_actions",""))
  unintended_consequences               = rev_xdata2(selectNode(rXML,"unintended_consequences",""))
  corrective_actions_responsible_person = rev_xdata2(selectNode(rXML,"corrective_actions_responsible_person",""))
  risk_value_post_mitigation            = rev_xdata2(selectNode(rXML,"risk_value_post_mitigation",""))
end if

currrisk = risk_value_post_mitigation

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

  if(curr_risk = "") then
    curr_risk = "Unassessed"
  end if

riskcolor = "black"
if(curr_risk = "Acceptable") then
  riskcolor = "#336600"
end if
if(curr_risk = "Acceptable With Mitigation") then
  riskcolor = "#ffcc00"
end if
if(curr_risk = "Unacceptable") then
  riskcolor = "#8a0808"
end if

accountable_leaderStr = ""
accountable_leaderStr = accountable_leaderStr & "<option value=''></option>"

'sql = "select accountable_leadersEHD from BristowSafety_Admin order by recid desc"
'set tmprs=conn_asap.execute(sql)
'if not tmprs.eof then
'  accountable_leaders = tmprs("accountable_leadersEHD")
'end if
if(len(accountable_leaders) > 0) then
  accountable_leadersArr = split(accountable_leaders,",")
  for i= 0 to ubound(accountable_leadersArr)

  accountable_leader = trim(accountable_leadersArr(i))

  accountable_leaderStr = accountable_leaderStr & "<option value='"& accountable_leader &"'>"& accountable_leader &"</option>"

  next
end if

accountable_leaderStr = accountable_leaderStr & "<option value='Other'>Other</option>"

baseOpts = "<option value='All'>All</option>"
sql = "select distinct CURRENT_BASE, Code from BUtoBASE where BUSINESS_UNIT = "& sqltext2(viewdivision) &" order by CURRENT_BASE asc"
set tmprs=conn_asap.execute(sql)
do while not tmprs.eof
  baseOpts = baseOpts &"<option value='"& tmprs("Code") &"'>"& tmprs("CURRENT_BASE") &"</option>"

  tmprs.movenext
loop
'baseOpts = baseOpts &"<option value='GEN'>GEN</option>"

stationOpts = "<option value=''></option>"
sql = "select distinct station from station_t order by station asc"
set tmprs=conn_asap.execute(sql)
do while not tmprs.eof
  stationOpts = stationOpts &"<option value='"& tmprs("station") &"'>"& tmprs("station") &"</option>"

  tmprs.movenext
loop

sourceOpts = "<option value=''></option>"
sql = "select distinct SRC_NAME from source_t order by SRC_NAME asc"
set tmprs=conn_asap.execute(sql)
do while not tmprs.eof
  sourceOpts = sourceOpts &"<option value='"& tmprs("SRC_NAME") &"'>"& tmprs("SRC_NAME") &"</option>"

  tmprs.movenext
loop

divisionOpts = "<option value=''></option>"
sql = "select distinct division from division_t order by division asc"
set tmprs=conn_asap.execute(sql)
do while not tmprs.eof
  divisionOpts = divisionOpts &"<option value='"& tmprs("division") &"'>"& tmprs("division") &"</option>"

  tmprs.movenext
loop

nameOpts = "<option value=''></option>"
if(base = "GLOBAL") then
  sql = "select distinct username, first_name, last_name from Tbl_Logins where (business_unit = 'Global') and sms_admin <> 'y' and last_name <> 'Aaron' order by last_name asc"
else
  sql = "select distinct loginID, username, first_name, last_name from Tbl_Logins where division = "& sqltext2(viewdivision) &" and last_name <> 'Aaron' order by last_name asc"
end if
set tmprs=conn_asap.execute(sql)
do while not tmprs.eof
  nameOpts = nameOpts &"<option value='"& tmprs("loginID") &"'>"& tmprs("last_name") &", "& tmprs("first_name") &"</option>"

  tmprs.movenext
loop

sql = "select first_name, last_name from tbl_logins where loginid = "& sqlnum(loginID)
set tmprs = conn_asap.execute(sql)
if not tmprs.eof then
  last_editorStr = tmprs("last_name") &", "& tmprs("first_name")
end if

%>
	<section id="secondary_bar">
<!--#include file="includes/logged_in_user.inc"-->

		<div class="breadcrumbs_container">
			<article class="breadcrumbs"><a href="http://www.masoftwaresystems.us/miat/splash.aspx">Action Log</a> <div class="breadcrumb_divider"></div> <a class="current">Hazard Detail</a></article>
		</div>
	</section><!-- end of secondary bar -->

<!--#include file="includes/sms_header3.inc"-->
<br/><br/>

<form action="divisional_saveData3.asp" method="post" name="frm" id="frm" onsubmit="return checkRequired()">

<input type="hidden" id="formname" name="formname" value="iSRT_LogInput">
<input type="hidden" id="safety_action_cnt" name="safety_action_cnt" value="<%= safety_action_cnt %>">
<input type="hidden" id="resultPage" name="resultPage" value="divisional_LogInput2.aspx">
<input type="hidden" id="get_max_recid" name="get_max_recid" value="">
<input type="hidden" id="viewDivision" name="viewDivision" value="<%= viewDivision %>">
<input type="hidden" id="item_status2" name="item_status2" value="<%= item_status %>">
<input type="hidden" id="position" name="position" value="<%= position %>">
<input type="hidden" id="isnew" name="isnew" value="<%= newlog %>">
<% if(generic = "y") then %>
<input type="hidden" id="mission" name="mission" value="<%= mission %>">
<input type="hidden" id="equipment" name="equipment" value="<%= equipment %>">
<% end if %>
<input type="hidden" id="base" name="base" value="<%= base %>">
<input type="hidden" id="log_number" name="log_number" value="<%= log_number %>">
<input type="hidden" id="hazard_base" name="hazard_base" value="<%= hazard_base %>">
<input type="hidden" id="hazard_type" name="hazard_type" value="<%= hazard_type %>">
<input type="hidden" id="hazard_number" name="hazard_number" value="<%= hazard_number %>">
<input type="hidden" id="original_date_opened" name="original_date_opened" value="<%= original_date_opened %>">
<input type="hidden" id="original_endorsed" name="original_endorsed" value="<%= endorsed %>">
<input type="hidden" id="saveonexit" name="saveonexit" value="y">
<input type="hidden" id="previous_hazard_owner" name="previous_hazard_owner" value="<%= hazard_owner %>">

<article class="module width_full">
<div class="module_content">
<h3>Hazard Detail</h3>
<center>
<table cellpadding="0" cellspacing="2" style="font-family:Helvetica, Arial, Verdana, sans-serif;font-size:12px;">
    <tr>
        <td style="width:155px; text-align: right;">Hazard ID:&nbsp;</td>
        <td><input type="TEXT" name="hazard_id" id="hazard_id" readonly displayName="Hazard ID" style="width: 410px;" value="<%= hazard_id %>" class="textbox"></td>
    </tr>
    <tr>
        <td style="color: #cc0000; width:155px;text-align: right;">Hazard Title:&nbsp;</td>
        <td><input type="TEXT" name="hazard_title" id="hazard_title" required displayName="Hazard Title" style="width: 410px;" value="<%= hazard_title %>" class="textbox"></td>
    </tr>
    <tr valign="top">
        <td style="text-align: right;">Description:&nbsp;</td>
        <td><textarea name="item_description" id="item_description" style="width: 410px;" displayName="Description" class="textbox" rows="9"><%= item_description %></textarea></td>
    </tr>
    <tr valign="top">
        <td style="text-align: right;">Summary of Description:&nbsp;</td>
        <td><textarea name="summary_description" id="summary_description" style="width: 410px;" displayName="Summary of Description" class="textbox" rows="3"><%= summary_description %></textarea></td>
    </tr>
    <tr>
        <td style="text-align: right;">Risk Acceptability:&nbsp;</td>
        <td><input type="TEXT" name="curr_risk" id="curr_risk" style="width: 410px;" readonly required displayName="Risk Acceptability" value="<%= curr_risk %>" class="textbox"></td>
    </tr>
    <tr>
        <td style="text-align: right;">Hazard Related To:&nbsp;</td>
        <td><input type="TEXT" name="hazard_related_to" id="hazard_related_to" style="width: 410px;" displayName="Hazard Related To" value="<%= hazard_related_to %>" class="textbox"></td>
    </tr>
    <tr>
        <td style="text-align: right;">Original Date Opened:&nbsp;</td>
        <td><input type="TEXT" name="original_date_opened" id="original_date_opened" style="width: 100px;" displayName="Original Date Opened" value="<%= original_date_opened %>" class="datepicker2 textbox"></td>
    </tr>
    <tr>
        <td style="text-align: right;">SOI:&nbsp;</td>
        <td >
               <select id="soi" name="soi" style="width:130px;" class="textbox">
                  <option value="SYS">Systemic</option>
                  <option value="REA">Reactive</option>
                  <option value="PRO">Proactive</option>
                </select><script>document.getElementById("soi").value = "<%= soi %>";</script>
        </td>
    </tr>
    <tr>
        <td style="text-align: right;">Station:&nbsp;</td>
        <td>
        <input type="TEXT" name="station" id="station" style="width: 410px;" displayName="Station" value="<%= station %>" class="textbox">
        </td>
    </tr>
    <tr>
        <td style="text-align: right;">Source:&nbsp;</td>
        <td>
               <select id="source" name="source" style="width:423px;" class="textbox">
<%= sourceOpts %>
                </select><script>document.getElementById("source").value = "<%= source %>";</script>
        </td>
   	</tr>
   	<tr>
        <td style="text-align: right;">Hazard Owner:&nbsp;</td>
        <td>
               <select id="hazard_owner" name="hazard_owner" style="width:423px;" class="textbox">
<%= nameOpts %>
                </select><script>document.getElementById("hazard_owner").value = "<%= hazard_owner %>";</script>
        </td>
   	</tr>
   	<tr>
        <td style="text-align: right;">Last Editor:&nbsp;</td>
        <td><input type="TEXT" readonly name="hazard_editor" style="width: 410px;" displayName="Hazard Editor" value="<%= last_editorStr %>" class="textbox"></td>
   	</tr>
   	<tr>
        <td style="text-align: right;">Date Opened:&nbsp;</td>
        <td><input type="TEXT" name="date_opened" id="date_opened" style="width: 100px;" displayName="Date Opened" value="<%= date_opened %>" class="datepicker2 textbox"></td>
   	</tr>
   	<tr>
        <td style="text-align: right;">Date Due:&nbsp;</td>
        <td><input type="TEXT" name="date_due" id="date_due" style="width: 100px;" displayName="Date Due" value="<%= date_due %>" class='datepicker2 textbox'></td>
   	</tr>
   	<tr>
        <td style="text-align: right;">Date Completed:&nbsp;</td>
        <td><input type="TEXT" name="date_completed" id="date_completed" style="width: 100px;" displayName="Date Completed" value="<%= date_completed %>" class="datepicker2 textbox"></td>
   	</tr>
   	<tr>
        <td style="text-align: right;">Next Review Date:&nbsp;</td>
        <td><input type="TEXT" name="next_review_date" id="next_review_date" style="width: 100px;" displayName="Next Review Date" value="<%= next_review_date %>" class="datepicker2 textbox"></td>
   	</tr>
   	<tr valign="top">
        <td style="text-align: right;">ALARP Statement:&nbsp;</td>
        <td><textarea name="alarp_statement" id="" style="width: 410px;" displayName="ALARP Statement" class="textbox" rows="3"><%= alarp_statement %></textarea></td>
   	</tr>
    <tr>
        <td style="text-align: right;">Status:&nbsp;</td>
        <td>
<select id="item_status" name="item_status" style="width:130px;" class="textbox">
  <option value="Open" >Open</option>
  <option value="Closed">Closed</option>
  <option value="Void">Void</option>
</select>
<script>
frm.item_status.value = "<%= item_status %>";
</script>
        </td>
    </tr>
    <tr>
        <td style="text-align: right;">Endorsed By:&nbsp;</td>
        <td>
<select id="endorsed_by" name="endorsed_by" style="width:423px;" class="textbox">
  <option value=""></option>
  <option value="Corporate Safety Committee">Corporate Safety Committee</option>
  <option value="Flight Data Analysis Committee">Flight Data Analysis Committee</option>
  <option value="Cabin Safety Committee">Cabin Safety Committee</option>
  <option value="Safety Action Group">Safety Action Group</option>
</select>
<script>
frm.endorsed_by.value = "<%= endorsed_by %>";
</script>
        </td>
    </tr>
        <tr>
			<td style="text-align: right;">Endorsed:&nbsp;</td>
            <td><input id="endorsed" type="checkbox" name="endorsed" value="1"  class="textbox" style="border:0px;">
<% if(endorsed = "1") then %>
<script>
document.getElementById("endorsed").checked = "true";
</script>
<% end if %>
            </td>
        </tr>
        <tr>
			<td style="text-align: right;">Re-Open for Assessment:&nbsp;</td>
            <td><input id="reopen" type="checkbox" name="reopen" value="1" class="textbox" style="border:0px;"></td>
        </tr>
    </table>
    </center>
    </div>
    </article>

<article class="module width_full">
<div class="module_content">
<h3>Links</h3>
<center>
<table cellpadding="0" cellspacing="2" style="font-family:Helvetica, Arial, Verdana, sans-serif;font-size:12px;">
   	<tr valign="top">
        <td style="text-align: right;width:155px;">&nbsp;</td>
        <td align="left" style="padding-left:10px;">
<%
set lXML					= CreateObject("Microsoft.XMLDOM")
lXML.async					= false
sql = "select * from EHD_Comments, Tbl_Logins where EHD_Comments.division = "& sqltext2(viewdivision) &" and log_number = "& sqlnum(log_number) &" and comment_type = 'link' and EHD_Comments.loginID = Tbl_Logins.loginID order by recid desc"
set tmprs = conn_asap.execute(sql)
do while not tmprs.eof
  if(len(tmprs("item_commentXML")) > 0) then
  lXML.loadXML(tmprs("item_commentXML"))
  if(len(tmprs("comment_date")) > 0) then
    tmpdateArr = split(tmprs("comment_date"))
    tmpdateStr = tmpdateArr(0) &" "& tmpdateArr(2)
  end if
%>
<b><span decode>&middot; <%= selectNode(lXML,"link","") %></span></b><br/>
<%
  end if
  tmprs.movenext
loop
%>
<br/>
        </td>
   	</tr>
   	<tr><td colspan="2" height="5"></td></tr>
    <tr>
        <td style="width:155px; text-align: right;">Link title:&nbsp;</td>
        <td><input type="TEXT" name="link_title" id="link_title" displayName="Link Title" style="width: 410px;" value="" class="textbox"></td>
    </tr>
    <tr>
        <td style="width:155px; text-align: right;">Link URL:&nbsp;</td>
        <td><input type="TEXT" name="link_url" id="link_url" displayName="Link URL" style="width: 410px;" value="" class="textbox"></td>
    </tr>
</table>
    </center>
    </div>
    </article>

<article class="module width_full">
<div class="module_content">
<h3>Attachments</h3>
<center>
<table cellpadding="0" cellspacing="2" style="font-family:Helvetica, Arial, Verdana, sans-serif;font-size:12px;">
   	<tr valign="top">
        <td style="text-align: right;width:155px;">&nbsp;</td>
        <td align="left" style="width: 410px;">
<%
set aXML					= CreateObject("Microsoft.XMLDOM")
aXML.async					= false
sql = "select * from EHD_Comments where EHD_Comments.division = "& sqltext2(viewdivision) &" and log_number = "& sqlnum(log_number) &" and comment_type = 'attachments' order by recid desc"
set tmprs = conn_asap.execute(sql)
do while not tmprs.eof
  if(len(tmprs("item_commentXML")) > 0) then
  aXML.loadXML(tmprs("item_commentXML"))
  if(len(tmprs("comment_date")) > 0) then
    tmpdateArr = split(tmprs("comment_date"))
    tmpdateStr = tmpdateArr(0) &" "& tmpdateArr(2)
  end if
%>
<b><span decode>&middot; <%= selectNode(aXML,"link","") %></span></b><br/>
<%
  end if
  tmprs.movenext
loop
%>
        </td>
   	</tr>
   	<tr><td colspan="2" height="5"></td></tr>
</table>
    </center>
    </div>
    </article>

<article class="module width_full">
<div class="module_content">
<h3>Comments</h3>
<center>
<table cellpadding="0" cellspacing="2" style="font-family:Helvetica, Arial, Verdana, sans-serif;font-size:12px;">
<tbody id="CommentsTable">
   	<tr valign="top">
        <td style="text-align: right;width:155px;">&nbsp;</td>
        <td align="left" style="padding-left:10px;">
<%
set cXML					= CreateObject("Microsoft.XMLDOM")
cXML.async					= false
sql = "select * from EHD_Comments, Tbl_Logins where EHD_Comments.division = "& sqltext2(viewdivision) &" and log_number = "& sqlnum(log_number) &" and comment_type = 'iSRT_LogInput' and EHD_Comments.loginID = Tbl_Logins.loginID order by recid desc"
set tmprs = conn_asap.execute(sql)
do while not tmprs.eof
  if(len(tmprs("item_commentXML")) > 0) then
  cXML.loadXML(tmprs("item_commentXML"))
  if(len(tmprs("comment_date")) > 0) then
    tmpdateArr = split(tmprs("comment_date"))
    tmpdateStr = tmpdateArr(0) &" "& tmpdateArr(2)
  end if
%>
<p><span decode><%= tmpdateStr %>&nbsp;<%= tmprs("first_name") %>&nbsp;<%= tmprs("last_name") %><br></span><span decode><%= rev_xdata2(selectNode(cXML,"comment","")) %></span></p>
<%
  end if
  tmprs.movenext
loop
%>
        </td>
   	</tr>
   	<tr><td colspan="2" height="5"></td></tr>
   	<tr valign="top">
        <td style="text-align: right;width:155px;">&nbsp;</td>
        <td><textarea name="item_comments" id="item_comments" style="width: 410px;" displayName="Comment" class="textbox" rows="3"></textarea></td>
   	</tr>
   	</tbody>
    </table>
    </center>
    </div>
    </article>



<article class="module width_full" style="border:0px;">
<div class="module_content">
<center>
<table border="0" cellpadding="0" cellspacing="2" style="font-family:Helvetica, Arial, Verdana, sans-serif;font-size:12px;">
        <tr>
			<td style="color: #cc0000; text-align: right;width:155px;"></td>
            <td style="padding-left:0px;text-align: left;width: 410px;">
<input type="checkbox" checked name="saveonexit2" id="saveonexit2" value="y" onclick="changeSave(this)"> Automatically save on exit
            </td>
        </tr>
        <tr>
			<td style="color: #cc0000; text-align: right;width:155px;"></td>
            <td style="padding-left:0px;text-align: left;width: 410px;">
<input type="button" value="Save" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-right:3px;" onclick="gotoSave()"><input <% if(newlog = "y") then %>disabled<% end if %> type="button" value="Assess Risk" style="font-size:10px;width:160px;font-weight:normal;height:20px;" onclick="goToRisk()"><br><input type="button" value="Log Summary" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-top:3px;margin-right:3px;" onclick="viewAssessmentSummary()"><input type="button" value="Return To Short Listing" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-top:3px;" onclick="gotoDivisionalBase()"><br><input type="button" value="Attachments" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-right:3px;" onclick="goToAttachments()">
            </td>
        </tr>
        <tr><td colspan="2" height="5"></td></tr>
<%
prevlog = ""
currlog = ""
nextlog = ""
sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and division = "& sqltext2(viewDivision) &" and active='y' order by divisionalLogNumber asc, recid asc"
set tmprs=conn_asap.execute(sql)
do while not tmprs.eof
  if(currlog <> "") then
    nextlog = tmprs("divisionalLogNumber")
    exit do
  end if
  if(cint(tmprs("divisionalLogNumber")) = cint(log_number)) then
    currlog = log_number
  else
    prevlog = tmprs("divisionalLogNumber")
  end if
  tmprs.movenext
loop
%>
        <tr>
			<td style="color: #cc0000; text-align: right;width:155px;"></td>
            <td style="padding-left:0px;text-align: left;width: 410px;">
<input type="button" value="<< Previous Hazard" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-right:3px;" onclick="goToHazard('<%= prevlog %>')" <% if(prevlog = "") then %>disabled<% end if %>><input <% if(nextlog = "") then %>disabled<% end if %> type="button" value="Next Hazard >>" style="font-size:10px;width:160px;font-weight:normal;height:20px;" onclick="goToHazard('<%= nextlog %>')">
            </td>
        </tr>
    </table>
    </center>
    </div>
    </article>
<p></p>


<script>
function addNew(t,r) {

  currCnt = parseInt(document.getElementById("safety_action_cnt").value);
  currCnt = currCnt +1;
  document.getElementById("safety_action_cnt").value = currCnt;

  var inputTable = document.getElementById(t);
  var inputTableRow = document.getElementById(r);

  var newTR0 = document.createElement('TR');
  var newTR1 = document.createElement('TR');
  var newTR2 = document.createElement('TR');
  var newTR3 = document.createElement('TR');
  var newTR4 = document.createElement('TR');
  var newTR5 = document.createElement('TR');
  var newTR6 = document.createElement('TR');
  var newTR7 = document.createElement('TR');
  var newTR8 = document.createElement('TR');
  var newTR9 = document.createElement('TR');
  var newTR10 = document.createElement('TR');
  var newTR11 = document.createElement('TR');
  var newTD0 = document.createElement('TD');
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
  var newTD11 = document.createElement('TD');
  var newTD12 = document.createElement('TD');
  var newTD13 = document.createElement('TD');
  var newTD14 = document.createElement('TD');
  var newTD15 = document.createElement('TD');
  var newTD16 = document.createElement('TD');
  var newTD17 = document.createElement('TD');
  var newTD18 = document.createElement('TD');
  var newTD19 = document.createElement('TD');
  var newTD20 = document.createElement('TD');
  var newTD21 = document.createElement('TD');
  var newTD22 = document.createElement('TD');
  inputTable.insertBefore(newTR0, inputTableRow);
  inputTable.insertBefore(newTR1, inputTableRow);
  inputTable.insertBefore(newTR2, inputTableRow);
  inputTable.insertBefore(newTR3, inputTableRow);
  inputTable.insertBefore(newTR4, inputTableRow);
  inputTable.insertBefore(newTR5, inputTableRow);
  inputTable.insertBefore(newTR6, inputTableRow);
  inputTable.insertBefore(newTR7, inputTableRow);
  inputTable.insertBefore(newTR8, inputTableRow);
  inputTable.insertBefore(newTR9, inputTableRow);
  inputTable.insertBefore(newTR10, inputTableRow);
  inputTable.insertBefore(newTR11, inputTableRow);

  //newTR1.setAttribute("style","background-color:red;");

  newTR0.appendChild(newTD0);
  newTR1.appendChild(newTD1);
  newTR1.appendChild(newTD2);
  newTR2.appendChild(newTD3);
  newTR2.appendChild(newTD4);
  newTR3.appendChild(newTD5);
  newTR3.appendChild(newTD6);
  newTR4.appendChild(newTD7);
  newTR4.appendChild(newTD8);
  newTR5.appendChild(newTD9);
  newTR5.appendChild(newTD10);
  newTR6.appendChild(newTD11);
  newTR6.appendChild(newTD12);
  newTR7.appendChild(newTD13);
  newTR7.appendChild(newTD14);
  newTR8.appendChild(newTD15);
  newTR8.appendChild(newTD16);
  newTR9.appendChild(newTD17);
  newTR9.appendChild(newTD18);
  newTR10.appendChild(newTD19);
  newTR10.appendChild(newTD20);
  newTR11.appendChild(newTD21);
  newTR11.appendChild(newTD22);

  newTD0.setAttribute("colspan","2");
  newTD0.setAttribute("height","10");
  newTD1.setAttribute("style","width:155px;text-align: right;");
  newTD3.setAttribute("style","text-align: right;");
  newTD5.setAttribute("style","text-align: right;");
  newTR4.setAttribute("valign","top");
  newTD7.setAttribute("style","text-align: right;");
  newTR5.setAttribute("valign","top");
  newTD9.setAttribute("style","text-align: right;");
  newTD11.setAttribute("style","text-align: right;");
  newTD13.setAttribute("style","text-align: right;");
  newTD15.setAttribute("style","text-align: right;");
  newTD17.setAttribute("style","text-align: right;");
  newTD19.setAttribute("style","text-align: right;");
  newTD19.setAttribute("height","5");
  newTD21.setAttribute("style","text-align: right;");
  newTD22.setAttribute("style","background-color:silver;padding-left:10px;");
  newTD22.setAttribute("height","1");

  newTD1.innerHTML = "Action Item:&nbsp;";
  newTD2.innerHTML = "<input type='TEXT' name='safety_action_nbr_"+currCnt+"' id='safety_action_nbr_"+currCnt+"' displayName='Safety Action Number' style='width: 410px;' value='<%= viewdivision %>-<%= log_numberStr %>."+currCnt+"' readonly class='textbox'>";
  newTD3.innerHTML = "Action Owner :&nbsp;";
  newTD4.innerHTML = "<select name='safety_action_poc_"+currCnt+"' id='safety_action_poc_"+currCnt+"' style='width: 272px;' displayName='Action Owner' class='textbox'><%= nameOpts %></select>";
  newTD5.innerHTML = "Action Type :&nbsp;";
  newTD6.innerHTML = "<select name='safety_action_type_"+currCnt+"' id='safety_action_type_"+currCnt+"' style='width: 272px;' displayName='Safety Action Type' class='textbox'><option value=''>Select Action Type</option><option value='Corrective Action Required/Finding'>Corrective Action Required/Finding</option><option value='Recommendation'>Recommendation</option><option value='DSAM'>DSAM</option><option value='ESAC'>ESAC</option><option value='CSC'>CSC</option></select></select>";
  newTD7.innerHTML = "Activity:&nbsp;";
  newTD8.innerHTML = "<textarea name='safety_action_"+currCnt+"' id='safety_action_"+currCnt+"' style='width: 410px;' displayName='Activity' class='textbox' rows='3'></textarea>";
  newTD9.innerHTML = "Comments:&nbsp;";
  newTD10.innerHTML = "<textarea name='safety_comments_"+currCnt+"' id='safety_comments_"+currCnt+"' style='width: 410px;' displayName='Comments' class='textbox' rows='3'></textarea>";
  newTD11.innerHTML = "Opened:&nbsp;";
  newTD12.innerHTML = "<input type='TEXT' name='safety_action_open_"+currCnt+"' id='safety_action_open_"+currCnt+"' style='width: 100px;' displayName='Opened' value='' class='datepicker2 textbox'>";
  newTD13.innerHTML = "Due:&nbsp;";
  newTD14.innerHTML = "<input type='TEXT' name='safety_action_due_"+currCnt+"' id='safety_action_due_"+currCnt+"' style='width: 100px;' displayName='Due' value='' class='datepicker2 textbox'>";
  newTD15.innerHTML = "Completed:&nbsp;";
  newTD16.innerHTML = "<input type='TEXT' name='safety_action_completed_"+currCnt+"' id='safety_action_completed_"+currCnt+"' style='width: 100px;' displayName='Completed' value='' class='datepicker2 textbox'>";
  newTD17.innerHTML = "Status:&nbsp;";
  newTD18.innerHTML = "<select name='safety_action_status_"+currCnt+"' id='safety_action_status_"+currCnt+"' style='width: 130px;' displayName='Status' class='textbox'><option value=''></option><option value='Open'>Open</option><option value='Closed'>Closed</option><option value='Void'>Void</option></select></select>";

}
</script>

<script>
function goToRisk() {
  //frm.action = "divisional_risk2.aspx?log_number=<%= log_number %>&viewDivision=<%= viewDivision %>";
  document.getElementById("resultPage").value = "divisional_risk2.aspx";
  frm.submit();
  //checkRequired();
}

function goToEmail() {
  frm.action = "divisional_emailInfo.aspx";
  frm.submit();
  //checkRequired();
}

function toggleLink() {
  //alert("test");
  if(document.getElementById("linkDIV").style.display == "none") {
    document.getElementById("linkDIV").style.display = "block";
  } else {
    document.getElementById("linkDIV").style.display = "none";
  }
}

function saveLinks() {
  //frm.action = "saveLinks.asp";
  document.getElementById("saveonexit2").checked = false;
  document.getElementById("saveonexit").value = "";
  document.getElementById("resultPage").value = "divisional_LogInput2.aspx";
  //frm.submit();
  //checkRequired();
}

function gotoSave() {
  //frm.action = "saveLinks.asp";
  document.getElementById("saveonexit2").checked = true;
  document.getElementById("saveonexit2").disabled = true;
  document.getElementById("saveonexit").value = "y";
  document.getElementById("resultPage").value = "divisional_LogInput2.aspx";
  frm.submit();
  //checkRequired();
}

function goToAttachments() {
  document.getElementById("resultPage").value = "divisional_Attachments.aspx";
  //frm.action = "divisional_Attachments.aspx";
  frm.submit();
  //checkRequired();
}

function goToHazard(l) {
<%
if ((request("cookie_editDivision") = "y") or (request("cookie_administrator") = "y")) then
%>
  document.getElementById("resultPage").value = "divisional_logInput2.aspx?log_number="+l+"&viewDivision=<%= viewDivision %>";
<%
else
%>
  document.getElementById("resultPage").value = "divisional_logPicture.aspx?log_number="+l+"&viewDivision=<%= viewDivision %>";
<%
end if
%>
  frm.submit();
}

function viewAssessmentSummary() {
  //document.location = "divisional_logPicture.aspx?log_number=<%= log_number %>&viewDivision=<%= viewDivision %>";
  document.getElementById("resultPage").value = "divisional_logPicture.aspx";
  //frm.action = "divisional_logPicture.aspx";
  frm.submit();
  //checkRequired();
}

function deleteLogNumber() {
  frm.action = "divisional_deleteLogNumber.aspx";
  //frm.submit();
  checkRequired();
}

function copytobase2() {
  frm.action = "divisional_copytobase.aspx";
  frm.submit();
}

function gotoDivisionalBase() {
  //document.location = "divisional_logPicture.aspx?log_number=<%= log_number %>&viewDivision=<%= viewDivision %>";
  document.getElementById("resultPage").value = "divisional_Base.aspx";
  //frm.action = "divisional_logPicture.aspx";
  frm.submit();
  //checkRequired();
}

function changeSave(o) {
  if(o.checked) {
    document.getElementById("saveonexit").value = "y";
  } else {
    document.getElementById("saveonexit").value = "";
  }
}
</script>

</form>

<xml id="dateXML"></xml>
<xml id="isrtXML"></xml>

<!--
<%= oXML.xml %>
-->
<!--
<%= oXML2.xml %>
-->