<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include file="includes/dbcommon.inc" (conn) -->
<!--#include file="includes/dbcommon_asap.inc"-->
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

'sql = "select * from Tbl_Logins where loginID = "& sqltext2(session("loginID"))
'set rs=conn.execute(sql)
'if not rs.EOF then
'  username			= rs("username")
'  first_name		= rs("first_name")
'  last_name			= rs("last_name")
'  employee_number	= rs("employee_number")
'  email_address		= rs("email_address")
'  phone_number		= rs("phone_number")
'  division		= rs("division")
'  best_contact		= rs("best_contact")
'  password			= rs("password")
'end if
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
      <td align="left" width="33%" style="padding-left:10px;padding-bottom:8px;padding-top:8px"><img src="images/dl_logo.gif" border="0"></td>
      <td style="" align="center" width="33%" style="font-size:15px;font-weight:bold;padding-bottom:5px;font-color:#000040;" background="" bgColor="#ffffff">SRT Action Log</td>
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
<form name="frm" action="do_loginRequest.asp" method="post">
<center>


<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:20px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:14px;color:#737579;">Request Login</span></td></tr>
</table>

<% if(len(msg) > 0) then %>
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:10px;color:red;font-weight:bold;"><%= msg %></span></td></tr>
</table>
<% end if %>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pgrey.gif" width="100%" height="1"></td></tr>
</table>

<table border="0" cellspacing="5" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Employee Number :</span></td>
    <td width="60%" align="left"><input type="text" class="input6" name="employee_number" style="width:195px;" value="<%= employee_number %>"></td>
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
            <select class="input6" name="division" style="width:195px;" >
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
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Access Level :</span></td>
    <td width="60%" align="left">
            <select class="input6" name="access_level" style="width:195px;" >
              <option value=""></option>
              <option value="l">Divisional Business Leader</option>
              <option value="w">Divisional User</option>
              <option value="p">Divisional Action Log Program Manager</option>
            </select>
    </td>
  </tr>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Email Address :</span></td>
    <td width="60%" align="left"><input type="text" class="input6" name="email_address" style="width:195px;" value="<%= email_address %>"></td>
  </tr>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Confirm Email Address :</span></td>
    <td width="60%" align="left"><input type="text" class="input6" name="email_address2" style="width:195px;" value="<%= email_address %>"></td>
  </tr>
  <tr>
      <td width="40%" align="right"><span class="fonts1" style="font-size:9px;color:#737579;">Example :</span></td>
      <td width="60%" align="left"><span class="fonts1" style="font-size:11px;color:#737579;"> Your.Name@bristowgroup.com </td>
  </tr>

  <tr>
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Phone Number :</span></td>
    <td width="60%" align="left"><input type="text" class="input6" name="phone_number" style="width:195px;" value="<%= phone_number %>"></td>
  </tr>
  <tr valign="top">
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Reason for Request :</span></td>
    <td width="60%" align="left"><textarea class="input6" style="width:195px;" name="reason" rows="4"><%= reason %></textarea></td>
  </tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:25px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pgrey.gif" width="100%" height="1"></td></tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="margin-top:15px;margin-left:10px;" bgColor="white" >
  <tr>
    <td width="100%" align="center">
      <input type="button" value="Request Login" class="button1" style="width:250" onclick="checkRequired()">
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
