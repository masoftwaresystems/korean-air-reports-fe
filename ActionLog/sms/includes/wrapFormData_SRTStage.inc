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


sub saveFormDataXML(li, f, ByRef fd, l, d)

  if(l = "") then
    l = 0
  end if

  dim sql
  sql = "insert into RawFormDatasXML(appID, formDataXML) values ('SMS', "& sqltext2(fd) &")"
  conn_asap.execute(sql)
  
  sql = "update EHD_Data set active = 'n' where srtStageNumber = "& l &" and formName = "& sqltext2(f) &" and division = "& sqltext2(d)
  conn_asap.execute(sql)
  
  sql = "insert into EHD_Data(loginID, formName, formDataXML, logNumber, active, division, divisionalLogNumber, srtLogNumber, srtStageNumber) values ("& sqltext2(li) &","& sqltext2(f) &", "& sqltext2(fd) &",null,'y','"& d &"',null,null,"& l &")"
  
  'response.write(sql)
  'response.end
  conn_asap.execute(sql)
  
end sub

sub createFormDataXML(ec, f, ByRef fd, l, d, srt)

  dim sql
  sql = "insert into RawFormDatasXML(appID, formDataXML) values ('SMS', "& sqltext2(fd) &")"
  conn_asap.execute(sql)
  
  sql = "update EHD_Data set active = 'n' where logNumber = "& l &" and formName = "& sqltext2(f) &" and division = "& sqltext2(d)
  conn_asap.execute(sql)
  
  if(d = "EH:DIV") then
    sql = "insert into EHD_Data(loginID, formName, formDataXML, logNumber, active, division, divisionalLogNumber, srtLogNumber) values ("& sqltext2(ec) &","& sqltext2(f) &", "& sqltext2(fd) &", "& l &",'y','"& d &"',null,"& sqlnum(srt) &")"
  else
    sql = "insert into EHD_Data(loginID, formName, formDataXML, logNumber, active, division, divisionalLogNumber, srtLogNumber) values ("& sqltext2(ec) &","& sqltext2(f) &", "& sqltext2(fd) &", "& l &",'y','"& d &"',"& l &","& sqlnum(srt) &")"
  end if
  
  'response.write(sql)
  'response.end
  conn_asap.execute(sql)
  
end sub



formdata = replace("<formdata>"& body &"</formdata>","&","&amp;")
saveFormDataXML session("loginID"), request("formname"), formdata, request("log_number"), request("viewDivision")


'response.write(formdata)
'response.end
%>