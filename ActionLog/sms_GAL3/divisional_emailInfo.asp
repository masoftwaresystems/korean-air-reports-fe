<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<%
log_number			= request("log_number")
log_numberStr		= string(4-len(log_number),"0")&log_number
viewDivision		= request("viewDivision")

sql = "select logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'iSRT_LogInput' and divisionalLogNumber = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and active = 'y' and archived = 'n' order by recid desc"
'response.write(sql)
'response.end
set rs = conn_asap.execute(sql)

if not rs.eof then
  set oXML					= CreateObject("Microsoft.XMLDOM")
  oXML.async				= false

  oXML.loadXML(rs("formDataXML"))

  safety_action_cnt			= selectNode(oXML,"safety_action_cnt","")
  'log_number				= selectNode(oXML,"log_number","")
  item_description			= rev_xdata2(selectNode(oXML,"item_description",""))
  accountable_leader		= selectNode(oXML,"accountable_leader","")
  source					= selectNode(oXML,"source","")
  date_opened				= selectNode(oXML,"date_opened","")
  date_due					= selectNode(oXML,"date_due","")
  date_completed			= selectNode(oXML,"date_completed","")
  item_status				= selectNode(oXML,"item_status","")

  hazard_base         = selectNode(oXML,"hazard_base","")
  hazard_type         = selectNode(oXML,"hazard_type","")
  hazard_number         = selectNode(oXML,"hazard_number","")

  hazard_number = string(4-len(hazard_number),"0") & hazard_number
  hazard_id = viewDivision &"-"& hazard_number

end if


%>

<html><head>
<!--#include file ="includes/commonhead.inc"-->
<title></title>
<script type="text/javascript">
    function isEmpty(str) {
	// Check whether string is empty.
	for (var intLoop = 0; intLoop < str.length; intLoop++)
	    if (" " != str.charAt(intLoop))
		return false;
	return true;
    }

    function checkRequired() {
	f = frm;
	var strError = "";
	for (var intLoop = 0; intLoop < f.elements.length; intLoop++)
	    if (null!=f.elements[intLoop].getAttribute("required"))
		if (isEmpty(f.elements[intLoop].value))
		    strError += "  " + f.elements[intLoop].name + "\n";
		if ("" != strError) {
		    alert("Required data is missing:\n" + strError);
		} else {
		    f.submit();
		}
    }

</script>
<style>
body{
font-family:arial;
font-size:8pt;
}
input{
font-size:8pt;
}
th{
font-size:8pt;
border-width:1;
border-color:black;
border-style:solid;
}
td{
font-size:8pt;
}
td.left{
border-width:1;
border-color:black;
border-left-style:solid;
}
td.right{
border-width:1;
border-color:black;
border-right-style:solid;
}
td.bottom{
border-width:1;
border-color:black;
border-bottom-style:solid;
}
td.top{
border-width:1;
border-color:black;
border-top-style:solid;
}

p{
margin:0;
}

.text {
width:250pt;
}

               @media print{
               body{ background-color:#FFFFFF; background-image:none; color:#000000 }
               #ad{ display:none;}
               #leftbar{ display:none;}
               #contentarea{ width:100%;}
               .hideprint{ display:none;}

</style>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
<!--#include file="script/nav.js"-->
    <% ' {{{ script %>
    <script type="text/javascript">
<!--#include file="script/display.asp"-->
    </script>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
<!--#include file="script/nav.js"-->
</head>
<body bgColor="#ffffff" topmargin="3pt" bottommargin="3pt" leftmargin="3pt" rightmargin="3pt">
      <div id="headerDiv">
<!--#include file="includes/sms_header.inc"-->
      </div>
<center>
<form action="divisional_doEmail.asp" method="post" name="frm" id="frm">
<input type="hidden" name="log_number" value="<%= request("log_number") %>">
<input type="hidden" name="viewDivision" value="<%= request("viewDivision") %>">
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:20px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:14px;color:#737579;"><span style="font-weight:bold;">Hazard ID <%= hazard_id %></span></span></td></tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pgrey.gif" width="300" height="1"></td></tr>
</table>

<table border="0" cellspacing="5" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">To :</span></td>
    <td width="60%" align="left"><input type="text" class="input6" name="email_to" style="width:300px;" value=""></td>
  </tr>

  <!--
  <tr>
      <td width="40%" align="right"><span class="fonts1" style="color:#737579;">&nbsp;</span></td>
      <td width="60%" align="left"><span class="fonts1" style="color:#737579;">Separate email addresses with commas.</span></td>
  </tr>
  -->

  <tr>
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Subject :</span></td>
    <td width="60%" align="left">

    <input type="text" class="input6" name="email_subject" style="width:300px;" value="Hazard ID <%= hazard_id %>". readonly />

    </td>
  </tr>
  <tr valign="top">
      <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Description :</span></td>
      <td width="60%" align="left"><textarea class="input6" name="email_item_description" style="width:300px;" rows="5" . readonly /><%= item_description %></textarea></td>
  </tr>
  <tr valign="top">
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Additional Information :</span></td>
    <td width="60%" align="left"><textarea class="input6" style="width:300px;" name="email_additionalinfo" rows="5"></textarea></td>
  </tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:3px;margin-left:10px;">
<%
acnt = 0
sql = "select * from EHD_Attachments where log_number = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and archived = 'n' order by recid desc"
set rs = conn_asap.execute(sql)
do while not rs.eof
  file_name		= rs("file_name")
  recid			= rs("recid")

  acnt = acnt +1
%>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;"><% if(acnt = 1) then %>Attachments:&nbsp;<% end if %></span></td>
    <td width="60%" align="left"><input type="checkbox" value="<%= recid %>" name="attachments" checked><span class="fonts1" style="padding-right:5px;"><a target="_blank" href="retrieveFile.asp?recid=<%= recid %>"><%= file_name %></a></span></td>
  </tr>
<%
  rs.movenext
loop
%>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:25px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pblack.gif" width="400" height="1"></td></tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="margin-top:15px;margin-left:10px;" bgColor="white" >
  <tr>
    <td width="100%" align="center">
      <input type="button" value="Send Email" class="button1" style="font-weight:normal;font-size:10px;width:150;" onclick="checkRequired()"> <input type="button" value="Return To Log Input" class="button1" style="font-weight:normal;font-size:10px;width:150;" onclick="document.location='divisional_LogInput.asp?log_number=<%= log_number %>&viewDivision=<%= viewDivision %>'"><br><input type="button" value="Return To Short Listing" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-top:3px;" onclick="document.location='divisional_base.asp?viewdivision=<%= viewdivision %>'">
    </td>
  </tr>
  <tr>
    <td width="100%" align="center" height="50"></td>
  </tr>
</table>

</form>

<!--#include file ="includes/footer.inc"-->
</body>
</html>
