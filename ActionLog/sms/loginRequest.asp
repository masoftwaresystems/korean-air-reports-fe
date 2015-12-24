<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#INCLUDE FILE = "includes/dbcommon.inc" (conn) -->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<%
recid = request("recid")

sql = "select * from srt_loginrequests where recid = "& sqlnum(recid)
set rs=conn_asap.execute(sql)
if not rs.EOF then
  employee_number	= rs("employee_number")
  first_name		= rs("first_name")
  last_name			= rs("last_name")
  division			= rs("division")
  email_address		= rs("email_address")
  phone_number		= rs("phone_number")
  reason			= rs("reason")
  request_date		= rs("request_date")
  access_level		= rs("access_level")
end if
%>
<html>
<head>
<!--#include file ="includes/commonhead.inc"-->
<script type="text/javascript">
function init() {
  //clearDropDowns();
  //frm.employee_number.focus();
  document.getElementById("division").value = "<%= division %>";
  document.getElementById("access_level").value = "<%= access_level %>";
  document.getElementById("password").focus();
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
  //alert(s);
  document.getElementById("status2").value = s;
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
<center>
<!--#include file="includes/sms_header.inc"-->
<form name="frm" action="createLogin.asp" method="post">
<input type="hidden" id="status2" name="status2" value="">
<input type="hidden" name="recid" value="<%= recid %>">

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:20px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:14px;color:#737579;">Requested Login</span></td></tr>
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
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Request Date :</span></td>
    <td width="60%" align="left"><span class="fonts1" style="color:#737579;"><%= request_date %></span></td>
  </tr>
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
            <select class="input6" id="division" name="division" style="width:195px;" >
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
            <select class="input6" id="access_level" name="access_level" style="width:195px;" >
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
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Phone Number :</span></td>
    <td width="60%" align="left"><input type="text" class="input6" name="phone_number" style="width:195px;" value="<%= phone_number %>"></td>
  </tr>
  <tr valign="top">
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Reason for Request :</span></td>
    <td width="60%" align="left"><textarea class="input6" style="width:195px;" name="reason" rows="4"><%= reason %></textarea></td>
  </tr>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Password :</span></td>
    <td width="60%" align="left"><input type="text" class="input6" id="password" name="password" style="width:195px;" value="<%= password %>"></td>
  </tr>
  <tr valign="top">
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Note To User :</span></td>
    <td width="60%" align="left"><textarea class="input6" style="width:195px;" name="user_note" rows="4"><%= user_note %></textarea></td>
  </tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:25px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pgrey.gif" width="100%" height="1"></td></tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="margin-top:15px;margin-left:10px;" bgColor="white" >
  <tr>
    <td width="100%" align="center">
      <input type="button" value="Create Login" class="button1" style="width:150;margin-right:3px;" onclick="submitForm('APPROVED')"><input type="button" value="Deny Login" class="button1" style="width:150" onclick="submitForm('DENIED')">
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
