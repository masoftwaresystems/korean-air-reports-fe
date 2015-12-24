<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<%
log_number			= request("log_number")
log_numberStr		= string(4-len(log_number),"0")&log_number
viewDivision		= request("viewDivision")

sql = "select logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'iSRT_LogInput' and divisionalLogNumber = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and active = 'y' and archived = 'n' order by recid desc"
'response.write(sql)
'response.end
set rs = conn_asap.execute(sql)

if not rs.eof then
  set oXML					= CreateObject("Microsoft.XMLDOM")
  oXML.async				= false

  oXML.loadXML(rs("formDataXML"))

  safety_action_cnt			= selectNode(oXML,"safety_action_cnt","")
  'log_number				= selectNode(oXML,"log_number","")
  item_description			= rev_xdata2(selectNode(oXML,"item_description",""))
  accountable_leader		= selectNode(oXML,"accountable_leader","")
  source					= selectNode(oXML,"source","")
  date_opened				= selectNode(oXML,"date_opened","")
  date_due					= selectNode(oXML,"date_due","")
  date_completed			= selectNode(oXML,"date_completed","")
  item_status				= selectNode(oXML,"item_status","")

  hazard_base         = selectNode(oXML,"hazard_base","")
  hazard_type         = selectNode(oXML,"hazard_type","")
  hazard_number         = selectNode(oXML,"hazard_number","")

  hazard_number = string(4-len(hazard_number),"0") & hazard_number
  hazard_id = viewDivision &"-"& hazard_number

end if


%>
	<section id="secondary_bar">
<!--#include file="includes/logged_in_user.inc"-->

		<div class="breadcrumbs_container">
			<article class="breadcrumbs"><a href="http://www.masoftwaresystems.us/miat/splash.aspx">Action Log</a> <div class="breadcrumb_divider"></div> <a class="current">Email Hazard</a></article>
		</div>
	</section><!-- end of secondary bar -->

<!--#include file="includes/sms_header3.inc"-->
<br/><br/>

<article class="module width_full">
<div class="module_content">
<h3>Hazard ID <%= hazard_id %></h3>

<form action="divisional_doEmail.asp" method="post" name="frm" id="frm">
<input type="hidden" name="log_number" value="<%= request("log_number") %>">
<input type="hidden" name="viewDivision" value="<%= request("viewDivision") %>">

<table border="0" cellspacing="5" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">To :</span></td>
    <td width="60%" align="left"><input type="text" class="input6" name="email_to" style="width:300px;" value=""></td>
  </tr>

  <!--
  <tr>
      <td width="40%" align="right"><span class="fonts1" style="color:#737579;">&nbsp;</span></td>
      <td width="60%" align="left"><span class="fonts1" style="color:#737579;">Separate email addresses with commas.</span></td>
  </tr>
  -->

  <tr>
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Subject :</span></td>
    <td width="60%" align="left">

    <input type="text" class="input6" name="email_subject" style="width:300px;" value="Hazard ID <%= hazard_id %>". readonly />

    </td>
  </tr>
  <tr valign="top">
      <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Description :</span></td>
      <td width="60%" align="left"><textarea class="input6" name="email_item_description" style="width:300px;" rows="5" . readonly /><%= item_description %></textarea></td>
  </tr>
  <tr valign="top">
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Additional Information :</span></td>
    <td width="60%" align="left"><textarea class="input6" style="width:300px;" name="email_additionalinfo" rows="5"></textarea></td>
  </tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:3px;margin-left:10px;">
<%
acnt = 0
sql = "select * from EHD_Attachments where log_number = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and archived = 'n' order by recid desc"
set rs = conn_asap.execute(sql)
do while not rs.eof
  file_name		= rs("file_name")
  recid			= rs("recid")

  acnt = acnt +1
%>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;"><% if(acnt = 1) then %>Attachments:&nbsp;<% end if %></span></td>
    <td width="60%" align="left"><input type="checkbox" value="<%= recid %>" name="attachments" checked><span class="fonts1" style="padding-right:5px;"><a target="_blank" href="retrieveFile.asp?recid=<%= recid %>"><%= file_name %></a></span></td>
  </tr>
<%
  rs.movenext
loop
%>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:25px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pblack.gif" width="400" height="1"></td></tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="margin-top:15px;margin-left:10px;" bgColor="white" >
  <tr>
    <td width="100%" align="center">
      <input type="button" value="Send Email" class="button1" style="font-weight:normal;font-size:10px;width:150;" onclick="checkRequired()"> <input type="button" value="Return To Log Input" class="button1" style="font-weight:normal;font-size:10px;width:150;" onclick="document.location='divisional_LogInput2.aspx?log_number=<%= log_number %>&viewDivision=<%= viewDivision %>'"><br><input type="button" value="Return To Short Listing" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-top:3px;" onclick="document.location='divisional_base.aspx?viewdivision=<%= viewdivision %>'">
    </td>
  </tr>
  <tr>
    <td width="100%" align="center" height="50"></td>
  </tr>
</table>

</form>

    </div>
    </article>
<p></p>
