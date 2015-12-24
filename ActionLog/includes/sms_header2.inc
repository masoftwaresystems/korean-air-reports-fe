<%
if(len(session("employee_number")) > 0) then
  loggedin_as = " <span style='font-weight:bold;'>"& session("first_name") &" "& session("last_name") &"</span>"
else
  loggedin_as = "&nbsp;"
end if

if(viewdivision = "") then
  viewdivision = session("division")
end if
viewdivisionStr = viewdivision

if(viewdivision = "BASE") then
  viewdivisionStr = "Generic Base"
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta name="robots" content="noindex,nofollow" />
<title>Bristow Action Log</title>

<script type="text/javascript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
     <link href="styles/display.css" rel="stylesheet" type="text/css" />
     <link href="css/style.css" rel="stylesheet" type="text/css" />
 <!--#include file="../script/nav.js"-->
 <script>
  <!--#include file="../script/formatMask.js"-->
  </script>
     <script type="text/javascript">
 <!--#include file="../script/display.asp"-->
     </script>
<!--Add Link to Style Sheet-->
<link rel="stylesheet" href="/sms_ehd3/css/smalStyles.css" type="text/css" media="screen" />
<!--End Link to Style Sheet-->

</head>
<body onload="init();MM_preloadImages('smal_images/bttnActionLog_r.jpg','smal_images/bttnReports_r.jpg','smal_images/bttnNewItem_r.jpg','smal_images/bttnPrint_r.jpg','smal_images/bttnAdmin_r.jpg')">

<!--Begin Header-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">

  <tr>
    <td background="smal_images/headerBG.jpg">
    <table width="950" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center" valign="top"><img src="smal_images/header.jpg" alt="Bristow Safety Management Action Log" width="950" height="123" /></td>
  </tr>
</table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#edeae3"><img src="smal_images/clear.gif" alt="clear" width="1" height="5"></td>
  </tr>
  <tr>
    <td background="smal_images/headerStripe.gif"><img src="smal_images/headerStripe.gif" alt="stripe" width="6" height="27"></td>
  </tr>
</table>
<!--End Header-->

<!--Begin Common Content-->
<div id="page-box">

      <!--Begin Login Row-->
		<div id="login">
            <table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="smal_images/loginFrnt.gif" /></td>
    <td bgcolor="#116c94"><!-- logged in as: --><span style="font-weight: bold;"><a href="updateProfile2.asp?user=y&loginID=<%= session("loginID") %>"><%= loggedin_as %></a></span> :: <a href="logout.asp">logout</a></td>
    <td><img src="smal_images/loginBck.gif" /></td>
  </tr>
</table>


		</div>
      	<div id="cent" style="font-size:16px;"><%= viewdivisionStr %> Action Log</div>
<!--End Login Row-->

<br class="clear">

<!--Begin Nav -->

<div id="nav_div" style="width: 100%; padding-top: 5px; margin: 0pt auto;">

<ul id="nav_menu">
    <li><a href="#">Action Log</a>
        <ul>


	    <li><a href="admin_LogDisplay.asp">Division<img src="images/arrow-right.gif" border="0" style="padding-left: 20px;" alt="arrow-right"></a>
		<ul>
		    <li><a href="admin_LogDisplay.asp?viewdivision=GLOBAL">GLOBAL</a></li>
		</ul>
		</li>
	    <li><a href="#">Business Unit<img src="images/arrow-right.gif" border="0" style="padding-left: 20px;" alt="arrow-right"></a>
		<ul>
		    <li><a href="#">EBU<img src="images/arrow-right.gif" border="0" style="padding-left: 20px;" alt="arrow-right"></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=EBU&amp;viewtype=ALL">All Hazards</a></li>
		    		<li><a href="divisional_Base.asp?viewdivision=EBU&amp;viewtype=BASE">Hazards by Base</a></li>
		    		<!-- <li><a href="divisional_Equipment.asp?viewdivision=EBU&viewtype=AIRCRAFT">Hazards by Aircraft</a></li> -->
		    	</ul>
		    </li>
		    <li><a href="#">COBU<img src="images/arrow-right.gif" border="0" style="padding-left: 20px;" alt="arrow-right"></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=COBU&amp;viewtype=ALL">All Hazards</a></li>
		    		<li><a href="divisional_Base.asp?viewdivision=COBU&amp;viewtype=BASE">Hazards by Base</a></li>
		    	</ul>
		    </li>
		    <li><a href="#">IBU<img src="images/arrow-right.gif" border="0" style="padding-left: 20px;" alt="arrow-right"></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=IBU&amp;viewtype=ALL">All Hazards</a></li>
		    		<li><a href="divisional_Base.asp?viewdivision=IBU&amp;viewtype=BASE">Hazards by Base</a></li>
		    	</ul>
		    </li>
		    <li><a href="#">NABU<img src="images/arrow-right.gif" border="0" style="padding-left: 20px;" alt="arrow-right"></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=NABU&amp;viewtype=ALL">All Hazards</a></li>
		    		<li><a href="divisional_Base.asp?viewdivision=NABU&amp;viewtype=BASE">Hazards by Base</a></li>
		    	</ul>
		    </li>
		    <li><a href="#">WASBU<img src="images/arrow-right.gif" border="0" style="padding-left: 20px;" alt="arrow-right"></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=WASBU&amp;viewtype=ALL">All Hazards</a></li>
		    		<li><a href="divisional_Base.asp?viewdivision=WASBU&amp;viewtype=BASE">Hazards by Base</a></li>
		    	</ul>
		    </li>
		    <li><a href="#">AUSBU<img src="images/arrow-right.gif" border="0" style="padding-left: 20px;" alt="arrow-right"></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=AUSBU&amp;viewtype=ALL">All Hazards</a></li>
		    		<li><a href="divisional_Base.asp?viewdivision=AUSBU&amp;viewtype=BASE">Hazards by Base</a></li>
		    	</ul>
		    </li>
		    <li><a href="#">BA<img src="images/arrow-right.gif" border="0" style="padding-left: 20px;" alt="arrow-right"></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=BA&amp;viewtype=ALL">All Hazards</a></li>
		    		<li><a href="divisional_Base.asp?viewdivision=BA&amp;viewtype=BASE">Hazards by Base</a></li>
		    	</ul>
		    </li>
		    <li><a href="#">TEST<img src="images/arrow-right.gif" border="0" style="padding-left: 20px;" alt="arrow-right"></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=TEST&amp;viewtype=ALL">All Hazards</a></li>
		    		<li><a href="divisional_Base.asp?viewdivision=TEST&amp;viewtype=BASE">Hazards by Base</a></li>
		    	</ul>
		    </li>
		</ul>
		</li>

	    <li><a href="#">Generic<img src="images/arrow-right.gif" border="0" style="padding-left: 20px;" alt="arrow-right"></a>
		<ul>
		    <li><a href="#">Aircraft<img src="images/arrow-right.gif" border="0" style="padding-left: 20px;" alt="arrow-right"></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=AS332&amp;viewtype=ALL">AS332</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=AW139&amp;viewtype=ALL">AW139</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=B206&amp;viewtype=ALL">B206</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=B412&amp;viewtype=ALL">B412</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=BK117&amp;viewtype=ALL">BK117</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=EC155&amp;viewtype=ALL">EC155</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=EC225&amp;viewtype=ALL">EC225</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=S61&amp;viewtype=ALL">S61</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=S76&amp;viewtype=ALL">S76</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=S92&amp;viewtype=ALL">S92</a></li>
		    	</ul>
		    </li>
		    <li><a href="divisional_LogDisplay.asp?viewdivision=BASE&amp;viewtype=ALL">Base</a></li>
		    <li><a href="#">Mission<img src="images/arrow-right.gif" border="0" style="padding-left: 20px;" alt="arrow-right"></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=SAR&amp;viewtype=ALL">SAR</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=CAT&amp;viewtype=ALL">CAT</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=HHO&amp;viewtype=ALL">HHO</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=USL&amp;viewtype=ALL">USL</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=TR&amp;viewtype=ALL">TR</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=FT&amp;viewtype=ALL">FT</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=Task&amp;viewtype=ALL">Task</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=NOPS&amp;viewtype=ALL">NOPS</a></li>
		    	</ul>
		    </li>
		</ul>
		</li>
            <li><a href="advancedSearch.asp?viewDivision=<%= viewdivision %>">Advanced Search</a></li>

            <li><a href="Splash.asp">Home</a></li>
        </ul>
    </li>
    <li><a href="#">Reports</a>
        <ul>
        	<li><a href="reports_Custom.asp">Custom</a></li>
        	<li><a href="reports_Overdue.asp">Overdue</a></li>
        	<!-- <li><a href="reports_Standard.asp">Standard</a></li> -->
        </ul>
    </li>
    <!--
    <li><a href="#">Reports</a>
        <ul>
        	<li></li>

            <li><a href="admin_LogReport.asp?overflow=y">SMS Report<img src="images/arrow-right.gif" border="0" style="padding-left:20px;" alt="arrow-right" /></a>
		<ul>
		    <li><a href="admin_LogReport.asp?searchVal=&amp;filterSelect=open&amp;divisionSelect=All&amp;overflow=y">Open</a></li>
		    <li><a href="admin_LogReport.asp?searchVal=&amp;filterSelect=closed&amp;divisionSelect=All&amp;overflow=y">Closed</a></li>
		    <li><a href="admin_LogReport.asp?searchVal=&amp;filterSelect=void&amp;divisionSelect=All&amp;overflow=y">Void</a></li>
		    <li><a href="admin_LogReport.asp?searchVal=&amp;filterSelect=re-opened&amp;divisionSelect=All&amp;overflow=y">Re-Opened</a></li>
		    <li><a href="admin_LogReport.asp?searchVal=&amp;filterSelect=demoted&amp;divisionSelect=All&amp;overflow=y">Demoted</a></li>
		    <li><a href="admin_LogReport.asp?searchVal=&amp;filterSelect=removed&amp;divisionSelect=All&amp;overflow=y">Removed</a></li>
		    <li><a href="admin_LogReport.asp?searchVal=&amp;filterSelect=not%20accepted&amp;divisionSelect=All&amp;overflow=y">Not Accepted</a></li>
		</ul>
	    </li>

            <li><a href="divisional_LogReport.asp?viewdivision=GLOBAL&amp;overflow=y">GLOBAL Report<img src="images/arrow-right.gif" border="0" style="padding-left:20px;" alt="arrow-right" /></a>
		<ul>
		    <li><a href="divisional_LogReport.asp?viewdivision=GLOBAL&amp;searchVal=&amp;filterSelect=open&amp;divisionSelect=All&amp;overflow=y">Open</a></li>
		    <li><a href="divisional_LogReport.asp?viewdivision=GLOBAL&amp;searchVal=&amp;filterSelect=closed&amp;divisionSelect=All&amp;overflow=y">Closed</a></li>
		    <li><a href="divisional_LogReport.asp?viewdivision=GLOBAL&amp;searchVal=&amp;filterSelect=void&amp;divisionSelect=All&amp;overflow=y">Void</a></li>
		    <li><a href="divisional_LogReport.asp?viewdivision=GLOBAL&amp;searchVal=&amp;filterSelect=re-opened&amp;divisionSelect=All&amp;overflow=y">Re-Opened</a></li>
		    <li><a href="divisional_LogReport.asp?viewdivision=GLOBAL&amp;searchVal=&amp;filterSelect=demoted&amp;divisionSelect=All&amp;overflow=y">Demoted</a></li>
		    <li><a href="divisional_LogReport.asp?viewdivision=GLOBAL&amp;searchVal=&amp;filterSelect=removed&amp;divisionSelect=All&amp;overflow=y">Removed</a></li>
		    <li><a href="divisional_LogReport.asp?viewdivision=GLOBAL&searchVal=&amp;filterSelect=not%20accepted&amp;divisionSelect=All&amp;overflow=y">Not Accepted</a></li>
		</ul>
	    </li>
        </ul>
    </li>
    -->

    <li><a href="#">New Item</a>
        <ul>
<%
sql = "select CURRENT_BASE, Code from BUtoBASE where BUSINESS_UNIT = "& sqltext2(viewdivision) &" and Code is not null and Code <> '' order by CURRENT_BASE asc"
set ors = conn_asap.execute(sql)
do while not ors.eof
%>
		    <li><a href="#"><%= ors("CURRENT_BASE") %><img src="images/arrow-right.gif" border="0" style="padding-left: 20px;" alt="arrow-right"></a>        
 
		    <ul><li><a href="#">Aircraft<img src="images/arrow-right.gif" border="0" style="padding-left: 20px;" alt="arrow-right"></a>
		    	<ul>
		    		<li><a href="divisional_LogInput.asp?viewdivision=<%= viewdivision %>&base=<%= ors("Code") %>&type=AS332&amp;viewtype=ALL">AS332</a></li>
		    		<li><a href="divisional_LogInput.asp?viewdivision=<%= viewdivision %>&base=<%= ors("Code") %>&type=AW139&amp;viewtype=ALL">AW139</a></li>
		    		<li><a href="divisional_LogInput.asp?viewdivision=<%= viewdivision %>&base=<%= ors("Code") %>&type=B206&amp;viewtype=ALL">B206</a></li>
		    		<li><a href="divisional_LogInput.asp?viewdivision=<%= viewdivision %>&base=<%= ors("Code") %>&type=B412&amp;viewtype=ALL">B412</a></li>
		    		<li><a href="divisional_LogInput.asp?viewdivision=<%= viewdivision %>&base=<%= ors("Code") %>&type=BK117&amp;viewtype=ALL">BK117</a></li>
		    		<li><a href="divisional_LogInput.asp?viewdivision=<%= viewdivision %>&base=<%= ors("Code") %>&type=EC155&amp;viewtype=ALL">EC155</a></li>
		    		<li><a href="divisional_LogInput.asp?viewdivision=<%= viewdivision %>&base=<%= ors("Code") %>&type=EC225&amp;viewtype=ALL">EC225</a></li>
		    		<li><a href="divisional_LogInput.asp?viewdivision=<%= viewdivision %>&base=<%= ors("Code") %>&type=S61&amp;viewtype=ALL">S61</a></li>
		    		<li><a href="divisional_LogInput.asp?viewdivision=<%= viewdivision %>&base=<%= ors("Code") %>&type=S76&amp;viewtype=ALL">S76</a></li>
		    		<li><a href="divisional_LogInput.asp?viewdivision=<%= viewdivision %>&base=<%= ors("Code") %>&type=S92&amp;viewtype=ALL">S92</a></li>
		    	</ul>
		    </li>
		    <li><a href="divisional_LogInput.asp?viewdivision=<%= viewdivision %>&type=BASE&base=<%= ors("Code") %>&amp;viewtype=ALL">Base</a></li>
		    <li><a href="#">Mission<img src="images/arrow-right.gif" border="0" style="padding-left: 20px;" alt="arrow-right"></a>
		    	<ul>
		    		<li><a href="divisional_LogInput.asp?viewdivision=<%= viewdivision %>&base=<%= ors("Code") %>&type=SAR&amp;viewtype=ALL">SAR</a></li>
		    		<li><a href="divisional_LogInput.asp?viewdivision=<%= viewdivision %>&base=<%= ors("Code") %>&type=CAT&amp;viewtype=ALL">CAT</a></li>
		    		<li><a href="divisional_LogInput.asp?viewdivision=<%= viewdivision %>&base=<%= ors("Code") %>&type=HHO&amp;viewtype=ALL">HHO</a></li>
		    		<li><a href="divisional_LogInput.asp?viewdivision=<%= viewdivision %>&base=<%= ors("Code") %>&type=USL&amp;viewtype=ALL">USL</a></li>
		    		<li><a href="divisional_LogInput.asp?viewdivision=<%= viewdivision %>&base=<%= ors("Code") %>&type=TR&amp;viewtype=ALL">TR</a></li>
		    		<li><a href="divisional_LogInput.asp?viewdivision=<%= viewdivision %>&base=<%= ors("Code") %>&type=FT&amp;viewtype=ALL">FT</a></li>
		    		<li><a href="divisional_LogInput.asp?viewdivision=<%= viewdivision %>&base=<%= ors("Code") %>&type=Task&amp;viewtype=ALL">Task</a></li>
		    		<li><a href="divisional_LogInput.asp?viewdivision=<%= viewdivision %>&base=<%= ors("Code") %>&type=NOPS&amp;viewtype=ALL">NOPS</a></li>
		    	</ul>
		    </li></ul>
            </li>
<%
  ors.movenext
loop
%>            
        </ul>
    </li>

   <!--
   <li><a href="#">Stage Area</a>
         <ul>
             <li><a href="divisional_StageInput.asp?viewDivision=GLOBAL">GLOBAL Stage Input</a></li>
             <li><a href="divisional_StageList.asp?viewDivision=GLOBAL">GLOBAL Stage List</a></li>
         </ul>
    </li>

   <li><a href="#">Library</a>
         <ul>
             <li><a href="#">Divisional Manuals</a></li>
             <li><a href="#">Training Docs</a></li>
         </ul>
    </li>
   -->
   <li><a href="#">Print</a>
         <ul>

             <li><a href="javascript:window.print();">Print Page</a></li>
             <li><a href="divisional_LogDisplay.asp?viewDivision=GLOBAL&amp;overflow=y">Printer Friendly</a></li>
             <li><a href="divisional_LogDisplay.asp?viewDivision=GLOBAL">Browser Friendly</a></li>
         </ul>
    </li>
<% if(session("sms_admin") = "y") then %>
    <li><a href="#">Admin</a>
        <ul>
            <li><a href="load_generic.asp">Load Generic</a></li>
            <li><a href="admin_user.asp">User</a></li>
            <li><a href="admin_base.asp">Base</a></li>
            <li><a href="admin_mission.asp">Mission</a></li>
            <li><a href="admin_aircraft.asp">Aircraft</a></li>
            <li><a href="editNews.asp">News</a></li>
        </ul>
    </li>
<% end if %>
</ul>
</div>

<!--End Nav -->

<!--Begin Quick Search -->
<div id="quicksearch">
<form action="divisional_LogDisplay.asp" method="post">

<input name="viewDivision" value="GLOBAL" type="hidden">

<input name="searchVal" id="searchVal" type="text" value="<%= request("searchVal") %>" class="quicksearchtext" style="width:200px; border:none; border: 0px solid black;">
<div id="quicksearchbttn">
<input class="quicksearchbttn" type="image" name="submit" src="smal_images/quicksearchBttn.gif" width="100" height="23" value="Quick Search" onClick="doSearch('GLOBAL')"  ></div>

</form>

</div>

<!--Begin Quick Search -->



</div>
<!--End Common Content-->
<br class="clear">