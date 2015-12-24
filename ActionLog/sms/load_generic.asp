<!--#include file="includes/security.inc" -->
<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<%
unlockLogs
%>
<%
if(request("rc")="1") then
  msg = "** "& request("cnt") &" Hazards Loaded **"
end if
%>
	<section id="secondary_bar">
<!--#include file="includes/logged_in_user.inc"-->

		<div class="breadcrumbs_container">
			<article class="breadcrumbs"><a href="http://www.masoftwaresystems.us/miat/splash.aspx">Action Log</a> <div class="breadcrumb_divider"></div> <a class="current">Load Generic Hazards</a></article>
		</div>
	</section><!-- end of secondary bar -->

<!--#include file="includes/sms_header3.inc"-->
<br/><br/>

<article class="module width_full">
<div class="module_content">
<h3>Load Generic Hazards</h3>

<center>
<form name="frm" action="loadGeneric.asp" method="post" >

<% if(len(msg) > 0) then %>
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:10px;color:red;font-weight:bold;"><%= msg %></span></td></tr>
</table>
<% end if %>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pgrey.gif" width="300" height="1"></td></tr>
</table>
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center">
  <select name="bu" id="bu" class="fonts1" style="width:250px;font-size:13px;" >
  <option value="" selected>Select Division</option>
<%
sql = "select distinct division, code from division_t order by division asc"
set rs=conn_asap.execute(sql)
do while not rs.eof
  tmpdivision = rs("division")
  tmpcode = rs("code")
%>
  <option value="<%= tmpcode %>" ><%= tmpdivision %></option>
<%
  rs.movenext
loop
%>
  </select></td></tr>
</table>
<!--
<table border="0" cellspacing="5" cellpadding="0" width="1000" style="padding-top:15px;margin-left:10px;padding-bottom:0px;margin-bottom:20px">
<tr>
  <td width="33%" align="left">
  <span class="fonts1" style="font-weight:bold;font-size:11px;text-decoration:underline;">Mission</span>
  </td>
  <td width="33%" align="left">
  <span class="fonts1" style="font-weight:bold;font-size:11px;text-decoration:underline;">Base/Ground</span>
  </td>
  <td width="33%" align="left">
  <span class="fonts1" style="font-weight:bold;font-size:11px;text-decoration:underline;">Aircraft</span>
  </td>
</tr>
<tr>
  <td valign="top">
<%
sql = "select mission from mission_t order by mission asc"
set rs=conn_asap.execute(sql)
do while not rs.eof
%>
<div class="fonts1" style="text-align:left;font-weight:bold;font-size:11px;width:200px;"><input type="checkbox" name="division" value="<%= rs("mission") %>|mission"> <%= rs("mission") %></div>
<%
  rs.movenext
loop
%>
  </td>
  <td valign="top">
<div class="fonts1" style="text-align:left;font-weight:bold;font-size:11px;width:250px;"><input type="checkbox" name="division" value="BASE|base"> All</div>
  </td>
  <td valign="top">
<%
sql = "select aircraft from aircraft_t order by aircraft asc"
set rs=conn_asap.execute(sql)
do while not rs.eof
%>
<div class="fonts1" style="text-align:left;font-weight:bold;font-size:11px;width:200px;"><input type="checkbox" name="division" value="<%= rs("aircraft") %>|aircraft"> <%= rs("aircraft") %></div>
<%
  rs.movenext
loop
%>
  </td>
</table>
-->
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:10px;margin-left:10px;margin-bottom:50px">
  <tr><td align="center"><input type="submit" value="Load Hazards" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-top:0px;" onclick2="document.frm.submit()"></td></tr>
</table>
</form>

</center>

    </div>
    </article>
<p></p>