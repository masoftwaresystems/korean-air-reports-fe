<%
'###############################################
'# 
'# banner.inc
'# 
'# Used as a constant header once logged in
'# 
%>
<%
if(len(session("employee_number")) > 0) then
  loggedin_as = "<span style='font-weight:normal;'>logged in as:</span> <a href='javascript:document.location=""updateProfile.asp""'>"& session("employee_number") &"</a>"
else
  loggedin_as = "&nbsp;"
end if

if(viewdivision = "ACS") then
  viewdivisionStr = "ACS/Cargo"
end if
if(viewdivision = "CGO") then
  viewdivisionStr = "ACS/Cargo"
end if
if(viewdivision = "FOP") then
  viewdivisionStr = "Flight Operations"
end if
if(viewdivision = "IFS") then
  viewdivisionStr = "In-Flight Service"
end if
if(viewdivision = "OCC") then
  viewdivisionStr = "Operations Control Center"
end if
if(viewdivision = "TOP") then
  viewdivisionStr = "TechOps"
end if
if((viewdivision = "iSRT")or(viewdivision = "")) then
  viewdivisionStr = "Integrated"
end if

%>
<div style="margin-right:0px;margin-left:0px;">
  <table border="0" cellspacing="0" cellpadding="0" width="100%" style="padding-top:3px;margin-left:0px;margin-right:10px;">
    <tr valign="bottom">
      <td align="left" width="33%" style="padding-left:10px;padding-bottom:8px;padding-top:8px"><a href="splash.asp"></a></td>
      <td style="" align="center" width="33%" style="font-size:15px;font-weight:bold;padding-bottom:5px;font-color:#000040;" background="" bgColor="#ffffff"><%= viewdivisionStr %>&nbsp;SRT Action Log</td>
      <td align="right" width="33%" valign="bottom" style="padding-bottom:7px;padding-right:5px;"><span style="font-size:10px;color:#003366;font-weight:bold;"><%= loggedin_as %> :: <a href="javascript:document.location='index.asp?logout=y'">logout</a></span></td>
      <td width="1%">&nbsp;</td>
    </tr>
  </table>
  <table border="0" cellspacing="0" cellpadding="0" width="98%" style="padding-top:0px;margin-left:0px;margin-right:0px;" background="images/headerbackground4.gif">
    <tr height="0">
      <td align="center"></td>
    </tr>
  </table>
  <table border="0" cellspacing="0" cellpadding="0" width="100%" style="padding-top:6px;margin-left:0px;margin-right:0px;">
    <tr><td align="center"><img src="images/1pblack.gif" width="98%" height="1"></td></tr>
  </table>
</div>
