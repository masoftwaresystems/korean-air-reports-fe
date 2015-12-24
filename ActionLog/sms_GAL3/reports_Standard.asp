<!--#include file="includes/security.inc" -->
<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<%
unlockLogs
%>
<html>
 <head>
 <!--#include file="includes/commonhead.inc"-->
     <link href="styles/display.css" rel="stylesheet" type="text/css" />
     <link href="css/style.css" rel="stylesheet" type="text/css" />
 <!--#include file="script/nav.js"-->
     <% ' {{{ script %>
     <script type="text/javascript">
 <!--#include file="script/display.asp"-->
     </script>
     <link href="css/style.css" rel="stylesheet" type="text/css" />
 <!--#include file="script/nav.js"-->
     <% ' }}} %>
   </head>
   <body >
<form name="frm" action="" method="post">

<center>
<!--#include file="includes/sms_header.inc"-->

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:20px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:14px;color:#737579;">Standard Hazard Reports</span></td></tr>
</table>

<% if(len(msg) > 0) then %>
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:10px;color:red;font-weight:bold;"><%= msg %></span></td></tr>
</table>
<% end if %>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pgrey.gif" width="300" height="1"></td></tr>
</table>

<table border="0" cellspacing="5" cellpadding="0" width="800" style="padding-top:15px;margin-left:10px;padding-bottom:0px;margin-bottom:50px">
<%
sql = "select distinct division, base from EHD_Data where active = 'y' and base <> '' and base is not null order by division asc, base asc"
set rs=conn_asap.execute(sql)
do while not rs.eof
  division = rs("division")
  base = rs("base")
%>
  <tr>
    <td width="30%" align="right"><span class="fonts1" style="color:#737579;font-weight:bold;">&middot;</span></td>
    <td width="70%" align="left"><span class="fonts1" style="font-weight:bold;font-size:11px;"><a href="fullReport.asp?viewdivision=<%= division %>&base=<%= base %>&aircraft=All" target="_blank"><span style="font-weight:normal;">BU - </span><span><%= division %></span>&nbsp;::&nbsp;<span style="font-weight:normal;">Base - </span><span><%= base %></span>&nbsp;::&nbsp;<span style="font-weight:normal;">Aircraft - </span><span>All</span></a></span></td>
  </tr>
<%
  rs.movenext
loop

sql = "select distinct division, base, equipment from EHD_Data where active = 'y' and base <> '' and base is not null and equipment <> '' and equipment is not null order by division asc, base asc, equipment asc"
set rs=conn_asap.execute(sql)
do while not rs.eof
  division = rs("division")
  base = rs("base")
  equipment = rs("equipment")
%>
  <tr>
    <td width="30%" align="right"><span class="fonts1" style="color:#737579;font-weight:bold;">&middot;</span></td>
    <td width="70%" align="left"><span class="fonts1" style="font-weight:bold;font-size:11px;"><a href="fullReport.asp?viewdivision=<%= division %>&base=<%= base %>&aircraft=<%= equipment %>" target="_blank"><span style="font-weight:normal;">BU - </span><span><%= division %></span>&nbsp;::&nbsp;<span style="font-weight:normal;">Base - </span><span><%= base %></span>&nbsp;::&nbsp;<span style="font-weight:normal;">Aircraft - </span><span><%= equipment %></span></a></span></td>
  </tr>
<%
  rs.movenext
loop
%>
</table>




<!--#include file ="includes/footer.inc"-->

</center>
</form>
</body>
</html>
