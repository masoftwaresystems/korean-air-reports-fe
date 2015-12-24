<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include virtual ="/global_includes/emailUtils.inc"-->
<%
log_number			= request("log_number")
log_numberStr		= string(4-len(log_number),"0")&log_number

email_to			= request("email_to")
email_subject		= request("email_subject")
email_additionalinfo	= request("email_additionalinfo")
email_item_description	= request("email_item_description")

attachments = request("attachments")

'response.write(attachments)
'response.end

email_cc			= ""
email_bcc			= "mike.aaron@gmail.com"
email_body			= email_body

email_body2 = "<br><br><b>Log Number: </b>"& email_subject &"<br><br><b>Description: </b>"& email_item_description &"<br><br><b>Additional Information: </b>"& email_additionalinfo &"<br><br>"

'sendSRTEmail email_to, email_cc, email_bcc, email_from, email_subject, email_body2, attachments
%>
	<section id="secondary_bar">
<!--#include file="includes/logged_in_user.inc"-->

		<div class="breadcrumbs_container">
			<article class="breadcrumbs"><a href="http://www.masoftwaresystems.us/miat/splash.aspx">Action Log</a> <div class="breadcrumb_divider"></div> <a class="current">Email Hazard</a></article>
		</div>
	</section><!-- end of secondary bar -->

<!--#include file="includes/sms_header3.inc"-->
<br/><br/>


<form action="doEmail.asp" method="post" name="frm" id="frm">
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:20px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:14px;color:#737579;">Email Information<br><span style="font-weight:bold;">Log Number <%= log_numberStr %></span></span></td></tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pgrey.gif" width="300" height="1"></td></tr>
</table>

<table border="0" cellspacing="5" cellpadding="0" width="550" style="margin-bottom:100px;padding-top:15px;margin-left:10px;">
  <tr>
    <td align="center"><span class="fonts1" style="color:#737579;">Email Sent</span></td>
  </tr>
</table>

</form>

