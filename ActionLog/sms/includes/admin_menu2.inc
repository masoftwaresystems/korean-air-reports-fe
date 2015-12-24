<%
'###############################################
'# admin_menu2.inc
'# 
'# Retired.
'#
%>
<table border="0" cellspacing="0" cellpadding="0" width="100%" style="margin-left:0px;">
  <tr align="center">
    <td align="left" width="30%">
<span id="basicsearchSPAN" class="hideprint" style="padding-left:10px;">
<input type="text" name="searchVal" id="searchVal" <% if(searchVal <> "") then %>value="<%= searchVal %>"<% end if %> style="border:1px solid black;width:60px;font-size:9px;"><input type="button" value="Search" onclick="doSearch()" style="width:55px;font:normal 9px verdana;color:black;">
<select id="filterSelect" name="filterSelect" value="filterSelect" style="border:1px solid black;width:60px;font-size:9px;margin-left:5px;">
<option value="all">All</option>
<option value="open">Open</option>
<option value="closed">Closed</option>
<option value="re-opened">Re-opened</option>
<option value="void">Void</option>
<option value="demoted">Demoted</option>
</select><input type="button" value="Status" onclick="doFilter()" style="width:55px;font:normal 9px verdana;color:black;">
<% if(filterSelect <> "") then %>
<script>
document.getElementById("filterSelect").value = "<%= filterSelect %>";
</script>
<% end if  %>
<% if(divisionSelect <> "") then %>
<script>
//document.getElementById("divisionSelect").value = "<%= divisionSelect %>";
</script>
<% end if  %>
<span style="FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: #000040; FONT-FAMILY: Arial;padding-left:8px;"><!-- [<a onclick2="newWindow('filter.asp');" href="javascript:toggleSearches('advanced')" class="h"> Advanced Filter </a>]  --></span>
</span>
<span id="advancedsearchSPAN" style="display:none;">
<span style="FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: #000040; FONT-FAMILY: Arial;padding-left:8px;">[<a href="javascript:toggleSearches('basic')" onclick2="newWindow('filter.asp');" class="h"> Basic Filter </a>]</span>
</span>
    </td>
    <td align="right" width="35%">
<!--#include file="divisional_menu2.inc"-->
    </td>
    <td align="right" width="5%">
    </td>
    <td align="right" width="30%" style="padding-right:10px;">
<span class="hideprint">
<div id="divButtons" name="divButtons">
<input type="button" value="Print" onclick="printPage3()" style="width:100px;font:normal 9px verdana;color:black;" /><input type="button" value="<%= buttonText %>" onclick="switchView()" style="width:100px;font:normal 9px verdana;color:black;" />
<!-- <input type="button" value="Unlock" onclick="window.location.reload(true);" style="width:100px;font:normal 9px verdana;color:black;background-color:#FFFFFF;" /> -->
</div></span>
    </td>
  </tr>
</table>


<table border="0" cellspacing="0" cellpadding="0" width="100%" style="padding-top:3px;margin-left:0px;">
  <tr><td align="center"><img src="images/1pblack.gif" width="98%" height="1"></td></tr>
</table>
      
