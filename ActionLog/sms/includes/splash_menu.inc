<link rel="stylesheet" type="text/css" href="styles/ddlevelsmenu-base.css"/>
<link rel="stylesheet" type="text/css" href="styles/ddlevelsfiles/ddlevelsmenu-topbar.css" />
<link rel="stylesheet" type="text/css" href="styles/ddlevelsfiles/ddlevelsmenu-sidebar.css" />
<script type="text/javascript" src="script/ddlevelsmenu.js"></script>

<style>
li {
text-align: left;
}
</style>

<div id="ddtopmenubar" class="mattblackmenu" style="border-bottom: 1px solid #000000;text-align: center;font-size: 14px;font-weight: bold;color: black;width: 96%;">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr align="center">
      <td width="14%"></td>
      <td width="14%"><a href="#" style="cursor:hand;text-decoration:none;color:black;" rel="ddsubmenu1">Action Log</a></td>
      <td width="14%"></td>
      <td width="14%"><a href="#" style="cursor:hand;text-decoration:none;color:black;" rel="ddsubmenu2">Reports</a></td>
      <td width="14%"></td>
      <td width="14%"><a href="#" style="cursor:hand;text-decoration:none;color:black;" rel="ddsubmenu3">New Item</a></td>
      <td width="14%"></td>
    </tr>
  </table>
</div>

<script type="text/javascript">
ddlevelsmenu.setup("ddtopmenubar", "topbar") //ddlevelsmenu.setup("mainmenuid", "topbar|sidebar")
</script>

<ul id="ddsubmenu1" class="ddsubmenustyle">
<li><a href="admin_LogDisplay.asp">iSRT Action Log</a></li>
<li><a href="admin_LogDisplay.asp?overflow=y">Printer Friendly</a></li>
</ul>

<ul id="ddsubmenu2" class="ddsubmenustyle">
<li><a href="admin_LogReport.asp?overflow=y">iSRT Report</a></li>
<li><a href="admin_LogReport.asp?searchVal=&amp;filterSelect=open&amp;divisionSelect=All&amp;overflow=y">Open iSRT Items</a></li>
<li><a href="filterForm.asp">Advanced Search</a></li>
</ul>

<ul id="ddsubmenu3" class="ddsubmenustyle">
<li><a href="admin_StageInput.asp?viewDivision=iSRT">Add To Staging Area</a></li>
<li><a href="admin_LogInput.asp">Add To Action Log</a></li>
</ul>

<ul id="ddsubmenux" class="ddsubmenustyle">
<li><a href="#">Item 1a</a></li>
<li><a href="#">Item 2a</a></li>
<li><a href="#">Item Folder 3a</a>
  <ul>
  <li><a href="#">Sub Item 3.1a</a></li>
  <li><a href="#">Sub Item 3.2a</a></li>
  <li><a href="#">Sub Item 3.3a</a></li>
  <li><a href="#">Sub Item 3.4a</a></li>
  </ul>
</li>
<li><a href="#">Item 4a</a></li>
<li><a href="#">Item Folder 5a</a>
  <ul>
  <li><a href="#">Sub Item 5.1a</a></li>
  <li><a href="#">Item Folder 5.2a</a>
    <ul>
    <li><a href="#">Sub Item 5.2.1a</a></li>
    <li><a href="#">Sub Item 5.2.2a</a></li>
    <li><a href="#">Sub Item 5.2.3a</a></li>
    <li><a href="#">Sub Item 5.2.4a</a></li>
    </ul>
  </li>
	</ul>
</a>
</li>
<li><a href="#">Item 6a</a></li>
</ul>