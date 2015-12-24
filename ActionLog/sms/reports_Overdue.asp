<!--#include file="includes/security.inc" -->
<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<%
unlockLogs
%>
	<section id="secondary_bar">
<!--#include file="includes/logged_in_user.inc"-->

		<div class="breadcrumbs_container">
			<article class="breadcrumbs"><a href="http://www.masoftwaresystems.us/miat/splash.aspx">Action Log</a> <div class="breadcrumb_divider"></div> <a class="current">Reports :: Overdue Hazards</a></article>
		</div>
	</section><!-- end of secondary bar -->

<!--#include file="includes/sms_header3.inc"-->
<br/><br/>

<article class="module width_full">
<div class="module_content">
<h3>Overdue Hazards</h3>

<center>

<% if(len(msg) > 0) then %>
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:10px;color:red;font-weight:bold;"><%= msg %></span></td></tr>
</table>
<% end if %>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pgrey.gif" width="300" height="1"></td></tr>
</table>
<form name="frm" action="overdueReport.asp" method="get" target="_blank">
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center"><select class="fonts1" style="width:210px;font-size:13px;" name="risk"><option value="" selected>Risk - All</option><option value="Acceptable" >Risk - Acceptable</option><option value="Acceptable With Mitigation" >Risk - Acceptable With Mitigation</option><option value="Unacceptable" >Risk - Unacceptable</option></select></td></tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center"><select class="fonts1" style="width:210px;font-size:13px;" name="division">
<% if((request("cookie_seeAll") = "y") or (request("cookie_administrator") = "y")) then %>
  <option value="" selected>Divisions - All</option>
<% end if %>
<%
if(request("cookie_seeDivision") = "y") then
  sqlStr = " where code = '"& request("cookie_division") &"' "
end if
sql = "select distinct division, code from division_t "& sqlStr &" order by division asc"
set rs=conn_asap.execute(sql)
do while not rs.eof
  tmpdivision = rs("division")
  tmpcode = rs("code")
%>
<option value="'<%= tmpcode %>'" ><%= tmpdivision %></option>
<%
  rs.movenext
loop
%>
  </select></td></tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="right" width="250">Date Opened From: </td><td><input type="TEXT" name="start_date" style="width: 100px;" displayName="Start Date" value="<%= start_date %>" class='datepicker2 textbox'></td></tr>
  <tr><td colspan="2" height="3"></td></tr>
  <tr><td align="right" width="250">Date Opened To: </td><td><input type="TEXT" name="end_date" style="width: 100px;" displayName="End Date" value="<%= end_date %>" class='datepicker2 textbox'></td></tr>
</table>


<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:10px;margin-left:10px;margin-bottom:50px">
  <tr><td align="center"><input type="submit" value="Status" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-top:0px;" onclick2="document.frm.submit()"></td></tr>
</table>
</form>

</center>

    </div>
    </article>
<p></p>