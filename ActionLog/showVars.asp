<%
if(len(request.querystring) > 0) then
  vars = request.querystring
else
  vars = request.form
end if
%>
<%= vars %>