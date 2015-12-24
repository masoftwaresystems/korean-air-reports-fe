<%
if(session("loginID") = "") then
  response.redirect "login.asp"
  response.end
end if
%>