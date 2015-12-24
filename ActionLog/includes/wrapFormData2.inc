<%

if(len(request.querystring) > 0) then
  vars = request.querystring
else
  vars = request.form
end if

'response.write(vars)
'response.end

varArr = split(vars,"&")
cnt=ubound(varArr)


for a=0 to cnt
  tmpValsArr = split(varArr(a),"=")
  if((ubound(tmpValsArr) > 0) and (len(trim(varArr(a))) > 0)) then
    tmpVal = tmpValsArr(1)
  else
    tmpVal = ""
  end if
  if(len(trim(varArr(a))) > 0) then
    'body = body &"<"& URLDecode(tmpValsArr(0)) &">"& xdata2(URLDecode(tmpVal)) &"</"& URLDecode(tmpValsArr(0)) &">"
    body = body &"<"& URLDecode(tmpValsArr(0)) &"><![CDATA["& tmpVal &"]]></"& URLDecode(tmpValsArr(0)) &">"

  end if
next

'response.write(body)
'response.end


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
    'notifyPOC fd, d 
  end if

  dim sql
  dim maxid
  
  sql = "select isnull(max(recid),0) maxid from RawFormDataXML"
  set rs = conn_asap.execute(sql)
  if not rs.eof then
    maxid = rs("maxid")
  end if
  maxid = cint(maxid) +1
  
  
  'response.write("insert into EHD_Data(recid, loginID, formName, formDataXML, logNumber, active, division, divisionalLogNumber, srtLogNumber, equipment, base, hazard_base, hazard_type, hazard_number, CREATEDATE) values ("& sqlnum(maxid) &","& sqltext2(ec) &","& sqltext2(f) &", "& sqltext2(fd) &", "& sqlnum(l) &",'y','"& d &"',"& sqlnum(l) &","& srt &",'"& e &"','"& baseStr &"',"& sqltext2(hb) &","& sqltext2(ht) &","& sqlnum(hn) &", getDate())")
  'response.end
  
  
  Set cmn= Server.CreateObject("ADODB.Command") 
  Set cmn.ActiveConnection = conn_asap
  
  'cmn.CommandText = "INSERT INTO Inventory (Material, Quantity) VALUES (?, ?)" 
  cmn.CommandText = "insert into RawFormDataXML(recid, appID, formDataXML) values (?, ?, ?)" 
  cmn.Prepared = True
  
  cmn.Parameters.Append cmn.CreateParameter("recid",3) 
  cmn.Parameters.Append cmn.CreateParameter("appID",200, ,10 )
  cmn.Parameters.Append cmn.CreateParameter("formDataXML",201, ,len(fd))
    
  cmn("recid") = maxid  
  cmn("appID") = "SMS"  
  cmn("formDataXML") = fd 
  cmn.Execute
  
  
  'sql = "insert into RawFormDataXML(recid, appID, formDataXML) values ("& sqlnum(maxid) &", 'SMS', "& sqltext2(fd) &")"
  'conn_asap.execute(sql)
  
  sql = "update EHD_Data set active = 'n' where logNumber = "& sqlnum(l) &" and formName = "& sqltext2(f) &" and division = "& sqltext2(d)
  conn_asap.execute(sql)
 
  
  if(len(srt) = 0) then
    srt = "null"
  end if
  
  baseStr = getBaseStr(hb,d)
  
  sql = "select isnull(max(recid),0) maxid from EHD_Data"
  set rs = conn_asap.execute(sql)
  if not rs.eof then
    maxid = rs("maxid")
  end if
  maxid = cint(maxid) +1
 
  
  if(d = "EH:DIV") then
    sql = "insert into EHD_Data(recid, loginID, formName, formDataXML, logNumber, active, division, srtLogNumber, equipment, base, hazard_base, hazard_type, hazard_number, CREATEDATE) values ("& sqlnum(maxid) &","& sqltext2(ec) &","& sqltext2(f) &", "& sqltext2(fd) &", "& sqlnum(l) &",'y','"& d &"',"& sqlnum(l) &",'"& e &"','"& baseStr &"',"& sqltext2(hb) &","& sqltext2(ht) &","& sqlnum(hn) &", getDate())"
  else
    sql = "insert into EHD_Data(recid, loginID, formName, formDataXML, logNumber, active, division, divisionalLogNumber, srtLogNumber, equipment, base, hazard_base, hazard_type, hazard_number, CREATEDATE) values ("& sqlnum(maxid) &","& sqltext2(ec) &","& sqltext2(f) &", "& sqltext2(fd) &", "& sqlnum(l) &",'y','"& d &"',"& sqlnum(l) &","& srt &",'"& e &"','"& baseStr &"',"& sqltext2(hb) &","& sqltext2(ht) &","& sqlnum(hn) &", getDate())"
  end if
  
  conn_asap.execute(sql)
  'response.write(sql)
  'response.end
  
  'Set cmn2= Server.CreateObject("ADODB.Command") 
  'Set cmn2.ActiveConnection = conn_asap
  
  'cmn2.CommandText = "insert into EHD_Data(recid, loginID, formName, formDataXML, logNumber, active, division, divisionalLogNumber, srtLogNumber, equipment, base, hazard_base, hazard_type, hazard_number, CREATEDATE) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?, getDate())" 
  'cmn2.Prepared = True
  
  'cmn2.Parameters.Append cmn.CreateParameter("recid",3) 
  'cmn2.Parameters.Append cmn.CreateParameter("loginID",200, ,len(ec) )
  'cmn2.Parameters.Append cmn.CreateParameter("formName",200, ,len(f))
  'cmn2.Parameters.Append cmn.CreateParameter("formDataXML",201, ,len(fd))
  'cmn2.Parameters.Append cmn.CreateParameter("logNumber",3)
  'cmn2.Parameters.Append cmn.CreateParameter("active",200, ,1)
  'cmn2.Parameters.Append cmn.CreateParameter("division",200, ,len(d))
  'cmn2.Parameters.Append cmn.CreateParameter("divisionalLogNumber",3)
  'cmn2.Parameters.Append cmn.CreateParameter("srtLogNumber",3)
  'cmn2.Parameters.Append cmn.CreateParameter("equipment",200, ,50)
  'cmn2.Parameters.Append cmn.CreateParameter("base",200, ,len(baseStr))
  'cmn2.Parameters.Append cmn.CreateParameter("hazard_base",200, ,50)
  'cmn2.Parameters.Append cmn.CreateParameter("hazard_type",200, ,50)
  'cmn2.Parameters.Append cmn.CreateParameter("hazard_number",200, ,50)
    
  'cmn2("recid") = maxid  
  'cmn2("loginID") = ec 
  'cmn2("formName") = f 
  'cmn2("formDataXML") = fd
  'cmn2("logNumber") = l
  'cmn2("active") = "y"
  'cmn2("division") = d
  'cmn2("divisionalLogNumber") = l
  'cmn2("srtLogNumber") = 0
  'cmn2("equipment") = e
  'cmn2("base") = baseStr
  'cmn2("hazard_base") = hb
  'cmn2("hazard_type") = ht
  'cmn2("hazard_number") = hn
  
  'cmn2.Execute

end sub

sub saveComments(ec, c, f, l, d)

  sql = "select isnull(max(recid),0) maxid from EHD_Comments"
  set rs = conn_asap.execute(sql)
  if not rs.eof then
    maxid = rs("maxid")
  end if
  maxid = cint(maxid) +1
  
  if(len(c) = 0) then
    c = c &" "
  end if

  'sql = "insert into EHD_Comments (recid, loginID, comment_ehd, comment_type, log_number, division, COMMENT_DATE) values ("& sqlnum(maxid) &","& sqlnum(ec) &","& sqltext2(c) &","& sqltext2(f) &","& sqlnum(l) &","& sqltext2(d) &", getDate())"
  'conn_asap.execute(sql)
  
  Set cmn3= Server.CreateObject("ADODB.Command") 
  Set cmn3.ActiveConnection = conn_asap
  
  cmn3.CommandText = "insert into EHD_Comments(recid, loginID, item_commentXML, comment_type, log_number, division, comment_ehd, COMMENT_DATE) values (?,?,?,?,?,?,?, getDate())" 
  cmn3.Prepared = True
  
  cmn3.Parameters.Append cmn3.CreateParameter("recid",3) 
  cmn3.Parameters.Append cmn3.CreateParameter("loginID",3)
  cmn3.Parameters.Append cmn3.CreateParameter("item_commentXML",201, ,len(c)+26)
  cmn3.Parameters.Append cmn3.CreateParameter("comment_type",200, ,len(f) )
  cmn3.Parameters.Append cmn3.CreateParameter("log_number",3)
  cmn3.Parameters.Append cmn3.CreateParameter("division",200, ,len(d))
  cmn3.Parameters.Append cmn3.CreateParameter("comment_ehd",200, ,1)
  
  c = replace(c,"?saveonexit2=y","")
  c = replace(c,"?saveonexit2=","")
    
  cmn3("recid") = maxid  
  cmn3("loginID") = ec 
  cmn3("item_commentXML") = "<data><![CDATA["& c &"]]></data>"
  cmn3("comment_type") = f
  cmn3("log_number") = l
  cmn3("division") = d
  cmn3("comment_ehd") = " "

  cmn3.Execute

end sub

sub createFormDataXML(ec, f, ByRef fd, l, d, srt, hb, ht, hn)


  if(f = "iSRT_LogInput") then
    notifyPOC fd,d
  end if

  dim sql
  
  sql = "select isnull(max(recid),0) maxid from RawFormDatasXML"
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
  
  sql = "select isnull(max(recid),0) maxid from EHD_Data"
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
  'set eXML		= CreateObject("Microsoft.XMLDOM")
  'eXML.async		= false
  'eXML.loadXML(formdata)
  
  'date_completed = date()
  'next_review_date = dateadd("m",4,date_completed)
  
  'if(obj_exists(eXML.selectSingleNode("//date_completed"))) then
  '  eXML.selectSingleNode("//date_completed").text = date_completed
  'else
  '  eXML.selectSingleNode("//formdata").appendChild(eXML.createNode(1,"date_completed",""))
  '  eXML.selectSingleNode("//date_completed").text = date_completed
  'end if
  'if(obj_exists(eXML.selectSingleNode("//next_review_date"))) then
  '  eXML.selectSingleNode("//next_review_date").text = next_review_date
  'else
  '  eXML.selectSingleNode("//formdata").appendChild(eXML.createNode(1,"next_review_date",""))
  '  eXML.selectSingleNode("//next_review_date").text = next_review_date
  'end if
  'eXML.selectSingleNode("//date_due").text = ""
  
  
  'if(obj_exists(eXML.selectSingleNode("//item_status"))) then
  '  if((eXML.selectSingleNode("//item_status").text <> "ALARP") and (eXML.selectSingleNode("//item_status").text <> "Not Applicable")) then
  '    eXML.selectSingleNode("//item_status").text = "ALARP"
  '  end if
  'else
  '  eXML.selectSingleNode("//formdata").appendChild(eXML.createNode(1,"item_status",""))
  '  eXML.selectSingleNode("//item_status").text = "ALARP"
  'end if
  
  'formdata = eXML.xml
  
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




saveFormDataXML session_loginID, request("formname"), formdata, request("log_number"), request("viewDivision"), request("srtLogNumber"), request("equipment"), request("base"), request("hazard_base"), request("hazard_type"), request("hazard_number")



  c = request("item_comments")
  c = replace(c,"?saveonexit2=y","")
  c = replace(c,"?saveonexit2=","")
  
if(len(trim(c)) > 0) then
  'saveComments session_loginID, request("item_comments"), request("formname"), request("log_number"), request("viewDivision")
  
  sql = "select isnull(max(recid),0) maxid from EHD_Comments"
  set rs = conn_asap.execute(sql)
  if not rs.eof then
    maxid = rs("maxid")
  end if
  maxid = cint(maxid) +1
  
    c = replace("<data><comment><![CDATA["& c &"]]></comment></data>","&","&amp;")
  
    sql = "insert into EHD_Comments (recid, loginID, item_commentXML, comment_type, log_number, division, COMMENT_DATE) values ("& sqlnum(maxid) &","& sqlnum(session_loginID) &","& sqltext2(c) &","& sqltext2(request("formname")) &","& request("log_number") &","& sqltext2(request("viewDivision")) &", getDate())"
    conn_asap.execute(sql)

  
  'Set cmn3= Server.CreateObject("ADODB.Command") 
  'Set cmn3.ActiveConnection = conn_asap
  
  'cmn3.CommandText = "insert into EHD_Comments(recid, loginID, item_commentXML, comment_type, log_number, division, comment_ehd, COMMENT_DATE) values (?,?,?,?,?,?,?, getDate())" 
  'cmn3.Prepared = True
  
  'cmn3.Parameters.Append cmn3.CreateParameter("recid",3) 
  'cmn3.Parameters.Append cmn3.CreateParameter("loginID",3)
  'cmn3.Parameters.Append cmn3.CreateParameter("item_commentXML",201, ,len(c)+100)
  'cmn3.Parameters.Append cmn3.CreateParameter("comment_type",200, ,len(request("formname")) )
  'cmn3.Parameters.Append cmn3.CreateParameter("log_number",3)
  'cmn3.Parameters.Append cmn3.CreateParameter("division",200, ,len(request("viewDivision")))
  'cmn3.Parameters.Append cmn3.CreateParameter("comment_ehd",200, ,1)
 
  'c = replace("<data><comment><![CDATA["& c &"]]></comment></data>","&","&amp;")
    
  'cmn3("recid") = maxid  
  'cmn3("loginID") = session_loginID 
  'cmn3("item_commentXML") = c
  'cmn3("comment_type") = request("formname")
  'cmn3("log_number") = request("log_number")
  'cmn3("division") = request("viewDivision")
  'cmn3("comment_ehd") = " "

  'cmn3.Execute
  
  
end if

  Set cmn4= Server.CreateObject("ADODB.Command") 
  Set cmn4.ActiveConnection = conn_asap
  
for a = 1 to cint(request("safety_action_cnt"))
  tmpComment = trim(request("safety_comments_"& a))
  if(len(tmpComment) > 0) then
  
    sql = "select isnull(max(recid),0) maxid from EHD_Comments"
    set rs = conn_asap.execute(sql)
    if not rs.eof then
      maxid = rs("maxid")
    end if
    maxid = cint(maxid) +1
  
    sql = "insert into EHD_Comments (recid, loginID, item_commentXML, comment_type, log_number, division, COMMENT_DATE) values ("& sqlnum(maxid) &","& sqlnum(session_loginID) &","& sqltext2(tmpComment) &","& sqltext2("ActionItem_"& a) &","& request("log_number") &","& sqltext2(request("viewDivision")) &", getDate())"
    conn_asap.execute(sql)
  
  'cmn4.CommandText = "insert into EHD_Comments(recid, loginID, item_commentXML, comment_type, log_number, division, comment_ehd, COMMENT_DATE) values (?,?,?,?,?,?,?, getDate())" 
  'cmn4.Prepared = True
  
  'cmn4.Parameters.Append cmn4.CreateParameter("recid",3) 
  'cmn4.Parameters.Append cmn4.CreateParameter("loginID",3)
  'cmn4.Parameters.Append cmn4.CreateParameter("item_commentXML",201, ,len(tmpComment))
  'cmn4.Parameters.Append cmn4.CreateParameter("comment_type",200, ,len("ActionItem_"& a))
  'cmn4.Parameters.Append cmn4.CreateParameter("log_number",3)
  'cmn4.Parameters.Append cmn4.CreateParameter("division",200, ,len(request("viewDivision")))
  'cmn4.Parameters.Append cmn4.CreateParameter("comment_ehd",200, ,1)
    
  'cmn4("recid") = maxid  
  'cmn4("loginID") = session_loginID 
  'cmn4("item_commentXML") = tmpComment
  'cmn4("comment_type") = "ActionItem_"& a
  'cmn4("log_number") = cint(request("log_number"))
  'cmn4("division") = request("viewDivision")
  'cmn4("comment_ehd") = " "

  'cmn4.Execute
    
  end if
  
  
  if((request("original_safety_action_poc_"& a) <> request("safety_action_poc_"& a)) and (request("safety_action_poc_"& a) <> "")) then

    sql = "select email_address from Tbl_Logins where loginID = "& sqlnum(request("safety_action_poc_"& a))
    set tmprs=conn_asap.execute(sql)
    if not tmprs.eof then
      email_toStr = tmprs("email_address")
    else
      email_toStr = "d_enkhtsetseg@miat.com"
    end if

      hazard_number = string(4-len(request("hazard_number")),"0") & request("hazard_number")
      hazard_id = request("viewDivision") &"-"& hazard_number &"."& a
  
      'email_to = email_toStr
      email_to = "d_enkhtsetseg@miat.com"
      email_cc = ""
      email_bcc = "mike.aaron@gmail.com"
      email_subject = "Hazard Action Item Owner Assignment :: "& hazard_id
      email_body = "You have been assigned action item <a href='http://www.masoftwaresystems.us/miat/divisional_LogInput2.aspx?position=&log_number="& request("log_number") &"&viewDivision="& request("viewDivision") &"'>"& hazard_id &"</a> to manage. [Email would have gone to "& email_toStr &"]"
      email_from = ""
      'sendEmail email_to, email_cc, email_bcc, email_from, email_subject, email_body
    
  end if
  
  if((request("original_safety_action_status_"& a) <> request("safety_action_status_"& a)) and (request("safety_action_status_"& a) = "Closed")) then

    sql = "select email_address from Tbl_Logins where loginID = "& sqlnum(request("safety_action_poc_"& a))
    set tmprs=conn_asap.execute(sql)
    if not tmprs.eof then
      email_toStr = tmprs("email_address")
    else
      email_toStr = "d_enkhtsetseg@miat.com"
    end if

      hazard_number = string(4-len(request("hazard_number")),"0") & request("hazard_number")
      hazard_id = request("viewDivision") &"-"& hazard_number &"."& a
  
      'email_to = email_toStr
      email_to = "d_enkhtsetseg@miat.com"
      email_cc = ""
      email_bcc = "mike.aaron@gmail.com"
      email_subject = "Hazard Action Item Closed :: "& hazard_id
      email_body = "The action item <a href='http://www.masoftwaresystems.us/miat/divisional_LogInput2.aspx?position=&log_number="& request("log_number") &"&viewDivision="& request("viewDivision") &"'>"& hazard_id &"</a> has been closed. [Email would have gone to "& email_toStr &"]"
      email_from = ""
      'sendEmail email_to, email_cc, email_bcc, email_from, email_subject, email_body

    
  end if

next

if(len(trim(request("link_url"))) > 0) then

  if(len(trim(request("link_title"))) > 0) then
    link_title = trim(request("link_title"))
  else
    link_title = trim(request("link_url"))
  end if
  linkStr = "<a href='http://"& trim(replace(request("link_url"),"http://","")) &"' target='_new'>"& link_title &"</a>"
  
  'response.write(linkStr)
  'response.end
  
  sql = "select isnull(max(recid),0) maxid from EHD_Comments"
  set rs = conn_asap.execute(sql)
  if not rs.eof then
    maxid = rs("maxid")
  end if
  maxid = cint(maxid) +1
  
   c = replace("<data><link><![CDATA["& linkStr &"]]></link></data>","&","&amp;")
  
    sql = "insert into EHD_Comments (recid, loginID, item_commentXML, comment_type, log_number, division, COMMENT_DATE) values ("& sqlnum(maxid) &","& sqlnum(session_loginID) &","& sqltext2(c) &","& sqltext2("link") &","& request("log_number") &","& sqltext2(request("viewDivision")) &", getDate())"
    conn_asap.execute(sql)

  
  'Set cmn5= Server.CreateObject("ADODB.Command") 
  'Set cmn5.ActiveConnection = conn_asap
  
  'cmn5.CommandText = "insert into EHD_Comments(recid, loginID, item_commentXML, comment_type, log_number, division, comment_ehd, COMMENT_DATE) values (?,?,?,?,?,?,?, getDate())" 
  'cmn5.Prepared = True
  
  'cmn5.Parameters.Append cmn5.CreateParameter("recid",3) 
  'cmn5.Parameters.Append cmn5.CreateParameter("loginID",3)
  'cmn5.Parameters.Append cmn5.CreateParameter("item_commentXML",201, ,len(linkStr)+100)
  'cmn5.Parameters.Append cmn5.CreateParameter("comment_type",200, ,len("link") )
  'cmn5.Parameters.Append cmn5.CreateParameter("log_number",3)
  'cmn5.Parameters.Append cmn5.CreateParameter("division",200, ,len(request("viewDivision")))
  'cmn5.Parameters.Append cmn5.CreateParameter("comment_ehd",200, ,1)
 
  'c = replace("<data><link><![CDATA["& linkStr &"]]></link></data>","&","&amp;")
    
  'cmn5("recid") = maxid  
  'cmn5("loginID") = session_loginID 
  'cmn5("item_commentXML") = c
  'cmn5("comment_type") = "link"
  'cmn5("log_number") = request("log_number")
  'cmn5("division") = request("viewDivision")
  'cmn5("comment_ehd") = " "

  'cmn5.Execute
  
  
end if

if((request("previous_hazard_owner") <> request("hazard_owner")) and (request("hazard_owner") <> "")) then

sql = "select email_address from Tbl_Logins where loginID = "& sqlnum(request("hazard_owner"))
set tmprs=conn_asap.execute(sql)
if not tmprs.eof then
  email_toStr = tmprs("email_address")
else
  email_toStr = "d_enkhtsetseg@miat.com"
end if

hazard_number = string(4-len(request("hazard_number")),"0") & request("hazard_number")
hazard_id = request("viewDivision") &"-"& hazard_number
  
'email_to = email_toStr
email_to = email_toStr
email_cc = "d_enkhtsetseg@miat.com"
email_bcc = "mike.aaron@gmail.com"
email_subject = "Hazard Owner Assignment :: "& hazard_id
email_body = "You have been assigned hazard <a href='http://www.masoftwaresystems.us/miat/divisional_LogInput2.aspx?position=&log_number="& request("log_number") &"&viewDivision="& request("viewDivision") &"'>"& hazard_id &"</a> to manage. [Email would have gone to "& email_toStr &"]"
email_from = ""
'sendEmail email_to, email_cc, email_bcc, email_from, email_subject, email_body

end if



if(request("formname") = "iSRT_LogInput") then

divisionArr		= split(request("division"),",")

sql = "delete from SRT_LogNumberDivisions where log_number = "& sqlnum(log_number) &" and archived = 'n'"
conn_asap.execute(sql)

for a = 0 to ubound(divisionArr)

  sql = "select isnull(max(recid),0) maxid from SRT_LogNumberDivisions"
  set rs = conn_asap.execute(sql)
  if not rs.eof then
    maxid = rs("maxid")
  end if
  maxid = cint(maxid) +1

  'sql = "insert into SRT_LogNumberDivisions (recid, log_number, division) values ("& sqlnum(maxid) &","& sqlnum(log_number) &","& sqltext2(trim(divisionArr(a))) &")"
  'conn_asap.execute(sql)

next

if(request("item_status") = "Archived") then
  sql = "update EHD_Data set archived = 'y' where logNumber = "& request("log_number") &" and formName = "& sqltext2(request("formname")) &" and division = "& sqltext2(request("viewDivision")) &" and active = 'y'"
  conn_asap.execute(sql)
end if

end if

'response.write(formdata)
'response.end
%>