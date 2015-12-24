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

email_cc			= ""
email_bcc			= "mike.aaron@gmail.com"
email_body			= email_additionalinfo


sendEmail email_to, email_cc, email_bcc, email_from, email_subject, email_body
%>
<html><head>
<!--#include file ="includes/commonhead.inc"-->
<title></title>
<SCRIPT LANGUAGE="JavaScript">
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

</SCRIPT>
</head>
<body bottomMargin="3" bgColor="#ffffff" leftMargin="3" topMargin="3" rightMargin="3">
<center>
<!--#include file ="includes/srt_header.inc"-->
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

<!--#include file ="includes/footer.inc"-->
</body>
</html>