<%
'response.write("copytobu:"& request("copytobu") &"<br>")
'response.write("viewDivision:"&  viewDivision &"<br>")
'response.end

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


if(request("copytobase") <> "") then

  newbase = request("copytobase")
  newbaseArr = split(newbase,"|")
  targetBU = newbaseArr(0)
  targetCode = newbaseArr(1)

  sql = "select CURRENT_BASE from BUtoBASE where BUSINESS_UNIT = "& sqltext2(targetBU) &" and Code = "& sqltext2(targetCode)
  set ors = conn_asap.execute(sql)
  if not ors.eof then
    targetBase = ors("CURRENT_BASE")
  end if

  sql = "select max(divisionalLogNumber) maxlognumber from EHD_Data where division = "& sqltext2(targetBU) &" and divisionalLogNumber is not null and formName = 'iSRT_LogInput'"
  set tmprs=conn_asap.execute(sql)
  if not tmprs.eof then
    if(isnull(tmprs("maxlognumber"))) then
      newlog_number = 0
    else
      newlog_number = cint(tmprs("maxlognumber"))
    end if
  else
    newlog_number = 0
  end if
  newlog_number = newlog_number +1
  newlog_number				= string(4-len(newlog_number),"0")&newlog_number
  
  if((request("hazard_base") = "GLOBAL") or (right(request("hazard_base"),3) = "GEN")) then
  
  sql = "update EHD_Data set active = 'n' where division = "& sqltext2(targetBU) &" and hazard_base = "& sqltext2(targetCode) &" and hazard_type = "& sqltext2(request("hazard_type")) &" and hazard_number = "& sqlnum(request("hazard_number"))
  conn_asap.execute(sql)
  
  hazard_number = request("hazard_number")
  
  else
  
  sql = "select max(hazard_number) max_hazard_number from EHD_Data where formname = 'iSRT_LogInput' and division = "& sqltext2(targetBU) &" and hazard_base = "& sqltext2(targetCode) &" and hazard_type = "& sqltext2(request("hazard_type"))
  set tmprs=conn_asap.execute(sql)
  if not tmprs.eof then
    if(isnull(tmprs("max_hazard_number"))) then
      hazard_number = 0
      if(viewDivision = "AUSBU") then
        hazard_number = 2000
      end if
      if(viewDivision = "EBU") then
        hazard_number = 3000
      end if
      if(viewDivision = "COBU") then
        hazard_number = 4000
      end if
      if(viewDivision = "IBU") then
        hazard_number = 5000
      end if
      if(viewDivision = "WASBU") then
        hazard_number = 6000
      end if
      if(viewDivision = "NABU") then
        hazard_number = 7000
      end if
      if(viewDivision = "BA") then
        hazard_number = 8000
      end if
      if(viewDivision = "TEST") then
        hazard_number = 9000
      end if
    else
      hazard_number = cint(tmprs("max_hazard_number"))
      if((viewDivision = "AUSBU") and (hazard_number < 2000)) then
        hazard_number = 2000
      end if
      if((viewDivision = "EBU") and (hazard_number < 3000)) then
        hazard_number = 3000
      end if
      if((viewDivision = "COBU") and (hazard_number < 4000)) then
        hazard_number = 4000
      end if
      if((viewDivision = "IBU") and (hazard_number < 5000)) then
        hazard_number = 5000
      end if
      if((viewDivision = "WASBU") and (hazard_number < 6000)) then
        hazard_number = 6000
      end if
      if((viewDivision = "NABU") and (hazard_number < 7000)) then
        hazard_number = 7000
      end if
      if((viewDivision = "BA") and (hazard_number < 8000)) then
        hazard_number = 8000
      end if
      if((viewDivision = "TEST") and (hazard_number < 9000)) then
        hazard_number = 9000
      end if
    end if
  else
    hazard_number = 0
    if(viewDivision = "AUSBU") then
      hazard_number = 2000
    end if
    if(viewDivision = "EBU") then
      hazard_number = 3000
    end if
    if(viewDivision = "COBU") then
      hazard_number = 4000
    end if
    if(viewDivision = "IBU") then
      hazard_number = 5000
    end if
    if(viewDivision = "WASBU") then
      hazard_number = 6000
    end if
    if(viewDivision = "NABU") then
      hazard_number = 7000
    end if
    if(viewDivision = "BA") then
      hazard_number = 8000
    end if
    if(viewDivision = "TEST") then
      hazard_number = 9000
    end if
  end if
  
  hazard_number = hazard_number +1
  
  end if

  hazard_number = string(4-len(hazard_number),"0") & hazard_number
  hazard_id = targetBU &"-"& hazard_number

  sql = "select formDataXML from EHD_Data where formname = 'iSRT_LogInput' and division = "& sqltext2(viewDivision) &" and divisionalLogNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' "
  set tmprs=conn_asap.execute(sql)
  if not tmprs.eof then
    formdataXML = tmprs("formDataXML")
  end if

  set oXML		= CreateObject("Microsoft.XMLDOM")
  oXML.async		= false

  oXML.loadXML(formdataXML)

  oXML.selectSingleNode("//viewDivision").text = targetBU
  oXML.selectSingleNode("//log_number").text = newlog_number

  if(obj_exists(oXML.selectSingleNode("//base"))) then
    oXML.selectSingleNode("//base").text = targetBase
  else
    oXML.selectSingleNode("//formdata").appendChild(oXML.createNode(1,"base",""))
    oXML.selectSingleNode("//base").text = targetBase
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
    oXML.selectSingleNode("//hazard_base").text = targetCode
  else
    oXML.selectSingleNode("//formdata").appendChild(oXML.createNode(1,"hazard_base",""))
    oXML.selectSingleNode("//hazard_base").text = targetCode
  end if

  if(obj_exists(oXML.selectSingleNode("//hazard_number"))) then
    oXML.selectSingleNode("//hazard_number").text = hazard_number
  else
    oXML.selectSingleNode("//formdata").appendChild(oXML.createNode(1,"hazard_number",""))
    oXML.selectSingleNode("//hazard_number").text = hazard_number
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

  sql = "insert into EHD_Data(loginID, formName, formDataXML, logNumber, active, division, divisionalLogNumber, srtLogNumber, hazard_base, hazard_type, hazard_number, base) values ("& sqltext2(session("loginID")) &","& sqltext2("iSRT_LogInput") &", "& sqltext2(formDataXML) &", "& newlog_number &",'y','"& targetBU &"',"& sqlnum(newlog_number) &","& sqlnum(srt) &","& sqltext2(targetCode) &","& sqltext2(request("hazard_type")) &","& sqlnum(hazard_number) &","& sqltext2(targetBase) &")"
  conn_asap.execute(sql)

  sql = "select * from EHD_Data where formname = 'risk' and division = "& sqltext2(viewDivision) &" and divisionalLogNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' "
  set tmprs=conn_asap.execute(sql)
  if not tmprs.eof then
    formdataXML = tmprs("formDataXML")

    set tmpXML		= CreateObject("Microsoft.XMLDOM")
    tmpXML.async		= false

    tmpXML.loadXML(formdataXML)

    tmpXML.selectSingleNode("//viewDivision").text = targetBU
    tmpXML.selectSingleNode("//log_number").text = newlog_number

    sql = "insert into EHD_Data(loginID, formName, formDataXML, logNumber, active, division, divisionalLogNumber, srtLogNumber, hazard_base, hazard_type, hazard_number, base) values ("& sqltext2(session("loginID")) &","& sqltext2("risk") &", "& sqltext2(tmpXML.xml) &", "& newlog_number &",'y','"& targetBU &"',"& sqlnum(newlog_number) &","& sqlnum(srt) &","& sqltext2(targetCode) &","& sqltext2(request("hazard_type")) &","& sqlnum(hazard_number) &","& sqltext2(targetBase) &")"
    conn_asap.execute(sql)

  end if

  response.redirect "divisional_LogInput.asp?position=&log_number="& newlog_number &"&viewDivision="& targetBU
  response.end

end if
%>