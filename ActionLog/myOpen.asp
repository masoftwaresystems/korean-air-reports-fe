<!--#include file="showVars.inc"-->
<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/commonUtils.inc" -->
<!--#include file="includes/security.inc" -->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include file="includes/lockMgr.inc"-->
	<section id="secondary_bar">
<!--#include file="includes/logged_in_user.inc"-->

		<div class="breadcrumbs_container">
			<article class="breadcrumbs"><a href="http://www.masoftwaresystems.us/miat/splash.aspx">Action Log</a> <div class="breadcrumb_divider"></div> <a class="current">Hazard Detail</a></article>
		</div>
	</section><!-- end of secondary bar -->

<!--#include file="includes/sms_header3.inc"-->
<br/><br/>


<article class="module width_full">
<div class="module_content">
<h3>My Open</h3>
<center>
<div style="height:40px;"></div>
<table cellpadding="0" cellspacing="2" border="0" style="font-family:Helvetica, Arial, Verdana, sans-serif;font-size:12px;">
   	<tr valign="top">
        <td style="text-align: right;width:60px;"></td>
        <td align="left" style="padding-left:10px;">
<%
set rs        = conn_asap.execute(sql)
set oXML     = CreateObject("Microsoft.XMLDOM")
set oXML2     = CreateObject("Microsoft.XMLDOM")
'sql = "select * from EHD_Data where division = "& sqltext2(request("cookie_division")) &" and formName = 'iSRT_LogInput' and active = 'y' and formDataXML like '%"& request("cookie_loginID") &"%' order by divisionalLogNumber desc, recid desc"
sql = "select main.logNumber, main.divisionalLogNumber divisionalLogNumber, main.division division, risk.formDataXML formDataXML2, main.formDataXML formDataXML from EHD_Data main left outer join EHD_Data risk on main.divisionalLogNumber = risk.divisionalLogNumber and main.division = risk.division  where main.division = "& sqltext2(request("cookie_division")) &" and main.formName = 'iSRT_LogInput' and main.active = 'y' and risk.active = 'y' and risk.formName = 'risk' order by main.divisionalLogNumber desc, main.recid desc"
set rs = conn_asap.execute(sql)
do while not rs.eof
  oXML.loadXML(rs("formDataXML"))
  oXML.async   = false
  oXML2.loadXML(rs("formDataXML2"))
  oXML2.async   = false

  proceed = "n"


  item_number         = selectNode(oXML,"item_number","")
  item_description    = rev_xdata2(selectNode(oXML,"item_description",""))
  accountable_leader  = rev_xdata2(selectNode(oXML,"accountable_leader",""))
  source              = rev_xdata2(selectNode(oXML,"source",""))
  date_opened         = selectNode(oXML,"date_opened","")
  date_due            = selectNode(oXML,"date_due","")
  date_completed      = selectNode(oXML,"date_completed","")
  item_status         = selectNode(oXML,"item_status","")
  item_status2				= selectNode(oXML,"item_status2","")

  item_title				= selectNode(oXML,"item_title","")

  hazard_owner				= selectNode(oXML,"hazard_owner","")
  hazard_manager			= selectNode(oXML,"hazard_manager","")

  hazard_title					= selectNode(oXML,"hazard_title","")


  hazard_base         = selectNode(oXML,"hazard_base","")
  hazard_type         = selectNode(oXML,"hazard_type","")
  hazard_number         = selectNode(oXML,"hazard_number","")

  hazard_number = string(4-len(hazard_number),"0") & hazard_number
  hazard_id = viewDivision &"-"& hazard_number

  safety_action_cnt			= selectNode(oXML2,"safety_action_cnt","")

if(safety_action_cnt = "") then
  safety_action_cnt = 0
end if

for a = 1 to safety_action_cnt
  safety_action_nbr				= selectNode(oXML2,"safety_action_nbr_"& a,"")
  safety_action					= rev_xdata2(selectNode(oXML2,"safety_action_"& a,""))
  safety_action_poc				= rev_xdata2(selectNode(oXML2,"safety_action_poc_"& a,""))

  safety_action_status			= selectNode(oXML2,"safety_action_status_"& a,"")


  safety_action_base			= selectNode(oXML2,"safety_action_base_"& a,"")

  if((safety_action_poc = request("cookie_loginID")) and (safety_action_status <> "Closed")) then
    proceed = "y"
  end if

next

  hazard_title = ""
  sql = "select formDataXML from EHD_Data where formname = 'iSRT_LogInput' and logNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' and division = "& sqltext2(viewDivision) &" order by logNumber desc, recid desc"
  set tmprs        = conn_asap.execute(sql)
  if not tmprs.eof then
    oXML2.loadXML(tmprs("formDataXML"))
    hazard_title         = selectNode(oXML2,"hazard_title","")
  end if


  if((item_status <> "Closed") and (hazard_owner = request("cookie_loginID")))then
    proceed = "y"
  end if
  proceed = "y"
  if(proceed = "y") then
%>
<div style='padding-bottom:3px;width:500px;text-align:left;font-weight:bold;'><span decode><a href='divisional_LogInput2.aspx?position=&log_number=<%= rs("logNumber") %>&viewDivision=<%= rs("division") %>'>&middot;&nbsp;<%= hazard_id %>&nbsp;<%= hazard_title %></a></span></div>
<%
  end if

  rs.movenext
loop
%>
<br/>
        </td>
   	</tr>
</table>
    </center>
    </div>
    </article>
    <p></p>

