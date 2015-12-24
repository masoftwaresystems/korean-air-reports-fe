<%
if(len(request.querystring) > 0) then
  vars = request.querystring
else
  vars = request.form
end if

if(instr(vars,"<script>") > 0) then
  response.end
end if
%>