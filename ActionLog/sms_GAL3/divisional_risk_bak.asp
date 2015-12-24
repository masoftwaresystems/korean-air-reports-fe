<% ' vi: set foldmethod=marker syn=aspvbs linebreak softtabstop=2 tabstop=2 shiftwidth=2 expandtab autoindent: %>
<!--#include file="includes/security.inc" -->
<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/wrapformdata2.inc"-->
<% ' {{{ Initial requests
dictionaryFields            = ""
recid                       = request("recid")
log_number                  = request("log_number")
viewDivision                = request("viewDivision")
contributing_factors_cnt    = "1"
active_errors_cnt           = "1"
latent_conditions_cnt       = "1"
causal_factors_cnt          = "1"
corrective_actions_cnt      = "1"
set oXML                    = CreateObject("Microsoft.XMLDOM")
oXML.async                  = false
sql = "select logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'risk' and logNumber = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and archived = 'n' and active = 'y' order by logNumber desc, recid desc"
set rs = conn_asap.execute(sql)
if not rs.eof then
  formDataXML                           = rs("formDataXML")

  oXML.loadXML(formDataXML)

  active_errors_cnt                     = selectNode(oXML,"active_errors_cnt","1")
  contributing_factors_cnt              = selectNode(oXML,"contributing_factors_cnt","1")
  latent_conditions_cnt                 = selectNode(oXML,"latent_conditions_cnt","1")
  causal_factors_cnt                    = selectNode(oXML,"causal_factors_cnt","1")
  corrective_actions_cnt                = selectNode(oXML,"corrective_actions_cnt","1")
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
end if
sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and logNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' and division = "& sqltext2(viewDivision) &" order by logNumber desc, recid desc"
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

  oXML2.loadXML(formDataXML2)

  safety_action_cnt   = selectNode(oXML2,"safety_action_cnt","")
  item_number         = selectNode(oXML2,"item_number","")
  item_description    = rev_xdata2(selectNode(oXML2,"item_description",""))
  accountable_leader  = rev_xdata2(selectNode(oXML2,"accountable_leader",""))
  source              = rev_xdata2(selectNode(oXML2,"source",""))
  date_opened         = selectNode(oXML2,"date_opened","")
  date_due            = selectNode(oXML2,"date_due","")
  date_completed      = selectNode(oXML2,"date_completed","")
  item_status         = selectNode(oXML2,"item_status","")
end if

log_numberStr = string(4-len(log_number),"0")&log_number

safetyactionOptionsStr = ""

for a = 1 to safety_action_cnt
  safety_action_nbr				= selectNode(oXML2,"safety_action_nbr_"& a,"")
  safety_action					= rev_xdata2(selectNode(oXML2,"safety_action_"& a,""))
  safety_action_poc				= rev_xdata2(selectNode(oXML2,"safety_action_poc_"& a,""))
  safety_action_poc_email		= rev_xdata2(selectNode(oXML2,"safety_action_poc_email_"& a,""))
  safety_action_open			= selectNode(oXML2,"safety_action_open_"& a,"")
  safety_action_due				= selectNode(oXML2,"safety_action_due_"& a,"")
  safety_action_completed		= selectNode(oXML2,"safety_action_completed_"& a,"")
  safety_action_status			= selectNode(oXML2,"safety_action_status_"& a,"")
  safety_action_poc2			= selectNode(oXML2,"safety_action_poc2_"& a,"")
  safety_action_type			= selectNode(oXML2,"safety_action_type_"& a,"")

  safetyactionOptionsStr = safetyactionOptionsStr & "<option value='"& viewDivision & safety_action_nbr &"'>"& safety_action_nbr &" - "& safety_action_status &"</option>"

next

sql = "select * from Tbl_Logins where employee_number = "& sqltext2(accountable_leader)
set tmprs=conn_asap.execute(sql)
if not tmprs.eof then
  employee_nbr = tmprs("employee_number")
  first_name = tmprs("first_name")
  last_name = tmprs("last_name")
end if
' }}} %>
<!--
formDataXML:<%= formDataXML %>

formDataXML2:<%= formDataXML2 %>
-->
<html>
  <head>
<!--#include file ="includes/commonhead.inc"-->
    <title>Risk Assessment of SRT Action Log Item</title>
    <!-- <script type="text/javascript" src="script/divisional_risk.js"></script> -->
<!--#include file="script/divisional_risk.inc"-->
    <link href="styles/risk.css" rel="stylesheet" type="text/css" />
    <% ' {{{ script %>
    <script type="text/javascript">
<!--#include file="script/display.asp"-->
    </script>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
<!--#include file="script/nav.js"-->
  </head>
  <body bgColor="white" topmargin="3pt" bottommargin="3pt" leftmargin="3pt" rightmargin="3pt">
  <body onload="init()">
      <div id="headerDiv">
<!--#include file="includes/sms_header.inc"-->
      </div>
    <center>
      <form action="divisional_submitRiskanalysis.asp" method="post" name="frm" id="frm">
        <% ' {{{ Hidden inputs %>
        <input type="hidden" id="log_number" name="log_number" value="<%= log_number %>" >
        <input type="hidden" id="viewDivision" name="viewDivision" value="<%= viewDivision %>" >
        <input type="hidden" id="active_errors_cnt" name="active_errors_cnt" value="<%= active_errors_cnt %>">
        <input type="hidden" id="contributing_factors_cnt" name="contributing_factors_cnt" value="<%= contributing_factors_cnt %>">
        <input type="hidden" id="latent_conditions_cnt" name="latent_conditions_cnt" value="<%= latent_conditions_cnt %>">
        <input type="hidden" id="causal_factors_cnt" name="causal_factors_cnt" value="<%= causal_factors_cnt %>">
        <input type="hidden" id="corrective_actions_cnt" name="corrective_actions_cnt" value="<%= corrective_actions_cnt %>">
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
        <input type="hidden" id="accountable_leader" name="accountable_leader" value="<%= accountable_leader %>" >
        <% ' }}} %>
        <table cellSpacing="0" cellPadding="1" width="100%" border="0">
          <tbody>
            <tr class="mainHead">
              <td width="100%" colSpan="4">Risk Assessment of Divisional Action Log Item</td>
            </tr>
            <tr class="plain">
              <td style="text-align:right;" width="25%" rowSpan="1">Log Nbr.</td>
              <td style="font-weight:bold;text-align:left;padding-left:10px;" align="left" width="25%" background="" bgColor="ffffff" ><%= viewDivision %><%= log_numberStr %></td>
              <td style="text-align:right" width="25%"></td>
              <td style="text-align:left" width="25%"></td>
            </tr>
            <tr class="plain">
              <td style="text-align:right;" width="25%" rowSpan="1">Accountable Leader</td>
              <td style="text-align:left;padding-left:10px;" width="25%"><%= accountable_leader %></td>
              <td style="text-align:right" width="25%"></td>
              <td style="text-align:left" width="25%"></td>
            </tr>
            <tr class="secondHead">
              <td width="100%" colSpan="4">Active Errors</td>
            </tr>
            <tr>
              <td class="info" width="25%">
                Actions or inactions by frontline employees that typically have an immediate adverse effect.
                <ul>
                	<li>Usually related to human error.</li>
                	<li>Associated with front-line employees.</li>
                	<li>Consequences are immediate.</li>
                	<li>The event is usually labeled by the last active error (proximate cause).</li>
                </ul>
                <b>Examples:</b> Procedural error, slip, lapse, etc.
              </td>
              <td class="info" width="75%" colSpan="3">
<%
active_errors_cntInt = cint(active_errors_cnt)
for a = 1 to active_errors_cntInt
  dictionaryFields = dictionaryFields &",active_error_"& a
%>
                <textarea id="active_error_<%= a %>" name="active_error_<%= a %>" style="width:540px;padding-below:5px;" rows="2"><%= rev_xdata2(selectNode(oXML,"active_error_"& a,"")) %></textarea>
<%
next
%>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tbody id="active_errorTABLE">
    <tr id="active_errorROW" style="height:1px;"><td style="height:1px;"></td></tr>
  </tbody>
</table>
                <input  type="button" value="Add Active Error" style="font-size:10px;width:160px;" onclick="addTextbox('active_errorTABLE','active_errorROW','active_error')">
              </td>
            </tr>
            <tr class="secondHead">
              <td width="100%" colSpan="4">Latent Conditions</td>
            </tr>
            <tr valign="top">
              <td class="info" width="25%">
                These conditions are generally associated with management decisions or actions.  Consequences may not be present for longs periods of time.
                <ul>
                	<li>Related to systemic errors (i.e., management, policy, and procedures).</li>
                	<li>Generally associated with management decisions or actions (often with good intentions).</li>
                	<li>By itself, a latent condition will never cause an accident.</li>
                </ul>
                <b>Examples:</b> Training and design of hardware, software, or procedures.
              </td>
              <td class="info" width="75%" colSpan="3">
<%
latent_conditions_cntInt = cint(latent_conditions_cnt)
for a = 1 to latent_conditions_cntInt
  dictionaryFields = dictionaryFields &",latent_condition_"& a
%>
                <textarea id="latent_condition_<%= a %>" name="latent_condition_<%= a %>" style="width:540px;padding-below:5px;" rows="2"><%= rev_xdata2(selectNode(oXML,"latent_condition_"& a,"")) %></textarea>
<%
next
%>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tbody id="latent_conditionTABLE">
    <tr id="latent_conditionROW" style="height:1px;"><td style="height:1px;"></td></tr>
  </tbody>
</table>
                <input  type="button" value="Add Latent Condition" style="font-size:10px;width:160px;" onclick="addTextbox('latent_conditionTABLE','latent_conditionROW','latent_condition')">
              </td>
            </tr>
            <tr>
              <td class="secondHead" width="100%" colSpan="4">Causal Factors</td>
            </tr>
            <tr valign="top">
              <td class="info" width="25%">
                Causal Factors are actions and conditions that were necessary and sufficient for a given event to have occurred. Without this factor the event would have not occurred.
              </td>
              <td class="info" width="75%" colSpan="3">
<%
causal_factors_cntInt = cint(causal_factors_cnt)
for a = 1 to causal_factors_cntInt
  dictionaryFields = dictionaryFields &",causal_factor_"& a
%>
                <textarea id="causal_factor_<%= a %>" name="causal_factor_<%= a %>" style="width:540px;padding-below:5px;" rows="2"><%= rev_xdata2(selectNode(oXML,"causal_factor_"& a,"")) %></textarea>
<%
next
%>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tbody id="causal_factorTABLE">
    <tr id="causal_factorROW" style="height:1px;"><td style="height:1px;"></td></tr>
  </tbody>
</table>
                <input  type="button" value="Add Causal Factor" style="font-size:10px;width:160px;" onclick="addTextbox('causal_factorTABLE','causal_factorROW','causal_factor')">
              </td>
            </tr>
          </tbody>
        </table>
        <table cellSpacing="0" cellPadding="1" width="100%" border="0">
          <tr class="secondHead">
            <td width="100%" colSpan="4">Current Measures / Risk Value</td>
          </tr>
          <tr class="thirdHead">
            <td width="100%" colSpan="4">Assign a value to the risk in its current state and describe the existing processes/procedures that are in place to prevent this condition.</td>
          </tr>
          <tr class="plain">
            <td style="text-align:right" width="25%">Current Measures to reduce the risk</td>
            <td style="text-align:left;padding-left:10px;" width="75%" colspan="3">
              <textarea id="current_measures" name="current_measures" rows="2" required="false" style="width:540px;padding-below:5px;"><%= trim(current_measures) %></textarea>
            </td>
          </tr>
          <tr class="plain">
            <td style="text-align:right;" width="25%">Responsible Person/Functional Area</td>
            <td style="text-align:left;padding-left:10px;" width="25%">
              <input type="text" name="current_measures_responsible_person" size="30" style="width:236px;"  value="<%= current_measures_responsible_person %>" required="false" />
            </td>
          </tr>
          <tr class="plain">
            <td style="text-align:right;" width="25%">
              Risk Value (Pre-mitigation)
            </td>
            <td style="text-align:left;padding-left:6px;" width="25%">
              <!-- <input onclick="toggleSection(this,'table1')" type="checkbox" value="RAM_Pre" name="RAM_Pre" /> --><input type="text" id="pre_risk" name="risk_value_pre_mitigation" size="30" readonly  value="<%= risk_value_pre_mitigation %>" required="false" style="width:220px;" />
            </td>
          </tr>
        </table>
        <table id="table1" cellSpacing="0" cellPadding="0" width="1000" border="0" style="display:block;padding-left:60px;">
          <tr>
            <td>
              <iframe src="visual.asp?log_number=<%= log_number %>&f=pre_risk&prefix=pre_&division=<%= viewdivision %>" width="900" frameborder="0" height="850"></iframe>
            </td>
          </tr>
        </table>
        <table cellSpacing="0" cellPadding="1" width="100%" border="0">
          <tr class="secondHead">
            <td width="100%" colSpan="4">Corrective Action / Risk Value</td>
          </tr>
          <tr class="thirdHead">
            <td width="100%" colSpan="4">
              Describe further corrective/proactive actions to mitigate the risk, the resulting Risk Value, and the person/functional area assigned to maintain oversight of the process.
            </td>
          </tr>
          <tr class="plain" valign="top">
            <td style="text-align:right;vertical-align:top;" width="25%">
              Corrective/Proactive Actions to Mitigate the Risk
            </td>
            <td style="text-align:left;padding-left:10px;" width="75%" colspan="3" valign="top">
<%
corrective_actions_cntInt = cint(corrective_actions_cnt)
for a = 1 to corrective_actions_cntInt
  dictionaryFields = dictionaryFields &",corrective_action_"& a
%>
              <textarea id="corrective_action_<%= a %>" name="corrective_action_<%= a %>" style="width:540px;padding-below:5px;" rows="2"><%= rev_xdata2(selectNode(oXML,"corrective_action_"& a,"")) %></textarea>
              <select name="corrective_action_item_<%= a %>" style="width:180px;margin-left:0px;margin-bottom:15px;">
                <option value="">Associate with Action Item</option>
                <!--
                <option value="All">All</option>
                <option value="None">None</option>
                -->
                <%= safetyactionOptionsStr %>
              </select>
<%
next
%>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tbody id="corrective_actionTABLE">
    <tr id="corrective_actionROW" style="height:1px;"><td style="height:1px;"></td></tr>
  </tbody>
</table>
                <input  type="button" value="Add Corrective Action" style="font-size:10px;width:160px;" onclick="addTextbox2('corrective_actionTABLE','corrective_actionROW','corrective_action')">

            </td>
          </tr>
          <tr class="plain">
            <td style="text-align:right;vertical-align:top;" width="25%">
              Unintended Consequences
            </td>
            <td style="text-align:left;padding-left:10px;" width="75%" colspan="3">
              <textarea id="unintended_consequences" name="unintended_consequences" rows="2" required="false" style="width:540px;padding-below:5px;"><%= trim(unintended_consequences) %></textarea>
            </td>
          </tr>
          <tr class="plain">
            <td style="text-align:right;" width="25%">
              Responsible Person/Functional Area
            </td>
            <td style="text-align:left;padding-left:10px;" width="25%">
              <input type="text" name="corrective_actions_responsible_person" size="30" style="width:236px;"  value="<%= corrective_actions_responsible_person %>" required="false" />
            </td>
          </tr>
          <tr class="plain">
            <td style="text-align:right;" width="25%">
              Risk Value (Post-mitigation)
            </td>
            <td style="text-align:left;padding-left:6px;" width="25%">
              <!-- <input onclick="toggleSection(this,'table2')" type="checkbox" value="RAM_Post" name="RAM_Post" /> --><input type="text" id="post_risk" name="risk_value_post_mitigation" size="30" readonly  value="<%= risk_value_post_mitigation %>" required="false" style="width:220px;" />
            </td>
          </tr>
        </table>
        <table id="table2" cellSpacing="0" cellPadding="0" width="1000" border="0" style="display:block;padding-left:60px;">
          <tr>
            <td>
              <iframe src="visual.asp?log_number=<%= log_number %>&f=post_risk&prefix=post_&division=<%= viewdivision %>" width="900" frameborder="0" height="850"></iframe>
            </td>
          </tr>
        </table>
        <table cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="white">
          <tr height="30">
            <td>
              &nbsp;
            </td>
          </tr>
          <tr>
          <td align="center">
            <input type="submit" value="Submit" style="font-size:10px;width:160px;margin-top:5px;margin-left:0px;">
            <input type="button" value="Return To Log Input" style="font-size:10px;width:160px;margin-top:5px;margin-left:0px;" onclick="document.location='divisional_LogInput.asp?log_number=<%= log_number %>&viewDivision=<%= viewDivision %>'">
            <br />
            <input type="button" value="Return To Action Log" style="font-size:10px;width:160px;margin-top:1px;margin-left:0px;" onclick="document.location='divisional_LogDisplay.asp?viewDivision=<%= viewDivision %>'">

          </td>
        </tr>
        <tr height="50">
          <td>
            &nbsp;
          </td>
        </tr>
      </table>
<!--#include file ="includes/footer.inc"-->
    </form>
  </body>
</html>
