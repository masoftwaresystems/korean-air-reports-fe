<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include virtual ="/global_includes/emailUtils.inc"-->
<%
log_number			= request("log_number")
log_numberStr		= string(4-len(log_number),"0")&log_number

viewDivision			= request("viewDivision")

email_to			= request("email_to")
email_subject		= request("email_subject")
email_additionalinfo	=   addTags(request("email_additionalinfo"))
email_item_description	=  addTags(request("email_item_description"))

attachments = request("attachments")

'response.write(attachments)
'response.end

email_cc			= ""
email_bcc			= ""
email_body			= email_body

email_body2 = "<br><br><b>Log Number: </b><br>"& email_subject &"<br><br><b>Description: </b><br>"& email_item_description &"<br><br><b>Additional Information: </b><br>"& email_additionalinfo &"<br><br>"

sendSRTEmail email_to, email_cc, email_bcc, email_from, email_subject, email_body2, attachments
%>
<html><head>
<!--#include file ="includes/commonhead.inc"-->
<title></title>
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
            } else {
            //checkCheckboxes();
            //checkAgreement();
              if(checkPasswords()) {
                f.submit();
              }
            }
         }

</script>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<!--#include file="script/nav.js"-->
</head>
<body bottomMargin="3" bgColor="#ffffff" leftMargin="3" topMargin="3" rightMargin="3">
<center>
<!--#include file="includes/sms_header.inc"-->

<form action="doEmail.asp" method="post" name="frm" id="frm">
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:20px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:14px;color:#737579;">Email Information<br><span style="font-weight:bold;">Log Number <%= viewDivision %><%= log_numberStr %></span></span></td></tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pgrey.gif" width="300" height="1"></td></tr>
</table>

<table border="0" cellspacing="5" cellpadding="0" width="550" style="margin-bottom:100px;padding-top:15px;margin-left:10px;">
  <tr>
    <td align="center"><span class="fonts1" style="color:#737579;">Email Sent</span></td>
  </tr>
</table>
<!--
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:25px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pblack.gif" width="400" height="1"></td></tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="margin-top:15px;margin-left:10px;" bgColor="white" >
  <tr>
    <td width="100%" align="center">
      <input type="button" value="Return To Log Input" style="font-weight:bold;font-size:10px;width:160px;margin-top:5px;margin-left:0px;" onclick="document.location='divisional_LogInput.asp?log_number=<%= log_number %>'"><input type="button" value="Return To Action Log" style="font-weight:bold;font-size:10px;width:160px;margin-top:1px;margin-left:0px;" onclick="document.location='divisional_LogDisplay.asp?viewdivision=<%= viewdivision %>'">
    </td>
  </tr>
  <tr>
    <td width="100%" align="center" height="50"></td>
  </tr>
</table>
-->
</form>

<!--#include file ="includes/footer.inc"-->
</body>
</html>
