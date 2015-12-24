<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/security.inc" -->
<!--#include file="includes/dbcommon_asap.inc"-->
<%
bu = request("bu")
base = request("base")
news = request("news")

sql = "delete from SMAL_News where base = "& sqltext2(base) &" and bu = "& sqltext2(bu)
conn_asap.execute(sql)

sql = "insert into SMAL_News (bu, base, news) values ("& sqltext2(bu) &","& sqltext2(base) &","& sqltext2(news) &")"
conn_asap.execute(sql)

response.redirect "editNews.aspx?bu="& bu &"&base="& base &"&rc=1"
response.end
%>