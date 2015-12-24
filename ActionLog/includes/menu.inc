<span class="hideprint">
<table border="0" cellspacing="0" cellpadding="0" width="100%" style="margin-left:0px;">  
  <tr align="center">
    <td align="right" width="30%">
    <% if((session("srt_admin") = "y") or (session("srt_admin") = "l") or (session("srt_admin") = "p")) then %>
      <span style="font: bold 9pt 'verdana', 'arial', 'helvetica';color:#737579;">Go To Divisional Log</span><select onchange="if(this.value != '') goToDivision(this.value);" style="border:1px solid black;width:80px;font-size:9px;margin-left:5px;">
        <option value=""></option>
    <% if((session("srt_admin") = "l") or (session("srt_admin") = "p")) then %>
        <option value="<%= session("division") %>"><%= session("division") %></option>
    <% else %>
        <option value="ACS">ACS</option>
        <option value="CGO">CGO</option>
        <option value="FOP">FOP</option>
        <option value="IFS">IFS</option>
        <option value="OCC">OCC</option>
        <option value="TOP">TOP</option>
    <% end if %>
      </select>
    <% else %>
      <span></span>
    <% end if %>
    </td>
    <td align="right" width="13%">
    <% if(session("srt_admin") = "y") then %>
      <span><a href="javascript:document.location='admin_LogInput.asp'" class="link1" style="color:#737579;">Add iSRT Item</a></span>
    <% else %>
      <span></span>
    <% end if %>
    </td>
    <td align="right" width="17%">
      <span><a href="javascript:document.location='admin_LogDisplay.asp'" class="link1" style="color:#737579;">Go To iSRT Action Log</a></span>
    </td>
    <td align="right" width="15%">
      <span><a href="javascript:document.location='updateProfile.asp'" class="link1" style="color:#737579;">Update Profile</a></span>
    </td>
    <td align="right" width="15%">
      <span><a href="javascript:document.location='index.asp?logout=y'" class="link1" style="color:#737579;">Logout</a></span>
    </td>
    <td align="center" width="5%">
      <span>&nbsp;</span>
    </td>
  </tr>
</table>
</span>
<table border="0" cellspacing="0" cellpadding="0" width="98%" style="padding-top:3px;margin-left:0px;">
  <tr><td align="center"><img src="images/1pblack.gif" width="98%" height="1"></td></tr>
</table>
<script>
function goToDivision(d) {
  document.location = "divisional_LogDisplay.asp?viewdivision="+d;
}
</script>