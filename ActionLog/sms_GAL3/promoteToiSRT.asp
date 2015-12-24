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
sql = "select IFNULL(max(lognumber),0) maxlog_number from EHD_Data where division = 'EH:DIV' and archived = 'n' and active = 'y' and formname = 'iSRT_LogInput'"
set tmprs = conn_asap.execute(sql)
if not tmprs.eof then
  maxlog_number = cint(tmprs("maxlog_number"))
end if
maxlog_number = maxlog_number +1

maxlog_numberStr	= string(4-len(maxlog_number),"0")&maxlog_number

sql = "select * from EHD_Data where lognumber = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and archived = 'n' and active = 'y' and formname = 'iSRT_LogInput'"
set tmprs = conn_asap.execute(sql)
if not tmprs.eof then

  targetXML.loadXML(tmprs("formDataXML"))
  targetLognumber = tmprs("logNumber")
  targetLognumberStr	= string(4-len(targetLognumber),"0")&targetLognumber

  targetXML.selectSingleNode("//log_number").text = maxlog_numberStr

  safety_action_cnt = cint(targetXML.selectSingleNode("//safety_action_cnt").text)

  targetXML.selectSingleNode("//resultPage").text = "admin_LogDisplay.asp"
  targetXML.selectSingleNode("//viewDivision").text = "EH:DIV"

  if(safety_action_cnt > 0) then
    for a = 1 to safety_action_cnt

      targetXML.selectSingleNode("//safety_action_nbr_"& a).text = maxlog_numberStr &"."& a

      targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_division_"& a,""))
      targetXML.selectSingleNode("//safety_action_division_"& a).text = viewDivision

      sql = "insert into EHD_Item_Map (divisional_item_nbr, srt_item_nbr, division, divisional_log_number, srt_log_number) values ("& sqlnum(a) &","& sqlnum(a) &","& sqltext2(viewDivision) &","& sqlnum(log_number) &","& sqlnum(maxlog_number) &")"
      conn_asap.execute(sql)

    next
  end if

  sql = "update EHD_Data set srtlognumber = "& sqlnum(maxlog_number) &" where lognumber = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and archived = 'n' and active = 'y' and formname = 'iSRT_LogInput'"
  conn_asap.execute(sql)

  createFormDataXML session("loginID"), request("formname"), targetXML.xml, log_number, "EH:DIV", maxlog_number

end if

sql = "select * from EHD_Data where lognumber = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and archived = 'n' and active = 'y' and formname = 'risk'"
set tmprs = conn_asap.execute(sql)
if not tmprs.eof then

  targetXML.loadXML(tmprs("formDataXML"))
  targetLognumber = tmprs("logNumber")
  targetLognumberStr	= string(4-len(targetLognumber),"0")&targetLognumber

  targetXML.selectSingleNode("//log_number").text = maxlog_numberStr

  targetXML.selectSingleNode("//viewDivision").text = "EH:DIV"

  sql = "update EHD_Data set srtlognumber = "& sqlnum(maxlog_number) &" where lognumber = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and archived = 'n' and active = 'y' and formname = 'risk'"
  conn_asap.execute(sql)

  createFormDataXML session("loginID"), "risk", targetXML.xml, log_number, "EH:DIV", maxlog_number

end if


response.redirect "admin_LogInput.asp?log_number="& maxlog_number &"&viewdivision=EH:DIV"
response.end
%>