<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/security.inc" -->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<%
unlockLogs
%>
<%
if(request("rc") = "1") then
  msg = "** User Created **"
end if
if(request("rc") = "2") then
  msg = "** User Updated **"
end if
if(request("rc") = "3") then
  msg = "** Please Select Your Division **"
end if

sql = "select * from Tbl_Logins where loginID = "& sqltext2(request("loginID"))
set rs=conn_asap.execute(sql)
if not rs.EOF then
  username			= rs("username")
  first_name		= rs("first_name")
  last_name			= rs("last_name")
  employee_number	= rs("employee_number")
  email_address		= rs("email_address")
  phone_number		= rs("phone_number")
  division			= rs("division")
  business_unit		= rs("business_unit")
  password			= rs("pw")
  sms_admin			= rs("sms_admin")
  base				= rs("base")
end if
%>
<!--#include file="includes/sms_header.inc"-->
<script type="text/javascript">
function init() {
  //alert("here");
  //clearDropDowns();
  //frm.employee_number.focus();
  document.frm.business_unit.value = "<%= business_unit %>";
  document.frm.sms_admin.value = "<%= sms_admin %>";
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
           //if((f.employee_number.value.length != 9)||(isNaN(f.employee_number.value))) {
           //  alert("Employee Number must be 9 digits");
           //  return false;
           //}
           //if((f.password1.value.length < 4)||(f.password1.value.length > 10)) {
           //  alert("Password must be 4-10 characters");
           //  return false;
           //}
           if(frm.password1.value.toLowerCase() != frm.password2.value.toLowerCase()) {
             alert("Passwords do not match");
             frm.password2.value = "";
             frm.password1.value = "";
             frm.password1.focus();
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

<form id="frm" name="frm" action="do_updateProfile.asp" method="post">
<input type="hidden" name="loginID" value="<%= request("loginID") %>">
<input type="hidden" name="user" value="<%= request("user") %>">
<input type="hidden" name="division" value="<%= business_unit %>">
<input type="hidden" name="oldpassword" value="<%= password %>">
<% if(request("user") =  "y") then %>
<input type="hidden" name="sms_admin" value="<%= sms_admin %>">
<% end if %>
<center>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:14px;color:#737579;">Update Profile</span></td></tr>
</table>
<% if(request("user") <>  "y") then %>
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center"><span class="fonts1" style="font-weight:bold;font-size:11px;">[ <a href="admin_user.asp"><span style="font-weight:normal;">back to user list</span></a> ]</span></td></tr>
</table>
<% end if %>
<% if(len(msg) > 0) then %>
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:10px;color:red;font-weight:bold;"><%= msg %></span></td></tr>
</table>
<% end if %>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pgrey.gif" width="370" height="1"></td></tr>
</table>

<table border="0" cellspacing="5" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="font-size:14px; color:#737579;">Username :</span></td>
    <td width="60%" align="left"><input type="text" class="input6" name="username" style="width:195px;border:1px solid black;" value="<%= username %>"></td>
  </tr>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="font-size:14px; color:#737579;">Password :</span></td>
    <td width="60%" align="left"><input type="password" class="input6" name="password1" style="width:195px;border:1px solid black;" value="<%= password %>"></td>
  </tr>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="font-size:14px; color:#737579;">Re-Type Password :</span></td>
    <td width="60%" align="left"><input type="password" class="input6" name="password2" style="width:195px;border:1px solid black;" value="<%= password %>"></td>
  </tr>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="font-size:14px; color:#737579;">First Name :</span></td>
    <td width="60%" align="left"><input type="text" class="input6" name="first_name" style="width:195px;border:1px solid black;" value="<%= first_name %>"></td>
  </tr>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="font-size:14px; color:#737579;">Last Name :</span></td>
    <td width="60%" align="left"><input type="text" class="input6" name="last_name" style="width:195px;border:1px solid black;" value="<%= last_name %>"></td>
  </tr>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="font-size:14px; color:#737579;">Division :</span></td>
    <td width="60%" align="left">
            <select class="input6" name="business_unit" id="business_unit" style="width:200px;border:1px solid black;" required>
              <option value=""></option>
<option value="EU">EU</option>
<option value="CU">CU</option>
<option value="IU">IU</option>
<option value="WAS">WAS</option>
<option value="AUS">AUS</option>
<option value="NA">NA</option>
<option value="Global">Global</option>
<option value="AC">AC</option>
<option value="TEST">TEST</option>
<option value="READONLY">READONLY</option>
            </select>
            <script>
            document.frm.business_unit.value = "<%= business_unit %>";
            </script>
    </td>
  </tr>
<% if(request("user") <>  "y") then %>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="font-size:14px; color:#737579;">SMS Role :</span></td>
    <td width="60%" align="left">
            <select class="input6" name="sms_admin" id="sms_admin" style="width:200px;border:1px solid black;" required>
              <option value=""></option>
              <option value="n">User</option>
              <option value="b">BU Administrator</option>
              <option value="y">Global Administrator</option>
            </select>
            <script>
            document.frm.sms_admin.value = "<%= sms_admin %>";
            </script>
    </td>
  </tr>
  <% end if %>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="font-size:14px; color:#737579;">Email Address :</span></td>
    <td width="60%" align="left"><input type="text" class="input6" name="email_address" style="width:195px;border:1px solid black;" value="<%= email_address %>"></td>
  </tr>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="font-size:14px; color:#737579;">Re-Type Email Address :</span></td>
    <td width="60%" align="left"><input type="text" class="input6" name="email_address2" style="width:195px;border:1px solid black;" value=""></td>
  </tr>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="font-size:14px; color:#737579;">Phone Number :</span></td>
    <td width="60%" align="left"><input type="text" class="input6" name="phone_number" style="width:195px;border:1px solid black;" value="<%= phone_number %>"></td>
  </tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:25px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pblack.gif" width="400" height="1"></td></tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="margin-top:15px;margin-left:10px;" bgColor="white" >
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="font-size:14px; color:#737579;">&nbsp;</span></td>
    <td width="60%" align="left"><input type="button" value="Save" class="button1" style="width:150px;" onclick="checkRequired()"></td>
  </tr>
  <tr>
    <td colspan="2" align="center" height="50"></td>
  </tr>
</table>

<!--#include file ="includes/footer.inc"-->

</center>
</form>

</body>
</html>
