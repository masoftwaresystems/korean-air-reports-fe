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
    body = body &"<"& URLDecode(tmpValsArr(0)) &">"& URLDecode(tmpVal) &"</"& URLDecode(tmpValsArr(0)) &">"
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

sub saveFormDataXML(ec, ByRef fd)

  dim sql
  sql = "insert into RawFormDatasXML(appID, formDataXML) values ("& sqltext2(ec) &", "& sqltext2(fd) &")"
  conn_asap.execute(sql)
  
end sub



formdata = replace("<formdata>"& body &"</formdata>","&","&amp;")
saveFormDataXML APPID, formdata

'response.write(formdata)
'response.end
%>