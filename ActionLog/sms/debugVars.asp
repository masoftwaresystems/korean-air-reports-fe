<%
'###############################################
'# 
'# debugVars.asp
'# 
'# Prints passed post or get arguments to screen after being formatted into XML by wrapformdata2.inc
'# 
%>
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include virtual ="/global_includes/wrapformdata2.inc"-->
<pre>
<%= formdata %>
</pre>