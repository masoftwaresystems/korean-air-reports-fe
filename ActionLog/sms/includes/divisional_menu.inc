<table border="0" cellspacing="0" cellpadding="0" width="100%" style="margin-left:0px;">
  <tr align="center">
    <td align="left" width="30%">
<span id="basicsearchSPAN" class="hideprint" style="padding-left:10px;">
<input type="text" name="searchVal" id="searchVal" <% if(searchVal <> "") then %>value="<%= searchVal %>"<% end if %> style="border:1px solid black;width:60px;font-size:10px;"><input type="button" value="Search" onclick="doSearch()" style="width:55px;font:normal 9px verdana;color:black;">
<select id="filterSelect" name="filterSelect" value="filterSelect" style="border:1px solid black;width:60px;font-size:10px;margin-left:5px;">
<option value="all">All</option>
<option value="open">Open</option>
<option value="closed">Closed</option>
<option value="re-opened">Re-opened</option>
<option value="void">Void</option>
</select><input type="button" value="Status" onclick="doFilter()" style="width:55px;font:normal 9px verdana;color:black;">
<% if(filterSelect <> "") then %>
<script>
document.getElementById("filterSelect").value = "<%= filterSelect %>";
</script>
<% end if  %>
<!-- <select id="divisionSelect" name="divisionSelect" value="divisionSelect" style="border:1px solid black;width:80px;font-size:10px;margin-left:5px;">
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
      <span style="font: bold 9pt 'verdana', 'arial', 'helvetica';color:#737579;">Divisional Menu</span><select onchange="if(this.value != '') goToSelection(this.value);" style="border:1px solid black;width:140px;font-size:9px;margin-left:5px;">
        <option value=""></option>
    <% if((request("viewdivision") = "ACSx") or (request("viewdivision") = "CGOx")) then %>
        <option value="AddItem_ACG">Add ACG Divisional Item</option>
        <option value="Log_ACG">Go To ACG Divisional Log</option>
    <% elseif(( request("viewdivision") = "ACS" ) or ( request("viewdivision") = "CGO" )) then %>
        <option value="AddItem_ACS">Add ACS Divisional Item</option>
        <option value="AddItem2_ACS">Add ACS Stage Item</option>
        <option value="Log_ACS">Go To ACS Divisional Log</option>
        <option value="Log2_ACS">Go To ACS Stage List</option>
        <option value="AddItem_CGO">Add CGO Divisional Item</option>
        <option value="AddItem2_CGO">Add CGO Stage Item</option>
        <option value="Log_CGO">Go To CGO Divisional Log</option>
        <option value="Log2_CGO">Go To CGO Stage List</option>
    <% else %>
        <option value="AddItem">Add Item to <%= request("viewdivision") %> Action Log</option>
        <option value="AddItem2">Add Item to <%= request("viewdivision") %> Staging Area</option>
        <option value="Log">Go To <%= request("viewdivision") %> Divisional Log</option>
        <option value="Log2">Go To <%= request("viewdivision") %> Stage List</option>
    <% end if %>
    <% if((session("srt_admin") = "y") or (session("srt_admin") = "l") or (session("srt_admin") = "p")) then %>
        <option value="iSRT">Go To iSRT Action Log</option>
    <% end if %>
    <% if((request("viewdivision") = "ACSx") or (request("viewdivision") = "CGOx")) then %>
        <option value="Report_ACG">Go To ACG Report</option>
    <% elseif(( request("viewdivision") = "ACS" ) or ( request("viewdivision") = "CGO" )) then %>
    <!--
        <option value="Report_ACS">Go To ACS Report</option>
        <option value="Report_CGO">Go To CGO Report</option>
    -->
    <% else %>
        <option value="Report">Go To <%= request("viewdivision") %> Report</option>
    <% end if %>
	<option value="Update">Update Profile</option>
	<option value="Home">Home Page</option>
      </select>
    </td>
    <td align="right" width="5%">
    </td>
    <td align="right" width="30%" style="padding-right:10px;">
<span class="hideprint">
<div id="divButtons" name="divButtons">
<input type="button" value="Print" onclick="printPage3()" style="width:100px;font:normal 9px verdana;color:black;" /><input type="button" value="<%= buttonText %>" onclick="switchView()" style="width:100px;font:normal 9px verdana;color:black;" />
<!-- <input type="button" value="Unlock" onclick="window.location.reload(true);" style="width:100px;font:normal 9px verdana;color:black;" /> -->
</div></span>
    </td>
  </tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="98%" style="padding-top:3px;margin-left:0px;">
  <tr><td align="center"><img src="images/1pblack.gif" width="98%" height="1"></td></tr>
</table>
      
<script>
function goToSelection(v) {
  if(v == "iSRT") {
    document.location = "admin_LogDisplay.asp";
  }
  if(v == "AddItem") {
    document.location = "divisional_LogInput.asp?viewdivision=<%= request("viewdivision") %>";
  }
  if(v == "AddItem2") {
    document.location = "divisional_StageInput.asp?viewdivision=<%= request("viewdivision") %>";
  }
  if(v == "Log") {
    document.location = "divisional_LogDisplay.asp?viewdivision=<%= request("viewdivision") %>";
  }
  if(v == "Log2") {
    document.location = "divisional_StageList.asp?viewdivision=<%= request("viewdivision") %>";
  }
  if(v == "Report") {
    document.location = "divisional_LogReport.asp?viewdivision=<%= request("viewdivision") %>";
  }
  if(v == "AddItem_ACS") {
    document.location = "divisional_LogInput.asp?viewdivision=ACS";
  }
  if(v == "AddItem_CGO") {
    document.location = "divisional_LogInput.asp?viewdivision=CGO";
  }
  if(v == "Log_ACS") {
    document.location = "divisional_LogDisplay.asp?viewdivision=ACS";
  }
  if(v == "Report_ACS") {
    document.location = "divisional_LogDisplay.asp?viewdivision=ACS";
  }
  if(v == "Log_CGO") {
    document.location = "divisional_LogDisplay.asp?viewdivision=CGO";
  }
  if(v == "Report_CGO") {
    document.location = "divisional_LogDisplay.asp?viewdivision=CGO";
  }
  if(v == "AddItem_ACG") {
    document.location = "divisional_LogInput.asp?viewdivision=ACG";
  }
  if(v == "Log_ACG") {
    document.location = "divisional_LogDisplay.asp?viewdivision=ACG";
  }
  if(v == "Report_ACG") {
    document.location = "divisional_LogReport.asp?viewdivision=ACG";
  }
  if(v == "Update") {
    document.location = "updateProfile.asp";
  }
  if(v == "Home") {
    document.location = "splash.asp";
  }
  if(v == "Log2_ACS") {
    document.location = "divisional_StageList.asp?viewdivision=ACS";
  }
  if(v == "Log2_CGO") {
    document.location = "divisional_StageList.asp?viewdivision=CGO";
  }
  if(v == "AddItem2_CGO") {
    document.location = "divisional_StageInput.asp?viewdivision=CGO";
  }
  if(v == "AddItem2_ACS") {
    document.location = "divisional_StageInput.asp?viewdivision=ACS";
  }
}
</script>
