<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include virtual ="/global_includes/emailUtils.inc"-->
<!--#include file ="includes/wrapformdata2.inc"-->
<%
tmplinks		= request("links")
log_number		= request("log_number")
viewDivision	= request("viewDivision")
position = request("position")

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

divisionArr		= split(request("division"),",")

sql = "delete from SRT_LogNumberDivisions where log_number = "& sqlnum(log_number) &" and division2 = "& sqltext2(viewDivision) &" and archived = 'n'"
conn_asap.execute(sql)

for a = 0 to ubound(divisionArr)

  sql = "insert into SRT_LogNumberDivisions (log_number, division, division2) values ("& sqlnum(log_number) &","& sqltext2(trim(divisionArr(a))) &","& sqltext2(viewDivision) &")"
  conn_asap.execute(sql)

next

sql = "select * from EHD_Data where lognumber = "& sqlnum(log_number) &" and division is not null and division = "& sqltext2(viewDivision) &" and srtlognumber is not null and archived = 'n' and active = 'y' and formname = 'iSRT_LogInput' "
set tmprs = conn_asap.execute(sql)
if not tmprs.eof then

  set tmpXML		= CreateObject("Microsoft.XMLDOM")
  tmpXML.async		= false

  tmpXML.loadXML(tmprs("formDataXML"))

  srtlognumberStr	= string(4-len(srtlognumber),"0")&srtlognumber

  sql = "select * from EHD_Data where srtlognumber = "& sqlnum(srtlognumber) &" and division = 'EH:DIV' and archived = 'n' and active = 'y' and formname = 'iSRT_LogInput'"
  set tmprs2 = conn_asap.execute(sql)
  if not tmprs2.eof then

    set targetXML		= CreateObject("Microsoft.XMLDOM")
    targetXML.async		= false

    targetXML.loadXML(tmprs2("formDataXML"))

    tmpcnt = cint(tmpXML.selectSingleNode("//safety_action_cnt").text)
    if(tmpcnt > 0) then
      for a = 1 to tmpcnt

        sql = "select * from EHD_Item_Map where srt_log_number = "& sqlnum(srtlognumber) &" and divisional_log_number = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and divisional_item_nbr = "& sqlnum(a)
        set tmprs3 = conn_asap.execute(sql)
        if (not tmprs3.eof) then
          srtitemnumber = tmprs3("srt_item_nbr")

          targetXML.selectSingleNode("//safety_action_"& srtitemnumber).text = tmpXML.selectSingleNode("//safety_action_"& a).text

          if(obj_exists(targetXML.selectSingleNode("//safety_action_poc_"& srtitemnumber)) and obj_exists(tmpXML.selectSingleNode("//safety_action_poc_"& a))) then
            targetXML.selectSingleNode("//safety_action_poc_"& srtitemnumber).text = tmpXML.selectSingleNode("//safety_action_poc_"& a).text
          end if

          if(obj_exists(targetXML.selectSingleNode("//safety_action_poc_email_"& srtitemnumber)) and obj_exists(tmpXML.selectSingleNode("//safety_action_poc_email_"& a))) then
            targetXML.selectSingleNode("//safety_action_poc_email_"& srtitemnumber).text = tmpXML.selectSingleNode("//safety_action_poc_email_"& a).text
          end if

          targetXML.selectSingleNode("//safety_action_open_"& srtitemnumber).text = tmpXML.selectSingleNode("//safety_action_open_"& a).text
          targetXML.selectSingleNode("//safety_action_due_"& srtitemnumber).text = tmpXML.selectSingleNode("//safety_action_due_"& a).text
          targetXML.selectSingleNode("//safety_action_completed_"& srtitemnumber).text = tmpXML.selectSingleNode("//safety_action_completed_"& a).text
          targetXML.selectSingleNode("//safety_action_status_"& srtitemnumber).text = tmpXML.selectSingleNode("//safety_action_status_"& a).text

        else

          tmpcnt2 = cint(targetXML.selectSingleNode("//safety_action_cnt").text)
          tmpcnt2 = tmpcnt2 +1

          targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_nbr_"& tmpcnt2,""))
          targetXML.selectSingleNode("//safety_action_nbr_"& tmpcnt2).text = srtlognumberStr &"."& tmpcnt2

          targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_"& tmpcnt2,""))
          targetXML.selectSingleNode("//safety_action_"& tmpcnt2).text = tmpXML.selectSingleNode("//safety_action_"& a).text

          targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_poc_"& tmpcnt2,""))
          targetXML.selectSingleNode("//safety_action_poc_"& tmpcnt2).text = tmpXML.selectSingleNode("//safety_action_poc_"& a).text

          targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_poc_email_"& tmpcnt2,""))
          if(obj_exists(targetXML.selectSingleNode("//safety_action_poc_email_"& tmpcnt2)) and obj_exists(tmpXML.selectSingleNode("//safety_action_poc_email_"& a))) then
            targetXML.selectSingleNode("//safety_action_poc_email_"& tmpcnt2).text = tmpXML.selectSingleNode("//safety_action_poc_email_"& a).text
          end if

          targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_open_"& tmpcnt2,""))
          targetXML.selectSingleNode("//safety_action_open_"& tmpcnt2).text = tmpXML.selectSingleNode("//safety_action_open_"& a).text

	      targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_due_"& tmpcnt2,""))
          targetXML.selectSingleNode("//safety_action_due_"& tmpcnt2).text = tmpXML.selectSingleNode("//safety_action_due_"& a).text

          targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_completed_"& tmpcnt2,""))
          targetXML.selectSingleNode("//safety_action_completed_"& tmpcnt2).text = tmpXML.selectSingleNode("//safety_action_completed_"& a).text

          targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_status_"& tmpcnt2,""))
          targetXML.selectSingleNode("//safety_action_status_"& tmpcnt2).text = tmpXML.selectSingleNode("//safety_action_status_"& a).text

          'targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_srt_nbr_"& tmpcnt2,""))
          'targetXML.selectSingleNode("//safety_action_srt_nbr_"& tmpcnt2).text = log_numberStr &"."& a

          targetXML.selectSingleNode("//formdata").appendChild(targetXML.createNode(1,"safety_action_division_"& tmpcnt2,""))
          targetXML.selectSingleNode("//safety_action_division_"& tmpcnt2).text = viewDivision

          targetXML.selectSingleNode("//safety_action_cnt").text = tmpcnt2

          sql = "delete from EHD_Item_Map where division = "& sqltext2(viewDivision) &" and divisional_log_number = "& sqlnum(log_number) &" and divisional_item_nbr = "& sqlnum(a)
          conn_asap.execute(sql)

          sql = "insert into EHD_Item_Map (divisional_item_nbr, srt_item_nbr, division, divisional_log_number, srt_log_number) values ("& sqlnum(a) &","& sqlnum(tmpcnt2) &","& sqltext2(viewDivision) &","& sqlnum(log_number) &","& sqlnum(srtlognumber) &")"
          conn_asap.execute(sql)

        end if

      next

    end if

    createFormDataXML session("loginID"), request("formname"), targetXML.xml, srtlognumber, "EH:DIV", srtlognumber

  end if

end if

%>
<%
' copy to base used to be right here

pageArg = "?position="& position &"&log_number="& log_number &"&viewDivision="& viewDivision


response.redirect request("resultPage") & pageArg
response.end
%>
