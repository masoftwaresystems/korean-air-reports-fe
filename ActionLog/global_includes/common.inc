<%
if(len(APPID) = 0) then
  response.end
end if

currDate = now()
%>
<!--#INCLUDE virtual = "/global_includes/dbcommon.inc" -->
<!--#INCLUDE virtual = "/global_includes/dbcommon_asap.inc" -->
<!--#include virtual = "/global_includes/xmlUtils.inc"-->
<!--#include virtual = "/global_includes/wrapFormData.inc"-->