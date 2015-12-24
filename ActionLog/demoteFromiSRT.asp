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

set targetXML		= CreateObject("Microsoft.XMLDOM")
targetXML.async		= false

sql = "select * from EHD_Data where lognumber = "& sqlnum(log_number) &" and division is not null and division = "& sqltext2(viewDivision) &" and archived = 'n' and active = 'y' and formname = 'iSRT_LogInput' and srtlognumber is not null"
set tmprs = conn_asap.execute(sql)
if not tmprs.eof then

  targetXML.loadXML(tmprs("formDataXML"))

  targetXML.selectSingleNode("//srtLogNumber").text = ""

end if

sql = "delete from EHD_Item_Map where divisional_log_number = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision)
conn_asap.execute(sql)

createFormDataXML session("loginID"), request("formname"), targetXML.xml, log_number, viewDivision, ""

response.redirect "divisional_LogInput.asp?log_number="& log_number &"&viewdivision="& viewDivision
response.end
%>