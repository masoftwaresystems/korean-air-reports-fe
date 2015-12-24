<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#INCLUDE FILE = "includes/dbcommon.inc" (conn) -->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<%
status = request("status")
email_address = request("email_address")
%>
<html>
<head>
<!--#include file ="includes/commonhead.inc"-->
<script type="text/javascript">
function init() {
  //clearDropDowns();
  //frm.employee_number.focus();
  //frm.division.value = "<%= division %>";
  //frm.access_level.value = "<%= access_level %>";
  //frm.password.focus();
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
<script>
function submitForm(s) {
  frm.status.value = s;
  frm.submit();
}
</script>

<link rel="stylesheet" type="text/css" href="styles/display.css" />
<link rel="stylesheet" type="text/css" href="styles/main.css" />
<link rel="stylesheet" type="text/css" href="styles/styles1.css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<!--#include file="script/nav.js"-->
</head>
<body onload="init()">
<form name="frm" action="createLogin.asp" method="post">
<center>

<!--#include file="includes/sms_header.inc"-->

<input type="hidden" name="status" value="">
<input type="hidden" name="recid" value="<%= recid %>">

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:20px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:14px;color:#737579;">Requested Login</span></td></tr>
</table>

<% if(len(msg) > 0) then %>
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:10px;color:red;font-weight:bold;"><%= msg %></span></td></tr>
</table>
<% end if %>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:0px;margin-left:10px;margin-bottom:0px;">
  <tr><td align="center"><img src="images/1pgrey.gif" width="100%" height="1"></td></tr>
  <tr><td align="center"><font style="font-size:10px;">[ <a href="loginRequests.asp">back to login requests</a> ]</td></tr>
</table>

<table border="0" cellspacing="5" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;margin-bottom:50px;">
  <tr>
    <td align="center"><span class="fonts1" style="color:#737579;">Login for&nbsp;<%= email_address %>&nbsp;was&nbsp;<%= status %></span></td>
  </tr>
</table>

<!--#include file ="includes/footer.inc"-->

</center>
</form>
</body>
</html>
