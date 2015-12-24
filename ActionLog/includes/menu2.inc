<table border="0" cellspacing="0" cellpadding="0" width="100%" style="margin-left:10px;">
  <tr align="center">
    <td align="right" width="26%">
    <% if(session("srt_admin") = "w") then %>
      <span></span>
    <% else %>
      <span><a href="javascript:document.location='admin_LogDisplay.asp'" class="link1" style="color:#737579;">Go To iSRT Action Log</a></span>
    <% end if %>
    </td>
    <td align="right" width="17%">
      <span><a href="javascript:document.location='divisional_LogInput.asp'" class="link1" style="color:#737579;">Add Divisional Item</a></span>
    </td>
    <td align="right" width="22%">
      <span><a href="javascript:document.location='divisional_LogDisplay.asp'" class="link1" style="color:#737579;">Go To Divisional Action Log</a></span>
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

<table border="0" cellspacing="0" cellpadding="0" width="98%" style="padding-top:3px;margin-left:0px;">
  <tr><td align="center"><img src="images/1pblack.gif" width="98%" height="1"></td></tr>
</table>