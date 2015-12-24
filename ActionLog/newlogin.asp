<!--#include file ="includes/nocache.inc"-->
<!--#INCLUDE FILE = "includes/dbcommon.inc" (conn) -->
<%
if(request("rc") = "2") then
  msg = "** Username Exists.  Please choose another **"
end if
if(request("rc") = "3") then
  msg = "We understand you have forgotten your password.<br>Please create a new one using your employee number."
end if

username			= request("username")
first_name			= request("first_name")
last_name			= request("last_name")
employee_number		= request("employee_number")
email_address		= request("email_address")
phone_number		= request("phone_number")
division		= request("division")
best_contact		= request("best_contact")
%>
<html>
<head>
<!--#include file ="includes/commonhead.inc"-->
<script type="text/javascript">
function init() {
  clearDropDowns();
  frm.employee_number.focus();
<% if(request("rc") = "2") then %>
  frm.employee_number.select();
<% end if %>
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
            } else {
            //checkCheckboxes();
            //checkAgreement();
              if(checkPasswords()) {
                f.submit();
              }
            }
         }
         function checkPasswords() {
           f = frm;
           if((f.employee_number.value.length != 9)||(isNaN(f.employee_number.value))) {
             alert("Employee Number must be 9 digits");
             return false;
           }
           if((f.password1.value.length < 4)||(f.password1.value.length > 10)) {
             alert("Password must be 4-10 characters");
             return false;
           }
           if(f.password1.value.toLowerCase() != f.password2.value.toLowerCase()) {
             f.password2.value = "";
             f.password1.value = "";
             f.password1.focus();
             alert("Passwords do not match.\nPlease retry.");
             return false;
           } else {
             if(frm.email_address.value.toLowerCase() != frm.email_address2.value.toLowerCase()) {
               alert("Email Addresses do not match");
               frm.email_address.focus();
               return false;
             } else {
               return true;
             }
           }
         }
</script>
</head>
<body onload="init()">
<form name="frm" action="do_newlogin.asp" method="post">
<center>
<!--#include file ="includes/banner.inc"-->

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:20px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:14px;color:#737579;">Create New Login</span></td></tr>
</table>

<% if(len(msg) > 0) then %>
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:12px;color:navy;font-weight:bold;"><%= msg %></span></td></tr>
</table>
<% end if %>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pgrey.gif" width="300" height="1"></td></tr>
</table>

<table border="0" cellspacing="5" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Employee Number (9 digits) :</span></td>
    <td width="60%" align="left"><input type="text" class="input6" name="employee_number" style="width:195px;" value="<%= employee_number %>" required></td>
  </tr>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Password (4-10 characters) :</span></td>
    <td width="60%" align="left"><input type="password" class="input6" name="password1" style="width:195px;" required></td>
  </tr>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Re-Type Password :</span></td>
    <td width="60%" align="left"><input type="password" class="input6" name="password2" style="width:195px;" ></td>
  </tr>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">First Name :</span></td>
    <td width="60%" align="left"><input type="text" class="input6" name="first_name" style="width:195px;" value="<%= first_name %>"></td>
  </tr>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Last Name :</span></td>
    <td width="60%" align="left"><input type="text" class="input6" name="last_name" style="width:195px;" value="<%= last_name %>"></td>
  </tr>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Division :</span></td>
    <td width="60%" align="left">
            <select class="input6" name="division" style="width:195px;" required>
              <option value=""></option>
              <option value="ACS">ACS</option>
              <option value="CGO">CGO</option>
              <option value="FOP">FOP</option>
              <option value="IFS">IFS</option>
              <option value="OCC">OCC</option>
              <option value="TOP">TOP</option>
            </select>
    </td>
  </tr>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Email Address :</span></td>
    <td width="60%" align="left"><input type="text" class="input6" name="email_address" style="width:195px;" required value="<%= email_address %>"></td>
  </tr>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Re-Type Email Address :</span></td>
    <td width="60%" align="left"><input type="text" class="input6" name="email_address2" style="width:195px;" value=""></td>
  </tr>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Phone Number :</span></td>
    <td width="60%" align="left"><input type="text" class="input6" name="phone_number" style="width:195px;" value="<%= phone_number %>"></td>
  </tr>
  <tr valign="top">
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">How Best To Contact Me :</span></td>
    <td width="60%" align="left"><textarea class="input6" style="width:195px;" name="best_contact" rows="3"><%= best_contact %></textarea></td>
  </tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:25px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pblack.gif" width="400" height="1"></td></tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="margin-top:15px;margin-left:10px;" bgColor="white" >
  <tr>
    <td width="100%" align="center">
      <input type="button" value="Create Login" class="button1" style="width:250"  onclick="checkRequired()">
    </td>
  </tr>
  <tr>
    <td width="100%" align="center" height="50"></td>
  </tr>
</table>

<!--#include file ="includes/footer.inc"-->

</center>
</form>
</body>
</html>
