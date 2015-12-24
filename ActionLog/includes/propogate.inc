<%   
'response.write(formdata)
'response.write(vbcrlf)
'response.end


tmplinks		= request("links")
log_number		= request("log_number")
viewDivision	= request("viewDivision")

log_numberStr	= string(4-len(log_number),"0")&log_number

tmplinksArr		= split(tmplinks,",")

sql = "delete from SRT_Links where primary_log_number = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and archived = 'n'"
conn_asap.execute(sql)

sql = "delete from SRT_Links where secondary_log_number = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and archived = 'n'"
conn_asap.execute(sql)

for a = 0 to ubound(tmplinksArr)

  sql = "insert into SRT_Links (primary_log_number, secondary_log_number, division) values ("& sqlnum(log_number) &","& sqlnum(tmplinksArr(a)) &","& sqltext2(viewDivision) &")"
  conn_asap.execute(sql)
  
  sql = "insert into SRT_Links (primary_log_number, secondary_log_number, division) values ("& sqlnum(tmplinksArr(a)) &","& sqlnum(log_number) &","& sqltext2(viewDivision)&")"
  conn_asap.execute(sql)
  
next


set tmpXML		= CreateObject("Microsoft.XMLDOM")
tmpXML.async		= false

tmpXML.loadXML(formdata)

set targetXML		= CreateObject("Microsoft.XMLDOM")
targetXML.async		= false


deleted_item_nbr	= selectNode(tmpXML,"deleted_item_nbr","")
deleted_item_division	= selectNode(tmpXML,"deleted_item_division","")

if(len(deleted_item_nbr) > 0) then

  sql = "select * from EHD_Item_Map where srt_log_number = "& sqlnum(log_number) &" and srt_item_nbr = "& sqlnum(deleted_item_nbr) &" and division = "& sqltext2(deleted_item_division)
  set tmprs = conn_asap.execute(sql)
  if not tmprs.eof then
      
    sql = "select * from EHD_Data where srtlognumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' and formname = 'iSRT_LogInput' and lognumber = "& sqlnum(tmprs("divisional_log_number")) &" and division = "& sqltext2(deleted_item_division)
    set tmprs2 = conn_asap.execute(sql)
        
    if not tmprs2.eof then
        
      targetXML.loadXML(tmprs2("formdataXML"))
        
      tmpCnt = selectNode(targetXML,"safety_action_cnt","0")
      if(cint(tmpCnt) > 0) then
        
        targetXML.selectSingleNode("//safety_action_cnt").text = cint(tmpCnt) -1
        
        targetXML.documentElement.removeChild(targetXML.documentElement.selectSingleNode("//safety_action_"& tmprs("divisional_item_nbr")))
        targetXML.documentElement.removeChild(targetXML.documentElement.selectSingleNode("//safety_action_poc_"& tmprs("divisional_item_nbr")))
        targetXML.documentElement.removeChild(targetXML.documentElement.selectSingleNode("//safety_action_poc_email_"& tmprs("divisional_item_nbr")))
        targetXML.documentElement.removeChild(targetXML.documentElement.selectSingleNode("//safety_action_open_"& tmprs("divisional_item_nbr")))
        targetXML.documentElement.removeChild(targetXML.documentElement.selectSingleNode("//safety_action_due_"& tmprs("divisional_item_nbr")))
        targetXML.documentElement.removeChild(targetXML.documentElement.selectSingleNode("//safety_action_completed_"& tmprs("divisional_item_nbr")))
        targetXML.documentElement.removeChild(targetXML.documentElement.selectSingleNode("//safety_action_status_"& tmprs("divisional_item_nbr")))
          
        if(obj_exists(targetXML.selectSingleNode("//safety_action_division_"& tmprs("divisional_item_nbr")))) then
          targetXML.documentElement.removeChild(targetXML.documentElement.selectSingleNode("//safety_action_division_"& tmprs("divisional_item_nbr")))
        end if
        if(obj_exists(targetXML.selectSingleNode("//safety_action_assigned_division_"& tmprs("divisional_item_nbr")))) then
          targetXML.documentElement.removeChild(targetXML.documentElement.selectSingleNode("//safety_action_assigned_division_"& tmprs("divisional_item_nbr")))
        end if
          
        sql = "delete from EHD_Item_Map where recid = "& sqlnum(tmprs("recid"))
        conn_asap.execute(sql)
          
        createFormDataXML session("loginID"), request("formname"), targetXML.xml, tmprs("divisional_log_number"), tmprs("division"), log_number
          
      end if
    end if                
  end if 
end if


divisionArr		= split(request("division"),",")

for a = 0 to ubound(divisionArr)

  tmpDivision = trim(divisionArr(a))
  
  'sql = "select max(divisionalLogNumber) maxlognumber from EHD_Data where division = "& sqltext2(tmpDivision) &" and divisionalLogNumber is not null and active = 'y' and archived = 'n' and formName = 'iSRT_LogInput'"
  if( (tmpDivision = "ACS") or (tmpDivision = "CGO") ) then
    sql = "select max(divisionalLogNumber) maxlognumber from EHD_Data where division in ('ACS','CGO') and divisionalLogNumber is not null and active = 'y' and archived = 'n' and formName = 'iSRT_LogInput'"
  else
    sql = "select max(divisionalLogNumber) maxlognumber from EHD_Data where division = "& sqltext2(tmpDivision) &" and divisionalLogNumber is not null and active = 'y' and archived = 'n' and formName = 'iSRT_LogInput'"
  end if
  'response.write(sql)
  'response.end
  set tmprs=conn_asap.execute(sql)
  if not tmprs.eof then
    if((len(tmprs("maxlognumber")) = 0) or (isnull(tmprs("maxlognumber")))) then
      maxlognumber = 0
    else
      maxlognumber = cint(tmprs("maxlognumber"))     
    end if
  else
    maxlognumber = 0
  end if
  
  nextlognumber = maxlognumber +1
  
  targetXML.loadXML("<formdata></formdata>")
 
  nextlognumberStr	= string(4-len(nextlognumber),"0")&nextlognumber
  
  tmpXML.loadXML(formdata)

  targetXML.selectSingleNode("//formdata").appendChild(tmpXML.selectSingleNode("//formname")) 
  targetXML.selectSingleNode("//formdata").appendChild(tmpXML.selectSingleNode("//safety_action_cnt")) 
  targetXML.selectSingleNode("//safety_action_cnt").text = "0"
  targetXML.selectSingleNode("//formdata").appendChild(tmpXML.selectSingleNode("//resultPage")) 
  targetXML.selectSingleNode("//resultPage").text = "divisional_LogInput.asp"
  targetXML.selectSingleNode("//formdata").appendChild(tmpXML.selectSingleNode("//get_max_recid")) 
  targetXML.selectSingleNode("//formdata").appendChild(tmpXML.selectSingleNode("//viewDivision"))
  targetXML.selectSingleNode("//viewDivision").text = tmpDivision
  if(obj_exists(tmpXML.selectSingleNode("//item_status2"))) then
    targetXML.selectSingleNode("//formdata").appendChild(tmpXML.selectSingleNode("//item_status2")) 
  else 
    targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"item_status2","")) 
    targetXML.selectSingleNode("//item_status2").text = tmpXML.selectSingleNode("//item_status").text
  end if
  targetXML.selectSingleNode("//formdata").appendChild(tmpXML.selectSingleNode("//log_number")) 
  targetXML.selectSingleNode("//log_number").text = nextlognumber
  targetXML.selectSingleNode("//formdata").appendChild(tmpXML.selectSingleNode("//item_description")) 
  
  Set NodeList = tmpXML.documentElement.selectNodes("//accountable_leader") 
  For Each Node In NodeList 
    targetXML.documentElement.appendChild(Node)
  Next
  
  targetXML.selectSingleNode("//formdata").appendChild(tmpXML.selectSingleNode("//source")) 
  targetXML.selectSingleNode("//formdata").appendChild(tmpXML.selectSingleNode("//date_opened")) 
  targetXML.selectSingleNode("//formdata").appendChild(tmpXML.selectSingleNode("//date_due")) 
  targetXML.selectSingleNode("//formdata").appendChild(tmpXML.selectSingleNode("//date_completed")) 
  targetXML.selectSingleNode("//formdata").appendChild(tmpXML.selectSingleNode("//item_status")) 
  if(obj_exists(tmpXML.selectSingleNode("//srtLogNumber"))) then
    targetXML.selectSingleNode("//formdata").appendChild(tmpXML.selectSingleNode("//srtLogNumber")) 
  else
    targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"srtLogNumber","")) 
    targetXML.selectSingleNode("//srtLogNumber").text = log_number
  end if

   
  'response.write(targetXML.xml)
  'response.write(vbcrlf)
  'response.end
    
    
  createFormDataXML session("loginID"), request("formname"), targetXML.xml, nextlognumber, tmpDivision, log_number

next


tmpXML.loadXML(formdata)

sql = "select * from EHD_Data where srtlognumber = "& sqlnum(log_number) &" and division is not null and division <> 'iSRT' and archived = 'n' and active = 'y' and formname = 'iSRT_LogInput'"
set tmprs = conn_asap.execute(sql)
do while not tmprs.eof

  targetXML.loadXML(tmprs("formDataXML"))
  targetLognumber = tmprs("logNumber")
  targetLognumberStr	= string(4-len(targetLognumber),"0")&targetLognumber
  targetDivision	= tmprs("division")
  
  tmpXML.loadXML(formdata)
  
  targetXML.selectSingleNode("//item_description").text = tmpXML.selectSingleNode("//item_description").text
  'targetXML.selectSingleNode("//accountable_leader").text = tmpXML.selectSingleNode("//accountable_leader").text
  
  Set NodeList1 = targetXML.documentElement.selectNodes("//accountable_leader") 
  For Each Node In NodeList1 
    targetXML.documentElement.removeChild(Node)
  Next
  Set NodeList2 = tmpXML.documentElement.selectNodes("//accountable_leader") 
  For Each Node In NodeList2 
    set tmpNode = targetXML.createNode(1,"accountable_leader","")
    tmpNode.text = Node.text
    targetXML.documentElement.appendChild(tmpNode)
  Next
  
  //targetXML.selectSingleNode("//source").text = tmpXML.selectSingleNode("//source").text
  targetXML.selectSingleNode("//date_opened").text = tmpXML.selectSingleNode("//date_opened").text
  targetXML.selectSingleNode("//date_due").text = tmpXML.selectSingleNode("//date_due").text
  targetXML.selectSingleNode("//date_completed").text = tmpXML.selectSingleNode("//date_completed").text
  if(obj_exists(targetXML.selectSingleNode("//item_status"))) then
    targetXML.selectSingleNode("//item_status").text = tmpXML.selectSingleNode("//item_status").text
  else
    targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"item_status",""))      
    targetXML.selectSingleNode("//item_status").text = tmpXML.selectSingleNode("//item_status").text
  end if
  
  createFormDataXML session("loginID"), request("formname"), targetXML.xml, targetLognumber, targetDivision, log_number
  
  tmprs.movenext
loop

tmpXML.loadXML(formdata)

tmpcnt = cint(tmpXML.selectSingleNode("//safety_action_cnt").text)
for b = 1 to tmpcnt
  if(obj_exists(tmpXML.selectSingleNode("//safety_action_division_"& b))) then
  
  
    tmpXML.loadXML(formdata)
  
    targetDivision = tmpXML.selectSingleNode("//safety_action_division_"& b).text
    sql = "select * from EHD_Data where division = "& sqltext2(targetDivision) &" and srtlognumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' and formname = 'iSRT_LogInput'"
    set targetRS = conn_asap.execute(sql)
    if not targetRS.eof then
    
      targetXML.loadXML(targetRS("formDataXML"))
      targetLognumber = targetRS("logNumber")
      targetLognumberStr	= string(4-len(targetLognumber),"0")&targetLognumber
      
      tmpcnt = cint(targetXML.selectSingleNode("//safety_action_cnt").text)
      tmpcnt = tmpcnt +1
      
      targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_nbr_"& tmpcnt,""))  
      targetXML.selectSingleNode("//safety_action_nbr_"& tmpcnt).text = targetLognumberStr &"."& tmpcnt

      targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_"& tmpcnt,""))      
      targetXML.selectSingleNode("//safety_action_"& tmpcnt).text = tmpXML.selectSingleNode("//safety_action_"& b).text
      
      targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_poc_"& tmpcnt,""))      
      targetXML.selectSingleNode("//safety_action_poc_"& tmpcnt).text = tmpXML.selectSingleNode("//safety_action_poc_"& b).text
      
      'targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_poc_email_"& tmpcnt,""))      
      'targetXML.selectSingleNode("//safety_action_poc_email_"& tmpcnt).text = tmpXML.selectSingleNode("//safety_action_poc_email_"& b).text
      
      targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_open_"& tmpcnt,""))      
      targetXML.selectSingleNode("//safety_action_open_"& tmpcnt).text = tmpXML.selectSingleNode("//safety_action_open_"& b).text
      
      targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_due_"& tmpcnt,""))      
      targetXML.selectSingleNode("//safety_action_due_"& tmpcnt).text = tmpXML.selectSingleNode("//safety_action_due_"& b).text
      
      targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_completed_"& tmpcnt,""))      
      targetXML.selectSingleNode("//safety_action_completed_"& tmpcnt).text = tmpXML.selectSingleNode("//safety_action_completed_"& b).text
      
      targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_status_"& tmpcnt,""))      
      targetXML.selectSingleNode("//safety_action_status_"& tmpcnt).text = tmpXML.selectSingleNode("//safety_action_status_"& b).text
      
      'targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_srt_nbr_"& tmpcnt,""))      
      'targetXML.selectSingleNode("//safety_action_srt_nbr_"& tmpcnt).text = log_numberStr &"."& b
      
      targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_other_name_"& tmpcnt,""))
      targetXML.selectSingleNode("//safety_action_other_name_"& tmpcnt).text = tmpXML.selectSingleNode("//safety_action_other_name_"& b).text
      
      targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_other_email_"& tmpcnt,""))
      targetXML.selectSingleNode("//safety_action_other_email_"& tmpcnt).text = tmpXML.selectSingleNode("//safety_action_other_email_"& b).text
      
      targetXML.selectSingleNode("//safety_action_cnt").text = tmpcnt
      
      'response.write(targetXML.xml)
      'response.write(vbcrlf)
      
      sql = "insert into EHD_Item_Map (divisional_item_nbr, srt_item_nbr, division, divisional_log_number, srt_log_number) values ("& sqlnum(tmpcnt) &","& sqlnum(b) &","& sqltext2(targetDivision) &","& sqlnum(targetLognumber) &","& sqlnum(log_number) &")"
      conn_asap.execute(sql)
      
      createFormDataXML session("loginID"), request("formname"), targetXML.xml, targetLognumber, targetDivision, log_number

    end if
  
  end if

next

tmpXML.loadXML(formdata)

tmpcnt = cint(tmpXML.selectSingleNode("//safety_action_cnt").text)
for b = 1 to tmpcnt
  if(obj_exists(tmpXML.selectSingleNode("//safety_action_assigned_division_"& b))) then
  
    tmpXML.loadXML(formdata)
  
    targetDivision = tmpXML.selectSingleNode("//safety_action_assigned_division_"& b).text
    sql = "select * from EHD_Data where division = "& sqltext2(targetDivision) &" and srtlognumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' and formname = 'iSRT_LogInput'"
    set targetRS = conn_asap.execute(sql)
    if not targetRS.eof then
    
      targetXML.loadXML(targetRS("formDataXML"))
      targetLognumber = targetRS("logNumber")
      targetLognumberStr	= string(4-len(targetLognumber),"0")&targetLognumber
      
      sql = "select * from EHD_Item_Map where division = "& sqltext2(targetDivision) &" and srt_log_number = "& sqlnum(log_number) &" and divisional_log_number = "& sqlnum(targetLognumber) &" and srt_item_nbr = "& sqlnum(b)
      set tmprs = conn_asap.execute(sql)
      if not tmprs.eof then
        targetItemNbr = tmprs("divisional_item_nbr")
        
        targetXML.selectSingleNode("//safety_action_"& targetItemNbr).text = tmpXML.selectSingleNode("//safety_action_"& b).text
        targetXML.selectSingleNode("//safety_action_poc_"& targetItemNbr).text = tmpXML.selectSingleNode("//safety_action_poc_"& b).text
        'targetXML.selectSingleNode("//safety_action_poc_email_"& targetItemNbr).text = tmpXML.selectSingleNode("//safety_action_poc_email_"& b).text
        targetXML.selectSingleNode("//safety_action_open_"& targetItemNbr).text = tmpXML.selectSingleNode("//safety_action_open_"& b).text
        targetXML.selectSingleNode("//safety_action_due_"& targetItemNbr).text = tmpXML.selectSingleNode("//safety_action_due_"& b).text
        targetXML.selectSingleNode("//safety_action_completed_"& targetItemNbr).text = tmpXML.selectSingleNode("//safety_action_completed_"& b).text
        targetXML.selectSingleNode("//safety_action_status_"& targetItemNbr).text = tmpXML.selectSingleNode("//safety_action_status_"& b).text
        
        if(obj_exists(targetXML.selectSingleNode("//safety_action_other_name_"& targetItemNbr))) then
          targetXML.selectSingleNode("//safety_action_other_name_"& targetItemNbr).text = tmpXML.selectSingleNode("//safety_action_other_name_"& b).text
        else
          targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_other_name_"& targetItemNbr,""))
          targetXML.selectSingleNode("//safety_action_other_name_"& targetItemNbr).text = tmpXML.selectSingleNode("//safety_action_other_name_"& b).text
        end if
        
        if(obj_exists(targetXML.selectSingleNode("//safety_action_other_email_"& targetItemNbr))) then
          targetXML.selectSingleNode("//safety_action_other_email_"& targetItemNbr).text = tmpXML.selectSingleNode("//safety_action_other_email_"& b).text
        else
          targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_other_email_"& targetItemNbr,""))
          targetXML.selectSingleNode("//safety_action_other_email_"& targetItemNbr).text = tmpXML.selectSingleNode("//safety_action_other_email_"& b).text
        end if

        createFormDataXML session("loginID"), request("formname"), targetXML.xml, targetLognumber, targetDivision, log_number
      
      end if

    end if
  
  end if

next

%>
