<% ' vi: set foldmethod=marker syn=aspvbs linebreak softtabstop=2 tabstop=2 shiftwidth=2 expandtab: %>
<%
' some login info
if(len(session("employee_number")) > 0) then
  loggedin_as = "logged in as: <a href='javascript:document.location=""updateProfile.asp""'>"& session("employee_number") &"</a>:: <a href='javascript:document.location=""index.asp?logout=y""'>logout</a>"
else
  loggedin_as = "&nbsp;"
end if
division = session("division")
srt_admin = session("srt_admin")
%>
