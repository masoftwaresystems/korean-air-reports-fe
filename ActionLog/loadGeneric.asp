<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<%
'response.end

'response.buffer = false

d    = day(now())
mon  = month(now())
yr   = year(now())
hr   = hour(now())
min  = minute(now())
sec  = second(now())
if(len(d) = 1) then
  d = "0"& d
end if
if(len(mon) = 1) then
  mon = "0"& mon
end if
if(len(hr) = 1) then
  hr = "0"& hr
end if
if(len(min) = 1) then
  min = "0"& min
end if
if(len(sec) = 1) then
  sec = "0"& sec
end if
dateStr = d &"/"& mon &"/"& yr


'dateDue = dateadd("d",90,now())
dateDue = dateadd("m",1,now())
d    = day(dateDue)
mon  = month(dateDue)
yr   = year(dateDue)
hr   = hour(dateDue)
min  = minute(dateDue)
sec  = second(dateDue)
if(len(d) = 1) then
  d = "0"& d
end if
if(len(mon) = 1) then
  mon = "0"& mon
end if
if(len(hr) = 1) then
  hr = "0"& hr
end if
if(len(min) = 1) then
  min = "0"& min
end if
if(len(sec) = 1) then
  sec = "0"& sec
end if
duedateStr = d &"/"& mon &"/"& yr

set oXML					= CreateObject("Microsoft.XMLDOM")
oXML.async					= false

divisionStr = request("division")
bu			= request("bu")
divisionArr = split(divisionStr,",")
'bu = "testbase|COBU"
buArr = split(bu,"|")
cnt = 0


divisionStr = request("bu")

sql = "select isnull(max(logNumber),0) maxlogNumber from EHD_Data where division = "& sqltext2(divisionStr)
set rs = conn_asap.execute(sql)
maxlogNumber = cint(rs("maxlogNumber"))

'response.write("bu:"& bu &"<br>")
'response.write("ubound:"& ubound(divisionArr) &"<br>")
for i = 0 to ubound(divisionArr)

tmpStr = split(divisionArr(i),"|")
if(bu <> "") then

'response.write("cnt:"& cnt &"<br>")
'response.write("divisionStr:"& divisionStr &"<br>")
'response.write("tmpStr(1):"& tmpStr(1) &"<br>")

tmpBase = "all"
tmpEquipment = ""
tmpMission = ""



sql = "select * from EHD_Data where division = 'GEN' and formName = 'iSRT_LogInput' and active = 'y' and archived = 'n' order by logNumber asc"
'response.write("sql:"& sql &"<br>")
'response.end
set rs = conn_asap.execute(sql)
do while not rs.eof

  maxlogNumber = maxlogNumber +1

  log_number	= string(4-len(maxlogNumber),"0")&maxlogNumber
  generic_log_number = rs("logNumber")

  sql = "select formDataXML from EHD_Data where recid = "& sqlnum(rs("recid"))
  set rs2 = conn_asap.execute(sql)

  oXML.loadXML(rs2("formDataXML"))

  'response.write("<br>::"&oXML.xml)
  'response.end

  endorsed					= selectNode(oXML,"endorsed","")
  if(endorsed = "1") then

  cnt = cnt +1

  oXML.selectSingleNode("//viewDivision").text = trim(divisionStr)
  oXML.selectSingleNode("//log_number").text = log_number

  if(obj_exists(oXML.selectSingleNode("//equipment"))) then
    oXML.selectSingleNode("//equipment").text = tmpEquipment
  else
    oXML.selectSingleNode("//formdata").appendChild(oXML.createNode(1,"equipment",""))
    oXML.selectSingleNode("//equipment").text = tmpEquipment
  end if
  if(obj_exists(oXML.selectSingleNode("//base"))) then
    oXML.selectSingleNode("//base").text = trim(divisionStr)
  else
    oXML.selectSingleNode("//formdata").appendChild(oXML.createNode(1,"base",""))
    oXML.selectSingleNode("//base").text = trim(divisionStr)
  end if
  if(obj_exists(oXML.selectSingleNode("//mission"))) then
    oXML.selectSingleNode("//mission").text = tmpMission
  else
    oXML.selectSingleNode("//formdata").appendChild(oXML.createNode(1,"mission",""))
    oXML.selectSingleNode("//mission").text = tmpMission
  end if
  if(obj_exists(oXML.selectSingleNode("//date_opened"))) then
    oXML.selectSingleNode("//date_opened").text = dateStr
  else
    oXML.selectSingleNode("//formdata").appendChild(oXML.createNode(1,"date_opened",""))
    oXML.selectSingleNode("//date_opened").text = dateStr
  end if

  if(obj_exists(oXML.selectSingleNode("//original_date_opened"))) then
    oXML.selectSingleNode("//original_date_opened").text = dateStr
  else
    oXML.selectSingleNode("//formdata").appendChild(oXML.createNode(1,"original_date_opened",""))
    oXML.selectSingleNode("//original_date_opened").text = dateStr
  end if

  if(obj_exists(oXML.selectSingleNode("//date_due"))) then
    oXML.selectSingleNode("//date_due").text = duedateStr
  else
    oXML.selectSingleNode("//formdata").appendChild(oXML.createNode(1,"date_due",""))
    oXML.selectSingleNode("//date_due").text = duedateStr
  end if


  if(obj_exists(oXML.selectSingleNode("//hazard_base"))) then
    oXML.selectSingleNode("//hazard_base").text = baseCode
  else
    oXML.selectSingleNode("//formdata").appendChild(oXML.createNode(1,"hazard_base",""))
    oXML.selectSingleNode("//hazard_base").text = baseCode
  end if
  if(obj_exists(oXML.selectSingleNode("//hazard_type"))) then
    oXML.selectSingleNode("//hazard_type").text = trim(divisionStr)
  else
    oXML.selectSingleNode("//formdata").appendChild(oXML.createNode(1,"hazard_type",""))
    oXML.selectSingleNode("//hazard_type").text = trim(divisionStr)
  end if
  if(obj_exists(oXML.selectSingleNode("//hazard_number"))) then
    oXML.selectSingleNode("//hazard_number").text = generic_log_number
  else
    oXML.selectSingleNode("//formdata").appendChild(oXML.createNode(1,"hazard_number",""))
    oXML.selectSingleNode("//hazard_number").text = generic_log_number
  end if

if(obj_exists(oXML.selectSingleNode("//endorsed"))) then
  oXML.selectSingleNode("//endorsed").text = ""
else
  oXML.selectSingleNode("//formdata").appendChild(oXML.createNode(1,"endorsed",""))
  oXML.selectSingleNode("//endorsed").text = ""
end if
if(obj_exists(oXML.selectSingleNode("//endorsed_by"))) then
  oXML.selectSingleNode("//endorsed_by").text = ""
else
  oXML.selectSingleNode("//formdata").appendChild(oXML.createNode(1,"endorsed_by",""))
  oXML.selectSingleNode("//endorsed_by").text = ""
end if
if(obj_exists(oXML.selectSingleNode("//hazard_owner"))) then
  oXML.selectSingleNode("//hazard_owner").text = ""
else
  oXML.selectSingleNode("//formdata").appendChild(oXML.createNode(1,"hazard_owner",""))
  oXML.selectSingleNode("//hazard_owner").text = ""
end if

if(obj_exists(oXML.selectSingleNode("//accountable_leader"))) then
  oXML.selectSingleNode("//accountable_leader").text = ""
else
  oXML.selectSingleNode("//formdata").appendChild(oXML.createNode(1,"accountable_leader",""))
  oXML.selectSingleNode("//accountable_leader").text = ""
end if

  formDataXML = oXML.xml


  sql = "select isnull(max(recid),0) maxid from EHD_Data"
  set rs4 = conn_asap.execute(sql)
  if not rs4.eof then
    maxid = rs4("maxid")
  end if
  maxid = cint(maxid) +1


  sql = "insert into EHD_Data (recid, loginID, createDate, division, formName, formDataXML, logNumber, archived, modifyDate, modifyUser, lockedrecord, lockedDate, lockedUser, active, srtLogNumber, divisionalLogNumber, srtStageNumber, base, equipment, generic, hazard_base, hazard_type, hazard_number) values ("& maxid &","& sqlnum(rs("loginID")) &",getDate(),"& sqltext2(trim(divisionStr)) &","& sqltext2(rs("formName")) &","& sqltext2(formDataXML) &","& sqlnum(log_number) &","& sqltext2(rs("archived")) &",getDate(),"& sqltext2(rs("modifyUser")) &",null,"& sqltext2(rs("lockedDate")) &","& sqltext2(rs("lockedUser")) &","& sqltext2(rs("active")) &","& sqlnum(rs("srtLogNumber")) &","& sqlnum(log_number) &","& sqlnum(rs("srtStageNumber")) &","& sqltext2(trim(divisionStr)) &","& sqltext2(tmpEquipment) &",'y',"& sqltext2(baseCode) &","& sqltext2(trim(divisionStr)) &","& sqlnum(generic_log_number) &")"

  response.write("sql:"& sql &"<br>")
  'response.end
  conn_asap.execute(sql)

  sql = "select * from EHD_Data where active = 'y' and division = "& sqltext2(rs("division")) &" and formName = 'risk' and logNumber = "& sqlnum(rs("logNumber")) &" and active = 'y' and archived = 'n' "
  set tmprs = conn_asap.execute(sql)
  if not tmprs.eof then

    oXML.loadXML(tmprs("formDataXML"))

    oXML.selectSingleNode("//viewDivision").text = trim(divisionStr)
    oXML.selectSingleNode("//log_number").text = log_number

    formDataXML = oXML.xml

  sql = "select isnull(max(recid),0) maxid from EHD_Data"
  set rs4 = conn_asap.execute(sql)
  if not rs4.eof then
    maxid = rs4("maxid")
  end if
  maxid = cint(maxid) +1

    sql = "insert into EHD_Data (recid, loginID, createDate, division, formName, formDataXML, logNumber, archived, modifyDate, modifyUser, lockedrecord, lockedDate, lockedUser, active, srtLogNumber, divisionalLogNumber, srtStageNumber, base, equipment, generic, hazard_base, hazard_type, hazard_number) values ("& maxid &","& sqlnum(tmprs("loginID")) &",getDate(),"& sqltext2(trim(divisionStr)) &","& sqltext2(tmprs("formName")) &","& sqltext2(formDataXML) &","& sqlnum(log_number) &","& sqltext2(tmprs("archived")) &",getDate(),"& sqltext2(tmprs("modifyUser")) &",null,"& sqltext2(tmprs("lockedDate")) &","& sqltext2(tmprs("lockedUser")) &","& sqltext2(tmprs("active")) &","& sqlnum(tmprs("srtLogNumber")) &","& sqlnum(log_number) &","& sqlnum(tmprs("srtStageNumber")) &","& sqltext2(trim(divisionStr)) &","& sqltext2(tmpEquipment) &",'y',"& sqltext2(baseCode) &","& sqltext2(trim(divisionStr)) &","& sqlnum(generic_log_number) &")"
    'response.write("sql:"& sql &"<br>")
    conn_asap.execute(sql)

  end if

  end if

  rs.movenext
loop

end if
next

'response.end

location = "load_generic.aspx?rc=1&cnt="& cnt
response.redirect location
response.end
%>

