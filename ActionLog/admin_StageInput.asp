<%
'###############################################
'#
'# admin_StageInput.asp
'#
'# Creation or modification of iSRT stage data
'#
%>
<% ' vi: set foldmethod=marker syn=aspvbs linebreak softtabstop=2 tabstop=2 shiftwidth=2 expandtab: %>
<!--#include file="includes/security.inc" -->
<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<!--#include virtual="/ASPSpellCheck/ASPSpellInclude.inc"-->
<%
viewDivision = request("viewDivision")
if(len(viewDivision) = 0) then
  'viewDivision = "ACS"
  viewDivision = session("division")
end if
viewDivision = "iSRT"
%>
<html><head>
<!--#include file ="includes/commonhead.inc"-->
<%
log_number = request("log_number")
position = request("position")

%>
<%
'###############################################
'# Grab new log number for Stage area when create of stage item
'#
%>
<%
if(log_number = "") then
  if( (viewDivision = "ACS") or (viewDivision = "CGO") ) then
    sql = "select max(srtStageNumber) maxsrtStageNumber from EHD_Data where division in ('ACS','CGO') and srtStageNumber is not null and active = 'y' and archived = 'n' and formName = 'iSRT_LogInput'"
  else
    sql = "select max(srtStageNumber) maxsrtStageNumber from EHD_Data where division = "& sqltext2(viewDivision) &" and srtStageNumber is not null and formName = 'iSRT_LogInput'"
  end if
  set tmprs=conn_asap.execute(sql)
  if not tmprs.eof then
    if(isnull(tmprs("maxsrtStageNumber"))) then
      log_number = 0
    else
      log_number = cint(tmprs("maxsrtStageNumber"))
    end if
  else
    log_number = 0
  end if
  log_number = log_number +1

end if

log_number				= string(4-len(log_number),"0")&log_number

'###############################################
'# Retrieve information for existing stage item; load into XML object
'#
sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and division = "& sqltext2(viewDivision) &" and srtStageNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' order by srtStageNumber desc, recid desc"
  set rs=conn_asap.execute(sql)

log_numberStr				= string(4-len(log_number),"0")&log_number

set oXML					= CreateObject("Microsoft.XMLDOM")
oXML.async					= false

if not rs.eof then
  loginID					= rs("loginID")
  createDate				= rs("createDate")
  formDataXML				= rs("formDataXML")
  recid						= rs("recid")
  'log_number				= rs("logNumber")
  log_number				= string(4-len(log_number),"0")&log_number


  oXML.loadXML(formDataXML)

  safety_action_cnt			= selectNode(oXML,"safety_action_cnt","")
  item_number				= selectNode(oXML,"item_number","")
  item_description			= rev_xdata2(selectNode(oXML,"item_description",""))
  accountable_leader		= rev_xdata2(selectNode(oXML,"accountable_leader",""))
  source					= rev_xdata2(selectNode(oXML,"source",""))
  date_opened				= selectNode(oXML,"date_opened","")
  date_due					= selectNode(oXML,"date_due","")
  date_completed			= selectNode(oXML,"date_completed","")
  item_status				= selectNode(oXML,"item_status","")

end if

if(safety_action_cnt = "") then
  safety_action_cnt = 0
end if

tmpCnt					= cint(safety_action_cnt)

'sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and logNumber = "& sqlnum(log_number) &" and archived = 'n' order by logNumber desc, recid desc"
sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and division = "& sqltext2(viewDivision) &" and srtStageNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' order by srtStageNumber desc, recid desc"

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
    srtLogNumberStr				= "iSRT"&string(4-len(srtLogNumber),"0")&srtLogNumber
  end if


  oXML2.loadXML(formDataXML)

  safety_action_cnt			= selectNode(oXML2,"safety_action_cnt","")
  item_number				= selectNode(oXML2,"item_number","")
  item_description			= rev_xdata2(selectNode(oXML2,"item_description",""))
  accountable_leader		= rev_xdata2(selectNode(oXML2,"accountable_leader",""))
  source					= rev_xdata2(selectNode(oXML2,"source",""))
  date_opened				= selectNode(oXML2,"date_opened","")
  date_due					= selectNode(oXML2,"date_due","")
  date_completed			= selectNode(oXML2,"date_completed","")
  item_status				= selectNode(oXML2,"item_status","")
  item_status2				= selectNode(oXML2,"item_status2","")

  if(item_status = "") then
    item_status = item_status2
  end if

end if

if(safety_action_cnt = "") then
  safety_action_cnt = 0
end if

tmpCnt					= cint(safety_action_cnt)

'###############################################
'# Retrieve risk information for existing stage item; load into XML object
'#

set rXML                    = CreateObject("Microsoft.XMLDOM")
rXML.async                  = false
sql = "select logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'risk' and srtStageNumber = "& sqlnum(log_number) &"  and archived = 'n' and active = 'y' order by srtStageNumber desc, recid desc"
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

<%
'###############################################
'# addRow: javascript function for dynamically adding action item row
'#
%>
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

<% if(session("srt_admin") = "y") then %>
  newTD1.innerHTML = "<!-- <input type='button' value='delete' style='font-size:8px;margin-right:5px;margin-left:5px;' onclick=\"deleteSafetyAction('"+currCnt+"')\"> --> <span style='FONT-WEIGHT: normal; FONT-SIZE: 7pt;  FONT-STYLE: normal; FONT-FAMILY: Arial;'><%= viewDivision %> <input type='text' name='safety_action_nbr_"+currCnt+"' size='15'  style='width:60px;'  value='<%= log_number %>."+currCnt+"' required='false' readonly /></span><select name='safety_action_type_"+currCnt+"' style='width:50px;' required='false'><option value=''></option><option value='CAR'>CAR</option><option value='Finding'>Finding</option><option value='Recommendation'>Recommendation</option></select>";
<% else %>
  newTD1.innerHTML = "<span style='FONT-WEIGHT: normal; FONT-SIZE: 7pt;  FONT-STYLE: normal; FONT-FAMILY: Arial;'><%= viewDivision %> <input type='text' name='safety_action_nbr_"+currCnt+"' size='30'  style='width:73px;'  value='<%= log_number %>."+currCnt+"' required='false' readonly /></span><select name='safety_action_type_"+currCnt+"' style='width:50px;' required='false'><option value=''></option><option value='CAR'>CAR</option><option value='Finding'>Finding</option><option value='Recommendation'>Recommendation</option></select>";
<% end if %>
  newTD2.innerHTML = "<textarea name='safety_action_"+currCnt+"' style='width:288px;' rows='3'></textarea>";
  //newTD3.innerHTML = "<input type='text' name='safety_action_poc_"+currCnt+"' size='30'  style='width:73px;'  value='' required='false' />";
  newTD3.innerHTML = "<select name='safety_action_poc_"+currCnt+"' style='width:85px;' required='false'  onchange='checkOther(this,\""+currCnt+"\")'><option value=''></option><%= pocSTR %><option value='Other'>Other</option></select><div id='OTHERNAMETITLE_"+currCnt+"' style='font-family:Arial;font-weight:normal;font-size:7pt;display:none;margin-top:5px;'>Other Name</div>";
  //newTD4.innerHTML = "<input type='text' name='safety_action_poc_email_"+currCnt+"' size='30'  style='width:73px;'  value='' required='false' />";
  newTD4.innerHTML = "<input type='text' name='safety_action_open_"+currCnt+"' size='30'  style='width:73px;'  value='' required='false' onblur=\"if(validateDate(this)){calcDueDate('"+currCnt+"');}\" /><div id='OTHERNAME_"+currCnt+"' style='display:none;'><input type='text' name='safety_action_other_name_"+currCnt+"' id='safety_action_other_name_"+currCnt+"' size='30'  style='width:73px;'  value='' required='false'  /></div>";
  newTD5.innerHTML = "<input type='text' name='safety_action_due_"+currCnt+"' size='30'  style='width:73px;'  value='' required='false' onblur='validateDate(this)' /><div id='OTHEREMAILTITLE_"+currCnt+"' style='font-family:Arial;font-weight:normal;font-size:7pt;margin-top:5px;display:none;'>Other Email</div>";
  newTD6.innerHTML = "<input type='text' name='safety_action_completed_"+currCnt+"' size='30'  style='width:73px;'  value='' required='false' onblur='validateDate(this)' /><div id='OTHEREMAIL_"+currCnt+"' style='display:none;'><input type='text' name='safety_action_other_email_"+currCnt+"' id='safety_action_other_email_"+currCnt+"' size='30'  style='width:73px;'  value='' required='false' /></div>";
  newTD7.innerHTML = "<select name='safety_action_status_"+currCnt+"' style='width:73px;' required='false'><option selected value='Open'>Open</option><option value='Closed'>Closed</option><option value='Void'>Void</option></select>";
  newTD8.innerHTML = "&nbsp;";
  newTD9.innerHTML = "&nbsp;";

}


<%
'###############################################
'# Javascript utility functions
'#
%>
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
  return;

  document.getElementById("safety_action_nbr_"+a).name = "x"+document.getElementById("safety_action_nbr_"+a).name;
  document.getElementById("safety_action_type_"+a).name = "x"+document.getElementById("safety_action_type_"+a).name;
  document.getElementById("safety_action_"+a).name =
  "x"+document.getElementById("safety_action_"+a).name;
  document.getElementById("safety_action_poc_"+a).name = "x"+document.getElementById("safety_action_poc_"+a).name;
  //document.getElementById("safety_action_poc2_"+a).name = "x"+document.getElementById("safety_action_poc2_"+a).name;
  //document.getElementById("safety_action_poc_email_"+a).name = "x"+document.getElementById("safety_action_poc_email_"+a).name;
  document.getElementById("safety_action_open_"+a).name = "x"+document.getElementById("safety_action_open_"+a).name;
  document.getElementById("safety_action_due_"+a).name = "x"+document.getElementById("safety_action_due_"+a).name;
  document.getElementById("safety_action_completed_"+a).name = "x"+document.getElementById("safety_action_completed_"+a).name;
  document.getElementById("safety_action_status_"+a).name = "x"+document.getElementById("safety_action_status_"+a).name;
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
  document.getElementById("resultPage").value = "admin_StageList.asp";
  //frm.submit();
  checkRequired();
}

function goToRisk() {
  frm.action = "admin_stagevisual.asp";
  frm.submit();
  //checkRequired();
}

function goToEmail() {
  frm.action = "admin_emailInfo.asp";
  //frm.submit();
  checkRequired();
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
  document.getElementById("resultPage").value = "admin_LogInput.asp";
  //frm.submit();
  checkRequired();
}

function goToAttachments() {
  frm.action = "admin_Attachments.asp";
  //frm.submit();
  checkRequired();
}

function viewAssessmentSummary() {
  frm.action = "admin_submitRiskanalysis.asp";
  //frm.submit();
  checkRequired();
}

function deleteLogNumber() {
  frm.action = "admin_deleteLogNumber.asp";
  //frm.submit();
  checkRequired();
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
  if(v =="" ) {
    openDate = new Date(document.getElementById("date_opened").value);
    dueDate = document.getElementById("date_due");
    daysToAdd = 90;
    newDate = openDate;
    newDate.setDate(newDate.getDate() + daysToAdd);
    if( (newDate.getMonth()+1) < 10)
	    newMonth = "0"+(newDate.getMonth()+1);
	  else
	    newMonth = newDate.getMonth()+1;
    // Need the +1 for the month because the months go from 0-11, don't ask why.
    dueDate.value = newMonth+"/"+newDate.getDate()+"/"+newDate.getFullYear();
  } else {
    openDate = new Date(document.getElementById("safety_action_open_"+v).value);
    dueDate = document.getElementById("safety_action_due_"+v);
    daysToAdd = 45;
    newDate = openDate;
    newDate.setDate(newDate.getDate() + daysToAdd);
    if( (newDate.getMonth()+1) < 10)
      newMonth = "0"+(newDate.getMonth()+1);
    else
      newMonth = newDate.getMonth()+1;
    dueDate.value = newMonth+"/"+newDate.getDate()+"/"+newDate.getFullYear();
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
        if (null!=f.elements[intLoop].getAttribute("required2"))
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
  //frm.item_status.value = "Open";
<% end if %>
}

</script>
<script type="text/javascript">
<!--
function validateDate(fld) {
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
<%
'###############################################
'# Dynamic menu
'#
%>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
<!--#include file="script/nav.js"-->
<style>
</style></head>
<body bottomMargin="3" bgColor="#ffffff" leftMargin="3" topMargin="3" rightMargin="3" onload="init()">
      <div id="headerDiv">
<!--#include file="includes/sms_header.inc"-->
      </div>
<center>

<form action="admin_saveStageData.asp" method="post" name="frm" id="frm">

<input type="hidden" id="formname" name="formname" value="iSRT_LogInput">
<input type="hidden" id="safety_action_cnt" name="safety_action_cnt" value="<%= safety_action_cnt %>">
<input type="hidden" id="resultPage" name="resultPage" value="admin_LogDisplay.asp">
<input type="hidden" id="get_max_recid" name="get_max_recid" value="">
<input type="hidden" id="viewDivision" name="viewDivision" value="<%= viewDivision %>">
<input type="hidden" id="item_status2" name="item_status2" value="<%= item_status %>">
<input type="hidden" id="position" name="position" value="<%= position %>">
<input type="hidden" id="log_number" name="log_number" value="<%= log_number %>">
<input type="hidden" id="isStage" name="isStage" value="y">

<table border="0" cellspacing="0" cellpadding="0" width="98%" style="padding-top:0px;margin-left:0px;">
  <tr><td align="center"><span class="fonts4" style="font-size:14px;color:#737579;"><span style="font-weight:bold;color:#000040;">Stage Number STG<%= log_numberStr %></span></span></td></tr>
</table>

<table style="BORDER-RIGHT: 1px; PADDING-RIGHT: 3px; BORDER-TOP: 1px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; BORDER-LEFT: 1px; PADDING-TOP: 3px; BORDER-BOTTOM: 1px; BACKGROUND-COLOR: #ffffff" cellSpacing="0" cellPadding="1" width="98%">
<tr>
<td height="5" style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial" background=""></td>
</tr>
</table>

<table cellSpacing="0" cellPadding="1" width="98%" border="0">
<tbody id="markerTABLE">
<tr>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial;padding-left:120px;" bgColor="000040" colSpan="1" width="50%" align="center" vAlign="top">Description</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial;padding-right:120px;" bgColor="000040" colSpan="1" width="50%" align="center" vAlign="top">Source</td>
</tr>
<tr>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial;padding-left:120px;" bgColor="ffffff"  colSpan="1" width="50%" vAlign="top" align="center" rowSpan="1">
<textarea name="item_description" style="width:350px;" rows="6" <%= srtReadonly %> ><%= item_description %></textarea>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial;padding-right:120px;" bgColor="ffffff"  colSpan="1" width="50%" align="center" vAlign="top" rowSpan="1">
<input type="text" name="source" size="30"  style="width:200px;"  value="<%= source %>" required="false"  <%= srtReadonly %> required2 />
</td>
</tr>

<tr style="height: 5px">
<td colspan="2" bgcolor="#ffffff">
</td>
</tr>


<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="center" background="" bgColor="ffffff" colSpan="2">.
</td>
</tr>

</tbody>
</table>

<%
'###############################################
'# Begin action list of Stage Action Items
'#
%>
<%
set divXML				= CreateObject("Microsoft.XMLDOM")
divXML.async			= false

sql = "select formDataXML, division, divisionalLogNumber from EHD_Data where srtLogNumber = "& sqlnum(srtLogNumber) &" and active = 'y' and formname = 'iSRT_LogInput' and archived = 'n' and divisionalLogNumber is not null and division <> 'iSRT' order by division asc, divisionalLogNumber asc"
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
POC
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
'###############################################
'# Retrieve and loop through Stage Action Items from XML object
'#
%>
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

%>
<tr valign="top">
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
<%= tmpdivision %><%= tmpdivisionalLogNumberStr %>.<%= a %>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colspan="1" width="17%" vAlign="top" rowSpan="1">
<%= safety_action %>
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
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
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

<table border="0" cellspacing="0" cellpadding="0" width="98%" style="margin-top:20px;margin-bottom:50px;" align="center">
  <tr><td align="center"><img src="images/1pgrey.gif" width="98%" height="1"></td></tr>
</table>
<%
'###############################################
'# Show linked Stage Action Items
'#
%>
<%
sql = "select * from SRT_Links where primary_log_number = "& sqlnum(log_number2) &" and division = "& sqltext2(viewDivision) &" and archived = 'n'"
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
  isLocked = isLogLocked(lrs("secondary_log_number"),"EH:DIV")
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
  isLocked = isLogLocked(lrs("secondary_log_number"),"EH:DIV")
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
'###############################################
'# List uploaded Stage documents
'#
%>
<%
if(len(trim(srtLogNumber)) = 0 or IsNull(srtLogNumber)) then
  tmpsql = "where a.divisionalLogNumber = "& sqlnum(log_number)
else
  tmpsql = "where a.srtlognumber = "& sqlnum(srtLogNumber)
end if
sql = ""& _
"select a.division, a.lognumber, b.file_name, b.recid, b.attach_size size "& _
"from EHD_Data a, EHD_Attachments b "& _
tmpsql & _
" and a.active = 'y' "& _
"and a.archived = 'n' "& _
"and a.formname = 'iSRT_LogInput' "& _
"and a.division = b.division "& _
"and a.lognumber = b.log_number "& _
"and b.archived = 'n' "& _
"order by division asc"
'response.write(sql)
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
  asize				= ars("size")

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
<%
'###############################################
'# Area to choose Stage action items with which to link
'#
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
tmpLogNumber = ""

sql = "select divisionalLogNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'iSRT_LogInput' and archived = 'n' and division = "& sqltext2(viewDivision) &" and divisionalLogNumber is not null and active = 'y' order by divisionalLogNumber desc, recid desc"
set lrs=conn_asap.execute(sql)
do while not lrs.eof

  lformDataXML				= lrs("formDataXML")
  llog_number				= lrs("divisionalLogNumber")
  ldivision					= lrs("division")

  loXML.loadXML(lformDataXML)

  litem_description			= rev_xdata2(selectNode(loXML,"item_description",""))

  if((tmpLogNumber <> llog_number) and (cint(llog_number) <> cint(log_number))) then
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
<%
'###############################################
'# Activity buttons
'#
%>
<input type="submit" value="Save" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-right:3px;"><input type="button" value="Assess Risk" style="font-size:10px;width:160px;font-weight:normal;height:20px;" onclick="goToRisk()"><br><input type="button" value="Return To Stage List" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-top:3px;margin-right:3px;" onclick="document.location='admin_stageList.asp?viewdivision=<%= viewdivision %>'"><% if(request("log_number") <> "") then %><% if(session("srt_admin") = "y") then %><input type="button" value="Add to iSRT Action Log" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-top:3px;margin-bottom:0px;" onclick="promoteToiSRT()">
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
<%
'###############################################
'# Set checkboxes for already-linked Stage items
'#
%>
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
  isrtXML.load("/sms_stage2/requestPromotionToDivisional.asp?logNumber=<%= log_numberStr %>&viewDivision=<%= viewDivision %>&requestor=<%= session("employee_number") %>");
  alert(alerttext);
  document.location='divisional_StageList.asp?viewdivision=<%= viewdivision %>';
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
  document.frm.action = "promoteStageToiSRT.asp";
  document.frm.submit();
}

function demoteFromiSRT() {
  document.frm.action = "demoteFromiSRT.asp";
  document.frm.submit();
}
</script>

<!--#include file ="includes/footer.inc"-->
</body>
</html>
<!--
<%= formDataXML %>
-->
<xml id="dateXML"></xml>
<xml id="isrtXML"></xml>

