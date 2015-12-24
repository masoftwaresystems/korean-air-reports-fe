<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/security.inc"-->
<!--#include file="includes/loginInfo.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<%
viewDivision = request("viewDivision")
%>
<!--#include file="includes/sms_header.inc"-->
<form action="divisional_LogDisplay.asp" method="post" name="frm" id="frm" >
<input type="hidden" name="advancedsearch" value="y">
  <div style="width:100%;padding-top:30px;padding-bottom:30px;margin: 0 auto;">


<table border="0" cellspacing="0" cellpadding="0" width="98%" style="padding-top:0px;margin-left:0px;">
  <tr><td align="center"><span class="fonts4" style="font-size:14px;color:#737579;"><span style="font-weight:bold;color:#116c94;">Advanced Search</span></span></td></tr>
</table>

<table style="BORDER-RIGHT: 1px; PADDING-RIGHT: 3px; BORDER-TOP: 1px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; BORDER-LEFT: 1px; PADDING-TOP: 3px; BORDER-BOTTOM: 1px; BACKGROUND-COLOR: #ffffff" cellSpacing="0" cellPadding="1" width="98%">
<tr>
<td height="5" style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial" background=""></td>
</tr>
</table>
<table cellSpacing="0" cellPadding="1" width="98%" border="0">
<tbody id="markerTABLE">
<tr>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" align="center" vAlign="top">
<table cellSpacing="0" cellPadding="1" width="98%" border="0">

<tr>
<td width="100%" align="center" style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" >Hazard Title</td>
</tr>
</table>
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Risk Acceptability</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Original Date Opened</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="6" width="4%" align="center" vAlign="top" title="Source Of Information">SOI</td>

</tr>

<tr valign="top">
              <td colspan="2">

<table cellSpacing="0" cellPadding="1" width="100%" border="0">
<tr valign="top">
<td width="100%" align="center" style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial"  ><span style="font-weight:bold;font-size:9pt;color:#116c94;">


<input name="item_title" style="width:550px;"  value=""></td>
</tr>
</table>
              </td>

<td style="FONT-WEIGHT: normal; FONT-SIZE: 10pt;  FONT-STYLE: normal; FONT-FAMILY: Arial; color: black;" bgColor="ffffff"  colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
               <select id="risk" name="risk" style="width:120px;" required><option value=""></option>
                  <option value="Unassessed">Unassessed</option>
                  <option value="Acceptable">Acceptable</option>
                  <option value="Acceptable With Mitigation">Acceptable With Mitigation</option>
                  <option value="Unacceptable">Unacceptable</option>

                </select><script>document.getElementById("risk").value = "";</script>


</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<input type="text" id="original_date_opened" name="original_date_opened" size="30"  style="width:73px;"  value=""   required2  title="" />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="6" width="4%" align="center" vAlign="top" rowSpan="1">
               <select id="soi" name="soi" style="width:120px;" required><option value=""></option>
                  <option value="SYS">Systemic</option>
                  <option value="REA">Reactive</option>
                  <option value="PRE">Predictive</option>
                  <option value="PRO">Proactive</option>

                </select><script>document.getElementById("soi").value = "";</script>
</td>
</tr>

<tr style="height: 5px">
<td colspan="10" bgcolor="#ffffff">
</td>
</tr>

<tr>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="19%" align="center" vAlign="top" rowspan="1">Description</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="8%" align="center" vAlign="top">Base</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Aircraft</td>

<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="4%" align="center" vAlign="top" >Mission</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="3" width="8%" align="center" vAlign="top" >BASE Filter</td>
</tr>

<tr><td style="padding-left:5px;FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="19%" align="center" vAlign="top" rowSpan="7">
<textarea name="item_description" style="width:600px;" rows="8"  ></textarea>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="8%" align="center"  vAlign="top" rowSpan="1">
<input type="text" id="base" name="base" size="30"  style="width:180px;"  value=""   />

</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">

<select name="equipment" id="equipment" style="width:85px;"   >

  <option value=""></option>

  <option value="172">172</option>

  <option value="208 Caravan">208 Caravan</option>

  <option value="AS332">AS332</option>

  <option value="AS350">AS350</option>

  <option value="AS355">AS355</option>

  <option value="AW139">AW139</option>

  <option value="B206">B206</option>

  <option value="B212">B212</option>

  <option value="B214">B214</option>

  <option value="B407">B407</option>

  <option value="B412">B412</option>

  <option value="BK117">BK117</option>

  <option value="Citation XLS">Citation XLS</option>

  <option value="EC135">EC135</option>

  <option value="EC155">EC155</option>

  <option value="EC175">EC175</option>

  <option value="EC225">EC225</option>

  <option value="R22">R22</option>

  <option value="S300">S300</option>

  <option value="S61">S61</option>

  <option value="S76">S76</option>

  <option value="S92">S92</option>

</select>
<script>
frm.equipment.value = "";
</script>

</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="4%" align="center" vAlign="top" rowSpan="1">

<select name="mission" style="width:85px;"   >
  <option value=""></option>
  <option value="SAR">SAR</option>
  <option value="CAT">CAT</option>
  <option value="HHO">HHO</option>
  <option value="USL">USL</option>

  <option value="TR">TR</option>
  <option value="FT">FT</option>
  <option value="Task">Task</option>
  <option value="NOPS">NOPS</option>
</select>
<script>
frm.mission.value = "";
</script>

</td>

<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="3" width="8%" align="center" vAlign="top" rowSpan="1" >
<select name="base_filter" style="width:120px;"   >
  <option value=""></option>
  <option value="Not Applicable">Not Applicable</option>
  <option value="BASE">BASE</option>
</select>
</td>

</tr>


<tr style="height: 5px">

<td colspan="8" bgcolor="#ffffff">
</td>
</tr>

<tr >
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Accountable Leader</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="8%" align="center" vAlign="top">Hazard Owner</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="4%" align="center" vAlign="top" >Hazard Editor</td>
<td style="FONT-WEIGHT: bold;FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold;FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold;FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top"></td>
</tr>

<tr>

<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
               <select id="accountable_leader" name="accountable_leader" style="width:100px;" required>
                  <option value=""></option>
                  <option value="BU Director">BU Director</option>
                  <option value="SV President">SV President</option>
                </select><script>document.getElementById("accountable_leader").value = "";</script>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="8%" align="center" vAlign="top" rowSpan="1">
<input type="text" id="hazard_owner" name="hazard_owner" size="30"  style="width:180px;"  value=""   />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="4%" align="center" vAlign="top" rowSpan="1">

<input type="text" id="hazard_editor" name="hazard_editor" size="30"  style="width:180px;"  value=""   />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
</tr>

<tr style="height: 5px">
<td colspan="8" bgcolor="#ffffff">

</td>
</tr>

<tr >
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Date Opened</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="8%" align="center" vAlign="top">Date Due</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top" >Date Completed</td>
<td style="FONT-WEIGHT: bold;FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Next Review Date</td>
<td style="FONT-WEIGHT: bold;FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold;FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="4%" align="center" vAlign="top"></td>
</tr>

<tr>

<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
<input type="text" id="date_opened" name="date_opened" size="30"  style="width:73px;"  value=""   required2  title="" />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="8%" align="center" vAlign="top" rowSpan="1">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td align="center" width2="50%">
<input type="text" id="date_due" name="date_due" size="30"  style="width:73px;"  value=""    required2 onblur="validateDate(this)"   title="" />
</td><!--<td align="left" width="50%"><a onclick="javascript:return isCalendarLoaded()" href="javascript:openCalendar('calendar2', getCurrentDate(), getNextYear(), 'frm', 'date_due')"><img id="calendar2" src="http://www.atlanta.net/global_images/appts.png" border="0"></a>
</td>--></tr>
</table>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="4%" align="center" vAlign="top" rowSpan="1">
<input type="text" id="date_completed" name="date_completed" size="30"  style="width:73px;"  value=""  onblur="validateDate(this)"    title="" />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<input type="text" id="next_review_date" name="next_review_date" size="30"  style="width:73px;"  value=""  onblur2="if(validateDate(this)){calcDueDate('');}"   required2 title="" />
</td>

<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
</tr>

<tr style="height: 5px">
<td colspan="8" bgcolor="#ffffff">
</td>
</tr>

<tr style="height: 5px">
<td colspan="8" bgcolor="#ffffff">
</td>
</tr>

<tr style="height: 5px">

<td colspan="10" bgcolor="#ffffff">
</td>
</tr>

<tr>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="19%" align="center" vAlign="top" rowspan="1">Comments</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="25%" align="center" vAlign="top" rowspan="1">ALARP Statement</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Status</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="8%" align="center" vAlign="top">Endorsed By</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="4%" align="center" vAlign="top" >Endorsed</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="4%" align="center" vAlign="top" ></td>

<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="8%" align="center" vAlign="top"></td>
</tr>

<tr><td style="padding-left:5px;FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="19%" align="center" vAlign="top" rowSpan="1">
<textarea name ="item_comments" style="width:288px;" rows="3"  required></textarea>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="25%" vAlign="top" rowSpan="1">
<textarea name="alarp_statement" style="width:288px;" rows="3"  ></textarea>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">

<select name="item_status" style="width:73px;"    >
  <option value=""></option>
  <option value="Open" selected>Open</option>

  <option value="ALARP">ALARP</option>
  <option value="Unassessed">Unassessed</option>
  <option value="Not Applicable">Not Applicable</option>
</select>
<script>
frm.item_status.value = "";
</script>

</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="8%" align="center" vAlign="top" rowSpan="1">
<select id="endorsed_by" name="endorsed_by" style="width:90px;"   >
  <option value=""></option>

  <option value="Base SAG">Base SAG</option>
  <option value="BU SAG">BU SAG</option>
  <option value="VP SAG">VP SAG</option>
</select>
<script>
frm.endorsed_by.value = "";
</script>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="4%" align="center" vAlign="top" rowSpan="1">
<input id="endorsed" type="checkbox" name="endorsed" value="1">

</td>

<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="8%" align="center" vAlign="top" rowSpan="1">

</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="8%" align="center" vAlign="top" rowSpan="1">


</td>
</tr>


<tr style="height: 5px">
<td colspan="10" bgcolor="#ffffff">
</td>
</tr>

<tr style="height: 5px">
<td colspan="2" bgcolor="#ffffff" align="left">

<div id="commentsDIV" style="display:none">


</div>
</td>
<td colspan="8" bgcolor="#ffffff">

</td>
</tr>

<tr style="height: 5px">
<td colspan="10" bgcolor="#ffffff">
</td>
</tr>

<tr id="ROWHEADER" style="display:none;">
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="19%" align="center"  vAlign="top" rowSpan="1">
&nbsp;
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="25%" align="center"  vAlign="top" rowSpan="1">
Activity
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">

</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
Action Owner
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="2" width="8%" align="center" vAlign="top" rowSpan="1">
Opened
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
Due
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
 Completed
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
Status
</td>

<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="c0c0c0" colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
</td>

</tr>




<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="left" width="100%" background="" bgColor="ffffff" colSpan="10">

<!--
<table width="100%" cellpadding="1" cellspacing="0" border="0" bgColor="ffffff" >
  <tbody id="markerTABLE">
-->
    <tr id="markerROW" style="height:1px;"><td style="height:1px;" colSpan="10"></td></tr>
<!--
  </tbody>
</table>
-->

</td>
</tr>



<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="center" background="" bgColor="ffffff" colSpan="10">.
</td>
</tr>

</tbody>
</table>


<table border="0" cellspacing="0" cellpadding="0" width="100%" style="margin-top:20px;margin-bottom:20px;" align="center">
  <tr><td align="center"><img src="images/1pgrey.gif" width="98%" height="1"></td></tr>
</table>



<div align="left" id="linkDIV" style="display:none;padding-left:5px;margin-top:10px;">
<table cellSpacing="0" cellPadding="1" width="99%" border="0" style="margin-top:0px;">
<tbody>
<tr valign="top">
<td align="left"><span style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial">Log Number Links </span></td>
</tr><tr><td >
<div style="border:1px solid black;height:110px;overflow:auto;">
<table border="0" cellspacing="5" cellpadding="0" width="98%">

</table>
</div>
</td>
</tr>
<tr><td><input type="button" value="Save Links" style="width:160px;font-weight:bold;height:20px;margin-top:3px;" onclick="saveLinks()"></td></tr>
</tbody>
</table>
</div>

<table cellSpacing="0" cellPadding="0" width="98%" border="0" bgcolor="white">

<tr >
<td align="center">


<input type="submit" value="Search" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-right:0px;">



</td>
</td>
</tr>

<tr height="20">
<td>
&nbsp;
</td>
</tr>

</table>
<input type="hidden" id="srtLogNumber" name="srtLogNumber" value="">

</form>

  </div>
<!--#include file ="includes/footer.inc"-->
  </body>
</html>
