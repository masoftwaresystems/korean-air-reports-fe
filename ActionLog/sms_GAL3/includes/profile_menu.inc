<table border="0" cellspacing="0" cellpadding="0" width="100%" style="margin-left:0px;">
  <tr align="center">
    <td align="center" >

<% if(session("srt_admin") = "y") then %>
<span style="font: bold 9pt 'verdana', 'arial', 'helvetica';color:#737579;">Admin Menu</span><select onchange="if(this.value != '') goToSelection2(this.value);"  style="border:1px solid black;width:175px;font-size:9px;margin-left:5px;">
        <option value=""></option>
        <% if((session("srt_admin") = "l") or (session("srt_admin") = "p")) then %>
        <option value="<%= session("division") %>">Go To Divisional Log - <%= session("division") %></option>
        <% else %>
        <option value="ACS">Go To Divisional Log - ACS</option>
        <option value="CGO">Go To Divisional Log - CGO</option>
        <option value="FOP">Go To Divisional Log - FOP</option>
        <option value="IFS">Go To Divisional Log - IFS</option>
        <option value="OCC">Go To Divisional Log - OCC</option>
        <option value="TOP">Go To Divisional Log - TOP</option>
        <% end if %>
        <option value="AddItem">Add Item to iSRT Action Log</option>
        <option value="AddItem2">Add Item to iSRT Staging Area</option>
        <option value="Log">Go To iSRT Action Log</option>
        <option value="Log2">Go To iSRT Stage List</option>
        <option value="Update">Update Profile</option>
        <option value="LoginRequests">Login Requests</option>
        <option value="Home">Home Page</option>
      </select>
<% else %>
      <span style="font: bold 9pt 'verdana', 'arial', 'helvetica';color:#737579;">Divisional Menu</span><select onchange="if(this.value != '') goToSelection(this.value);" style="border:1px solid black;width:175px;font-size:9px;margin-left:5px;">
        <option value=""></option>
    <% if((session("srt_admin") = "y") or (session("srt_admin") = "l") or (session("srt_admin") = "p")) then %>
        <option value="iSRT">Go To iSRT Action Log</option>
    <% end if %>
    <% if((session("division") = "ACS") or (session("division") = "CGO")) then %>
    <!--
        <option value="AddItem_ACG">Add ACG Divisional Item</option>
        <option value="Log_ACG">Go To ACG Divisional Log</option>
    -->
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
        <option value="Home">Home Page</option>
      </select>
<% end if %>

    </td>
  </tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="100%" style="padding-top:3px;padding-bottom:10px;margin-left:0px;">
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
  if(v == "AddItem_ACS") {
    document.location = "divisional_LogInput.asp?viewdivision=ACS";
  }
  if(v == "AddItem2_ACS") {
    document.location = "divisional_StageInput.asp?viewdivision=ACS";
  }
  if(v == "AddItem_CGO") {
    document.location = "divisional_LogInput.asp?viewdivision=CGO";
  }
  if(v == "AddItem2_CGO") {
    document.location = "divisional_StageInput.asp?viewdivision=CGO";
  }
  if(v == "Log_ACS") {
    document.location = "divisional_LogDisplay.asp?viewdivision=ACS";
  }
  if(v == "Log2_ACS") {
    document.location = "divisional_StageList.asp?viewdivision=ACS";
  }
  if(v == "Log2_CGO") {
    document.location = "divisional_StageList.asp?viewdivision=CGO";
  }
  if(v == "AddItem_ACG") {
    document.location = "divisional_LogInput.asp?viewdivision=ACG";
  }
  if(v == "Log_ACG") {
    document.location = "divisional_LogDisplay.asp?viewdivision=ACG";
  }
  if(v == "Home") {
    document.location = "splash.asp";
  }
}
</script>


<script>
function goToSelection2(v) {
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
  if(v == "ACG") {
    document.location = "divisional_LogDisplay.asp?viewdivision="+v;
  }
  if(v == "LoginRequests") {
    document.location = "loginRequests.asp";
  }
  if(v == "Update") {
    document.location = "updateProfile.asp";
  }
  if(v == "Home") {
    document.location = "splash.asp";
  }
}
</script>