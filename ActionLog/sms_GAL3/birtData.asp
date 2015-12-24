<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<hazards>
<%
sql = "select lognumber, division from EHD_Data where active = 'y' and formname = 'iSRT_LogInput' and base = 'Norwich'  order by lognumber asc"

set rrs = conn_asap.execute(sql)
do while not rrs.eof

log_number			= rrs("lognumber")
log_numberStr		= string(4-len(log_number),"0")&log_number

viewDivision			= rrs("division")
%>
<%
sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and logNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' and division = "& sqltext2(viewDivision) &" order by logNumber desc, recid desc"
'response.write(sql)
set rs        = conn_asap.execute(sql)
set oXML2     = CreateObject("Microsoft.XMLDOM")
oXML2.async   = false
if not rs.eof then
  loginID       = rs("loginID")
  createDate    = rs("createDate")
  formDataXML2  = rs("formDataXML")
  recid         = rs("recid")

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
  item_status2				= selectNode(oXML2,"item_status2","")

  if(item_status = "") then
    item_status = item_status2
  end if

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

  initial_assessment_date			= selectNode(oXML2,"initial_assessment_date","")
  initial_assessment_occasion		= selectNode(oXML2,"initial_assessment_occasion","")
  current_assessment_date			= selectNode(oXML2,"current_assessment_date","")
  current_assessment_occasion		= selectNode(oXML2,"current_assessment_occasion","")
  post_assessment_date				= selectNode(oXML2,"post_assessment_date","")
  post_assessment_occasion			= selectNode(oXML2,"post_assessment_occasion","")
  further_risk_reduction_needed		= selectNode(oXML2,"further_risk_reduction_needed","")
  hazard_ok_alarp					= selectNode(oXML2,"hazard_ok_alarp","")
  alarp_statement					= selectNode(oXML2,"alarp_statement","")

end if

if(safety_action_cnt = "") then
  safety_action_cnt = 0
end if

set oXML					= CreateObject("Microsoft.XMLDOM")
oXML.async					= false

sql = "select * from EHD_Data where formname = 'risk' and logNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' and division = "& sqltext2(viewDivision) &" order by logNumber desc, recid desc"
'response.write(sql)
'response.end
set rs        = conn_asap.execute(sql)
set oXML     = CreateObject("Microsoft.XMLDOM")
oXML.async   = false
if not rs.eof then
  loginID       = rs("loginID")
  createDate    = rs("createDate")
  formDataXML2  = rs("formDataXML")
  recid         = rs("recid")

  oXML.loadXML(formDataXML2)

  current_measures_responsible_person	= selectNode(oXML,"current_measures_responsible_person","")
  risk_value							= selectNode(oXML,"risk_value","")
  physical_injury						= selectNode(oXML,"physical_injury","")
  damage_to_the_environment				= selectNode(oXML,"damage_to_the_environment","")
  damage_to_assets						= selectNode(oXML,"damage_to_assets","")
  potential_increased_cost				= selectNode(oXML,"potential_increased_cost","")
  damage_to_corporate_reputation		= selectNode(oXML,"damage_to_corporate_reputation","")
  likelihood							= selectNode(oXML,"likelihood","")
  comments								= selectNode(oXML,"comments","")
end if


sql = "select * from Tbl_Logins where employee_number = "& sqltext2(request("accountable_leader"))
set tmprs=conn_asap.execute(sql)
if not tmprs.eof then
  employee_nbr = tmprs("employee_number")
  first_name = tmprs("first_name")
  last_name = tmprs("last_name")
end if
%>
<hazard>
<log_number><%= xdata2(log_numberStr) %></log_number>
<title><%= xdata2(item_title) %></title>
<item_description><%= xdata2(item_description) %></item_description>
<item_comments><%= xdata2(item_comments) %></item_comments>
<base><%= xdata2(base) %></base>
<aircraft><%= xdata2(equipment) %></aircraft>
<hazard_owner><%= xdata2(hazard_owner) %></hazard_owner>
<hazard_editor><%= xdata2(hazard_editor) %></hazard_editor>
<hazard_manager><%= xdata2(hazard_manager) %></hazard_manager>
<accountable_leader><%= xdata2(accountable_leader) %></accountable_leader>
<source><%= xdata2(source) %></source>
<date_opened><%= xdata2(date_opened) %></date_opened>
<date_due><%= xdata2(date_due) %></date_due>
<date_completed><%= xdata2(date_completed) %></date_completed>
<endorsed><%= xdata2(endorsed) %></endorsed>
<endorsed_by><%= xdata2(endorsed_by) %></endorsed_by>
<next_review_date><%= xdata2(next_review_date) %></next_review_date>
<initial_assessment_date><%= xdata2(initial_assessment_date) %></initial_assessment_date>
<initial_assessment_occasion><%= xdata2(initial_assessment_occasion) %></initial_assessment_occasion>
<current_assessment_date><%= xdata2(current_assessment_date) %></current_assessment_date>
<current_assessment_occasion><%= xdata2(current_assessment_occasion) %></current_assessment_occasion>
<post_assessment_date><%= xdata2(post_assessment_date) %></post_assessment_date>
<post_assessment_occasion><%= xdata2(post_assessment_occasion) %></post_assessment_occasion>
<further_risk_reduction_needed><%= xdata2(further_risk_reduction_needed) %></further_risk_reduction_needed>
<hazard_ok_alarp><%= xdata2(hazard_ok_alarp) %></hazard_ok_alarp>
<alarp_statement><%= xdata2(alarp_statement) %></alarp_statement>
<item_status><%= xdata2(item_status) %></item_status>
<item_status><%= xdata2(item_status) %></item_status>
<action_items>
<%
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
  safety_action_other_name			= selectNode(oXML2,"safety_action_other_name_"& a,"")
  safety_action_other_email			= selectNode(oXML2,"safety_action_other_email_"& a,"")

  if(safety_action_poc <> "") then
    if(safety_action_poc = "Other") then
      safety_action_poc_name = safety_action_other_name
    else
      sql = "select first_name, last_name from Tbl_Logins where employee_number in ('"& safety_action_poc &"') order by division asc, last_name asc"
      set emprs = conn_asap.execute(sql)
      if not emprs.eof then
        safety_action_poc_name = left(emprs("first_name"),1) &"&nbsp;"& emprs("last_name")
      end if
    end if
  end if

%>
<action_item>
<action_item_number><%= xdata2(log_numberStr) %></action_item_number>
<safety_action_type><%= xdata2(safety_action_type) %></safety_action_type>
<safety_action><%= xdata2(safety_action) %></safety_action>
<safety_action_poc_name><%= xdata2(safety_action_poc_name) %></safety_action_poc_name>
<safety_action_open><%= xdata2(safety_action_open) %></safety_action_open>
<safety_action_due><%= xdata2(safety_action_due) %></safety_action_due>
<safety_action_completed><%= xdata2(safety_action_completed) %></safety_action_completed>
<safety_action_status><%= xdata2(safety_action_status) %></safety_action_status>
</action_item>
<%
next
%>
</action_items>
<safety_action_status><%= xdata2(safety_action_status) %></safety_action_status>
<active_errors>
<% for a = 1 to cint(selectNode(oXML,"active_errors_cnt","0")) %>
<active_error><%= xdata2(selectNode(oXML,"active_error_"& a,"")) %></active_error>
<% next %>
</active_errors>
<latent_conditions>
<% for a = 1 to cint(selectNode(oXML,"latent_conditions_cnt","0")) %>
<latent_condition><%= xdata2(selectNode(oXML,"latent_condition_"& a,"")) %></latent_condition>
<% next %>
</latent_conditions>
<current_measures>
<% for a = 1 to cint(selectNode(oXML,"current_measures_cnt","0")) %>
<current_measure><%= xdata2(selectNode(oXML,"current_measures_"& a,"")) %></current_measure>
<% next %>
</current_measures>
<current_measures_responsible_person><%= xdata2(selectNode(oXML,"current_measures_responsible_person","")) %></current_measures_responsible_person>
<risk_value_pre_mitigation><%= xdata2(selectNode(oXML,"risk_value_pre_mitigation","")) %></risk_value_pre_mitigation>
<corrective_actions>
<% for a = 1 to cint(selectNode(oXML,"corrective_actions_cnt","0")) %>
<corrective_action><%= xdata2(selectNode(oXML,"corrective_action_"& a,"")) %></corrective_action>
<% next %>
</corrective_actions>
<unintended_consequences><%= xdata2(selectNode(oXML,"unintended_consequences","")) %></unintended_consequences>
<corrective_actions_responsible_person><%= xdata2(selectNode(oXML,"corrective_actions_responsible_person","")) %></corrective_actions_responsible_person>
<risk_value_post_mitigation><%= xdata2(selectNode(oXML,"risk_value_post_mitigation","")) %></risk_value_post_mitigation>
</hazard>
<%
  rrs.movenext
loop
%>
</hazards>