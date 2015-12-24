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

if(viewdivision = "ACSE") then
  viewdivisionStr = "Generic Base"
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta name="robots" content="noindex,nofollow" />
<title>KE Hazard Safety Action Log</title>

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
<link rel="stylesheet" href="css/smalStyles.css" type="text/css" media="screen" />
<!--End Link to Style Sheet-->

</head>
<body onload="init();MM_preloadImages('smal_images/bttnActionLog_r.jpg','smal_images/bttnReports_r.jpg','smal_images/bttnNewItem_r.jpg','smal_images/bttnPrint_r.jpg','smal_images/bttnAdmin_r.jpg')">

<!--Begin Header-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td background="smal_images/headerBG.jpg">
    <table width="950" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="left" valign="bottom" style="padding-top:20px;"><img src="/global_images/ke_logo.png"></td>
  </tr>
  <tr>
    <td align="left" valign="bottom" height2="80" style="padding-top:0px;"><span style="font-size:20px;font-weight:bold;">Hazard Action Log System</span></td>
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
    <li><a href="splash.asp">Home</a></li>

    <li><a href="#">Action Log</a>
        <ul>


	    <li><a href="#">Division<img src="images/arrow-right.gif" border="0" style="padding-left: 20px;" alt="arrow-right"></a>
		<ul>
<%
sql = "select * from division_t order by division asc"
set tmprs = conn_asap.execute(sql)
do while not tmprs.eof
%>
		    <li><a href="#"><%= tmprs("code") %><img src="images/arrow-right.gif" border="0" style="padding-left: 20px;" alt="arrow-right"></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=<%= tmprs("code") %>&amp;viewtype=ALL">Detail Listing</a></li>
		    		<li><a href="divisional_Base.asp?viewdivision=<%= tmprs("code") %>&amp;viewtype=ACSE">Short Listing</a></li>
		    	</ul>
		    </li>
<%
  tmprs.movenext
loop
%>
		</ul>
		</li>
<% if(session("sms_admin") = "y") then %>
	    <li><a href="#">Generic<img src="images/arrow-right.gif" border="0" style="padding-left: 20px;" alt="arrow-right"></a>
		<ul>
		    <li><a href="#">GEN Hazards<img src="images/arrow-right.gif" border="0" style="padding-left: 20px;" alt="arrow-right"></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=GEN&amp;viewtype=ALL">Detail Listing</a></li>
		    		<li><a href="divisional_Base.asp?viewdivision=GEN&amp;viewtype=ACSE">Short Listing</a></li>
		    	</ul>
		    </li>
		</ul>
		</li>
<% end if %>
            <li><a href="advancedSearch2.asp?viewDivision=<%= viewdivision %>">Advanced Search</a></li>

        </ul>
    </li>
    <li><a href="#">Reports</a>
        <ul>
        	<li><a href="reports_Custom.asp">Custom</a></li>
        	<li><a href="reports_Overdue.asp">Overdue</a></li>
        </ul>
    </li>
<% if(((session("business_unit") <> "READONLY") and (session("sms_admin") = "y")) or ((session("sms_admin") = "b") and (session("business_unit") = viewdivision))) then %>
	    <li><a href="#">Add New</a>
		<ul>
				<li><a href="#"><%= viewdivision %><img src="images/arrow-right.gif" border="0" style="padding-left: 0px;" alt="arrow-right"></a>
				<ul>
		    		  <li><a href="divisional_LogInput.asp?viewdivision=<%= viewdivision %>&base=GEN&type=HAZ&amp;viewtype=ALL">Hazard</a></li>
		    		</ul>
		    		</li>
		</ul>
	    </li>
<% end if %>

<% if(session("sms_admin") = "y") then %>
    <li><a href="#">Admin</a>
        <ul>
            <li><a href="load_generic.asp">Load Generic</a></li>
            <li><a href="admin_user.asp">User</a></li>
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