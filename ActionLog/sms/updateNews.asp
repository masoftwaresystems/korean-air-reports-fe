<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/security.inc" -->
<!--#include file="includes/dbcommon_asap.inc"-->
<%
division = request("division")
news = request("news")

sql = "delete from BULLET_INFO_T where REPORTER = "& sqltext2(division)
conn_asap.execute(sql)

sql = "insert into BULLET_INFO_T (REPORTER, SUBJECT) values ("& sqltext2(division) &","& sqltext2(news) &")"
conn_asap.execute(sql)


response.redirect "fckeditor.asp?division="& division &"&rc=1"
response.end
%>

