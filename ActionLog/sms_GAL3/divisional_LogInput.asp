<% ' vi: set foldmethod=marker syn=aspvbs linebreak softtabstop=2 tabstop=2 shiftwidth=2 expandtab: %>
<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/commonUtils.inc" -->
<!--#include file="includes/security.inc" -->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<%
unlockLogs
if(isLogLocked(request("log_number"),request("viewDivision")) <> "n") then
  response.redirect("divisional_LogDisplay.asp")
  response.end
end if
lockLog request("log_number"),request("viewDivision")
viewDivision = request("viewDivision")
if(len(viewDivision) = 0) then
  'viewDivision = "ACS"
  viewDivision = session("division")
end if
%>
<!--#include file="includes/sms_header.inc"-->
<%
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

  if(item_status = "") then
    item_status = item_status2
  end if
end if

proceed = "n"
if((session("sms_admin") = "y") or (session("business_unit") = "Global"))then
  proceed = "y"
end if
if((session("business_unit") = viewDivision) and ((session("hazard_base") = base) or (session("base") = base) or (session("base") = "All"))) then
  proceed = "y"
end if

if(proceed = "n") then
  response.redirect "getSummary2.asp?log_number="& request("log_number") &"&viewdivision="& request("viewDivision")
  response.end
end if

if(request("log_number") = "") then
  original_date_opened = date()
  date_opened = original_date_opened
  date_due = dateadd("m",1,date_opened)
end if

if (not(isdate(next_review_date))) then
	next_review_date = ""
end if

if(date_opened <> "") then
  date_openedStr = day(date_opened) &"-"& monthname(month(date_opened),true) &"-"& year(date_opened)
end if
if(date_due <> "") then
  date_dueStr = day(date_due) &"-"& monthname(month(date_due),true) &"-"& year(date_due)
end if
if(date_completed <> "") then
  date_completedStr = day(date_completed) &"-"& monthname(month(date_completed),true) &"-"& year(date_completed)
end if
if(next_review_date <> "") then
  next_review_dateStr = day(next_review_date) &"-"& monthname(month(next_review_date),true) &"-"& year(next_review_date)
end if
if(original_date_opened <> "") then
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
nameOpts = ""
if(base = "GLOBAL") then
  sql = "select distinct username, first_name, last_name from Tbl_Logins where (business_unit = 'Global') and sms_admin <> 'y' and last_name <> 'Aaron' order by last_name asc"
else
  sql = "select distinct username, first_name, last_name from Tbl_Logins where ((business_unit = "& sqltext2(viewdivision) &") or (sms_admin = 'y')) and last_name <> 'Aaron' order by last_name asc"
end if
set tmprs=conn_asap.execute(sql)
do while not tmprs.eof
  nameOpts = nameOpts &"<option value='"& tmprs("first_name") &" "& tmprs("last_name") &"'>"& tmprs("first_name") &" "& tmprs("last_name") &"</option>"

  tmprs.movenext
loop


%>
<script language="JavaScript">
                                           function printPage() {
                                           if(document.all) {
                                           document.all.divButtons.style.visibility = 'hidden';
                                           window.print();
                                           document.all.divButtons.style.visibility = 'visible';
                                            } else {
                                           document.getElementById('divButtons').style.visibility = 'hidden';
                                           window.print();
                                           document.getElementById('divButtons').style.visibility = 'visible';
                                           }
}


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
  inputTable.insertBefore(newTR1, inputTableRow);

  //newTR1.setAttribute("style","background-color:red;");

  newTR1.appendChild(newTD1);
  newTR1.appendChild(newTD2);
  newTR1.appendChild(newTD3);
  newTR1.appendChild(newTD4);
  newTR1.appendChild(newTD5);
  newTR1.appendChild(newTD6);
  newTR1.appendChild(newTD7);
  newTR1.appendChild(newTD8);
  newTR1.appendChild(newTD9);

  newTD1.setAttribute("style","FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial");
  newTD1.setAttribute("bgColor","ffffff");
  newTD1.setAttribute("width","19%");
  newTD1.setAttribute("align","center");
  newTD1.setAttribute("vAlign","top");

  newTD2.setAttribute("style","FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial");
  newTD2.setAttribute("bgColor","ffffff");
  newTD2.setAttribute("width","25%");
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
  newTD5.setAttribute("colSpan","2");

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

<%
pocSTR = ""
sql = "select * from Tbl_Logins where srt_admin in ('l','w') and division = "& sqltext2(viewdivision) &" order by last_name asc"
set tmprs=conn_asap.execute(sql)
do while not tmprs.eof
  employee_nbr = tmprs("employee_number")
  first_name = tmprs("first_name")
  last_name = tmprs("last_name")

  pocSTR = pocSTR &"<option value='"& employee_nbr &"'>"& left(first_name,1) &"&nbsp;"& last_name &"</option>"

  tmprs.movenext
loop
%>

<% if(session("sms_admin") = "y") then %>
  newTD1.innerHTML = "<input type='button' value='delete' style='font-size:8px;margin-right:5px;margin-left:5px;' onclick=\"deleteSafetyAction('"+currCnt+"')\"> <span style='FONT-WEIGHT: normal; FONT-SIZE: 7pt;  FONT-STYLE: normal; FONT-FAMILY: Arial;'><input type='text' name='safety_action_nbr_"+currCnt+"' size='15'  style='width:60px;'  value='<%= hazard_id %>."+currCnt+"'  readonly /></span><br/><select name='safety_action_type_"+currCnt+"' style='width:155px;font-size:10px;' ><option value=''>Select Action Type</option><option value='Corrective Action Required/Finding'>Corrective Action Required/Finding</option><option value='Recommendation'>Recommendation</option><option value='Base SAG'>Base SAG</option><option value='BU SAG'>BU SAG</option><option value='VP SAG'>VP SAG</option></select>";
<% else %>
  newTD1.innerHTML = "<span style='FONT-WEIGHT: normal; FONT-SIZE: 7pt;  FONT-STYLE: normal; FONT-FAMILY: Arial;'><input type='text' name='safety_action_nbr_"+currCnt+"' size='30'  style='width:73px;'  value='<%= hazard_id %>."+currCnt+"'  readonly /></span><br/><select name='safety_action_type_"+currCnt+"' style='width:155px;font-size:10px;' ><option value=''>Select Action Type</option><option value='Corrective Action Required/Finding'>Corrective Action Required/Finding</option><option value='Recommendation'>Recommendation</option><option value='Base SAG'>Base SAG</option><option value='BU SAG'>BU SAG</option><option value='VP SAG'>VP SAG</option></select>";
<% end if %>
  newTD2.innerHTML = "<textarea name='safety_action_"+currCnt+"' style='width:288px;' rows='3'></textarea>";
  newTD3.innerHTML = "<!-- <select name='safety_action_base_"+currCnt+"' style='width:85px;font-size:9px;' ><%= baseOpts %></select> -->";
  newTD4.innerHTML = "<input type='text' name='safety_action_poc_"+currCnt+"' size='30'  style='width:73px;'  value='' /><div id='OTHERNAMETITLE_"+currCnt+"' style='font-family:Arial;font-weight:normal;font-size:7pt;display:none;margin-top:5px;'>Other Name</div>";
  //newTD4.innerHTML = "<input type='text' name='safety_action_poc_email_"+currCnt+"' size='30'  style='width:73px;'  value='' />";
  newTD5.innerHTML = "<div style2='float:left;'><input type='text' name='safety_action_open_"+currCnt+"' size='30'  style='width:70px;'  value=''  onblur=\"if(validateDate(this)){calcDueDate('"+currCnt+"');}\" /></div><div style2='float:right;'><a onclick='javascript:return isCalendarLoaded()' href=\"javascript:openCalendar('calendarx_"+currCnt+"', getCurrentDate(), getNextYear(), 'frm', 'safety_action_open_"+currCnt+"')\"><img id='calendarx_"+currCnt+"' src=\"http://www.atlanta.net/global_images/appts.png\" border='0'></a></div><div id='OTHERNAME_"+currCnt+"' style='display:none;'><input type='text' name='safety_action_other_name_"+currCnt+"' id='safety_action_other_name_"+currCnt+"' size='30'  style='width:73px;'  value=''   /></div>";
  newTD6.innerHTML = "<div style='float:left;'><input type='text' name='safety_action_due_"+currCnt+"' size='30'  style='width:73px;'  value=''  onblur='validateDate(this)' <% if(session("sms_admin") <> "y") then %>readOnly<% end if %> /></div><div style='float:right;'><a onclick='javascript:return isCalendarLoaded()' href=\"javascript:openCalendar('calendary_"+currCnt+"', getCurrentDate(), getNextYear(), 'frm', 'safety_action_due_"+currCnt+"')\"><img id='calendary_"+currCnt+"' src=\"http://www.atlanta.net/global_images/appts.png\" border='0'></a></div><div id='OTHEREMAILTITLE_"+currCnt+"' style='font-family:Arial;font-weight:normal;font-size:7pt;margin-top:5px;display:none;'>Other Email</div>";
  newTD7.innerHTML = "<div style='float:left;'><input type='text' name='safety_action_completed_"+currCnt+"' size='30'  style='width:73px;'  value=''  onblur='validateDate(this)' /></div><div style='float:right;'><a onclick='javascript:return isCalendarLoaded()' href=\"javascript:openCalendar('calendarz_"+currCnt+"', getCurrentDate(), getNextYear(), 'frm', 'safety_action_completed_"+currCnt+"')\"><img id='calendarz_"+currCnt+"' src=\"http://www.atlanta.net/global_images/appts.png\" border='0'></a></div><div id='OTHEREMAIL_"+currCnt+"' style='display:none;'><input type='text' name='safety_action_other_email_"+currCnt+"' id='safety_action_other_email_"+currCnt+"' size='30'  style='width:73px;'  value='' /></div>";
  newTD8.innerHTML = "<select name='safety_action_status_"+currCnt+"' style='width:73px;' ><option selected value='Open'>Open</option><option value='Closed'>Closed</option><option value='Re-opened'>Re-opened</option><option value='Void'>Void</option></select>";
  newTD9.innerHTML = "<input type='hidden' name='isnew_"+currCnt+"' value='y'>";

}
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

function setFieldValue(f,v) {
  document.getElementById(f).value = v;
}

function deleteSafetyAction(a) {
  //return;

  document.getElementById("safety_action_nbr_"+a).name = "x"+document.getElementById("safety_action_nbr_"+a).name;
  document.getElementById("safety_action_type_"+a).name = "x"+document.getElementById("safety_action_type_"+a).name;
  document.getElementById("safety_action_"+a).name = "x"+document.getElementById("safety_action_"+a).name;
  //document.getElementById("safety_action_poc_"+a).name = "x"+document.getElementById("safety_action_poc_"+a).name;
  //document.getElementById("safety_action_poc2_"+a).name = "x"+document.getElementById("safety_action_poc2_"+a).name;
  //document.getElementById("safety_action_poc_email_"+a).name = "x"+document.getElementById("safety_action_poc_email_"+a).name;
  document.getElementById("safety_action_open_"+a).name = "x"+document.getElementById("safety_action_open_"+a).name;
  document.getElementById("safety_action_due_"+a).name = "x"+document.getElementById("safety_action_due_"+a).name;
  document.getElementById("safety_action_completed_"+a).name = "x"+document.getElementById("safety_action_completed_"+a).name;
  //document.getElementById("safety_action_status_"+a).name = "x"+document.getElementById("safety_action_status_"+a).name;
  document.getElementById("safety_action_other_name_"+a).name = "x"+document.getElementById("safety_action_other_name_"+a).name;
  document.getElementById("safety_action_other_email_"+a).name = "x"+document.getElementById("safety_action_other_email_"+a).name;


  var startNum = a++;
  var endNum = parseInt(document.getElementById("safety_action_cnt").value)

  for (var x = startNum; x <= endNum; x++) {

    newNum = x -1;

    tmpnbr = document.getElementById("safety_action_nbr_"+x).value;
    tmpNbrArr = tmpnbr.split(".");
    tmpnbr = tmpNbrArr[0] +"."+ newNum;
    document.getElementById("safety_action_nbr_"+x).value = tmpnbr;

    document.getElementById("safety_action_nbr_"+x).name = "safety_action_nbr_"+newNum;
    document.getElementById("safety_action_type_"+x).name = "safety_action_type_"+newNum;
    document.getElementById("safety_action_"+x).name = "safety_action_"+newNum;
    document.getElementById("safety_action_poc_"+x).name = "safety_action_poc_"+newNum;
    //document.getElementById("safety_action_poc2_"+x).name = "safety_action_poc2_"+newNum;
    //document.getElementById("safety_action_poc_email_"+x).name = "safety_action_poc_email_"+newNum;
    document.getElementById("safety_action_open_"+x).name = "safety_action_open_"+newNum;
    document.getElementById("safety_action_due_"+x).name = "safety_action_due_"+newNum;
    document.getElementById("safety_action_completed_"+x).name = "safety_action_completed_"+newNum;
    document.getElementById("safety_action_status_"+x).name = "safety_action_status_"+newNum;
    document.getElementById("safety_action_other_name_"+x).name = "safety_action_other_name_"+newNum;
    document.getElementById("safety_action_other_email_"+x).name = "safety_action_other_email_"+newNum;
  }
  tmpcnt = parseInt(document.getElementById("safety_action_cnt").value);
  tmpcnt--;
  document.getElementById("safety_action_cnt").value = tmpcnt;
  document.getElementById("get_max_recid").value = "y";
  document.getElementById("resultPage").value = "divisional_LogInput.asp";
  //frm.submit();
  checkRequired();
}

function goToRisk() {
  frm.action = "divisional_risk.asp";
  frm.submit();
  //checkRequired();
}

function goToEmail() {
  frm.action = "divisional_emailInfo.asp";
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
  document.getElementById("resultPage").value = "divisional_LogInput.asp";
  //frm.submit();
  checkRequired();
}

function goToAttachments() {
  frm.action = "divisional_Attachments.asp";
  frm.submit();
  //checkRequired();
}

function viewAssessmentSummary() {
  frm.action = "divisional_logPicture.asp";
  frm.submit();
  //checkRequired();
}

function deleteLogNumber() {
  frm.action = "divisional_deleteLogNumber.asp";
  //frm.submit();
  checkRequired();
}

function copytobase2() {
  frm.action = "divisional_copytobase.asp";
  frm.submit();
}

// {{{ calcDueDate(v)
// Rewritten for compatibility with web standards... (meaning browsers other than ie will now work)
// Had to add id="..." attributes, because javascript uses id, not name.
function calcDueDate(v) {
  var openDate;
  var dueDate;
  var newDate;
  var daysToAdd;
  var newMonth;
  var tmpOpenDateArr;
  if(v =="" ) {

    if(document.getElementById("date_opened").value != "") {
    //alert(document.getElementById("date_opened").value.split('/'));
    tmpOpenDateArr = document.getElementById("date_opened").value.split('/');
    //alert(tmpOpenDateArr[1]+'/'+tmpOpenDateArr[0]+'/'+tmpOpenDateArr[2]);
    openDate = new Date(tmpOpenDateArr[1]+'/'+tmpOpenDateArr[0]+'/'+tmpOpenDateArr[2]);

    dueDate = document.getElementById("date_due");
    daysToAdd = 90;
    newDate = openDate;
    newDate.setDate(newDate.getDate() + daysToAdd);
    if( (newDate.getMonth()+1) < 10)
	    newMonth = "0"+(newDate.getMonth()+1);
	  else
	    newMonth = newDate.getMonth()+1;
    // Need the +1 for the month because the months go from 0-11, don't ask why.
    dueDate.value = newDate.getDate()+"/"+newMonth+"/"+newDate.getFullYear();
    }
  } else {
    if(document.getElementById("safety_action_open_"+v).value != "") {
    tmpOpenDateArr = document.getElementById("safety_action_open_"+v).value.split('/');
    //alert(tmpOpenDateArr[1]+'/'+tmpOpenDateArr[0]+'/'+tmpOpenDateArr[2]);

    openDate = new Date(tmpOpenDateArr[1]+'/'+tmpOpenDateArr[0]+'/'+tmpOpenDateArr[2]);
    dueDate = document.getElementById("safety_action_due_"+v);
    daysToAdd = 45;
    newDate = openDate;
    newDate.setDate(newDate.getDate() + daysToAdd);
    if( (newDate.getMonth()+1) < 10)
      newMonth = "0"+(newDate.getMonth()+1);
    else
      newMonth = newDate.getMonth()+1;
    //dueDate.value = newMonth+"/"+newDate.getDate()+"/"+newDate.getFullYear();
    dueDate.value = newDate.getDate()+"/"+newMonth+"/"+newDate.getFullYear();
    }
  }
}
// }}} end calcDueDate(v)
function changeStatus(v) {
  document.getElementById("item_status2").value = v;
}
</script>
<script type="text/javascript">
  function isEmpty(str) {
     // Check whether string is empty.
     for (var intLoop = 0; intLoop < str.length; intLoop++)
        if (" " != str.charAt(intLoop))
           return false;
     return true;
  }

  function checkRequired() {
     f = frm;
     var strError = "";
     for (var intLoop = 0; intLoop < f.elements.length; intLoop++)
        if (null!=f.elements[intLoop].getAttribute("required"))
           if (isEmpty(f.elements[intLoop].value))
              strError += "  " + f.elements[intLoop].name + "\n";
     if ("" != strError) {
        alert("Required data is missing:\n" + strError);
        return false;
     } else {
     //checkCheckboxes();
     //checkAgreement();
       f.submit();
       return true;
     }
  }
</script>
<script>
function init() {

<% if(request("log_number") = "") then %>
  frm.item_status.value = "Open";
<% end if %>
}

</script>
<script type="text/javascript">
<!--
function validateDate(fld) {
    return true;

    var RegExPattern = /^(?=\d)(?:(?:(?:(?:(?:0?[13578]|1[02])(\/|-|\.)31)\1|(?:(?:0?[1,3-9]|1[0-2])(\/|-|\.)(?:29|30)\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})|(?:0?2(\/|-|\.)29\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))|(?:(?:0?[1-9])|(?:1[0-2]))(\/|-|\.)(?:0?[1-9]|1\d|2[0-8])\4(?:(?:1[6-9]|[2-9]\d)?\d{2}))($|\ (?=\d)))?(((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))|([01]\d|2[0-3])(:[0-5]\d){1,2})?$/;
    var errorMessage = 'Invalid date\nPlease use the following format: mm/dd/yyyy';
    if(fld.value.length > 0) {
      if ((fld.value.match(RegExPattern)) && (fld.value!='')) {
          //alert('Date is OK');
          return true;
      } else {
          alert(errorMessage);
          fld.focus();
          fld.select();
          return false;
      }
    } else {
      return true;
    }
}
//-->
</script>
<script>

function checkStage() {
<% if(newlog = "y") then %>

<% else %>
  return true;
<% end if %>
}
</script>

<center>

<form action="divisional_saveData3.asp" method="post" name="frm" id="frm" onsubmit="return checkRequired()">

<input type="hidden" id="formname" name="formname" value="iSRT_LogInput">
<input type="hidden" id="safety_action_cnt" name="safety_action_cnt" value="<%= safety_action_cnt %>">
<input type="hidden" id="resultPage" name="resultPage" value="divisional_LogInput.asp">
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

<table border="0" cellspacing="0" cellpadding="0" width="98%" style="padding-top:0px;margin-left:0px;">
  <tr><td align="center"><span class="fonts4" style="font-size:14px;color:#737579;"><span style="font-weight:bold;color:#116c94;">Hazard ID <%= hazard_id %></span></span><div id="PINWHEEL"><img src="http://www.bristowsafety.com/images/pinwheel.gif">
</div></td></tr>
</table>

<table style="BORDER-RIGHT: 1px; PADDING-RIGHT: 3px; BORDER-TOP: 1px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; BORDER-LEFT: 1px; PADDING-TOP: 3px; BORDER-BOTTOM: 1px; BACKGROUND-COLOR: #ffffff" cellSpacing="0" cellPadding="1" width="98%">
<tr>
<td height="5" style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial" background=""></td>
</tr>
</table>

<table cellSpacing="0" cellPadding="1" width="98%" border="0">
<tbody id="markerTABLE">
<tr>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" align="center" vAlign="top">
<table cellSpacing="0" cellPadding="1" width="98%" border="0">
<tr>
<td width="100%" align="center" style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" >Hazard Title</td>
</tr>
</table>
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Risk Acceptability</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Original Date Opened</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="6" width="4%" align="center" vAlign="top" title="Source Of Information">SOI</td>

</tr>

<tr valign="top">
              <td colspan="2">
<table cellSpacing="0" cellPadding="1" width="100%" border="0">
<tr valign="top">
<td width="100%" align="center" style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial"  ><span style="font-weight:bold;font-size:9pt;color:#116c94;">
<% if(session("sms_admin") = "y") then %>
                <input type="button" value="delete" style="font-size:8px;margin-right:5px;margin-left:5px;" onclick="deleteLogNumber()">
<% end if %>
<input name="item_title" style="width:550px;" <% if((session("sms_admin") <> "y") and (request("log_number") <> "")) then %>readOnly<% end if %> value="<%= item_title %>"></td>
</tr>
</table>
              </td>
<%
  is_iSRT = "n"
  srtlinksStr = ""
  sql = "select srtLogNumber from EHD_Data where divisionalLogNumber = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and formname = 'iSRT_LogInput' and active = 'y' and archived = 'n' and srtLogNumber is not null order by srtLogNumber asc"
  set rs4 = conn_asap.execute(sql)
  if not rs4.eof then
    srtLogNumber				= rs4("srtLogNumber")

    is_iSRT = "y"

    srtlinksStr = srtlinksStr &"EH:DIV"& string(4-len(srtLogNumber),"0")&srtLogNumber &"<br>"

    sql = "select division, divisionalLogNumber from EHD_Data where srtLogNumber = "& sqlnum(srtLogNumber) &" and formname = 'iSRT_LogInput' and division <> 'EH:DIV' order by division asc, divisionalLogNumber asc"
    set rs5 = conn_asap.execute(sql)
    do while not rs5.eof
      srtdivision				= rs5("division")
      srtdivisionalLogNumber	= rs5("divisionalLogNumber")
      if((srtdivisionalLogNumber <> log_number) and (srtdivision <> viewDivision)) then
        srtlinksStr = srtlinksStr & srtdivision & string(4-len(srtdivisionalLogNumber),"0")&srtdivisionalLogNumber &"<br>"
      end if

      rs5.movenext
    loop
    srtlinksStr = rtrim(srtlinksStr)

  end if
  if((is_iSRT = "y") and (session("srt_admin") <> "y")) then
    srtReadonly = "readonly"
    srtDisabled = "disabled"
  end if
%>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt;  FONT-STYLE: normal; FONT-FAMILY: Arial; color: <%= riskcolor %>;" bgColor="ffffff"  colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
<%= curr_risk %>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1" title="<%= original_date_openedStr %>">
<%= original_date_opened %>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="6" width="4%" align="center" vAlign="top" rowSpan="1">
               <select id="soi" name="soi" style="width:120px;" required>
                  <option value="SYS">Systemic</option>
                  <option value="REA">Reactive</option>
                  <option value="PRO">Proactive</option>
                </select><script>document.getElementById("soi").value = "<%= soi %>";</script>
</td>
</tr>

<tr style="height: 5px">
<td colspan="10" bgcolor="#ffffff">
</td>
</tr>

<tr>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="19%" align="center" vAlign="top" rowspan="1">Description</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="8%" align="center" vAlign="top">Division</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Station</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="4%" align="center" vAlign="top" >Source</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="3" width="8%" align="center" vAlign="top" ></td>
</tr>

<tr><td style="padding-left:5px;FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="19%" align="center" vAlign="top" rowSpan="7">
<textarea name="item_description" style="width:600px;" rows="8" <% if((session("sms_admin") <> "y") and (request("log_number") <> "")) then %>readOnly<% end if %> <%= srtReadonly %> ><%= item_description %></textarea>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="8%" align="center"  vAlign="top" rowSpan="1">
<% if(generic = "y") then %>
<%= baseStr %>
<% else %>
<input type="text" name="baseStr" id="baseStr" style="width:230px;" <% if((session("sms_admin") <> "y") and (request("log_number") <> "")) then %>readOnly<% end if %> value = "<%= baseStr %>">
<% end if %>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<% if(generic = "y") then %>
<%= equipment %>
<% else %>
<input type="text" name="equipment" id="equipment" style="width:130px;" <% if((session("sms_admin") <> "y") and (request("log_number") <> "")) then %>readOnly<% end if %> value = "<%= equipment %>">
<% end if %>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="4%" align="center" vAlign="top" rowSpan="1">
<% if(generic = "y") then %>
<%= mission %>
<% else %>
<input type="text" name="mission" id="mission" style="width:130px;" <% if((session("sms_admin") <> "y") and (request("log_number") <> "")) then %>readOnly<% end if %> value = "<%= mission %>">
<% end if %>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="3" width="8%" align="center" vAlign="top" rowSpan="1" >

</td>

</tr>


<tr style="height: 5px">
<td colspan="8" bgcolor="#ffffff">
</td>
</tr>

<tr >
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="8%" align="center" vAlign="top">Hazard Owner</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="4%" align="center" vAlign="top" >Hazard Editor</td>
<td style="FONT-WEIGHT: bold;FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold;FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold;FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top"></td>
</tr>

<tr>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="8%" align="center" vAlign="top" rowSpan="1">
<select name="hazard_owner" id="hazard_owner" style="width:180px;" required><option value="">TBD/TBC</option><%= nameOpts %></select>
<script>
document.getElementById("hazard_owner").value = "<%= hazard_owner %>";
</script>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="4%" align="center" vAlign="top" rowSpan="1">
<%
sql = "select first_name, last_name from Tbl_Logins where LoginID = "& sqlnum(loginID)
set tmprs=conn_asap.execute(sql)
if not tmprs.eof then
  tmp_name = tmprs("first_name") &" "& tmprs("last_name")
end if
%>
<input type="text" id="hazard_editor" name="hazard_editor" size="30"  style="width:180px;"  value="<%= tmp_name %>" readonly  />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
</tr>

<tr style="height: 5px">
<td colspan="8" bgcolor="#ffffff">
</td>
</tr>

<tr >
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Date Opened</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="8%" align="center" vAlign="top">Date Due</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top" >Date Completed</td>
<td style="FONT-WEIGHT: bold;FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Next Review Date</td>
<td style="FONT-WEIGHT: bold;FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold;FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="4%" align="center" vAlign="top"></td>
</tr>

<tr>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
<input type="text" id="date_opened" name="date_opened" size="30"  style="width:73px;"  value="<%= date_opened %>" onblur="if(validateDate(this)){calcDueDate('');}"  <%= srtReadonly %> required2  title="<%= date_openedStr %>" />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="8%" align="center" vAlign="top" rowSpan="1">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td align="right" width="50%">
<input type="text" id="date_due" name="date_due" size="30"  style="width:73px;"  value="<%= date_due %>"   <%= srtReadonly %> required2 onblur="validateDate(this)" <% if(session("sms_admin") <> "y") then %>readOnly<% end if %>  title="<%= date_dueStr %>" />
</td><td align="left" width="50%"><% if(session("sms_admin") = "y") then %><a onclick="javascript:return isCalendarLoaded()" href="javascript:openCalendar('calendar2', getCurrentDate(), getNextYear(), 'frm', 'date_due')"><img id="calendar2" src="http://www.atlanta.net/global_images/appts.png" border="0"><% end if %></a>
</td></tr>
</table>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="4%" align="center" vAlign="top" rowSpan="1">
<input type="text" id="date_completed" name="date_completed" size="30"  style="width:73px;"  value="<%= date_completed %>"  onblur="validateDate(this)"  <%= srtReadonly %>  title="<%= date_completedStr %>" />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<input type="text" id="next_review_date" name="next_review_date" size="30"  style="width:73px;"  value="<%= next_review_date %>"  onblur2="if(validateDate(this)){calcDueDate('');}"  <%= srtReadonly %> required2 title="<%= next_review_dateStr %>" <% if(session("sms_admin") <> "y") then %>readOnly<% end if %> />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
</tr>

<tr style="height: 5px">
<td colspan="8" bgcolor="#ffffff">
</td>
</tr>

<tr style="height: 5px">
<td colspan="8" bgcolor="#ffffff">
</td>
</tr>

<tr style="height: 5px">
<td colspan="10" bgcolor="#ffffff">
</td>
</tr>

<tr>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="19%" align="center" vAlign="top" rowspan="1">Comments</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="25%" align="center" vAlign="top" rowspan="1">ALARP Statement</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Status</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="8%" align="center" vAlign="top">Endorsed By</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="4%" align="center" vAlign="top" >Endorsed</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="4%" align="center" vAlign="top" >Re-Open for Assessment</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="8%" align="center" vAlign="top"></td>
</tr>

<tr><td style="padding-left:5px;FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="19%" align="center" vAlign="top" rowSpan="1">
<textarea name ="item_comments" style="width:288px;" rows="3"></textarea>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="25%" vAlign="top" rowSpan="1">
<textarea name="alarp_statement" style="width:288px;" rows="3" <%= srtReadonly %> ><%= alarp_statement %></textarea>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
<% if(is_iSRT = "y") then %>
<%= item_status  %>
<% else %>
<select name="item_status" id="item_status" style="width:73px;"   <%= srtDisabled %> onchange="changeStatus(this.value)">
  <option value="Open" selected>Open</option>
  <option value="Closed">Closed</option>
  <option value="Not Applicable">Not Applicable</option>
</select>
<script>
frm.item_status.value = "<%= item_status %>";
</script>
<% end if %>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="8%" align="center" vAlign="top" rowSpan="1">
<select id="endorsed_by" name="endorsed_by" style="width:90px;"   >
  <option value=""></option>
  <option value="DSAM">DSAM</option>
  <option value="ESAC">ESAC</option>
  <option value="CSC">CSC</option>
</select>
<script>
frm.endorsed_by.value = "<%= endorsed_by %>";
</script>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="4%" align="center" vAlign="top" rowSpan="1">
<input id="endorsed" type="checkbox" name="endorsed" value="1" onclick="endorsedAlert(this)">
<% if(endorsed = "1") then %>
<script>
document.getElementById("endorsed").checked = "true";
</script>
<% end if %>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="8%" align="center" vAlign="top" rowSpan="1">
<input id="reopen" type="checkbox" name="reopen" value="1">
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
</tr>

<tr style="height: 5px">
<td align="center">
<input type="button" id="commentsButton" value="click to show comments" style="font-size:10px;margin-right:5px;margin-left:5px;" onclick="toggleComments()">
<script>
function toggleComments() {
  c = document.getElementById("commentsDIV");
  b = document.getElementById("commentsButton");
  if(c.style.display == "none") {
    c.style.display = "block";
    b.value = "click to hide comments";
  } else {
    c.style.display = "none";
    b.value = "click to show comments";
  }
}
</script>
</td>
<td colspan="9" bgcolor="#ffffff">
</td>
</tr>

<tr style="height: 5px">
<td colspan="10" bgcolor="#ffffff">
</td>
</tr>

<tr style="height: 5px">
<td colspan="2" bgcolor="#ffffff" align="left">
<div id="commentsDIV" style="display:none">
<%
sql = "select * from EHD_Comments, Tbl_Logins where EHD_Comments.division = "& sqltext2(viewdivision) &" and log_number = "& sqlnum(log_number) &" and comment_type = 'iSRT_LogInput' and EHD_Comments.loginID = Tbl_Logins.loginID order by recid desc"
set tmprs = conn_asap.execute(sql)
do while not tmprs.eof
%>
<p><%= tmprs("comment_date") %>&nbsp;<%= tmprs("first_name") %>&nbsp;<%= tmprs("last_name") %><br><%= tmprs("comment_ehd") %></p>
<%
  tmprs.movenext
loop
%>
</div>
</td>
<td colspan="8" bgcolor="#ffffff">
</td>
</tr>

<tr style="height: 5px">
<td colspan="10" bgcolor="#ffffff">
</td>
</tr>

<tr id="ROWHEADER" <% if((request("log_number") = "") or (safety_action_cnt = 0)) then %>style="display:none;"<% end if %>>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="19%" align="center"  vAlign="top" rowSpan="1">
&nbsp;
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="25%" align="center"  vAlign="top" rowSpan="1">
Activity
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">

</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
Action Owner
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="2" width="8%" align="center" vAlign="top" rowSpan="1">
Opened
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
Due
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
 Completed
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
Status
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
</td>

</tr>


<%
dictionaryFields = ""
for a = 1 to safety_action_cnt
  safety_action_nbr				= selectNode(oXML,"safety_action_nbr_"& a,"")
  safety_action					= rev_xdata2(selectNode(oXML,"safety_action_"& a,""))
  safety_action_poc				= rev_xdata2(selectNode(oXML,"safety_action_poc_"& a,""))
  safety_action_poc_email		= rev_xdata2(selectNode(oXML,"safety_action_poc_email_"& a,""))
  safety_action_open			= selectNode(oXML,"safety_action_open_"& a,"")
  safety_action_due				= selectNode(oXML,"safety_action_due_"& a,"")
  safety_action_completed		= selectNode(oXML,"safety_action_completed_"& a,"")
  safety_action_status			= selectNode(oXML,"safety_action_status_"& a,"")
  safety_action_poc2			= selectNode(oXML,"safety_action_poc2_"& a,"")
  safety_action_type			= selectNode(oXML,"safety_action_type_"& a,"")
  safety_action_other_name			= selectNode(oXML,"safety_action_other_name_"& a,"")
  safety_action_other_email			= selectNode(oXML,"safety_action_other_email_"& a,"")

  safety_action_base			= selectNode(oXML,"safety_action_base_"& a,"")

  dictionaryFields = dictionaryFields &",safety_action_"& a

  if(safety_action_poc = "Other") then
    otherdisplays = "block"
  else
    otherdisplays = "none"
  end if

if(safety_action_open <> "") then
  safety_action_openStr = day(safety_action_open) &"-"& monthname(month(safety_action_open),true) &"-"& year(safety_action_open)
end if
if(safety_action_due <> "") then
  safety_action_dueStr = day(safety_action_due) &"-"& monthname(month(safety_action_due),true) &"-"& year(safety_action_due)
end if
if((safety_action_completed <> "") and (isdate(safety_action_completed))) then
  safety_action_completedStr = day(safety_action_completed) &"-"& monthname(month(safety_action_completed),true) &"-"& year(safety_action_completed)
end if
%>
<tr>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 7pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="19%" align="left"  vAlign="top" rowSpan="1">
<% if(session("sms_admin") = "y") then %><input type="button" value="delete" style="font-size:8px;margin-right:5px;margin-left:5px;" onclick="deleteSafetyAction('<%= a %>')"> <% end if %><%= viewDivision %><input type="text" id="safety_action_nbr_<%= a %>" name="safety_action_nbr_<%= a %>" size="15"  style="width:60px;"  value="<%= log_numberStr %>.<%= a %>"  /><br/>
<select name="safety_action_type_<%= a %>" id="safety_action_type_<%= a %>" style="width:155px;font-size:10px;" required3>
  <option value="">Select Action Type</option>
  <option value="Corrective Action Required/Finding">Corrective Action Required/Finding</option>
  <option value="Recommendation">Recommendation</option>
    <option value="DSAM">DSAM</option>
    <option value="ESAC">ESAC</option>
  <option value="CSC">CSC</option>
</select>
<script>
frm.safety_action_type_<%= a %>.value = "<%= safety_action_type %>";
</script>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="25%" vAlign="top" rowSpan="1">
<textarea id="safety_action_<%= a %>" name="safety_action_<%= a %>" style="width:288px;" rows="3"><%= safety_action %></textarea>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" vAlign="top" rowSpan="1">
<!--
<select name="safety_action_base_<%= a %>" id="safety_action_base_<%= a %>" style="width:85px;"  ><%= baseOpts %></select>
<% if(safety_action_base <> "") then %>
<script>
document.getElementById("safety_action_base_<%= a %>").value = "<%= safety_action_base %>";
</script>
<% end if %>
-->
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
<input type="text" id="safety_action_poc_<%= a %>" name="safety_action_poc_<%= a %>" size="30"  style="width:73px;"  value="<%= safety_action_poc %>"   />
<div id="OTHERNAMETITLE_<%= a %>" style="margin-top:5px;font-weight:bold;font-size:7pt;display:<%= otherdisplays %>;">Other Name</div>
                <script>
                  //document.getElementById("safety_action_poc_<%= a %>").value = "<%= safety_action_poc %>";
                </script>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="2" width="8%" align="center" vAlign="top" rowSpan="1">
<div style2="float:left;"><input type="text" id="safety_action_open_<%= a %>" name="safety_action_open_<%= a %>" size="30"  style="width:70px;"  value="<%= safety_action_open %>"  onblur="if(validateDate(this)){calcDueDate('<%= a %>');}" title="<%= safety_action_openStr %>" /></div><div style2="float:right;"><a onclick="javascript:return isCalendarLoaded()" href="javascript:openCalendar('calendara_<%= a %>', getCurrentDate(), getNextYear(), 'frm', 'safety_action_open_<%= a %>')"><img id="calendara_<%= a %>" src="http://www.atlanta.net/global_images/appts.png" border="0"></a></div>
<div id="OTHERNAME_<%= a %>" style="display:<%= otherdisplays %>;"><input type="text" name="safety_action_other_name_<%= a %>" id="safety_action_other_name_<%= a %>" size="30"  style="width:73px;"  value="<%= safety_action_other_name %>"  /></div>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<div style2="float:left;"><input type="text" id="safety_action_due_<%= a %>" name="safety_action_due_<%= a %>" size="30"  style="width:70px;"  value="<%= safety_action_due %>"  onblur="validateDate(this)" <% if(session("sms_admin") <> "y") then %>readOnly<% end if %>  title="<%= safety_action_dueStr %>" /></div><div style2="float:right;"><a onclick="javascript:return isCalendarLoaded()" href="javascript:openCalendar('calendarb_<%= a %>', getCurrentDate(), getNextYear(), 'frm', 'safety_action_due_<%= a %>')"><img id="calendarb_<%= a %>" src="http://www.atlanta.net/global_images/appts.png" border="0"></a></div>
<div id="OTHEREMAILTITLE_<%= a %>" style="font-weight:bold;font-size:7pt;margin-top:5px;display:<%= otherdisplays %>;">Other Email</div>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<div style2="float:left;"><input type="text" id="safety_action_completed_<%= a %>" name="safety_action_completed_<%= a %>" size="30"  style="width:70px;"  value="<%= safety_action_completed %>"  onblur="validateDate(this)"   title="<%= safety_action_completedStr %>" /></div><div style2="float:right;"><a onclick="javascript:return isCalendarLoaded()" href="javascript:openCalendar('calendarc_<%= a %>', getCurrentDate(), getNextYear(), 'frm', 'safety_action_completed_<%= a %>')"><img id="calendarc_<%= a %>" src="http://www.atlanta.net/global_images/appts.png" border="0"></a></div>
<div id="OTHEREMAIL_<%= a %>" style="display:<%= otherdisplays %>;"><input type="text" name="safety_action_other_email_<%= a %>" id="safety_action_other_email_<%= a %>" size="30"  style="width:73px;"  value="<%= safety_action_other_email %>"  /></div>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<select id="safety_action_status_<%= a %>" name="safety_action_status_<%= a %>" style="width:73px;" >
  <option value=""></option>
  <option value="Open">Open</option>
  <option value="Closed">Closed</option>
  <option value="Void">Void</option>
</select>
<script>
frm.safety_action_status_<%= a %>.value = "<%= safety_action_status %>";
</script>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
</tr>
<%
next
%>

<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="left" width="100%" background="" bgColor="ffffff" colSpan="10">

<!--
<table width="100%" cellpadding="1" cellspacing="0" border="0" bgColor="ffffff" >
  <tbody id="markerTABLE">
-->
    <tr id="markerROW" style="height:1px;"><td style="height:1px;" colSpan="10"></td></tr>
<!--
  </tbody>
</table>
-->

</td>
</tr>
<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="left"  background="" bgColor="ffffff">
<input  type="button" value="Add Update" style="font-size:10px;width:100px;margin-top:5px;margin-left:10px;" onclick="addRow('markerTABLE','markerROW')">
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial;padding-left:25px;" align="left" background="" bgColor="ffffff" colSpan="9">

</td>
</tr>


<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="center" background="" bgColor="ffffff" colSpan="10">.
</td>
</tr>

</tbody>
</table>

<%
set divXML				= CreateObject("Microsoft.XMLDOM")
divXML.async			= false

sql = "select formDataXML, division, divisionalLogNumber from EHD_Data where srtLogNumber = "& sqlnum(srtLogNumber) &" and formname = 'iSRT_LogInputx' and divisionalLogNumber is not null and division <> 'EH:DIV' order by division asc, divisionalLogNumber asc"
set divrs = conn_asap.execute(sql)
do while not divrs.eof
  tmpformDataXML			= divrs("formDataXML")
  tmpdivision				= divrs("division")
  tmpdivisionalLogNumber	= divrs("divisionalLogNumber")
  tmpdivisionalLogNumberStr	= string(4-len(tmpdivisionalLogNumber),"0")&tmpdivisionalLogNumber

  if(tmpdivision <> viewdivision) then
%>
<div align="left" style="padding-left:5px;">
<table cellSpacing="0" cellPadding="1" width="470" border="0" style="margin-top:20px;">
<tbody>
<tr valign="top">
<td align="left"><span style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial"><%= tmpdivision %><%= tmpdivisionalLogNumberStr %> Action Items :&nbsp;</span></td>
</tr>
</tbody>
</table>
</div>

<table cellSpacing="0" cellPadding="1" width="100%" border="0">
<tbody>
<tr>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
&nbsp;
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="17%" align="center"  vAlign="top" rowSpan="1">
Activity
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
Base
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
Action Owner
</td>
<!--
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
POC Email
</td>
-->
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
Opened
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
Due
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
 Completed
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" align="center" vAlign="top" rowSpan="1">
Status
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" align="center" vAlign="top" rowSpan="1">
&nbsp;</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" align="center" vAlign="top" rowSpan="1">
&nbsp;</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" align="center" vAlign="top" rowSpan="1">
&nbsp;</td>
</tr>
<%
divXML.loadXML(tmpformDataXML)

tmpsafety_action_cnt		= selectNode(divXML,"safety_action_cnt","")

for a = 1 to tmpsafety_action_cnt
  safety_action_nbr				= selectNode(divXML,"safety_action_nbr_"& a,"")
  safety_action					= rev_xdata2(selectNode(divXML,"safety_action_"& a,""))
  safety_action_poc				= rev_xdata2(selectNode(divXML,"safety_action_poc_"& a,""))
  safety_action_poc_email		= rev_xdata2(selectNode(divXML,"safety_action_poc_email_"& a,""))
  safety_action_open			= selectNode(divXML,"safety_action_open_"& a,"")
  safety_action_due				= selectNode(divXML,"safety_action_due_"& a,"")
  safety_action_completed		= selectNode(divXML,"safety_action_completed_"& a,"")
  safety_action_status			= selectNode(divXML,"safety_action_status_"& a,"")
  safety_action_base			= selectNode(divXML,"safety_action_base_"& a,"")

%>
<tr valign="top">
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
<%= hazard_id %>.<%= a %>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colspan="1" width="17%" vAlign="top" rowSpan="1">
<%= safety_action %>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
<%= safety_action_base%>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
<%= safety_action_poc %>
</td>
<!--
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
<%= safety_action_poc_email %>
</td>
-->
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<%= safety_action_open %>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="2" width="8%" align="center" vAlign="top" rowSpan="1">
<%= safety_action_due %>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<%= safety_action_completed %>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<%= safety_action_status %>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
</tr>
<%
next
%>
</tbody>
</table>
<%
  end if
  divrs.movenext
loop
%>

<table border="0" cellspacing="0" cellpadding="0" width="100%" style="margin-top:20px;margin-bottom:20px;" align="center">
  <tr><td align="center"><img src="images/1pgrey.gif" width="98%" height="1"></td></tr>
</table>

<%
sql = "select * from SRT_Links where primary_log_number = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and archived = 'n'"
set lrs = conn_asap.execute(sql)
if not lrs.eof then
%>
<div align="left" style="padding-left:5px;">
<table cellSpacing="0" cellPadding="1" width="470" border="0" style="margin-top:20px;">
<tbody>
<tr valign="top">
<td width="170" align="left"><span style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial">Related Log Numbers :&nbsp;</span></td>
<td width="300">
<div >
<table border="0" cellspacing="0" cellpadding="0" width="300">
<%
do while not lrs.eof
  tmp_secondarylognumber = string(4-len(lrs("secondary_log_number")),"0")&lrs("secondary_log_number")
  tmp_division = lrs("division")
  isLocked = isLogLocked(lrs("secondary_log_number"),viewDivision)
  if(isLocked = "n") then
    clickloc = "divisional_LogInput.asp?log_number="& lrs("secondary_log_number") &"&viewDivision="& viewDivision
  else
    clickloc = "javascript:alert('Log "& log_number &" locked\nuser "& isLocked &"')"
  end if
%>
  <tr valign="top">
  <td><span style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;<a href="<%= clickloc %>"><%= tmp_division %><%= tmp_secondarylognumber %></a></span></td>
  </tr>
<%
  lrs.movenext
loop
%>
<%
do while not lrs.eof
  tmp_secondarylognumber = string(4-len(lrs("secondary_log_number")),"0")&lrs("secondary_log_number")
  tmp_division = lrs("division")
  isLocked = isLogLocked(lrs("secondary_log_number"),viewDivision)
  if(isLocked = "n") then
    clickloc = "divisional_LogInput.asp?log_number="& lrs("secondary_log_number") &"&viewDivision="& viewDivision
  else
    clickloc = "javascript:alert('Log "& log_number &" locked\nuser "& isLocked &"')"
  end if
%>
  <tr valign="top">
  <td><span style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;<a href="<%= clickloc %>"><%= tmp_division %><%= tmp_secondarylognumber %></a></span></td>
  </tr>
<%
  lrs.movenext
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
%>

<%
if(len(trim(srtLogNumber)) = 0 or IsNull(srtLogNumber)) then
  tmpsql = "where a.divisionalLogNumber = "& sqlnum(log_number)
else
  tmpsql = "where a.srtlognumber = "& sqlnum(srtLogNumber)
end if
sql = ""& _
"select a.division, a.lognumber, b.real_file_name file_name, b.recid, b.attach_size "& _
"from EHD_Data a, EHD_Attachments b "& _
tmpsql & _
" and a.division = "& sqltext2(viewDivision) & _
" and a.active = 'y' "& _
"and a.archived = 'n' "& _
"and a.formname = 'iSRT_LogInput' "& _
"and a.division = b.division "& _
"and a.lognumber = b.log_number "& _
"and b.archived = 'n' "& _
"order by a.division asc"
'response.write(sql)
'response.end
set ars = conn_asap.execute(sql)
if not ars.eof then
%>
<div align="left" style="padding-left:5px;">
<table cellSpacing="0" cellPadding="1" width="470" border="0" style="margin-top:20px;">
<tbody>
<tr valign="top">
<td width="120" align="left"><span style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial">Attachments :&nbsp;</span></td>
<td width="350">
<div >
<table border="0" cellspacing="0" cellpadding="0" width="350">
<%
do while not ars.eof

  afile_name		= ars("file_name")
  arecid			= ars("recid")
  adivision			= ars("division")
  asize				= ars("attach_size")

%>
  <tr valign="top">
  <td><span style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;<a href="retrieveFile3.asp?recid=<%= arecid %>" target="_blank"><%= adivision %>&nbsp;<%= afile_name %><!-- &nbsp;-&nbsp;<%= asize %>&nbsp;bytes --></a></span></td>
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
%>

<div align="left" id="linkDIV" style="display:none;padding-left:5px;margin-top:10px;">
<table cellSpacing="0" cellPadding="1" width="99%" border="0" style="margin-top:0px;">
<tbody>
<tr valign="top">
<td align="left"><span style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial">Log Number Links </span></td>
</tr><tr><td >
<div style="border:1px solid black;height:110px;overflow:auto;">
<table border="0" cellspacing="5" cellpadding="0" width="98%">
<%
set loXML					= CreateObject("Microsoft.XMLDOM")
loXML.async					= false
tmpLogNumber = 0

sql = "select divisionalLogNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'iSRT_LogInput' and archived = 'n' and division = "& sqltext2(viewDivision) &" and divisionalLogNumber is not null and active = 'y' order by divisionalLogNumber desc, recid desc"
set lrs=conn_asap.execute(sql)
do while not lrs.eof

  lformDataXML				= lrs("formDataXML")
  llog_number				= lrs("divisionalLogNumber")
  ldivision					= lrs("division")

  loXML.loadXML(lformDataXML)

  litem_description			= rev_xdata2(selectNode(loXML,"item_description",""))

  if((cint(tmpLogNumber) <> cint(llog_number)) and (cint(llog_number) <> cint(log_number))) then
    tmpLogNumber = llog_number

    llog_number				= string(4-len(llog_number),"0")&llog_number
%>
  <tr valign="top" style="padding-bottom:10px;">
  <td width="100"><input type="checkbox" id="links_<%= lrs("divisionalLogNumber") %>" name="links" value="<%= llog_number %>"><span style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;<%= ldivision %><%= llog_number %></span></td>
  <td width="98%"><span style="FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Arial;border 1px solid black;"><%= litem_description %></span></td></tr>
<%
  end if
  lrs.movenext
loop
%>
</table>
</div>
</td>
</tr>
<tr><td><input type="button" value="Save Links" style="width:160px;font-weight:bold;height:20px;margin-top:3px;" onclick="saveLinks()"></td></tr>
</tbody>
</table>
</div>

<table cellSpacing="0" cellPadding="0" width="98%" border="0" bgcolor="white">

<tr >
<td align="center">

<input type="submit" value="Save" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-right:3px;"><input type="button" value="Assess Risk" style="font-size:10px;width:160px;font-weight:normal;height:20px;" onclick="goToRisk()"><br><input type="button" value="Add/Remove Attachments" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-top:3px;margin-right:3px;" onclick="goToAttachments()"><input type="button" value="Log Summary" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-top:3px;" onclick="viewAssessmentSummary()"><br><input type="button" value="Email This Item" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-right:3px;" onclick="goToEmail()"><input type="button" value="Return To Base Hazards" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-top:3px;" onclick="document.location='divisional_base.asp?viewdivision=<%= viewdivision %>'">
<% if((session("srt_admin") = "l") or ((session("srt_admin") = "p"))) then %>
<% if(is_iSRT = "y") then %>
<br><input type="button" value="Request Demotion from D-SAG" style="font-size:10px;width:230;font-weight:normal;height:20px;margin-top:3px;margin-bottom:3px;" onclick="sendDemotionRequest()">
<% else %>
<br><input type="button" value="Request Escalation to D-SAG" style="font-size:10px;width:230;font-weight:normal;height:20px;margin-top:3px;margin-bottom:3px;" onclick="sendPromotionRequest()">
<% end if %>
<% end if %>
<% if(session("srt_admin") = "y") then %>
<% if(is_iSRT = "y") then %>
<br><input type="button" value="Demote from D-SAG" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-top:3px;margin-bottom:3px;" onclick="demoteFromiSRT()">
<% else %>
<br><input type="button" value="Escalate to D-SAG" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-top:3px;margin-bottom:3px;" onclick="promoteToiSRT()">
<% end if %>


<% end if %>
<br>

</td>
</td>
</tr>

<tr height="20">
<td>
&nbsp;
</td>
</tr>

</table>

<input type="hidden" id="srtLogNumber" name="srtLogNumber" value="<%= srtLogNumber %>">

</form>

<script>
<%
sql = "select * from SRT_Links where primary_log_number = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and archived = 'n'"
set lrs = conn_asap.execute(sql)
do while not lrs.eof
%>
document.getElementById("links_<%= lrs("secondary_log_number") %>").checked = true;
<%
  lrs.movenext
loop
%>

function sendPromotionRequest() {
  var alerttext = "Request Sent\nCopy of request sent from <%= session("email_address") %>";
  var currNode;
  isrtXML.async = false;
  isrtXML.resolveExternals = false;
  isrtXML.load("/requestPromotionToSRT.asp?logNumber=<%= log_numberStr %>&viewDivision=<%= viewDivision %>&requestor=<%= session("employee_number") %>");
  alert(alerttext);
  document.location='divisional_LogDisplay.asp?viewdivision=<%= viewdivision %>';
}
function sendDemotionRequest() {
  var alerttext = "Request Sent\nCopy of request sent from <%= session("email_address") %>";
  var currNode;
  isrtXML.async = false;
  isrtXML.resolveExternals = false;
  isrtXML.load("/requestDemotionFromSRT.asp?logNumber=<%= log_numberStr %>&viewDivision=<%= viewDivision %>&requestor=<%= session("employee_number") %>");
  alert(alerttext);
  document.location='divisional_LogDisplay.asp?viewdivision=<%= viewdivision %>';
}

function promoteToiSRT() {
  document.frm.action = "promoteToiSRT.asp";
  document.frm.submit();
}

function demoteFromiSRT() {
  document.frm.action = "demoteFromiSRT.asp";
  document.frm.submit();
}
</script>
<script>
function endorsedAlert(o) {
  if(o.checked) {
    if((document.getElementById("item_status").value != "ALARP")&&(document.getElementById("item_status").value != "Not Applicable")) {
      alert("Please ensure status is ALARP or Not Applicable");
    }
  }
}
</script>

<iframe id="CalFrame" style="display:none; position:absolute; width:156px; height:198px; z-index=100;border: 1px solid black;" marginheight="0" marginwidth="0" noresize frameborder="0" scrolling="no" src="calendar.htm"></iframe>

<!--#include file ="includes/footer.inc"-->
<script>
document.getElementById("PINWHEEL").style.display = "none";
</script>
</body>
</html>
<!--
<%= formDataXML %>
-->
<xml id="dateXML"></xml>
<xml id="isrtXML"></xml>

