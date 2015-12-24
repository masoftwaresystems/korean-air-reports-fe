<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include file ="includes/wrapformdata2.inc"-->
<%

'response.write(formdata)
'response.write(vbcrlf)
'response.end

log_number		= request("log_number")
viewDivision	= request("viewDivision")

log_numberStr	= string(4-len(log_number),"0")&log_number

set targetXML			= CreateObject("Microsoft.XMLDOM")
targetXML.async		= false

maxlog_number = 0
sql = "select max(lognumber) maxlog_number from EHD_Data where division = "& sqltext2(viewDivision) &" and archived = 'n' and active = 'y' and formname = 'iSRT_LogInput'"
set tmprs = conn_asap.execute(sql)
if not tmprs.eof then
  maxlog_number = cint(tmprs("maxlog_number"))
end if
maxlog_number = maxlog_number +1

maxlog_numberStr	= string(4-len(maxlog_number),"0")&maxlog_number

sql = "select * from EHD_Data where srtstagenumber = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and archived = 'n' and active = 'y' and formname = 'iSRT_LogInput'"
set tmprs = conn_asap.execute(sql)
if not tmprs.eof then

  targetXML.loadXML(tmprs("formDataXML"))

  targetXML.selectSingleNode("//log_number").text = maxlog_numberStr

  targetXML.selectSingleNode("//resultPage").text = "admin_LogDisplay.asp"

  sql = "update EHD_Data set lognumber = "& sqlnum(maxlog_number) &", srtlognumber = "& sqlnum(maxlog_number) &" where srtstagenumber = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and archived = 'n' and active = 'y' and formname = 'iSRT_LogInput'"
  conn_asap.execute(sql)

  createFormDataXML session("loginID"), request("formname"), targetXML.xml, maxlog_number, viewDivision, maxlog_number

end if


response.redirect "admin_LogDisplay.asp?viewdivision="& viewDivision
response.end
%>