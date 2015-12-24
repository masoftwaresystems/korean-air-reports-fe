<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/emailUtils.inc"-->
<%

division = request("division")
log_number = request("log_number")
employee_number = request("employee_number")
requestor = request("requestor")

log_numberStr	= string(4-len(log_number),"0")&log_number

sql = "delete from SRT_Locks where division = "& sqltext2(division) &" and log_number = "& sqlnum(log_number) &" and lockedUser = "& sqltext2(employee_number)
conn_asap.execute(sql)

sql = "select email_address from Tbl_Logins where employee_number = "& sqltext2(requestor)
set rs=conn_asap.execute(sql)
if not rs.eof then
  email_to = rs("email_address")
else
  email_to = "support@masoftwaresystems.com"
end if

body = ""
body = body& "Log Item Unlocked (Please refresh your browser)<br><br>"
body = body& "Log Number: "& division & log_numberStr &"<br>"

email_cc = ""
email_bcc = "support@masoftwaresystems.com"
email_from = ""
email_subject = "Log Item Unlocked ("& division & log_numberStr &")"

sendEmail email_to, email_cc, email_bcc, email_from, email_subject, body
%>
<html>
<head>
<!--#include file ="includes/commonhead.inc"-->
<script type="text/javascript">
function init() {
  clearDropDowns();
  //frm.employee_number.focus();
  frm.division.value = "<%= division %>";
}
function clearDropDowns() {
  f = frm;
  for (var intLoop = 0; intLoop < f.elements.length; intLoop++) {
    if(f.elements[intLoop].tagName.toLowerCase() == 'select') {
      f.elements[intLoop].value = "";
    }
  }
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
              if(fieldsMatch()) {
                f.submit();
                return true;
              } else {
                return false;
              }
            }
         }
         function fieldsMatch() {
           if(frm.email_address.value.toLowerCase() != frm.email_address2.value.toLowerCase()) {
             alert("Email Addresses do not match");
             frm.email_address.value = "";
             frm.email_address2.value = "";
             frm.email_address.focus();
             return false;
           } else {
             return true;
           }
         }
</script>

<div style="margin-right:0px;margin-left:0px;">
  <table border="0" cellspacing="0" cellpadding="0" width="100%" style="padding-top:3px;margin-left:0px;margin-right:10px;">
    <tr valign="bottom">
      <td align="left" width="33%" style="padding-left:10px;padding-bottom:8px;padding-top:8px"></td>
      <td style="" align="center" width="33%" style="font-size:15px;font-weight:bold;padding-bottom:5px;font-color:#000040;" background="" bgColor="#ffffff"><%= division %> Action Log</td>
      <td align="right" width="33%" valign="bottom" style="padding-bottom:7px;padding-right:5px;"><span style="font-size:10px;color:#003366;font-weight:bold;">&nbsp;</span></td>
      <td width="1%">&nbsp;</td>
    </tr>
  </table>

  <table border="0" cellspacing="0" cellpadding="0" width="100%" style="padding-top:0px;margin-left:0px;margin-right:0px;">
    <tr><td align="center"><img src="images/1pblack.gif" width="98%" height="1"></td></tr>
  </table>
</div>

<link rel="stylesheet" type="text/css" href="styles/display.css" />
<link rel="stylesheet" type="text/css" href="styles/main.css" />
<link rel="stylesheet" type="text/css" href="styles/styles1.css" />
</head>
<body >
<form name="frm" action="" method="post">
<center>


<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:20px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:14px;color:#737579;">Unlock Log</span></td></tr>
</table>

<% if(len(msg) > 0) then %>
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:10px;color:red;font-weight:bold;"><%= msg %></span></td></tr>
</table>
<% end if %>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pgrey.gif" width="100%" height="1"></td></tr>
</table>

<table border="0" cellspacing="5" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;margin-bottom:35px;">
  <tr>
    <td align="center"><span class="fonts1" style="color:#737579;"><%= division %><%= log_numberStr %> Unlocked</span></td>
  </tr>
</table>

<!--#include file ="includes/footer.inc"-->

</center>
</form>
</body>
</html>
