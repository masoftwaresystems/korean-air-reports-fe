<%
'###############################################
'# admin_menu.inc
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
<!-- <select id="divisionSelect" name="divisionSelect" value="divisionSelect" style="border:1px solid black;width:80px;font-size:9px;margin-left:5px;">
              <option value="All">All</option>
              <option value="ACS">ACS</option>
              <option value="CGO">CGO</option>
              <option value="FOP">FOP</option>
              <option value="IFS">IFS</option>
              <option value="OCC">OCC</option>
              <option value="TOP">TOP</option>
</select><input type="button" value="Division" onclick="doDivision()" style="width:45px;"> -->
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
      <span style="font: bold 9pt 'verdana', 'arial', 'helvetica';color:#737579;">Admin Menu</span><select onchange="if(this.value != '') goToSelection(this.value);"  style="border:1px solid black;width:155px;font-size:9px;margin-left:5px;">
        <option value=""></option>
	<% if((session("srt_admin") = "l") or (session("srt_admin") = "p")) then %>
        <% if((session("division") = "ACSx") or (session("division") = "CGOx")) then %>
        <option value="ACG">Go To Divisional Log - ACG</option>
        <% else %>
        <option value="<%= session("division") %>">Go To Divisional Log - <%= session("division") %></option>
        <% end if %>
        <% else %>
        <option value="ACS">Go To Divisional Log - ACS</option>
        <option value="CGO">Go To Divisional Log - CGO</option>
<!--
        <option value="ACG">Go To Divisional Log - ACG</option>
-->
        <option value="FOP">Go To Divisional Log - FOP</option>
        <option value="IFS">Go To Divisional Log - IFS</option>
        <option value="OCC">Go To Divisional Log - OCC</option>
        <option value="TOP">Go To Divisional Log - TOP</option>
        <% end if %>
        <% if(session("srt_admin") = "y") then %>
        <option value="AddItem">Add Item to iSRT Action Log</option>
        <option value="AddItem2">Add Item to iSRT Staging Area</option>
        <% end if %>
        <option value="Log">Go To iSRT Action Log</option>
        <option value="Log2">Go To iSRT Stage List</option>
        <option value="Report">Go To iSRT Report</option>
        <option value="Update">Update Profile</option>
        <% if(session("srt_admin") = "y") then %>
        <option value="LoginRequests">Login Requests</option>
        <% end if %>
        <option value="Home">Home Page</option>
      </select>
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
      
<script>
function goToSelection(v) {
  if(v == "ACS") {
    document.location = "divisional_LogDisplay.asp?viewdivision="+v;
  }
  if(v == "CGO") {
    document.location = "divisional_LogDisplay.asp?viewdivision="+v;
  }
  if(v == "FOP") {
    document.location = "divisional_LogDisplay.asp?viewdivision="+v;
  }
  if(v == "IFS") {
    document.location = "divisional_LogDisplay.asp?viewdivision="+v;
  }
  if(v == "OCC") {
    document.location = "divisional_LogDisplay.asp?viewdivision="+v;
  }
  if(v == "TOP") {
    document.location = "divisional_LogDisplay.asp?viewdivision="+v;
  }
  if(v == "AddItem") {
    document.location = "admin_LogInput.asp";
  }
  if(v == "AddItem2") {
    document.location = "admin_StageInput.asp";
  }
  if(v == "Log") {
    document.location = "admin_LogDisplay.asp";
  }
  if(v == "Log2") {
    document.location = "admin_StageList.asp";
  }
  if(v == "Report") {
    document.location = "admin_LogReport.asp";
  }
  if(v == "ACG") {
    document.location = "divisional_LogDisplay.asp?viewdivision="+v;
  }
  if(v == "Update") {
    document.location = "updateProfile.asp";
  }
  if(v == "LoginRequests") {
    document.location = "loginRequests.asp";
  }
  if(v == "Home") {
    document.location = "splash.asp";
  }
}
</script>
