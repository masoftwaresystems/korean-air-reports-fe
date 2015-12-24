<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/commonUtils.inc" -->
<!--#include file="includes/security.inc" -->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<%
log_number		= request("log_number")
viewDivision	= request("viewDivision")

log_number		= string(4-len(log_number),"0")&log_number

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

strDate = yr & mon & d & hr & min & sec

sql = "select hazard_base, hazard_type, hazard_number from EHD_Data where formname = 'iSRT_LogInput' and division = "& sqltext2(viewDivision) &" and divisionalLogNumber = "& sqlnum(log_number) &" and active = 'y'"
'response.write(sql)
'response.end
set tmprs=conn_asap.execute(sql)
if not tmprs.eof then
  hazard_base = tmprs("hazard_base")
  hazard_type = tmprs("hazard_type")
  if(isnull(tmprs("hazard_number"))) then
    hazard_number = 0
  else
    hazard_number = cint(tmprs("hazard_number"))
  end if
end if

hazard_number = string(4-len(hazard_number),"0") & hazard_number
hazard_id = viewDivision &"-"& hazard_number

%>
	<section id="secondary_bar">
<!--#include file="includes/logged_in_user.inc"-->

		<div class="breadcrumbs_container">
			<article class="breadcrumbs"><a href="http://www.masoftwaresystems.us/miat/splash.aspx">Action Log</a> <div class="breadcrumb_divider"></div> <a class="current">Attachments</a></article>
		</div>
	</section><!-- end of secondary bar -->

<!--#include file="includes/sms_header3.inc"-->
<br/><br/>

<form action="divisional_saveFile2.asp" method="post" name="frm" id="frm" enctype="multipart/form-data" >

<input type="hidden" id="log_number" name="log_number" value="<%= log_number %>">
<input type="hidden" id="viewDivision" name="viewDivision" value="<%= viewDivision %>">
<input type="hidden" id="strDate" name="strDate" value="<%= strDate %>">

<article class="module width_full">
<div class="module_content">
<h3>Attachments: Hazard ID <%= hazard_id %></h3>

<table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:0px;">
<%
set lXML					= CreateObject("Microsoft.XMLDOM")
lXML.async					= false
sql = "select * from EHD_Comments where EHD_Comments.division = "& sqltext2(viewdivision) &" and log_number = "& sqlnum(log_number) &" and comment_type = 'attachments' order by recid desc"
set tmprs = conn_asap.execute(sql)
do while not tmprs.eof
  lXML.loadXML(tmprs("item_commentXML"))
  if(len(tmprs("comment_date")) > 0) then
    tmpdateArr = split(tmprs("comment_date"))
    tmpdateStr = tmpdateArr(0) &" "& tmpdateArr(2)
  end if
%>
  <tr>
    <td align="right" width="40%"></td>
    <td align="left" width="60%" style="font-size:11px;"><input type="button" value="delete" style="font-size:9px;width:50px;margin-right:5px;" onclick="document.location='divisional_deleteFile.asp?recid=<%= tmprs("recid") %>&log_number=<%= log_number %>&viewDivision=<%= viewDivision %>'"><b><span decode>&middot; <%= selectNode(lXML,"link","") %></span></b></td>
  </tr>
<br/>
<%
  tmprs.movenext
loop
%>
</table>

<table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:30px;">
  <tr>
    <td align="right" width="40%"><span class="fonts1" style="padding-right:5px;">Select File : </span></td>
    <td align="left" width="60%"><input name="filename" id="filename" type="file" class="input1" style="width:400px;"></td>
  </tr>
  <tr>
    <td align="right" ><span class="fonts1" style="padding-right:5px;">&nbsp;</span></td>
    <td align="left" ><input type="submit" value="Upload Attachment" style="font-size:10px;width:165px;margin-top:5px;margin-left:0px;" ><input type="button" value="Return To Log Input" style="font-size:10px;width:165px;margin-top:5px;margin-left:0px;" onclick="document.location='divisional_LogInput2.aspx?log_number=<%= log_number %>&viewDivision=<%= viewDivision %>'"><br><input type="button" value="Return To Short Listing" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-top:3px;" onclick="document.location='divisional_base.aspx?viewdivision=<%= viewdivision %>'"><!-- <input type="button" value="Return To Action Log" style="font-size:10px;width:165px;margin-top:1px;margin-left:0px;" onclick="document.location='divisional_LogDisplay.aspx?viewDivision=<%= viewDivision %>&position=<%= request("cookie_position") %>'"> --></td>
  </tr>
</table>
    </div>
    </article>

</form>


<p></p>



