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
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2"align="center" vAlign="top">
<table cellSpacing="0" cellPadding="1" width="98%" border="0">
<tr>
<td width="20%" align="center" style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" >Log Nbr.</td>
<td width="60%" align="center" style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" >Hazard Title</td>
<td width="20%" align="center" style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" >Business Unit</td>
</tr>
</table>
</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Aircraft</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Accountable Leader</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="4%" align="center" vAlign="top" title="Source Of Information">SOI</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="4%" align="center" vAlign="top" title="Hazard Log">HL</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Date Opened <br> dd/mm/yyyy</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Date Due</td>
<td style="FONT-WIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Date Completed</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Status</td>
</tr>

<tr valign="top">
              <td colspan="2">
<table cellSpacing="0" cellPadding="1" width="100%" border="0">
<tr valign="top">
<td width="20%" align="center" style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial"  ><span style="font-weight:bold;font-size:9pt;color:#116c94;">


<input type="text" name="log_number" style="width:100px;"  value="" required="false"  /></span></td>
<td width="60%" align="center" style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial"  ><input name="item_title" style="width:288px;"  value=""></td>
<td width="20%" align="center" style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial"  >
            <select class="input6" name="viewdivision" id="viewdivision" style="width:85px;" >
              <option value=""></option>
<option value="EBU">EBU</option>
<option value="COBU">COBU</option>
<option value="IBU">IBU</option>
<option value="WASBU">WASBU</option>
<option value="AUSBU">AUSBU</option>
<option value="NABU">NABU</option>
<option value="Global">Global</option>
<option value="BA">BA</option>
<option value="TEST">TEST</option>
            </select>
            <script>
            document.frm.viewdivision.value = "<%= viewdivision %>";
            </script>

</td>
</tr>
</table>
              </td>

<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">

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
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
               <select id="accountable_leader" name="accountable_leader" style="width:100px;" required>
                  <option value=""></option>
                  <option value="BU Director">BU Director</option>
                  <option value="SV President">SV President</option>
                </select><script>document.getElementById("accountable_leader").value = "";</script>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="4%" align="center" vAlign="top" rowSpan="1">
               <select id="soi" name="soi" style="width:40px;" required>
                  <option value="SYS">SYS</option>
                  <option value="REA">REA</option>
                  <option value="PRE">PRE</option>
                  <option value="PRO">PRO</option>
                </select><script>document.getElementById("soi").value = "";</script>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="4%" align="center" vAlign="top" rowSpan="1">
               <select id="hl" name="hl" style="width:40px;" required>
                  <option value="A">A</option>
                  <option value="B">B</option>
                  <option value="M">M</option>
                </select><script>document.getElementById("hl").value = "";</script>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<div style="float:left;"><input type="text" id="date_opened" name="date_opened" size="30"  style="width:73px;"  value="" onblur="if(validateDate(this)){calcDueDate('');}"   required2  title="" /></div><div style="float:right;"><a onclick="javascript:return isCalendarLoaded()" href="javascript:openCalendar('calendar1', getCurrentDate(), getNextYear(), 'frm', 'date_opened')"><img id="calendar1" src="http://www.atlanta.net/global_images/appts.png" border="0"></a></div>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<div style="float:left;"><input type="text" id="date_due" name="date_due" size="30"  style="width:73px;"  value=""    required2 onblur="validateDate(this)"   title="" /></div><div style="float:right;"><a onclick="javascript:return isCalendarLoaded()" href="javascript:openCalendar('calendar2', getCurrentDate(), getNextYear(), 'frm', 'date_due')"><img id="calendar2" src="http://www.atlanta.net/global_images/appts.png" border="0"></a></div>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<div style="float:left;"><input type="text" id="date_completed" name="date_completed" size="30"  style="width:73px;"  value=""  onblur="validateDate(this)"    title="" /></div><div style="float:right;"><a onclick="javascript:return isCalendarLoaded()" href="javascript:openCalendar('calendar3', getCurrentDate(), getNextYear(), 'frm', 'date_completed')"><img id="calendar3" src="http://www.atlanta.net/global_images/appts.png" border="0"></a></div>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">

<select name="item_status" style="width:73px;"    onchange="changeStatus(this.value)">
  <option value="Open" selected>Open</option>
  <option value="ALARP">ALARP</option>
  <option value="Unassessed">Unassessed</option>
  <option value="Archived">Archived</option>
  <option value="Not Applicable">Not Applicable</option>
</select>
<script>
frm.item_status.value = "";
</script>

</td>
</tr>

<tr style="height: 5px">
<td colspan="10" bgcolor="#ffffff">
</td>
</tr>

<tr>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="19%" align="center" vAlign="top" rowspan="1">Description</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Base</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Mission</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="4%" align="center" vAlign="top" >Hazard Owner</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="8%" align="center" vAlign="top" >Hazard Editor</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="8%" align="center" vAlign="top">Next Review Date</td>
</tr>

<tr><td style="padding-left:5px;FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="19%" align="center" vAlign="top" rowSpan="4">
<textarea name="item_description" style="width:600px;" rows="6"  ></textarea>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">

<select name="base" id="base" style="width:105px;" ><option value=""></option><option value='All'>All</option><option value='Aberdeen'>Aberdeen</option><option value='Aberdeen COBU'>Aberdeen COBU</option><option value='AUSBU Base 1'>AUSBU Base 1</option><option value='AUSBU Generic'>AUSBU Generic</option><option value='Baltic Sea'>Baltic Sea</option><option value='Barrow'>Barrow</option><option value='Base 1'>Base 1</option><option value='Base A'>Base A</option><option value='Bergen'>Bergen</option><option value='Brazoria County, TX'>Brazoria County, TX</option><option value='Bronnoysund Airport'>Bronnoysund Airport</option><option value='Broome'>Broome</option><option value='Calabar'>Calabar</option><option value='Christiansund'>Christiansund</option><option value='Concord, CA'>Concord, CA</option><option value='Creole, LA'>Creole, LA</option><option value='Deadhorse, AK'>Deadhorse, AK</option><option value='Den Helder'>Den Helder</option><option value='Donegal'>Donegal</option><option value='Dongara'>Dongara</option><option value='EBU HSE Test'>EBU HSE Test</option><option value='EBU NOR Generic'>EBU NOR Generic</option><option value='Eket'>Eket</option><option value='Escravos'>Escravos</option><option value='Essendon'>Essendon</option><option value='Exmouth'>Exmouth</option><option value='Fairbanks, AK'>Fairbanks, AK</option><option value='Galbraith Lake, AK'>Galbraith Lake, AK</option><option value='Galliano, LA'>Galliano, LA</option><option value='Galveston, TX'>Galveston, TX</option><option value='Geraldton'>Geraldton</option><option value='Glennallen, AK'>Glennallen, AK</option><option value='Gloucester UK-Bristow Academy'>Gloucester UK-Bristow Academy</option><option value='Guyana'>Guyana</option><option value='Hammerfest'>Hammerfest</option><option value='Hangar 14 / New Iberia, LA'>Hangar 14 / New Iberia, LA</option><option value='Houma, LA'>Houma, LA</option><option value='Houston'>Houston</option><option value='Humberside'>Humberside</option><option value='Intracoastal, LA'>Intracoastal, LA</option><option value='Karratha'>Karratha</option><option value='Lagos'>Lagos</option><option value='Learmouth'>Learmouth</option><option value='Misurata'>Misurata</option><option value='Mitiga'>Mitiga</option><option value='Mobile'>Mobile</option><option value='New Iberia HUB, LA'>New Iberia HUB, LA</option><option value='New Iberia-Bristow Academy'>New Iberia-Bristow Academy</option><option value='Norwich'>Norwich</option><option value='Oakey'>Oakey</option><option value='Oooguruk Transfer Point, AK'>Oooguruk Transfer Point, AK</option><option value='Patterson, LA'>Patterson, LA</option><option value='Perth'>Perth</option><option value='Piarco'>Piarco</option><option value='Port Harcourt AGIP'>Port Harcourt AGIP</option><option value='Port Harcourt/NAF Base'>Port Harcourt/NAF Base</option><option value='Pump Station 4, Alyeska Pipeline'>Pump Station 4, Alyeska Pipeline</option><option value='Pump Station 5, Alyeska Pipeline'>Pump Station 5, Alyeska Pipeline</option><option value='Redhill'>Redhill</option><option value='Scatsta'>Scatsta</option><option value='Stavanger'>Stavanger</option><option value='Suriname'>Suriname</option><option value='Test BU'>Test BU</option><option value='Titusville, FLA'>Titusville, FLA</option><option value='Tooradin'>Tooradin</option><option value='Truscott'>Truscott</option><option value='Turkmanbashi'>Turkmanbashi</option><option value='Valdez, AK'>Valdez, AK</option><option value='Varanus Island'>Varanus Island</option><option value='Venice, LA'>Venice, LA</option><option value='Warri Chevron'>Warri Chevron</option><option value='Warri Osubi'>Warri Osubi</option><option value='WASBU Generic'>WASBU Generic</option></select>
<script>
document.getElementById("base").value = "";
</script>

</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">

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
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="4%" align="center" vAlign="top" rowSpan="1">
<select name="hazard_owner" id="hazard_owner" style="width:180px;" ><option value=""></option><option value='AUSBU  Head of Flight Ops'>AUSBU  Head of Flight Ops</option><option value='Karratha Base Manager'>Karratha Base Manager</option><option value='Barrow Island BM'>Barrow Island BM</option><option value='AUSBU BU Director'>AUSBU BU Director</option><option value='Katrina Cuijpers'>Katrina Cuijpers</option><option value='Fritz Fryters'>Fritz Fryters</option><option value='AUSBU Head of Commercial'>AUSBU Head of Commercial</option><option value='AUSBU Head of Engineering'>AUSBU Head of Engineering</option><option value='AUSBU Head of HR'>AUSBU Head of HR</option><option value='AUSBU Head of HSE'>AUSBU Head of HSE</option><option value='AUSBU Head of Logistics'>AUSBU Head of Logistics</option><option value='AUSBU Head of Security'>AUSBU Head of Security</option><option value='AUSBU Head of Technical Services'>AUSBU Head of Technical Services</option><option value='Peter Snowden'>Peter Snowden</option></select>

</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="8%" align="center" vAlign="top" rowSpan="1" >

<input type="text" id="hazard_editor" name="hazard_editor" size="30"  style="width:180px;"  value=""   /></td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="8%" align="center" vAlign="top" rowSpan="1">
<div style2="float:left;"><input type="text" id="next_review_date" name="next_review_date" size="30"  style="width:73px;"  value=""  onblur2="if(validateDate(this)){calcDueDate('');}"   required2 title="" /></div><div style2="float:right;"><a onclick="javascript:return isCalendarLoaded()" href="javascript:openCalendar('calendar4', getCurrentDate(), getNextYear(), 'frm', 'next_review_date')"><img id="calendar4" src="http://www.atlanta.net/global_images/appts.png" border="0"></a></div>
</td>
</td>
</tr>

<tr >
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Endorsed</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Endorsed by</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="4%" align="center" vAlign="top" ></td>
<td style="FONT-WEIGHT: bold;FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top"></td>
</tr>

<tr>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
<input id="endorsed" type="checkbox" name="endorsed" value="1">

</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<input type="text" id="endorsed_by" name="endorsed_by" size="30"  style="width:73px;"  value=""    />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="4%" align="center" vAlign="top" rowSpan="1">
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
</td>
</tr>

<tr style="height: 5px">
<td colspan="8" bgcolor="#ffffff">
</td>
</tr>
<!--
<tr >
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Init Assesment Date</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Init Assessment Occasion</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="4%" align="center" vAlign="top" >Curr Assessment Date</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Curr Assessment Occasion</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Post Assessment Date</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top">Post Assessment Occasion</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top"></td>
</tr>

<tr>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
<div style="float:left;"><input type="text" id="initial_assessment_date" name="initial_assessment_date" size="30"  style="width:70px;"  value="" required="false" /></div><div style="float:right;"><a onclick="javascript:return isCalendarLoaded()" href="javascript:openCalendar('calendar7', getCurrentDate(), getNextYear(), 'frm', 'initial_assessment_date')"><img id="calendar7" src="http://www.atlanta.net/global_images/appts.png" border="0"></a></div>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<input type="text" id="initial_assessment_occasion" name="initial_assessment_occasion" size="30"  style="width:85px;"  value="" required="false" /></td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="4%" align="center" vAlign="top" rowSpan="1">
<div style="float:left;"><input type="text" id="current_assessment_date" name="current_assessment_date" size="30"  style="width:70px;"  value="" required="false"  /></div><div style="float:right;"><a onclick="javascript:return isCalendarLoaded()" href="javascript:openCalendar('calendar5', getCurrentDate(), getNextYear(), 'frm', 'current_assessment_date')"><img id="calendar5" src="http://www.atlanta.net/global_images/appts.png" border="0"></a></div>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<input type="text" id="current_assessment_occasion" name="current_assessment_occasion" size="30"  style="width:85px;"  value="" required="false" /></td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<div style="float:left;"><input type="text" id="post_assessment_date" name="post_assessment_date" size="30"  style="width:73px;"  value="" required="false" /></div><div style="float:right;"><a onclick="javascript:return isCalendarLoaded()" href="javascript:openCalendar('calendar6', getCurrentDate(), getNextYear(), 'frm', 'post_assessment_date')"><img id="calendar6" src="http://www.atlanta.net/global_images/appts.png" border="0"></a></div>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
<input type="text" id="post_assessment_occasion" name="post_assessment_occasion" size="30"  style="width:85px;"  value="" required="false" />
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1">
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center"  vAlign="top" rowSpan="1">
</td>
</tr>
-->
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
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="2" width="8%" align="center" vAlign="top">Further Risk Reduction Needed?</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="3" width="8%" align="center" vAlign="top">Hazard Ok?/ALARP</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="4%" align="center" vAlign="top" ></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="4%" align="center" vAlign="top" ></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top"></td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 8pt;COLOR: #ffffff; FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="116c94" colSpan="1" width="8%" align="center" vAlign="top"></td>
</tr>

<tr><td style="padding-left:5px;FONT-WEIGHT: bold; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="19%" align="center" vAlign="top" rowSpan="1">
<textarea name ="item_comments" style="width:288px;" rows="3"  required></textarea>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="25%" vAlign="top" rowSpan="1">
<textarea name="alarp_statement" style="width:288px;" rows="3"  ></textarea>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="2" width="8%" align="center"  vAlign="top" rowSpan="1">
<input id="further_risk_reduction_needed" type="checkbox" name="further_risk_reduction_needed" value="1">

</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="3" width="8%" align="center" vAlign="top" rowSpan="1">
<input id="hazard_ok_alarp" type="checkbox" name="hazard_ok_alarp" value="1">

</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="4%" align="center" vAlign="top" rowSpan="1">


</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1"></td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1"></td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt;  FONT-STYLE: normal; FONT-FAMILY: Arial" bgColor="ffffff"  colSpan="1" width="8%" align="center" vAlign="top" rowSpan="1"></td>
</tr>

<tr style="height: 5px">
<td colspan="10" bgcolor="#ffffff">
</td>
</tr>

<tr style="height: 5px">
<td colspan="2" bgcolor="#ffffff" align="left">

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
<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="left"  background="" bgColor="ffffff">

</td>
<td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial;padding-left:25px;" align="left" background="" bgColor="ffffff" colSpan="9">

</td>
</tr>


<tr><td style="FONT-WEIGHT: bold; FONT-SIZE: 4pt; COLOR: #ffffff; FONT-FAMILY: Arial" align="center" background="" bgColor="ffffff" colSpan="10">.
</td>
</tr>

</tbody>
</table>



<table border="0" cellspacing="0" cellpadding="0" width="98%" style="margin-top:20px;margin-bottom:50px;" align="center">
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

<tr height="30">
<td>
&nbsp;
</td>
</tr>

<tr >
<td align="center">

<input type="submit" value="Search" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-right:0px;">


<br>

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

