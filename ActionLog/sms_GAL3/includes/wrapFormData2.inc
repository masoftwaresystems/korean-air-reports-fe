<%

if(len(request.querystring) > 0) then
  vars = request.querystring
else
  vars = request.form
end if

'response.write(request.form)
'response.end

Dim S3Temp(1,1)

Function URLDecode(S3Decode)

    S3In  = S3Decode
    S3Out = ""
    S3In  = Replace(S3In, "+", " ")
    S3Pos = Instr(S3In, "%")

    Do While S3Pos

         S3Len = Len(S3In)
         If S3Pos > 1 Then S3Out = S3Out & Left(S3In, S3Pos - 1)
         S3Temp(0,0) = Mid(S3In, S3Pos + 1, 1)
         S3Temp(1,0) = Mid(S3In, S3Pos + 2, 1)

         For S3i = 0 to 1

              If Asc(S3Temp(S3i,0)) > 47 And Asc(S3Temp(S3i, 0)) < 58 Then

                   S3Temp(S3i, 1) = Asc(S3Temp(S3i, 0)) - 48

              Else

                   S3Temp(S3i, 1) = Asc(S3Temp(S3i, 0)) - 55

              End If

         Next

         S3Out = S3Out & Chr((S3Temp(0,1) * 16) + S3Temp(1,1))
         S3In  = Right(S3In, (S3Len - (S3Pos + 2)))
         S3Pos = Instr(S3In, "%")

    Loop

    URLDecode = S3Out & S3In

End Function

varArr = split(vars,"&")
cnt=ubound(varArr)

for a=0 to cnt
  tmpValsArr = split(varArr(a),"=")
  if((ubound(tmpValsArr) > 0) and (len(trim(varArr(a))) > 0))then
    if(left(tmpValsArr(0),4) = "card") then
      tmpVal = ""
    else
      tmpVal = tmpValsArr(1)
    end if
  else
    tmpVal = ""
  end if
  if(len(trim(varArr(a))) > 0) then
    body = body &"<"& URLDecode(tmpValsArr(0)) &">"& xdata2(URLDecode(tmpVal)) &"</"& URLDecode(tmpValsArr(0)) &">"
  end if
next

sub addToQuestionAnswersArr(ByRef qArr, ByRef aArr, q, a)

  dim arrLen
  arrLen = ubound(qArr) +1
  dim tmpArr
  dim i
  dim tmpq
  tmpq = replace(q,"_"," ")
  if(len(a) > 0) then
    tmpArr = split(a,",")
    for i=0 to ubound(tmpArr)
      redim preserve qArr(arrLen+1)
      redim preserve aArr(arrLen+1)
      qArr(arrLen) = tmpq
      aArr(arrLen) = replace(tmpArr(i),"_"," ")
      arrLen = arrLen +1
    next
  end if

  'addToQuestionAnswersArr = true
end sub

function getBaseStr(b,d)
  baseStr = b
  sql = "select current_base from BUtoBASE where business_unit = "& sqltext2(d) &" and code = "& sqltext2(b)
  'response.write(sql)
  'response.end
  
  set tmprs = conn_asap.execute(sql)
  if not tmprs.eof then
    baseStr = tmprs("current_base")
  end if
  
  getBaseStr = baseStr
end function

sub saveFormDataXML(ec, f, ByRef fd, l, d, srt, e, b, hb, ht, hn)

  if(f = "iSRT_LogInput") then
    notifyPOC fd, d 
  end if

  dim sql
  dim maxid
  
  sql = "select nvl(max(recid),0) maxid from RawFormDataXML"
  set rs = conn_asap.execute(sql)
  if not rs.eof then
    maxid = rs("maxid")
  end if
  maxid = cint(maxid) +1
  
  sql = "insert into RawFormDataXML(recid, appID, formDataXML) values ("& sqlnum(maxid) &", 'SMS', "& sqltext2(fd) &")"
  conn_asap.execute(sql)
  
  sql = "update EHD_Data set active = 'n' where logNumber = "& l &" and formName = "& sqltext2(f) &" and division = "& sqltext2(d)
  conn_asap.execute(sql)
  
  if(len(srt) = 0) then
    srt = "null"
  end if
  
  baseStr = getBaseStr(hb,d)
  
  sql = "select nvl(max(recid),0) maxid from EHD_Data"
  set rs = conn_asap.execute(sql)
  if not rs.eof then
    maxid = rs("maxid")
  end if
  maxid = cint(maxid) +1
  
  if(d = "EH:DIV") then
    sql = "insert into EHD_Data(recid, loginID, formName, formDataXML, logNumber, active, division, srtLogNumber, equipment, base, hazard_base, hazard_type, hazard_number, CREATEDATE) values ("& sqlnum(maxid) &","& sqltext2(ec) &","& sqltext2(f) &", "& sqltext2(fd) &", "& l &",'y','"& d &"',"& l &",'"& e &"','"& baseStr &"',"& sqltext2(hb) &","& sqltext2(ht) &","& sqlnum(hn) &", current_date)"
  else
    sql = "insert into EHD_Data(recid, loginID, formName, formDataXML, logNumber, active, division, divisionalLogNumber, srtLogNumber, equipment, base, hazard_base, hazard_type, hazard_number, CREATEDATE) values ("& sqlnum(maxid) &","& sqltext2(ec) &","& sqltext2(f) &", "& sqltext2(fd) &", "& l &",'y','"& d &"',"& l &","& srt &",'"& e &"','"& baseStr &"',"& sqltext2(hb) &","& sqltext2(ht) &","& sqlnum(hn) &", current_date)"
  end if
  
  'response.write(sql)
  'response.end
  conn_asap.execute(sql)
  
end sub

sub saveComments(ec, c, f, l, d)

  sql = "select nvl(max(recid),0) maxid from EHD_Comments"
  set rs = conn_asap.execute(sql)
  if not rs.eof then
    maxid = rs("maxid")
  end if
  maxid = cint(maxid) +1
  
  if(len(c) = 0) then
    c = c &" "
  end if

  'sql = "insert into EHD_Comments (recid, loginID, comment_ehd, comment_type, log_number, division, COMMENT_DATE) values ("& sqlnum(maxid) &","& sqlnum(ec) &","& sqltext2(c) &","& sqltext2(f) &","& sqlnum(l) &","& sqltext2(d) &", current_date)"
  'response.write(sql)
  'response.end
  'conn_asap.execute(sql)

end sub

sub createFormDataXML(ec, f, ByRef fd, l, d, srt, hb, ht, hn)


  if(f = "iSRT_LogInput") then
    notifyPOC fd,d
  end if

  dim sql
  
  sql = "select nvl(max(recid),0) maxid from RawFormDatasXML"
  set rs = conn_asap.execute(sql)
  if not rs.eof then
    maxid = rs("maxid")
  end if
  maxid = cint(maxid) +1
  
  sql = "insert into RawFormDatasXML(recid, appID, formDataXML) values ("& sqlnum(maxid) &",'SMS', "& sqltext2(fd) &")"
  conn_asap.execute(sql)
  
  sql = "update EHD_Data set active = 'n' where logNumber = "& l &" and formName = "& sqltext2(f) &" and division = "& sqltext2(d)
  conn_asap.execute(sql)
  
  baseStr = getBaseStr(hb,d)
  
  sql = "select nvl(max(recid),0) maxid from EHD_Data"
  set rs = conn_asap.execute(sql)
  if not rs.eof then
    maxid = rs("maxid")
  end if
  maxid = cint(maxid) +1
  
  if(d = "EH:DIV") then
    sql = "insert into EHD_Data(recid, loginID, formName, formDataXML, logNumber, active, division, divisionalLogNumber, srtLogNumber, hazard_base, hazard_type, hazard_number, base) values ("& sqlnum(maxid) &","& sqltext2(ec) &","& sqltext2(f) &", "& sqltext2(fd) &", "& l &",'y','"& d &"',"& sqlnum(l) &","& sqlnum(srt) &","& sqltext2(hb) &","& sqltext2(ht) &","& sqlnum(hn) &",'"& baseStr &"')"
  else
    sql = "insert into EHD_Data(recid, loginID, formName, formDataXML, logNumber, active, division, divisionalLogNumber, srtLogNumber, hazard_base, hazard_type, hazard_number, base) values ("& sqlnum(maxid) &","& sqltext2(ec) &","& sqltext2(f) &", "& sqltext2(fd) &", "& l &",'y','"& d &"',"& sqlnum(l) &","& sqlnum(srt) &","& sqltext2(hb) &","& sqltext2(ht) &","& sqlnum(hn) &",'"& baseStr &"')"
  end if
  
  'response.write(sql)
  'response.end
  conn_asap.execute(sql)
  
end sub


sub notifyPOC(ByRef fd, division)
  
  dim tmpXML
  dim tmpcnt
  dim b
  dim accountable_leader
  dim poc
  dim accountable_leader_email
  dim poc_email
  dim pm
  dim pm_email
  dim sql
  dim rs
  dim log_number
  'dim division
  
  set tmpXML		= CreateObject("Microsoft.XMLDOM")
  tmpXML.async		= false
  tmpXML.loadXML(fd)
  
  log_number = selectNode(tmpXML,"log_number","")
  'division = selectNode(tmpXML,"viewdivision","")
  
  if(selectNode(tmpXML,"isnew","") = "y") then
    accountable_leader = selectNode(tmpXML,"accountable_leader","")
    sql = "select email_address from Tbl_Logins where employee_number = "& sqltext2(accountable_leader)
    set rs=conn_asap.execute(sql)
    if not rs.eof then
      accountable_leader_email = rs("email_address")
    end if
    sql = "select email_address from Tbl_Logins where division = "& sqltext2(division) &" and srt_admin = 'p'"
    set rs=conn_asap.execute(sql)
    if not rs.eof then
      pm_email = rs("email_address")
    end if
    
    if(accountable_leader_email <> "") then
      email_to = "alex.vargas@delta.com"
      email_cc = "mike.aaron@gmail.com"
      email_subject = "New Item : "& division & log_number
      email_body = "Would have been sent to Accountable Leader "& accountable_leader_email &", PM "& pm_email
      
      'sendEmail email_to, email_cc, email_bcc, email_from, email_subject, email_body
    end if
    
    tmpXML.selectSingleNode("//isnew").text = "n"
  end if

  tmpcnt = cint(selectNode(tmpXML,"safety_action_cnt",""))
  for b = 1 to tmpcnt
    if(selectNode(tmpXML,"isnew_"& b,"") = "y") then
    
      poc = selectNode(tmpXML,"safety_action_poc_"& b,"")
      sql = "select email_address from Tbl_Logins where employee_number = "& sqltext2(poc)
      set rs=conn_asap.execute(sql)
      if not rs.eof then
        poc_email = rs("email_address")
      end if
      
      if(poc_email <> "") then
        email_to = "alex.vargas@delta.com"
        email_cc = "mike.aaron@gmail.com"
        email_subject = "New Item : "& division & log_number &"."& b
        email_body = "Would have been sent to POC "& poc_email
      
        'sendEmail email_to, email_cc, email_bcc, email_from, email_subject, email_body
      
        tmpXML.selectSingleNode("//isnew_"& b).text = "n"
      end if
  
    end if
  next
  
end sub



formdata = replace("<formdata>"& body &"</formdata>","&","&amp;")


if((request("original_endorsed") <> "1") and (request("endorsed") = "1")) then
  set eXML		= CreateObject("Microsoft.XMLDOM")
  eXML.async		= false
  eXML.loadXML(formdata)
  
  date_completed = date()
  next_review_date = dateadd("m",4,date_completed)
  
  if(obj_exists(eXML.selectSingleNode("//date_completed"))) then
    eXML.selectSingleNode("//date_completed").text = date_completed
  else
    eXML.selectSingleNode("//formdata").appendChild(eXML.createNode(1,"date_completed",""))
    eXML.selectSingleNode("//date_completed").text = date_completed
  end if
  if(obj_exists(eXML.selectSingleNode("//next_review_date"))) then
    eXML.selectSingleNode("//next_review_date").text = next_review_date
  else
    eXML.selectSingleNode("//formdata").appendChild(eXML.createNode(1,"next_review_date",""))
    eXML.selectSingleNode("//next_review_date").text = next_review_date
  end if
  eXML.selectSingleNode("//date_due").text = ""
  
  
  if(obj_exists(eXML.selectSingleNode("//item_status"))) then
    if((eXML.selectSingleNode("//item_status").text <> "ALARP") and (eXML.selectSingleNode("//item_status").text <> "Not Applicable")) then
      eXML.selectSingleNode("//item_status").text = "ALARP"
    end if
  else
    eXML.selectSingleNode("//formdata").appendChild(eXML.createNode(1,"item_status",""))
    eXML.selectSingleNode("//item_status").text = "ALARP"
  end if
  
  formdata = eXML.xml
  
end if

if(request("reopen") = "1") then
  set roXML		= CreateObject("Microsoft.XMLDOM")
  roXML.async		= false
  roXML.loadXML(formdata)
  
date_opened = date()
'date_due = dateadd("d",90,date_opened)
date_due = dateadd("m",1,date_opened)
  
if(obj_exists(roXML.selectSingleNode("//endorsed"))) then
  roXML.selectSingleNode("//endorsed").text = ""
else
  roXML.selectSingleNode("//formdata").appendChild(roXML.createNode(1,"endorsed",""))
  roXML.selectSingleNode("//endorsed").text = ""
end if
if(obj_exists(roXML.selectSingleNode("//endorsed_by"))) then
  roXML.selectSingleNode("//endorsed_by").text = ""
else
  roXML.selectSingleNode("//formdata").appendChild(roXML.createNode(1,"endorsed_by",""))
  roXML.selectSingleNode("//endorsed_by").text = ""
end if

if(obj_exists(roXML.selectSingleNode("//next_review_date"))) then
  roXML.selectSingleNode("//next_review_date").text = ""
else
  roXML.selectSingleNode("//formdata").appendChild(roXML.createNode(1,"next_review_date",""))
  roXML.selectSingleNode("//next_review_date").text = ""
end if

roXML.selectSingleNode("//date_opened").text = date_opened
roXML.selectSingleNode("//date_due").text = date_due
roXML.selectSingleNode("//reopen").text = ""
  
  formdata = roXML.xml
  
end if


saveFormDataXML session("loginID"), request("formname"), formdata, request("log_number"), request("viewDivision"), request("srtLogNumber"), request("equipment"), request("base"), request("hazard_base"), request("hazard_type"), request("hazard_number")

  
saveComments session("loginID"), request("item_comments"), request("formname"), request("log_number"), request("viewDivision")

if(request("formname") = "iSRT_LogInput") then

divisionArr		= split(request("division"),",")

sql = "delete from SRT_LogNumberDivisions where log_number = "& sqlnum(log_number) &" and archived = 'n'"
conn_asap.execute(sql)

for a = 0 to ubound(divisionArr)

  sql = "select nvl(max(recid),0) maxid from SRT_LogNumberDivisions"
  set rs = conn_asap.execute(sql)
  if not rs.eof then
    maxid = rs("maxid")
  end if
  maxid = cint(maxid) +1

  sql = "insert into SRT_LogNumberDivisions (recid, log_number, division) values ("& sqlnum(maxid) &","& sqlnum(log_number) &","& sqltext2(trim(divisionArr(a))) &")"
  conn_asap.execute(sql)

next

if(request("item_status") = "Archived") then
  sql = "update EHD_Data set archived = 'y' where logNumber = "& request("log_number") &" and formName = "& sqltext2(request("formname")) &" and division = "& sqltext2(request("viewDivision")) &" and active = 'y'"
  conn_asap.execute(sql)
end if

end if

'response.write(formdata)
'response.end
%>