<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/security.inc" -->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<%
unlockLogs
%>
	<section id="secondary_bar">
<!--#include file="includes/logged_in_user.inc"-->

		<div class="breadcrumbs_container">
			<article class="breadcrumbs"><a href="http://www.masoftwaresystems.us/miat/splash.aspx">Action Log</a> <div class="breadcrumb_divider"></div> <a class="current">User Administration</a></article>
		</div>
	</section><!-- end of secondary bar -->

<!--#include file="includes/sms_header3.inc"-->
<br/><br/>


<script>
function deleteItem(l) {
  document.location = "deleteUser.asp?loginID="+l;
}
</script>

<article class="module width_full">
<div class="module_content">
<h3>Administer Users</h3>

<form name="frm" action="updateProfile.aspx" method="post">

<center>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center"><span class="fonts1" style="font-weight:bold;font-size:11px;">[ <a href="updateProfile.aspx"><span style="font-weight:normal;">Add New User</span></a> ]</span></td></tr>
</table>

<% if(len(msg) > 0) then %>
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:10px;color:red;font-weight:bold;"><%= msg %></span></td></tr>
</table>
<% end if %>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pgrey.gif" width="370" height="1"></td></tr>
</table>

<table border="0" cellspacing="5" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;padding-bottom:0px;margin-bottom:50px">
<%
sql = "select * from Tbl_Logins order by last_name asc"
set rs=conn_asap.execute(sql)
do while not rs.eof
  loginID = rs("loginID")
  first_name = rs("first_name")
  last_name = rs("last_name")
  business_unit = rs("business_unit")
  employee_number = rs("employee_number")
%>
  <tr>
    <td width="30%" align="right"><span class="fonts1" style="color:#737579;font-weight:bold;"><input type="button" value="delete" style="font-size:8px;margin-right:5px;margin-left:5px;" onclick="deleteItem('<%= loginID %>')"> &middot;</span></td>
    <td width="70%" align="left"><span class="fonts1" style="font-weight:bold;font-size:11px;"><a href="updateProfile.aspx?loginID=<%= loginID %>"><%= last_name %>&nbsp;<%= first_name %>&nbsp;[<span style="font-weight:normal;"><%= employee_number  %></span>]</a></span></td>
  </tr>
<%
  rs.movenext
loop
%>
</table>

</center>
</form>

    </div>
    </article>
<p></p>
