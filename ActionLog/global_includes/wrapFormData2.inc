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

sub saveFormDataXML(ec, f, ByRef fd, l, d, srt)

  if(f = "iSRT_LogInput") then
    notifyPOC fd, d 
  end if

  dim sql
  sql = "insert into RawFormDatasXML(appID, formDataXML) values ('SMS', "& sqltext2(fd) &")"
  conn_asap.execute(sql)
  
  sql = "update SRT_Data set active = 'n' where logNumber = "& l &" and formName = "& sqltext2(f) &" and division = "& sqltext2(d)
  conn_asap.execute(sql)
  
  if(len(srt) = 0) then
    srt = "null"
  end if
  
  if(d = "iSRT") then
    sql = "insert into SRT_Data(loginID, formName, formDataXML, logNumber, active, division, srtLogNumber) values ("& sqltext2(ec) &","& sqltext2(f) &", "& sqltext2(fd) &", "& l &",'y','"& d &"',"& l &")"
  else
    sql = "insert into SRT_Data(loginID, formName, formDataXML, logNumber, active, division, divisionalLogNumber, srtLogNumber) values ("& sqltext2(ec) &","& sqltext2(f) &", "& sqltext2(fd) &", "& l &",'y','"& d &"',"& l &","& srt &")"
  end if
  
  'response.write(sql)
  'response.end
  conn_asap.execute(sql)
  
end sub


sub createFormDataXML(ec, f, ByRef fd, l, d, srt)

  if(f = "iSRT_LogInput") then
    notifyPOC fd,d
  end if

  dim sql
  sql = "insert into RawFormDatasXML(appID, formDataXML) values ('SMS', "& sqltext2(fd) &")"
  conn_asap.execute(sql)
  
  sql = "update SRT_Data set active = 'n' where logNumber = "& l &" and formName = "& sqltext2(f) &" and division = "& sqltext2(d)
  conn_asap.execute(sql)
  
  if(d = "iSRT") then
    sql = "insert into SRT_Data(loginID, formName, formDataXML, logNumber, active, division, divisionalLogNumber, srtLogNumber) values ("& sqltext2(ec) &","& sqltext2(f) &", "& sqltext2(fd) &", "& l &",'y','"& d &"',null,"& sqlnum(srt) &")"
  else
    sql = "insert into SRT_Data(loginID, formName, formDataXML, logNumber, active, division, divisionalLogNumber, srtLogNumber) values ("& sqltext2(ec) &","& sqltext2(f) &", "& sqltext2(fd) &", "& l &",'y','"& d &"',"& l &","& sqlnum(srt) &")"
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
    sql = "select email_address from tbl_logins where employee_number = "& sqltext2(accountable_leader)
    set rs=conn_asap.execute(sql)
    if not rs.eof then
      accountable_leader_email = rs("email_address")
    end if
    sql = "select email_address from tbl_logins where division = "& sqltext2(division) &" and srt_admin = 'p'"
    set rs=conn_asap.execute(sql)
    if not rs.eof then
      pm_email = rs("email_address")
    end if
    
    if(accountable_leader_email <> "") then
      email_to = "alex.vargas@delta.com"
      email_cc = "mike.aaron@gmail.com"
      email_subject = "New Item : "& division & log_number
      email_body = "Would have been sent to Accountable Leader "& accountable_leader_email &", PM "& pm_email
      
      sendEmail email_to, email_cc, email_bcc, email_from, email_subject, email_body
    end if
    
    tmpXML.selectSingleNode("//isnew").text = "n"
  end if

  tmpcnt = cint(selectNode(tmpXML,"safety_action_cnt",""))
  for b = 1 to tmpcnt
    if(selectNode(tmpXML,"isnew_"& b,"") = "y") then
    
      poc = selectNode(tmpXML,"safety_action_poc_"& b,"")
      sql = "select email_address from tbl_logins where employee_number = "& sqltext2(poc)
      set rs=conn_asap.execute(sql)
      if not rs.eof then
        poc_email = rs("email_address")
      end if
      
      if(poc_email <> "") then
        email_to = "alex.vargas@delta.com"
        email_cc = "mike.aaron@gmail.com"
        email_subject = "New Item : "& division & log_number &"."& b
        email_body = "Would have been sent to POC "& poc_email
      
        sendEmail email_to, email_cc, email_bcc, email_from, email_subject, email_body
      
        tmpXML.selectSingleNode("//isnew_"& b).text = "n"
      end if
  
    end if
  next
  
end sub



formdata = replace("<formdata>"& body &"</formdata>","&","&amp;")
saveFormDataXML session("loginID"), request("formname"), formdata, request("log_number"), request("viewDivision"), request("srtLogNumber")

if(request("formname") = "iSRT_LogInput") then

divisionArr		= split(request("division"),",")

sql = "delete from SRT_LogNumberDivisions where log_number = "& sqlnum(log_number) &" and archived = 'n'"
conn_asap.execute(sql)

for a = 0 to ubound(divisionArr)

  sql = "insert into SRT_LogNumberDivisions (log_number, division) values ("& sqlnum(log_number) &","& sqltext2(trim(divisionArr(a))) &")"
  conn_asap.execute(sql)
   
next

end if

'response.write(formdata)
'response.end
%>