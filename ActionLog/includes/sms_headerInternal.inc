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

      	<div id="cent" style="font-size:16px;"><%= viewdivisionStr %> Action Log Reports</div>
<!--End Login Row-->

<br class="clear">

<!--Begin Nav -->

<div id="nav_div" style="width: 100%; padding-top: 5px; margin: 0pt auto;">

<ul id="nav_menu">
    <li><a href="index.asp">Home</a></li>
    <li><a href="internalReports.asp?viewdivision=EBU&amp;viewtype=BASE">EBU</a></li>
    <li><a href="internalReports.asp?viewdivision=COBU&amp;viewtype=BASE">COBU</a></li>
    <li><a href="internalReports.asp?viewdivision=IBU&amp;viewtype=BASE">IBU</a></li>
    <li><a href="internalReports.asp?viewdivision=NABU&amp;viewtype=BASE">NABU</a></li>
    <li><a href="internalReports.asp?viewdivision=WASBU&amp;viewtype=BASE">WASBU</a></li>
    <li><a href="internalReports.asp?viewdivision=AUSBU&amp;viewtype=BASE">AUSBU</a></li>
    <li><a href="internalReports.asp?viewdivision=BA&amp;viewtype=BASE">BA</a></li>
</ul>
</div>

<!--End Nav -->




</div>
<!--End Common Content-->
<br class="clear">