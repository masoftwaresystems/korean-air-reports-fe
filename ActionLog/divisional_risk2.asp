<!--#include file="showVars.inc"-->
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
  response.redirect("divisional_LogDisplay.aspx")
  response.end
end if
lockLog request("log_number"),request("viewDivision")
viewDivision = request("viewDivision")
if(len(viewDivision) = 0) then
  viewDivision = request("cookie_division")
end if
%>
<%
dictionaryFields            = ""
recid                       = request("recid")
log_number                  = request("log_number")
viewDivision                = request("viewDivision")
contributing_factors_cnt    = "1"
active_errors_cnt           = "1"
latent_conditions_cnt       = "1"
causal_factors_cnt          = "1"
corrective_actions_cnt      = "1"
current_measures_cnt        = "1"
factors_cnt 			    = "1"
consequences_cnt		    = "1"
comments_cnt			    = "1"
set oXML                    = CreateObject("Microsoft.XMLDOM")
oXML.async                  = false
sql = "select logNumber, division, recid, loginID, createDate, formdataXML, generic from EHD_Data where formname = 'risk' and logNumber = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and active = 'y' order by logNumber desc, recid desc"
set rs = conn_asap.execute(sql)
if not rs.eof then
  formDataXML                           = rs("formDataXML")
  generic                   	        = rs("generic")

  oXML.loadXML(formDataXML)

  active_errors_cnt                     = selectNode(oXML,"active_errors_cnt","1")
  contributing_factors_cnt              = selectNode(oXML,"contributing_factors_cnt","1")
  latent_conditions_cnt                 = selectNode(oXML,"latent_conditions_cnt","1")
  causal_factors_cnt                    = selectNode(oXML,"causal_factors_cnt","1")
  corrective_actions_cnt                = selectNode(oXML,"corrective_actions_cnt","1")
  current_measures_cnt					= selectNode(oXML,"current_measures_cnt","1")
  factors_cnt					        = selectNode(oXML,"factors_cnt","1")
  consequences_cnt						= selectNode(oXML,"consequences_cnt","1")
  pre_physical_injury                   = selectNode(oXML,"pre_physical_injury","")
  pre_damage_to_the_environment         = selectNode(oXML,"pre_damage_to_the_environment","")
  pre_damage_to_assets                  = selectNode(oXML,"pre_damage_to_assets","")
  pre_potential_increased_cost          = selectNode(oXML,"pre_potential_increased_cost","")
  pre_damage_to_corporate_reputation    = selectNode(oXML,"pre_damage_to_corporate_reputation","")
  pre_damage_to_corporate_reputation2   = selectNode(oXML,"pre_damage_to_corporate_reputation2","")
  pre_likelihood                        = rev_xdata2(selectNode(oXML,"pre_likelihood",""))
  post_physical_injury                  = selectNode(oXML,"post_physical_injury","")
  post_damage_to_the_environment        = selectNode(oXML,"post_damage_to_the_environment","")
  post_damage_to_assets                 = selectNode(oXML,"post_damage_to_assets","")
  post_potential_increased_cost         = selectNode(oXML,"post_potential_increased_cost","")
  post_damage_to_corporate_reputation   = selectNode(oXML,"post_damage_to_corporate_reputation","")
  post_damage_to_corporate_reputation2  = selectNode(oXML,"post_damage_to_corporate_reputation2","")
  post_likelihood                       = rev_xdata2(selectNode(oXML,"post_likelihood",""))
  'log_number                            = selectNode(oXML,"log_number","")
  current_measures                      = rev_xdata2(selectNode(oXML,"current_measures",""))
  current_measures_responsible_person   = rev_xdata2(selectNode(oXML,"current_measures_responsible_person",""))
  risk_value_pre_mitigation             = rev_xdata2(selectNode(oXML,"risk_value_pre_mitigation",""))
  corrective_actions                    = rev_xdata2(selectNode(oXML,"corrective_actions",""))
  unintended_consequences               = rev_xdata2(selectNode(oXML,"unintended_consequences",""))
  corrective_actions_responsible_person = rev_xdata2(selectNode(oXML,"corrective_actions_responsible_person",""))
  risk_value_post_mitigation            = rev_xdata2(selectNode(oXML,"risk_value_post_mitigation",""))

  safety_action_cnt			= selectNode(oXML,"safety_action_cnt","")
end if
sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and logNumber = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and active  ='y' order by logNumber desc, recid desc"
'response.write(sql)
'response.end
set rs        = conn_asap.execute(sql)
set oXML2     = CreateObject("Microsoft.XMLDOM")
oXML2.async   = false
if not rs.eof then
  loginID       = rs("loginID")
  createDate    = rs("createDate")
  formDataXML2  = rs("formDataXML")
  recid         = rs("recid")
  'log_number    = rs("logNumber")
  'log_number    = string(4-len(log_number),"0")&log_number
  base = rs("base")

  oXML2.loadXML(formDataXML2)

  item_number         = selectNode(oXML2,"item_number","")
  item_description    = rev_xdata2(selectNode(oXML2,"item_description",""))
  item_title		  = selectNode(oXML2,"item_title","")
  accountable_leader  = rev_xdata2(selectNode(oXML2,"accountable_leader",""))
  source              = rev_xdata2(selectNode(oXML2,"source",""))
  date_opened         = selectNode(oXML2,"date_opened","")
  date_due            = selectNode(oXML2,"date_due","")
  date_completed      = selectNode(oXML2,"date_completed","")
  item_status         = selectNode(oXML2,"item_status","")

  recid         = rs("recid")

  hazard_base         = trim(selectNode(oXML2,"hazard_base",""))
  hazard_type         = selectNode(oXML2,"hazard_type","")
  hazard_number         = selectNode(oXML2,"hazard_number","")

  hazard_number = string(4-len(hazard_number),"0") & hazard_number
  hazard_id = viewDivision &"-"& hazard_number

  hazard_title		  = selectNode(oXML2,"hazard_title","")
  hazard_owner		  = selectNode(oXML2,"hazard_owner","")
end if

log_numberStr = hazard_number


safetyactionOptionsStr = ""

if(safety_action_cnt = "") then
  safety_action_cnt = 0
end if

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

  safetyactionOptionsStr = safetyactionOptionsStr & "<option value='"& viewDivision & safety_action_nbr &"'>"& safety_action_nbr &" - "& safety_action_status &"</option>"

next

sql = "select * from Tbl_Logins where employee_number = "& sqltext2(accountable_leader)
set tmprs=conn_asap.execute(sql)
if not tmprs.eof then
  employee_nbr = tmprs("employee_number")
  first_name = tmprs("first_name")
  last_name = tmprs("last_name")
end if

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

if(isnumeric(hazard_owner)) then
sql = "select first_name, last_name from tbl_logins where loginid = "& sqlnum(hazard_owner)
set tmprs = conn_asap.execute(sql)
if not tmprs.eof then
  accountable_leaderStr = tmprs("last_name") &", "& tmprs("first_name")
end if
end if

%>
	<section id="secondary_bar">
<!--#include file="includes/logged_in_user.inc"-->

		<div class="breadcrumbs_container">
			<article class="breadcrumbs"><a href="http://www.masoftwaresystems.us/miat/splash.aspx">Action Log</a> <div class="breadcrumb_divider"></div> <a class="current">Risk Detail</a></article>
		</div>
	</section><!-- end of secondary bar -->

<!--#include file="includes/sms_header3.inc"-->
<br/><br/>

<form action="divisional_saveData3.asp" method="post" name="frm" id="frm" onsubmit="return checkRequired()">
        <input type="hidden" id="log_number" name="log_number" value="<%= log_number %>" >
        <input type="hidden" id="viewDivision" name="viewDivision" value="<%= viewDivision %>" >
        <input type="hidden" id="safety_action_cnt" name="safety_action_cnt" value="<%= safety_action_cnt %>">
        <input type="hidden" id="resultPage" name="resultPage" value="divisional_LogInput2.aspx">
        <input type="hidden" id="active_errors_cnt" name="active_errors_cnt" value="<%= active_errors_cnt %>">
        <input type="hidden" id="contributing_factors_cnt" name="contributing_factors_cnt" value="<%= contributing_factors_cnt %>">
        <input type="hidden" id="latent_conditions_cnt" name="latent_conditions_cnt" value="<%= latent_conditions_cnt %>">
        <input type="hidden" id="causal_factors_cnt" name="causal_factors_cnt" value="<%= causal_factors_cnt %>">
        <input type="hidden" id="corrective_actions_cnt" name="corrective_actions_cnt" value="<%= corrective_actions_cnt %>">
        <input type="hidden" id="current_measures_cnt" name="current_measures_cnt" value="<%= current_measures_cnt %>">
        <input type="hidden" id="factors_cnt" name="factors_cnt" value="<%= factors_cnt %>">
        <input type="hidden" id="consequences_cnt" name="consequences_cnt" value="<%= consequences_cnt %>">
        <input type="hidden" id="pre_physical_injury" name="pre_physical_injury" value="">
        <input type="hidden" id="pre_damage_to_the_environment" name="pre_damage_to_the_environment" value="">
        <input type="hidden" id="pre_damage_to_assets" name="pre_damage_to_assets" value="">
        <input type="hidden" id="pre_potential_increased_cost" name="pre_potential_increased_cost" value="">
        <input type="hidden" id="pre_damage_to_corporate_reputation" name="pre_damage_to_corporate_reputation" value="">
        <input type="hidden" id="pre_damage_to_corporate_reputation2" name="pre_damage_to_corporate_reputation2" value="">
        <input type="hidden" id="pre_likelihood" name="pre_likelihood" value="">
        <input type="hidden" id="post_physical_injury" name="post_physical_injury" value="">
        <input type="hidden" id="post_damage_to_the_environment" name="post_damage_to_the_environment" value="">
        <input type="hidden" id="post_damage_to_assets" name="post_damage_to_assets" value="">
        <input type="hidden" id="post_potential_increased_cost" name="post_potential_increased_cost" value="">
        <input type="hidden" id="post_damage_to_corporate_reputation" name="post_damage_to_corporate_reputation" value="">
        <input type="hidden" id="post_damage_to_corporate_reputation2" name="post_damage_to_corporate_reputation2" value="">
        <input type="hidden" id="post_likelihood" name="post_likelihood" value="">
        <input type="hidden" name="pre_physical_injury_rating" id="pre_physical_injury_rating" value="" >
        <input type="hidden" name="pre_damage_to_the_environment_rating" id="pre_damage_to_the_environment_rating" value="" >
        <input type="hidden" name="pre_damage_to_assets_rating" id="pre_damage_to_assets_rating" value="" >
        <input type="hidden" name="pre_potential_increased_cost_rating" id="pre_potential_increased_cost_rating" value="" >
        <input type="hidden" name="pre_damage_to_corporate_reputation_rating" id="pre_damage_to_corporate_reputation_rating" value="" >
        <input type="hidden" name="pre_damage_to_corporate_reputation2_rating" id="pre_damage_to_corporate_reputation2_rating" value="" >
        <input type="hidden" name="pre_likelihood_level" id="pre_likelihood_level" value="" >
        <input type="hidden" name="post_physical_injury_rating" id="post_physical_injury_rating" value="" >
        <input type="hidden" name="post_damage_to_the_environment_rating" id="post_damage_to_the_environment_rating" value="" >
        <input type="hidden" name="post_damage_to_assets_rating" id="post_damage_to_assets_rating" value="" >
        <input type="hidden" name="post_potential_increased_cost_rating" id="post_potential_increased_cost_rating" value="" >
        <input type="hidden" name="post_damage_to_corporate_reputation_rating" id="post_damage_to_corporate_reputation_rating" value="" >
        <input type="hidden" name="post_damage_to_corporate_reputation2_rating" id="post_damage_to_corporate_reputation2_rating" value="" >
        <input type="hidden" name="post_likelihood_level" id="post_likelihood_level" value="" >
        <input type="hidden" id="formname" name="formname" value="risk">
        <input type="hidden" id="hazard_owner" name="hazard_owner" value="<%= hazard_owner %>" >
        <input type="hidden" id="accountable_leader" name="accountable_leader" value="<%= accountable_leader %>" >

<input type="hidden" id="hazard_base" name="hazard_base" value="<%= hazard_base %>">
<input type="hidden" id="hazard_type" name="hazard_type" value="<%= hazard_type %>">
<input type="hidden" id="hazard_number" name="hazard_number" value="<%= hazard_number %>">


<article class="module width_full">
<div class="module_content">
<h3>Risk Detail</h3>
<center>
<table cellpadding="0" cellspacing="2" style="font-family:Helvetica, Arial, Verdana, sans-serif;font-size:12px;">
    <tr>
        <td style="width:155px; text-align: right;">Hazard ID:&nbsp;</td>
        <td><input type="TEXT" name="hazard_id" id="hazard_id" readonly displayName="Hazard ID" style="width: 410px;" value="<%= hazard_id %>" class="textbox"></td>
    </tr>
    <tr>
        <td style="width:155px;text-align: right;">Hazard Title:&nbsp;</td>
        <td><input type="TEXT" name="hazard_title" id="hazard_title" readonly displayName="Hazard Title" style="width: 410px;" value="<%= hazard_title %>" class="textbox"></td>
    </tr>
    <tr>
        <td style="text-align: right;">Hazard Owner:&nbsp;</td>
        <td><input type="TEXT" name="accountable_leader" style="width: 410px;" readonly displayName="Accountable Leader" value="<%= accountable_leaderStr %>" class="textbox"></td>
    </tr>
    </table>
    </center>
    </div>
    </article>

<article class="module width_full">
<div class="module_content">
<h3>Pre-Mitigation</h3>
<center>
<table cellpadding="0" cellspacing="2" style="font-family:Helvetica, Arial, Verdana, sans-serif;font-size:12px;">
<tbody id="PreTable">
<%
factors_cntInt = cint(factors_cnt)
for a = 1 to factors_cntInt
  dictionaryFields = dictionaryFields &",factors_"& a
  if((left(selectNode(oXML,"factors_type_"& a,""),7) = "Generic") and (request("cookie_sms_admin") <> "y")) then
    tmpreadonly = "readonly"
  else
    tmpreadonly = ""
  end if
%>
    <tr valign="top">
        <td style="text-align: right;width:155px;"><% if(a = 1) then %>Causes / Threats:<% end if %>&nbsp;</td>
        <td><textarea name="factor_<%= a %>" style="width: 410px;" displayName="Cause/Threat" class="textbox" rows="5"><%= rev_xdata2(selectNode(oXML,"factor_"& a,"")) %></textarea></td>
    </tr>
<%
next
%>
    <tr id="threatRow"><td colspan="2" height="0"></td></tr>
   	<tr valign="top">
        <td style="text-align: right;">&nbsp;</td>
        <td align="left" style="padding-left:10px;"><a href="javascript:addThreat()">Add New Cause/Threat</a></td>
   	</tr>
   	<tr><td colspan="2" height="5"></td></tr>
<%
consequences_cntInt = cint(consequences_cnt)
for a = 1 to consequences_cntInt
  dictionaryFields = dictionaryFields &",consequences_"& a
  if((left(selectNode(oXML,"consequences_type_"& a,""),7) = "Generic") and (request("cookie_sms_admin") <> "y")) then
    tmpreadonly = "readonly"
  else
    tmpreadonly = ""
  end if
%>
    <tr valign="top">
        <td style="text-align: right;"><% if(a = 1) then %>Consequences:<% end if %>&nbsp;</td>
        <td><textarea name="consequences_<%= a %>" style="width: 410px;" displayName="Consequence" class="textbox" rows="5"><%= rev_xdata2(selectNode(oXML,"consequences_"& a,"")) %></textarea></td>
    </tr>
<%
next
%>
    <tr id="consequenceRow"><td colspan="2" height="0"></td></tr>
   	<tr valign="top">
        <td style="text-align: right;">&nbsp;</td>
        <td align="left" style="padding-left:10px;"><a href="javascript:addConsequence()">Add New Consequence</a></td>
   	</tr>
   	<tr><td colspan="2" height="5"></td></tr>
<%
current_measures_cntInt = cint(current_measures_cnt)
for a = 1 to current_measures_cntInt
  dictionaryFields = dictionaryFields &",current_measures_"& a
  if((left(selectNode(oXML,"current_measures_type_"& a,""),7) = "Generic") and (request("cookie_sms_admin") <> "y")) then
    tmpreadonly = "readonly"
  else
    tmpreadonly = ""
  end if
%>
    <tr valign="top">
        <td style="text-align: right;"><% if(a = 1) then %>Current Measures to reduce the risk:<% end if %>&nbsp;</td>
        <td><textarea name="current_measures_<%= a %>" style="width: 410px;" displayName="Current Measure" class="textbox" rows="5"><%= rev_xdata2(selectNode(oXML,"current_measures_"& a,"")) %></textarea></td>
    </tr>
<%
next
%>
    <tr id="measureRow"><td colspan="2" height="0"></td></tr>
   	<tr valign="top">
        <td style="text-align: right;">&nbsp;</td>
        <td align="left" style="padding-left:10px;"><a href="javascript:addMeasure()">Add New Measure</a></td>
   	</tr>
   	<tr><td colspan="2" height="5"></td></tr>
    <tr>
        <td style="text-align: right;">Responsible Team:&nbsp;</td>
        <td>
<input type="TEXT" id="current_measures_responsible_person" name="current_measures_responsible_person" style="width: 410px;" displayName="Responsible Team" value="<%= current_measures_responsible_person %>" class="textbox">
        </td>
    </tr>
    <tr>
        <td style="text-align: right;">Risk Value (Pre-mitigation):&nbsp;</td>
        <td><input type="TEXT" id="pre_risk" name="risk_value_pre_mitigation" readonly style="width: 410px;" displayName="Pre-Risk Value" value="<%= risk_value_pre_mitigation %>" class="textbox"></td>
    </tr>
    <tr><td colspan="2" height="5"></td></tr>
   	<tr valign="top">
        <td style="text-align: right;">&nbsp;</td>
        <td align="left" style="padding-left:10px;"><a id="preLink" href="javascript:togglePre()">Hide Pre-Risk Matrix</a></td>
   	</tr>
   	</tbody>
    </table>
    </center>
    </div>
    </article>

<div id="preMatrix" style="padding-left:25px;display:block;">
<center>
<iframe src="visual.asp?log_number=<%= log_number %>&f=pre_risk&prefix=pre_&division=<%= viewdivision %>&headerprefix=PRE-" width="915" frameborder="0" height="820"></iframe>
</center>
</div>

<article class="module width_full">
<div class="module_content">
<h3>Action Items</h3>
<center>
<table border="0" cellpadding="0" cellspacing="2" style="font-family:Helvetica, Arial, Verdana, sans-serif;font-size:12px;">
<tbody id="markerTABLE">
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

if((safety_action_open <> "") and (not isnull(safety_action_open)) and (isdate(safety_action_open))) then
  safety_action_openStr = day(safety_action_open) &"-"& monthname(month(safety_action_open),true) &"-"& year(safety_action_open)
end if
if((safety_action_due <> "") and (not isnull(safety_action_due)) and (isdate(safety_action_due))) then
  safety_action_dueStr = day(safety_action_due) &"-"& monthname(month(safety_action_due),true) &"-"& year(safety_action_due)
end if
if((safety_action_completed <> "") and (not isnull(safety_action_completed)) and (isdate(safety_action_completed))) then
  safety_action_completedStr = day(safety_action_completed) &"-"& monthname(month(safety_action_completed),true) &"-"& year(safety_action_completed)
end if
%>
		<tr>
			<td style="width:155px;text-align: right;">Action Item:&nbsp;</td>
            <td><input type="TEXT" name="safety_action_nbr_<%= a %>" id="safety_action_nbr_<%= a %>" displayName="Safety Action Number" style="width: 410px;" value="<%= viewdivision %>-<%= log_numberStr %>.<%= a %>" readonly class="textbox"></td>
        </tr>
        <tr>
			<td style="text-align: right;">Action Owner :&nbsp;</td>
            <td><select name="safety_action_poc_<%= a %>" id="safety_action_poc_<%= a %>" style="width: 272px;" displayName="Action Owner" class="textbox">
<%= nameOpts %>
    </select>
    <script>
    document.getElementById("safety_action_poc_<%= a %>").value = "<%= safety_action_poc %>";
    </script>
    <input type="hidden" name="original_safety_action_poc_<%= a %>" value="<%= safety_action_poc %>">
            </td>
        </tr>
        <tr>
			<td style="text-align: right;">Action Type:&nbsp;</td>
            <td>
<select name="safety_action_type_<%= a %>" id="safety_action_type_<%= a %>"  style="width: 272px;" displayName="Safety Action Type" class="textbox">
  <option value="">Select Action Type</option>
  <option value="Corrective Action Required/Finding">Corrective Action Required/Finding</option>
  <option value="Recommendation">Recommendation</option>
    <option value="DSAM">DSAM</option>
    <option value="ESAC">ESAC</option>
  <option value="CSC">CSC</option>
</select>
<script>
frm.safety_action_type_<%= a %>.value = "<%= urldecode(safety_action_type) %>";
</script>
            </td>
        </tr>
        <tr valign="top">
			<td style="text-align: right;">Activity:&nbsp;</td>
            <td><textarea name="safety_action_<%= a %>" style="width: 410px;" displayName="Activity" class="textbox" rows="3"><%= safety_action %></textarea></td>
        </tr>
        <tr valign="top">
			<td style="text-align: right;">Comments:&nbsp;</td>
            <td><textarea name="safety_comments_<%= a %>" style="width: 410px;" displayName="Comments" class="textbox" rows="3"></textarea></td>
        </tr>
        <tr>
			<td style="text-align: right;">Opened:&nbsp;</td>
            <td><input type="TEXT" name="safety_action_open_<%= a %>" id="safety_action_open_<%= a %>" style="width: 100px;" displayName="Opened" value="<%= safety_action_open %>" class="datepicker2 textbox"></td>
        </tr>
		<tr>
			<td style="text-align: right;">Due:&nbsp;</td>
            <td><input type="TEXT" name="safety_action_due_<%= a %>" style="width: 100px;" displayName="Due" value="<%= safety_action_due %>" class="datepicker2 textbox"></td>
        </tr>
        <tr>
			<td style="text-align: right;">Completed:&nbsp;</td>
            <td><input type="TEXT" name="safety_action_completed_<%= a %>" id="safety_action_completed_<%= a %>" style="width: 100px;" value="<%= safety_action_completed %>" class="datepicker2 textbox"></td>
        </tr>
        <tr>
			<td style="text-align: right;">Status:&nbsp;</td>
            <td>
<select id="safety_action_status_<%= a %>" name="safety_action_status_<%= a %>" displayName="Status" class="textbox" style="width: 130px;">
  <option value=""></option>
  <option value="Open">Open</option>
  <option value="Closed">Closed</option>
  <option value="Void">Void</option>
</select>
<script>
frm.safety_action_status_<%= a %>.value = "<%= safety_action_status %>";
</script>
<input type="hidden" name="original_safety_action_status_<%= a %>" value="<%= safety_action_status %>">
            </td>
        </tr>
        <tr><td colpan="2" height="5"></tr>
   	<tr valign="top">
        <td style="text-align: right;width:155px;">&nbsp;</td>
        <td align="left" style="padding-left:10px;">
<%
set acXML					= CreateObject("Microsoft.XMLDOM")
acXML.async					= false
sql = "select item_commentXML, first_name, last_name, comment_date from EHD_Comments, Tbl_Logins where EHD_Comments.division = "& sqltext2(viewdivision) &" and log_number = "& sqlnum(log_number) &" and comment_type = 'ActionItem_"& a &"' and EHD_Comments.loginID = Tbl_Logins.loginID order by recid desc"
set tmprs = conn_asap.execute(sql)
do while not tmprs.eof
  if(len(tmprs("item_commentXML")) > 0) then
  'acXML.loadXML(tmprs("item_commentXML"))
  if(len(tmprs("comment_date")) > 0) then
    tmpdateArr = split(tmprs("comment_date"))
    tmpdateStr = tmpdateArr(0) &" "& tmpdateArr(2)
  end if
%>
<p><span decode><%= tmpdateStr %>&nbsp;<%= tmprs("first_name") %>&nbsp;<%= tmprs("last_name") %><br></span><span ><%= tmprs("item_commentXML") %></span></p>
<%
  end if
  tmprs.movenext
loop
%>
        </td>
   	</tr>
        <tr><td colpan="2" height="5"></tr>
        <tr>
			<td style="text-align: right;"></td>
            <td style="background-color:silver;padding-left:10px;" height="1"></td>
        </tr>
<%
next
%>
        <tr id="markerROW" style="height:1px;"><td colpan="2" height="5"></tr>
   	<tr valign="top">
        <td style="width:155px;text-align: right;">&nbsp;</td>
        <td align="left" style="width: 410px;padding-left:10px;"><a id="addNewLink" href="javascript:addNew('markerTABLE','markerROW')">Add New Action Item</a></td>
   	</tr>
   	</tbody>
    </table>
    </center>
    </div>
    </article>


<article class="module width_full">
<div class="module_content">
<h3>Post-Mitigation</h3>
<center>
<table cellpadding="0" cellspacing="2" style="font-family:Helvetica, Arial, Verdana, sans-serif;font-size:12px;">
<tbody id="PostTable">
<%
corrective_actions_cntInt = cint(corrective_actions_cnt)
for a = 1 to corrective_actions_cntInt
  dictionaryFields = dictionaryFields &",corrective_action_"& a
%>
    <tr valign="top">
        <td style="text-align: right;width:155px;"><% if(a = 1) then %>Corrective/Proactive Actions to Mitigate the Risk:<% end if %>&nbsp;</td>
        <td><textarea name="corrective_action_<%= a %>" style="width: 410px;" displayName="Correct/Proactive Action" class="textbox" rows="5"><%= rev_xdata2(selectNode(oXML,"corrective_action_"& a,"")) %></textarea></td>
   	</tr>
    <tr valign="top">
        <td style="text-align: right;width:155px;">&nbsp;</td>
        <td>
<select id="corrective_action_item_<%= a %>" name="corrective_action_item_<%= a %>" style="width:422px;" class="textbox">
  <option value="" >Associated Action Item</option>
<%= safetyactionOptionsStr %>
</select>
<script>
frm.corrective_action_item_<%= a %>.value = "<%= selectNode(oXML,"corrective_action_item_"& a,"") %>";
</script>
        </td>
   	</tr>
   	<tr><td colspan="2" height="5"></td></tr>
<%
next
%>
    <tr id="correctiveactionRow"><td colspan="2" height="0"></td></tr>
   	<tr valign="top">
        <td style="text-align: right;">&nbsp;</td>
        <td align="left" style="padding-left:10px;"><a href="javascript:addCorrectiveAction()">Add Corrective/Proactive Action</a></td>
   	</tr>
   	<tr><td colspan="2" height="5"></td></tr>
   	<tr valign="top">
        <td style="text-align: right;">Responsible Team:&nbsp;</td>
        <td>
<input type="TEXT" id="corrective_actions_responsible_person" name="corrective_actions_responsible_person" style="width: 410px;" displayName="Responsible Team" value="<%= corrective_actions_responsible_person %>" class="textbox">
        </td>
   	</tr>
   	<tr>
        <td style="text-align: right;">Risk Value (Post-mitigation):&nbsp;</td>
        <td><input type="TEXT" id="post_risk" name="risk_value_post_mitigation" style="width: 410px;" displayName="Post-Risk Value" value="<%= risk_value_post_mitigation %>" class="textbox"></td>
   	</tr>
   	<tr><td colspan="2" height="5"></td></tr>
   	<tr valign="top">
        <td style="text-align: right;">&nbsp;</td>
        <td align="left" style="padding-left:10px;"><a id="preLink" href="javascript:togglePost()">Hide Post-Risk Matrix</a></td>
   	</tr>
   	</tbody>
    </table>
    </center>
    </div>
    </article>

<div id="postMatrix" style="padding-left:25px;display:block;">
<center>
<iframe src="visual.asp?log_number=<%= log_number %>&f=post_risk&prefix=post_&division=<%= viewdivision %>&headerprefix=POST-" width="915" frameborder="0" height="820"></iframe>
</center>
</div>

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
sql = "select item_commentXML, comment_date, first_name, last_name from EHD_Comments, Tbl_Logins where EHD_Comments.division = "& sqltext2(viewdivision) &" and log_number = "& sqlnum(log_number) &" and comment_type = 'risk' and EHD_Comments.loginID = Tbl_Logins.loginID order by recid desc"
set tmprs = conn_asap.execute(sql)
do while not tmprs.eof
  if(len(tmprs("item_commentXML")) > 0) then
  cXML.loadXML(tmprs("item_commentXML"))
  if(len(tmprs("comment_date")) > 0) then
    tmpdateArr = split(tmprs("comment_date"))
    tmpdateStr = tmpdateArr(0) &" "& tmpdateArr(2)
  end if
%>
<p><span decode><%= tmpdateStr %>&nbsp;<%= tmprs("first_name") %>&nbsp;<%= tmprs("last_name") %><br></span><span decode><%= selectNode(cXML,"comment","") %></span></p>
<%
  end if
  tmprs.movenext
loop
%>
        </td>
   	</tr>
        <tr><td colpan="2" height="5"></tr>
   	<tr valign="top">
        <td style="text-align: right;width:155px;">&nbsp;</td>
        <td><textarea name="item_comments" id="item_comments" style="width: 410px;" displayName="Comment" class="textbox" rows="5"></textarea></td>
   	</tr>
   	<!--
    <tr id="commentRow"><td colspan="2" height="0"></td></tr>
   	<tr valign="top">
        <td style="text-align: right;">&nbsp;</td>
        <td align="left" style="padding-left:10px;"><a href="javascript:addComment()">Add New Comment</a></td>
   	</tr>
   	-->
   	<tr><td colspan="2" height="5"></td></tr>
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
<input type="checkbox" checked name="saveonexit" id="saveonexit" value="y"> Automatically save on exit
            </td>
        </tr>
        <tr>
			<td style="color: #cc0000; text-align: right;width:155px;"></td>
            <td style="padding-left:0px;text-align: left;width: 410px;">
<input type="button" value="Save" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-right:3px;" onclick="gotoSave()"><input type="button" value="Log Input" style="font-size:10px;width:160px;font-weight:normal;height:20px;" onclick="goToInput()"><br><input type="button" value="Log Summary" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-top:3px;margin-right:3px;" onclick="viewAssessmentSummary()"><input type="button" value="Return To Short Listing" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-top:3px;" onclick="gotoDivisionalBase()"><br><input type="button" value="Attachments" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-right:3px;" onclick="goToAttachments()">
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
function togglePost() {
  if(document.getElementById("postMatrix").style.display == "none") {
    document.getElementById("postMatrix").style.display = "block";
    document.getElementById("postLink").innerHTML = "Hide Post-Risk Matrix";
  } else {
    document.getElementById("postMatrix").style.display = "none";
    document.getElementById("postLink").innerHTML = "Show Post-Risk Matrix";
  }
}

function togglePre() {
  if(document.getElementById("preMatrix").style.display == "none") {
    document.getElementById("preMatrix").style.display = "block";
    document.getElementById("preLink").innerHTML = "Hide Pre-Risk Matrix";
  } else {
    document.getElementById("preMatrix").style.display = "none";
    document.getElementById("preLink").innerHTML = "Show Pre-Risk Matrix";
  }
}

</script>

<script>
function addThreat() {

  currCnt = parseInt(document.getElementById("factors_cnt").value);
  currCnt = currCnt +1;
  document.getElementById("factors_cnt").value = currCnt;

  var inputTable = document.getElementById("PreTable");
  var inputTableRow = document.getElementById("threatRow");

  var newTR1 = document.createElement('TR');
  var newTD1 = document.createElement('TD');
  var newTD2 = document.createElement('TD');

  inputTable.insertBefore(newTR1, inputTableRow);

  newTR1.appendChild(newTD1);
  newTR1.appendChild(newTD2);

  newTD1.setAttribute("style","width:155px;text-align: right;");

  newTD2.innerHTML = "<textarea name='factor_"+currCnt+"' id='factor_"+currCnt+"' style='width: 410px;' displayName='Cause/Threat' class='textbox' rows='5'></textarea>";
}

function addConsequence() {

  currCnt = parseInt(document.getElementById("consequences_cnt").value);
  currCnt = currCnt +1;
  document.getElementById("consequences_cnt").value = currCnt;

  var inputTable = document.getElementById("PreTable");
  var inputTableRow = document.getElementById("consequenceRow");

  var newTR1 = document.createElement('TR');
  var newTD1 = document.createElement('TD');
  var newTD2 = document.createElement('TD');

  inputTable.insertBefore(newTR1, inputTableRow);

  newTR1.appendChild(newTD1);
  newTR1.appendChild(newTD2);

  newTD1.setAttribute("style","width:155px;text-align: right;");

  newTD2.innerHTML = "<textarea name='consequences_"+currCnt+"' id='consequences_"+currCnt+"' style='width: 410px;' displayName='Consequence' class='textbox' rows='5'></textarea>";
}

function addConsequence() {

  currCnt = parseInt(document.getElementById("consequences_cnt").value);
  currCnt = currCnt +1;
  document.getElementById("consequences_cnt").value = currCnt;

  var inputTable = document.getElementById("PreTable");
  var inputTableRow = document.getElementById("consequenceRow");

  var newTR1 = document.createElement('TR');
  var newTD1 = document.createElement('TD');
  var newTD2 = document.createElement('TD');

  inputTable.insertBefore(newTR1, inputTableRow);

  newTR1.appendChild(newTD1);
  newTR1.appendChild(newTD2);

  newTD1.setAttribute("style","width:155px;text-align: right;");

  newTD2.innerHTML = "<textarea name='consequences_"+currCnt+"' id='consequences_"+currCnt+"' style='width: 410px;' displayName='Consequence' class='textbox' rows='5'></textarea>";
}

function addMeasure() {

  currCnt = parseInt(document.getElementById("current_measures_cnt").value);
  currCnt = currCnt +1;
  document.getElementById("current_measures_cnt").value = currCnt;

  var inputTable = document.getElementById("PreTable");
  var inputTableRow = document.getElementById("measureRow");

  var newTR1 = document.createElement('TR');
  var newTD1 = document.createElement('TD');
  var newTD2 = document.createElement('TD');

  inputTable.insertBefore(newTR1, inputTableRow);

  newTR1.appendChild(newTD1);
  newTR1.appendChild(newTD2);

  newTD1.setAttribute("style","width:155px;text-align: right;");

  newTD2.innerHTML = "<textarea name='current_measures_"+currCnt+"' id='current_measures_"+currCnt+"' style='width: 410px;' displayName='Current Measure' class='textbox' rows='5'></textarea>";
}

function addCorrectiveAction() {

  currCnt = parseInt(document.getElementById("corrective_actions_cnt").value);
  currCnt = currCnt +1;
  document.getElementById("corrective_actions_cnt").value = currCnt;

  var inputTable = document.getElementById("PostTable");
  var inputTableRow = document.getElementById("correctiveactionRow");

  var newTR1 = document.createElement('TR');
  var newTR2 = document.createElement('TR');
  var newTR3 = document.createElement('TR');
  var newTD1 = document.createElement('TD');
  var newTD2 = document.createElement('TD');
  var newTD3 = document.createElement('TD');
  var newTD4 = document.createElement('TD');
  var newTD5 = document.createElement('TD');

  inputTable.insertBefore(newTR1, inputTableRow);
  inputTable.insertBefore(newTR2, inputTableRow);
  inputTable.insertBefore(newTR3, inputTableRow);

  newTR1.appendChild(newTD1);
  newTR1.appendChild(newTD2);
  newTR2.appendChild(newTD3);
  newTR2.appendChild(newTD4);
  newTR3.appendChild(newTD5);

  newTD1.setAttribute("style","width:155px;text-align: right;");
  newTD3.setAttribute("style","width:155px;text-align: right;");
  newTD5.setAttribute("colspan","2");
  newTD5.setAttribute("height","5");

  newTD2.innerHTML = "<textarea name='corrective_action_"+currCnt+"' id='corrective_action_"+currCnt+"' style='width: 410px;' displayName='Corrective Action' class='textbox' rows='5'></textarea>";
  newTD4.innerHTML = "<select id='corrective_action_item_"+currCnt+"' name='corrective_action_item_"+currCnt+"' style='width:422px;' class='textbox'><option value='' >Associated Action Item</option><%= safetyactionOptionsStr %></select>";

}

function addComment() {

  currCnt = parseInt(document.getElementById("comments_cnt").value);
  currCnt = currCnt +1;
  document.getElementById("comments_cnt").value = currCnt;

  var inputTable = document.getElementById("CommentsTable");
  var inputTableRow = document.getElementById("commentRow");

  var newTR1 = document.createElement('TR');
  var newTD1 = document.createElement('TD');
  var newTD2 = document.createElement('TD');

  inputTable.insertBefore(newTR1, inputTableRow);

  newTR1.appendChild(newTD1);
  newTR1.appendChild(newTD2);

  newTD1.setAttribute("style","width:155px;text-align: right;");

  newTD2.innerHTML = "<textarea name='comment_"+currCnt+"' id='comment_"+currCnt+"' style='width: 410px;' displayName='Comment' class='textbox' rows='5'></textarea>";
}
</script>

<script>

function gotoSave() {
  //frm.action = "saveLinks.asp";
  document.getElementById("saveonexit").checked = true;
  document.getElementById("resultPage").value = "divisional_risk2.aspx";
  frm.submit();
  //checkRequired();
}

function gotoDivisionalBase() {
  document.getElementById("resultPage").value = "divisional_base.aspx";
  frm.submit();
}

function goToInput() {
  //frm.action = "divisional_LogInput2.aspx?log_number=<%= log_number %>&viewDivision=<%= viewDivision %>";
  document.getElementById("resultPage").value = "divisional_LogInput2.aspx";
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
  document.getElementById("resultPage").value = "divisional_LogInput2.aspx";
  //frm.submit();
  checkRequired();
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

function goToAttachments() {
  document.getElementById("resultPage").value = "divisional_Attachments.aspx";
  //frm.action = "divisional_Attachments.aspx";
  frm.submit();
  //checkRequired();
}

function viewAssessmentSummary() {
  //document.location = "divisional_logPicture.aspx?log_number=<%= log_number %>&viewDivision=<%= viewDivision %>";
  document.getElementById("resultPage").value = "divisional_logPicture.aspx";
  //frm.action = "divisional_logPicture.aspx";
  frm.submit();
  //checkRequired();
}


function setFieldValue(f,v) {
  document.getElementById(f).value = v;
}
</script>

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

  $('#safety_action_open_'+currCnt).datepicker2();
  $('#safety_action_due_'+currCnt).datepicker2();
  $('#safety_action_completed_'+currCnt).datepicker2();


}
</script>


    </form>

<!--
<%= oXML2.xml %>
-->
<!--
<%= oXML.xml %>
-->