<%
'###############################################
'#
'# adminDisplay.asp
'#
'# Retired
'#
%>
<!--#include file="includes/security.inc" -->
<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<% unlockLogs %>
<%
position = request("position")
if(position = "") then
  startpos = 0
else
  startpos = cint(position)
  if(cint(position) > 0) then
    prevpos = startpos -10
  end if
end if


overflow = request("overflow")
if(overflow = "y") then
  buttonText = "Browser-Friendly"
else
  buttonText = "Printer-Friendly"
end if

filterSelect = request("filterSelect")
searchVal = request("searchVal")
searchType = request("searchType")
divisionSelect = request("divisionSelect")

if(filterSelect = "") then
  filterSelect = "all"
end if
if(divisionSelect = "") then
  divisionSelect = "All"
end if
%>
<html><head>
<!--#include file ="includes/commonhead.inc"-->
<title></title>
<script type="text/javascript">
    var overflow = "<%= overflow %>";
    function printPage() {
	<% if(overflow = "y") then %>
	if(document.all) {
	    document.all.divButtons.style.visibility = 'hidden';
	    //window.print();
	    document.all.divButtons.style.visibility = 'visible';
	} else {
	    document.getElementById('divButtons').style.visibility = 'hidden';
	    //window.print();
	    document.getElementById('divButtons').style.visibility = 'visible';
	}
	<% else %>
	document.location = "adminDisplay.asp?overflow=y&searchVal=<%= searchVal %>&filterSelect=<%= filterSelect %>&divisionSelect=<%= divisionSelect %>";
	<% end if %>
    }
    function printPage2() {
	<% if(overflow = "y") then %>
	//window.print(); orientation='landscape'
	<% else %>
	window.open ("adminDisplay.asp?overflow=y&searchVal=<%= searchVal %>&filterSelect=<%= filterSelect %>&divisionSelect=<%= divisionSelect %>","printwindow");
	<% end if %>
    }
    <% if(overflow = "y") then %>
    printPage2();
    <% end if %>
    function printPage3() {
	window.print(); orientation='landscape';
    }
    function switchView() {
	if(overflow != "y") {
	   document.location = "adminDisplay.asp?overflow=y&searchVal=<%= searchVal %>&filterSelect=<%= filterSelect %>&divisionSelect=<%= divisionSelect %>";
	} else {
	    document.location = "adminDisplay.asp?searchVal=<%= searchVal %>&filterSelect=<%= filterSelect %>&divisionSelect=<%= divisionSelect %>";
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


.c0c0c0 {
    font-weight: bold;
    font-size: 8pt;
    font-style: normal;
    font-family: Arial;
    background-color: #c0c0c0;
}

.ffffff {
    font-weight: normal;
    font-size: 8pt;
    font-style: normal;
    font-family: Arial;
    background-color: #ffffff;
}
</style>

<style type="text/css">
A.h:link {text-decoration: none}
A.h:visited {text-decoration: none}
A.h:active {text-decoration: none}
A.h:hover {text-decoration: underline; color: navy; cursor: hand;}
</style>

<script>
function getDaysBetween(d1,d2) {
  var currNode;
  xmlhttpSvc.async = false;
  xmlhttpSvc.resolveExternals = false;
  xmlhttpSvc.load("/ets/acvbusers/getDefaults.asp?eventID=<%= eventid %>");
  currNode = xmlhttpSvc.selectSingleNode("//p.<%= a %>");

  document.frm.percentage_<%= a %>.value = currNode.text;
}
function setRowColor(row, color) {
  cells = row.getElementsByTagName('td');
  for(a=0; a < 12; a++) {
   // alert(color);
    cells[a].setAttribute('bgcolor', color, 0);
  }
}
function newWindow(url) {
    var day = new Date();
    var id = day.getTime();
    var win = open(url,id,'width=600,height=200,scrollbars,resizable');
}
function doSearch() {
  document.location = "adminDisplay.asp?searchVal="+ document.getElementById("searchVal").value +"&filterSelect=<%= filterSelect %>&divisionSelect=<%= divisionSelect %>&overflow=<%= overflow %>";
}

function doFilter() {
  document.location = "adminDisplay.asp?searchVal=<%= searchVal %>&filterSelect="+ document.getElementById("filterSelect").value +"&divisionSelect=<%= divisionSelect %>&overflow=<%= overflow %>";
}

function doDivision() {
  document.location = "adminDisplay.asp?searchVal=<%= searchVal %>&filterSelect=<%= filterSelect %>&divisionSelect="+ document.getElementById("divisionSelect").value +"&overflow=<%= overflow %>";
}

function toggleSearches(v) {
  if(v == "advanced") {
    //alert("advanced");
    document.getElementById("advancedSearchDIV").style.display = "block";
    document.getElementById("advancedsearchSPAN").style.display = "block";
    document.getElementById("basicsearchSPAN").style.display = "none";
  }
  if(v == "basic") {
    //alert("basic");
    document.getElementById("advancedSearchDIV").style.display = "none";
    document.getElementById("advancedsearchSPAN").style.display = "none";
    document.getElementById("basicsearchSPAN").style.display = "block";
  }
}
</script>
</head>
<body bottomMargin="3" bgColor="#ffffff" leftMargin="3" topMargin="3" rightMargin="3">
<center>
<!--#include file ="includes/srt_header.inc"-->

<div class="tableContainer">
<table style="BORDER-RIGHT: 1px; PADDING-RIGHT: 3px; BORDER-TOP: 1px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; BORDER-LEFT: 1px; PADDING-TOP: 3px; BORDER-BOTTOM: 1px; BACKGROUND-COLOR: #ffffff; margin-bottom: 3px;" border="0" cellSpacing="0" cellPadding="1" width="100%">
<tr valign="bottom" >
<td style="FONT-WEIGHT: normal; FONT-SIZE: 14pt; COLOR: #000040; FONT-FAMILY: Arial;padding-left:10px;" align="left" width="50%" background="" bgColor="#ffffff">
<span id="basicsearchSPAN" class="hideprint">
<input type="text" name="searchVal" id="searchVal" <% if(searchVal <> "") then %>value="<%= searchVal %>"<% end if %> style="border:1px solid black;width:80px;font-size:10px;"><input type="button" value="Search" onclick="doSearch()" style="width:45px;">
<select id="filterSelect" name="filterSelect" value="filterSelect" style="border:1px solid black;width:80px;font-size:10px;margin-left:5px;">
<option value="all">All</option>
<option value="open">Open</option>
<option value="closed">Closed</option>
</select><input type="button" value="Status" onclick="doFilter()" style="width:45px;">
<% if(filterSelect <> "") then %>
<script>
document.getElementById("filterSelect").value = "<%= filterSelect %>";
</script>
<% end if  %>
<select id="divisionSelect" name="divisionSelect" value="divisionSelect" style="border:1px solid black;width:80px;font-size:10px;margin-left:5px;">
              <option value="All">All</option>
              <option value="ACS">ACS</option>
              <option value="CGO">CGO</option>
              <option value="FOP">FOP</option>
              <option value="IFS">IFS</option>
              <option value="OCC">OCC</option>
              <option value="TOP">TOP</option>
</select><input type="button" value="Division" onclick="doDivision()" style="width:45px;">
<% if(divisionSelect <> "") then %>
<script>
document.getElementById("divisionSelect").value = "<%= divisionSelect %>";
</script>
<% end if  %>
<span style="FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: #000040; FONT-FAMILY: Arial;padding-left:8px;"><!-- [<a onclick2="newWindow('filter.asp');" href="javascript:toggleSearches('advanced')" class="h"> Advanced Filter </a>]  --></span>
</span>
<span id="advancedsearchSPAN" style="display:none;">
<span style="FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: #000040; FONT-FAMILY: Arial;padding-left:8px;">[<a href="javascript:toggleSearches('basic')" onclick2="newWindow('filter.asp');" class="h"> Basic Filter </a>]</span>
</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: #000040; FONT-FAMILY: Arial" align="right" width="50%" background="" bgColor="#ffffff">
<span class="hideprint">
<div id="divButtons" name="divButtons">
<input type="button" value="Print" onclick="printPage3()" style="width:120px;font:bold 11px verdana;color:black;background-color:#FFFFFF;" /><input type="button" value="<%= buttonText %>" onclick="switchView()" style="width:120px;font:bold 11px verdana;color:black;background-color:#FFFFFF;" />
<input type="button" value="Refresh Locks" onclick="window.location.reload(true);" style="width:120px;font:bold 11px verdana;color:black;background-color:#FFFFFF;" />
</div></span>
</td>
</tr>
</table>

	<div id="advancedSearchDIV" bgcolor="#ffffff" align="left" style="padding-left:0px;display:none;">
	    <form method="post" action="adminDisplay.asp">
	    <input type="hidden" name="searchType" id="Adv_searchType" value="<%= request("Adv_searchType") %>" >
	    <input type="hidden" name="position" id="Adv_position" value="<%= request("Adv_position") %>" >
	    <input type="hidden" name="overflow" id="Adv_overflow" value="<%= request("Adv_overflow") %>" >
	    <table cellspacing="0" cellpadding="1" width="100%" border="0" style="margin-bottom:0px;margin-left:10px;">
	      <tr><td style="border-top:1px solid black;">&nbsp;</td></tr>
	    <table>
		<table cellspacing="0" cellpadding="1" width="370" border="0" style="margin-bottom:3px;">
		    <tr>
			<td style="font-weight:normal;font-size:8pt;font-family:Arial" align="right" width="20%" bgcolor="#ffffff">Search by:</td>
			<td style="font-weight:normal;font-size:8pt;font-family:Arial" align="left" width="8%" bgcolor="#ffffff">
			    <select name="srt_searchfield1" style="border:1px solid black;width:150px;font-size:10px;">
				<option value=""></option>
				<option value="log_number">Log Nbr.</option>
				<option value="item_description">Description</option>
				<option value="division">Division</option>
				<option value="accountable_leader">Accountable Leader</option>
				<option value="risk_value_mitigation">Risk Value</option>
				<option value="source">Source</option>
				<option value="date_opened">Date Opened</option>
				<option value="date_completed">Date Completed</option>
				<option value="item_status">Status</option>
			    </select>
			</td>
			<td><input type="text" name="srt_searchvalue1" size="50" width="70%" value="<%= request("srt_searchvalue1")  %>" style="border:1px solid black;width:150px;font-size:10px;"></td>
		    </tr>
		    <tr>
			<td align="right" width="15%">
			    <select name="srt_boolean2" style="border:1px solid black;font-size:10px;width:55px;">
				<option value="And">And</option>
				<option value="Or">Or</option>
			    </select>
			</td>
			<td style="font-weight:normal;font-size:8pt;font-family:Arial" align="left" width="8%" bgcolor="#ffffff">
			    <select name="srt_searchfield2" style="border:1px solid black;width:150px;font-size:10px;">
				<option value=""></option>
				<option value="log_number">Log Nbr.</option>
				<option value="item_description">Description</option>
				<option value="division">Division</option>
				<option value="accountable_leader">Accountable Leader</option>
				<option value="risk_value_pre_mitigation">Risk Value Pre.</option>
				<option value="risk_value_post_mitigation">Risk Value post.</option>
				<option value="source">Source</option>
				<option value="date_opened">Date Opened</option>
				<option value="date_completed">Date Completed</option>
				<option value="item_status">Status</option>
			    </select>
			</td>
			<td><input type="text" name="srt_searchvalue2" size="50" maxlength="100" value="<%= request("srt_searchvalue2")  %>" style="border:1px solid black;width:150px;font-size:10px;"></td>
		    </tr>
		</table>
		<input type="submit" value="Search" style="margin-left:10px;" />
		<script>
		document.getElementById("srt_searchfield1").value = "<%= request("srt_searchfield1") %>";
		document.getElementById("srt_searchvalue1").value = "<%= request("srt_searchvalue1") %>";
		<% if(srt_boolean2 <> "") then %>
		document.getElementById("srt_boolean2").value = "<%= request("srt_boolean2") %>";
		<% end if %>
		document.getElementById("srt_searchfield2").value = "<%= request("srt_searchfield2") %>";
		document.getElementById("srt_searchvalue2").value = "<%= request("srt_searchvalue2") %>";
		</script>
	    </form>
	</div>

<%

sql = "select srtlognumber, logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'iSRT_LogInput' and archived = 'n' and active = 'y' and divisionalLogNumber is null order by logNumber desc, recid desc"
set rs = conn_asap.execute(sql)

%>

<form name="frm" id="frm" action="adminDisplay.asp" method="post">

<table cellSpacing="0" cellPadding="1" width="100%" border="0">
<tbody>
<tr>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="5%" align="center" vAlign="top">iSRT Log Nbr.</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="20%" align="center" vAlign="top">Description</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="5%" align="center" vAlign="top">Divisional<br>Log Nbr.</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="8%" align="center" vAlign="top">Accountable Leader</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="8%" align="center" vAlign="top">Risk Value</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="5%" align="center" vAlign="top">Source</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="6%" align="center" vAlign="top">Date Opened</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="6%" align="center" vAlign="top">Date Due</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="6%" align="center" vAlign="top">Date Completed</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="4%" align="center" vAlign="top">Days</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="5%" align="center" vAlign="top">Status</td>
</tr>
<% if(overflow <> "y") then %>
</tbody>
</table>
<div style="height:370px;overflow:auto;">
<table cellSpacing="0" cellPadding="1" width="100%" border="0">
<tbody>
<% end if %>
<tr>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="5%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="20%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="5%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="8%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="8%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="5%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="6%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="6%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="6%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="4%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="000040" selected="true" colSpan="1" width="5%" align="center" vAlign="top"></td>
</tr>
<%
  set oXML					= CreateObject("Microsoft.XMLDOM")
  oXML.async				= false
  set oXML2					= CreateObject("Microsoft.XMLDOM")
  oXML2.async				= false

  tmpLogNumber = ""
  firstOne = "y"

  currpos = 0
  recsshown = 0

  'response.write("<tr><td colspan='11'>startpos:"& startpos &"<br></td></tr>")

  do while not rs.eof

  searchHit = 0

  'response.write("<tr><td colspan='11'>currpos:"& currpos &"<br></td></tr>")


  loginID					= rs("loginID")
  createDate				= rs("createDate")
  formDataXML				= rs("formDataXML")
  recid						= rs("recid")
  viewDivision					= rs("viewDivision")

  srtlognumber				= rs("srtlognumber")
  log_number				= srtlognumber
  if(len(log_number) > 0) then
    log_numberStr				= string(4-len(log_number),"0")&log_number
  end if

  oXML.loadXML(formDataXML)

  safety_action_cnt			= selectNode(oXML,"safety_action_cnt","")
  'log_number				= selectNode(oXML,"log_number","")
  item_description			= rev_xdata2(selectNode(oXML,"item_description",""))
  accountable_leader		= rev_xdata2(selectNode(oXML,"accountable_leader",""))
  source					= rev_xdata2(selectNode(oXML,"source",""))
  date_opened				= selectNode(oXML,"date_opened","")
  date_due					= selectNode(oXML,"date_due","")
  date_completed			= selectNode(oXML,"date_completed","")
  item_status				= selectNode(oXML,"item_status","")

  item_description			= replace(item_description,vbcrlf,"<br>")

  tmpCnt					= cint(safety_action_cnt)

  filterHit = 1
  searchHit = 1
  divisionHit = 1

  if(searchType = "advanced") then

		'srt_searchfield1		= request("srt_searchfield1")
		'srt_searchvalue1		= request("srt_searchvalue1")
		'srt_boolean2			= request("srt_boolean2")
		'srt_searchfield2		= request("srt_searchfield2")
		'srt_searchvalue2		= request("srt_searchvalue2")

  else

  if(filterSelect <> "") then

    if(filterSelect = "all") then
      filterHit = 1
    else
      if(lcase(item_status) = lcase(filterSelect)) then
        filterHit = 1
      else
        filterHit = 0
      end if
    end if
  end if

  if(searchVal <> "") then
    tmpsearchVal = replace(searchVal,"""","")
    if(instr(lcase(formDataXML),lcase(tmpsearchVal)) > 0) then
      searchHit = 1
    else
      searchHit = 0
    end if
  end if

  if(divisionSelect <> "All") then
    sql = "select recid from SRT_LogNumberDivisions where log_number = "& sqlnum(log_number) &" and archived = 'n' and division = "& sqltext2(divisionSelect)
    set drs = conn_asap.execute(sql)
    if not drs.eof then
      divisionHit = 1
    else
      divisionHit = 0
    end if
  end if

  end if

  if((searchHit = 1) and (filterHit = 1) and (divisionHit = 1)) then

  skiprec = "n"
  currpos = currpos +1
  if(startpos > 0) then
    if(startpos >= currpos) then
      skiprec = "y"
    end if
  end if

  if((skiprec <> "y") or (overflow = "y")) then

  'response.write("<tr><td colspan='11'>skiprec:"& skiprec &"<br></td></tr>")
  'response.write("<tr><td colspan='11'>recsshown:"& recsshown &"<br></td></tr>")

  recsshown = recsshown +1
  if((recsshown = 11) and (overflow <> "y")) then
    currpos = currpos -1
    exit do
  end if

  curr_risk = ""


  sql = "select logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data where formname = 'risk' and logNumber = "& sqlnum(log_number) &" and archived = 'n' and active = 'y' order by logNumber desc, recid desc"
  set rs2 = conn_asap.execute(sql)
  if not rs2.eof then
    formDataXML2				= rs2("formDataXML")
    oXML2.loadXML(formDataXML2)

    risk_value_pre_mitigation		= selectNode(oXML2,"risk_value_pre_mitigation","")
    risk_value_post_mitigation		= selectNode(oXML2,"risk_value_post_mitigation","")

    if(risk_value_post_mitigation <> "") then
      curr_risk = risk_value_post_mitigation
    else
      curr_risk = risk_value_pre_mitigation
    end if

  end if

  divisionStr = ""
  sql = "select division, recid from SRT_LogNumberDivisions where log_number = "& sqlnum(log_number) &" and archived = 'n' order by division asc"
  set rs3 = conn_asap.execute(sql)
  do while not rs3.eof
    division				= rs3("division")
    divisionStr = divisionStr &" "& division

    rs3.movenext
  loop
  divisionStr = rtrim(divisionStr)

  srtlinksStr = ""
  sql = "select division, divisionalLogNumber from EHD_Data where srtLogNumber = "& sqlnum(log_number) &" and active = 'y' and divisionalLogNumber is not null and formname = 'iSRT_LogInput' order by division asc, divisionalLogNumber asc"
  set rs4 = conn_asap.execute(sql)
  do while not rs4.eof
    srtdivision				= rs4("division")
    srtdivisionalLogNumber	= rs4("divisionalLogNumber")
    srtlinksStr = srtlinksStr & srtdivision & string(4-len(srtdivisionalLogNumber),"0")&srtdivisionalLogNumber &"<br>"

    rs4.movenext
  loop
  srtlinksStr = rtrim(srtlinksStr)


  'response.write("<tr><td colspan='11'>log_number:"& log_number &"<br></td></tr>")
  'response.write("<tr><td colspan='11'>tmpLogNumber:"& tmpLogNumber &"<br></td></tr>")
  if(tmpLogNumber <> log_number) then
    tmpLogNumber = log_number
%>
<% if(firstOne <> "y") then %>
<tr><td bgcolor="#ffffff" colspan="12" ><div style="height:0px;border:1px solid black;font-size:1px;background-color:#000040;">&nbsp;</div></td></tr>
<% else %>
<% firstOne = "n" %>
<% end if %>
<%
isLocked = isLogLocked(log_number,"EH:DIV")
if(isLocked = "n") then
  clickloc = "document.location='iSRT_LogInput.asp?log_number="& log_number &"'"
else
  clickloc = "alert('Log "& log_number &" locked\nuser "& isLocked &"')"
end if
%>
<tr onclick="<%= clickloc %>"  onmouseover="setRowColor(this, '#FFFFE7');this.style.cursor='hand';" onmouseout="setRowColor(this, 'white')"><td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;font-size:14px;">iSRT<%= log_numberStr %>&nbsp;</span>
<!-- <br /><input  type="button" value="Update" style="font-size:10px;background-color:white;width:50px;margin-top:5px;margin-left:10px;" onclick="document.location='iSRT_LogInput.asp?recid=<%= recid %>'" /> -->
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1"  vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= item_description %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1"  vAlign="top" rowSpan="1" align="center">
<span style="font-weight:bold;"><%= srtlinksStr %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= accountable_leader %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= curr_risk %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= source %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= date_opened %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= date_due %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= date_completed %>&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<%
if(date_completed = "") then
  d2 = date
else
  d2 = date_completed
end if
%>
<span style="font-weight:bold;"><% if(len(date_opened) > 0) then %><%= datediff("d",date_opened,d2) %><% end if %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="#ffffff" selected="false" colSpan="1" align="center"  vAlign="top" rowSpan="1">
<span style="font-weight:bold;"><%= item_status %>&nbsp;</span>
</td>
</tr>


<% if(tmpCnt > 0) then %>
<%
isLocked = isLogLocked(log_number,"EH:DIV")
if(isLocked = "n") then
  clickloc = "document.location='iSRT_LogInput.asp?log_number="& log_number &"'"
else
  clickloc = "alert('Log "& log_number &" locked\nuser "& isLocked &"')"
end if
%>
<tr onclick="<%= clickloc %>"  onmouseover="this.style.cursor='hand';" ><td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" rowSpan="1" colSpan="1"  align="center" vAlign="top" >
<span style="font-weight:bold;">Item Nbr.</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" colSpan="1" vAlign="top" rowSpan="1" align="center">
<span style="font-weight:bold;">Safety Action</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" colSpan="1" align="center"  vAlign="top" rowSpan="1">
<span style="font-weight:bold;">POC</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;">Date Opened</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;">Date Due</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;">Date Completed</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;">Days</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;">Status</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;">&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;">&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" selected="false" colSpan="1" align="center" vAlign="top" rowSpan="1">
<span style="font-weight:bold;">&nbsp;</span>
</td>
</tr>
<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 12pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" rowSpan="1" colSpan="11" width="10%" align="right" vAlign="top" >
</td>
</tr>
<% end if %>
<%
for a = 1 to tmpCnt

  safety_action_nbr				= selectNode(oXML,"safety_action_nbr_"& a,"")
  safety_action					= rev_xdata2(selectNode(oXML,"safety_action_"& a,""))
  safety_action_poc				= rev_xdata2(selectNode(oXML,"safety_action_poc_"& a,""))
  safety_action_poc_email		= rev_xdata2(selectNode(oXML,"safety_action_poc_email_"& a,""))
  safety_action_open			= selectNode(oXML,"safety_action_open_"& a,"")
  safety_action_due				= selectNode(oXML,"safety_action_due_"& a,"")
  safety_action_completed		= selectNode(oXML,"safety_action_completed_"& a,"")
  safety_action_status			= selectNode(oXML,"safety_action_status_"& a,"")

  safety_action			= replace(safety_action,vbcrlf,"<br>")

%>

<%
isLocked = isLogLocked(log_number,"EH:DIV")
if(isLocked = "n") then
  clickloc = "document.location='iSRT_LogInput.asp?log_number="& log_number &"'"
else
  clickloc = "alert('Log "& log_number &" locked\nuser "& isLocked &"')"
end if
%>
<tr onclick="<%= clickloc %>"  onmouseover="setRowColor(this, '#FFFFE7');this.style.cursor='hand';" onmouseout="setRowColor(this, 'white')"><td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" rowSpan="1" colSpan="1" align="center" vAlign="top" >
<span style="font-weight:normal;">iSRT<%= safety_action_nbr %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= safety_action %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1" align="center"  vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= safety_action_poc %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= safety_action_open %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= safety_action_due %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= safety_action_completed %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<%
if(safety_action_completed = "") then
  d2 = date
else
  d2 = safety_action_completed
end if
%>
<span style="font-weight:normal;"><% if(len(safety_action_open) > 0) then %><%= datediff("d",safety_action_open,d2) %><% end if %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;"><%= safety_action_status %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;">&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;">&nbsp;</span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" colSpan="1"  align="center" vAlign="top" rowSpan="1">
<span style="font-weight:normal;">&nbsp;</span>
</td>
</tr>
<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 12pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff" selected="false" rowSpan="1" colSpan="11" align="right" vAlign="top" ><br>
</td>
</tr>
<tr><td style="height:0px;" bgcolor="#dcdcdf" colspan="11"></td></tr>
<%
next

acnt = 0
sql = "select count(*) cnt from EHD_Attachments where log_number = "& sqlnum(log_number) &" and archived = 'n'"
set rscnt = conn_asap.execute(sql)
if not rscnt.eof then
  acnt = cint(rscnt("cnt"))
end if
%>
<tr><td style="height:8px;FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial;padding-left:5px;" bgcolor="#ffffff" colspan="12" align="left"><% if(acnt > 0) then
%><span style="font-weight:normal;width:150px"><a href="iEHD_Attachments.asp?log_number=<%= log_number %>" style="text-decoration:none;">Attachments(<b><%= acnt %></b>)</a></span><% end if %>
<%
sql = "select * from SRT_Links where primary_log_number = "& sqlnum(log_number) &" and archived = 'n'"
set lrs = conn_asap.execute(sql)
if not lrs.eof then
%>
<span style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial;width:120px;">Related to :&nbsp;</span>
<%
do while not lrs.eof
  tmp_secondarylognumber = string(4-len(lrs("secondary_log_number")),"0")&lrs("secondary_log_number")
%>
<span style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial;width:30px;"><%= tmp_secondarylognumber %></span>
<%
  lrs.movenext
loop
end if
%>
</td>
</tr>
<tr><td style="height:0px;" bgcolor="#ffffff" colspan="11"></td></tr>
<%

  end if
  end if
  end if
  rs.movenext
  loop
%>
</tbody>
</table>

<% if(overflow <> "y") then %>
</div>
<% end if %>

<div width="100%" style="border-top: 1px solid black;"></div>

<br>

<% if(overflow <> "y") then %>
<table cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="white">
<tr height="0">
<td align="center">
<span style="width:150px;font-weight:bold;"><% if(startpos > 0) then %><a href="adminDisplay.asp?position=<%= prevpos %>&filterSelect=<%= filterSelect %>&searchVal=<%= searchVal %>&divisionSelect=<%= divisionSelect %>">&lt;&lt;prev</a><% else %>&lt;&lt;prev<% end if %></span>
<span style="width:150px;font-weight:bold;"><% if(recsshown = 11) then %><a href="adminDisplay.asp?position=<%= currpos %>&filterSelect=<%= filterSelect %>&searchVal=<%= searchVal %>&divisionSelect=<%= divisionSelect %>">next&gt;&gt;</a><% else %>next&gt;&gt;<% end if %></span>
</td>
</tr>

</table>
<% end if %>

</form>

<!--#include file ="includes/footer.inc"-->


</body>
</html>
<xml id="xmlhttpSvc"></xml>
