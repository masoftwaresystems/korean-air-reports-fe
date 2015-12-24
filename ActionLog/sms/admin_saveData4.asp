<%
'###############################################
'#
'# admin_saveData4.asp
'#
'# Retired.
'#
%>
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include file ="includes/wrapformdata2.inc"-->
<%
tmplinks		= request("links")
log_number		= request("log_number")
viewDivision	= request("viewDivision")
links_SRT		= request("links_SRT")

tmplinksArr		= split(tmplinks,",")

for a = 0 to ubound(tmplinksArr)

  tmplinksArr2 = split(tmplinksArr(a),"-")

  sql = "update EHD_Data set srtLogNumber = "& sqlnum(log_number) &" where divisionalLogNumber = "& sqlnum(tmplinksArr2(0)) &" and division = "& sqltext2(tmplinksArr2(1)) &" and active = 'y' and archived = 'n'"

  conn_asap.execute(sql)

next

tmplinksArr3		= split(request("links_SRT"),",")

set tmpXML			= CreateObject("Microsoft.XMLDOM")
tmpXML.async		= false

for a = 0 to ubound(tmplinksArr3)
  tmpDivision = tmplinksArr3(a)

  sql = "select max(divisionalLogNumber) maxlognumber from EHD_Data where division = "& sqltext2(tmpDivision) &" and divisionalLogNumber is not null and active = 'y' and archived = 'n' and formName = 'iSRT_LogInput'"
  set tmprs=conn_asap.execute(sql)
  if not tmprs.eof then
    maxlognumber = cint(tmprs("maxlognumber"))
  else
    maxlognumber = 0
  end if

  nextlognumber = maxlognumber +1

  nextlognumberStr	= string(4-len(nextlognumber),"0")&nextlognumber

  tmpXML.loadXML(formdata)

  tmpXML.selectSingleNode("//resultPage").text = "divisional_LogInput.asp"
  tmpXML.selectSingleNode("//viewDivision").text = tmpDivision
  tmpXML.selectSingleNode("//log_number").text = nextlognumber

  tmpcnt = cint(tmpXML.selectSingleNode("//safety_action_cnt").text)

  for b = 1 to tmpcnt

    tmpXML.selectSingleNode("//safety_action_nbr_"&b).text = nextlognumberStr &"."& b

  next

  saveFormDataXML session("loginID"), request("formname"), tmpXML.xml, nextlognumber, tmpDivision

next

pageArg = "?log_number="& log_number &"&viewDivision="& viewDivision

response.redirect request("resultPage") & pageArg
response.end
%>