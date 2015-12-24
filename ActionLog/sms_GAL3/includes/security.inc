<%
if(session("loginID") = "") then
  response.redirect "index.asp"
  response.end
end if
%>