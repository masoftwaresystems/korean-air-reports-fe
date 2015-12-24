<%@ Page language="c#" AutoEventWireup="false" %>
<%@ Register TagPrefix="uc" TagName="ContentDownloader" Src="/Controls/ContentDownloader.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>SMAL</title>

     <link href="styles/display.css" rel="stylesheet" type="text/css" />
     <link href="css/style.css" rel="stylesheet" type="text/css" />
 <!--#include file="script/nav.js"-->
 <link rel="stylesheet" href="/miat/louis-template-design-elements/css/layout.css" type="text/css" media="screen" />
 	<!--[if lt IE 9]>
 	<link rel="stylesheet" href="css/ie.css" type="text/css" media="screen" />
 	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
 	<![endif]-->
 
     <!--[if lt IE 8]>
     <style type="text/css">
 fieldset select {
     border: 1px solid #BBBBBB;
     color: #666666;
     height: 20px;
     margin: 0 12px;
     width: 96%;
 }
 #checkboxes{
 	padding-top:25px;
     padding-left:15px;
     margin-left:0;
 	list-style-type:none;}
 
 
     </style>
     <![endif]-->

 <script>
  <!--#include file="script/formatMask.js"-->
  </script>
<!--Add Link to Style Sheet-->
<link rel="stylesheet" href="css/smalStyles.css" type="text/css" media="screen" />
<!--End Link to Style Sheet-->
		<style media="all" type="text/css">@import "css/styles-all.css";</style>
		
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
 
<script> 
$(function() {
	$( ".datepicker1" ).datepicker({
	        minDate: 7, 
		changeMonth: true,
		changeYear: true,
		format: 'm/d/Y',
		date: '6/13/2012',
		current: '6/13/2012',
	    onBeforeShow: function(){
		$('.datepicker1').DatePickerSetDate('6/13/2012', true);
		}
	});
});
 
$(function() {
	$( ".datepicker2" ).datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'yy-mm-dd'
	});
});
</script>
</head>

<body >
<div id="page-box">
  <div id="logo"> <a href="splash.aspx"><img src="images/miat_logo.png" alt="SMAL" /></a></div>
<br class="clear">    
  <div id="topNav">
	<!--#include virtual="topNav.aspx" -->
    </div>
<div id="mainContent">
<uc:ContentDownloader id="Menu" runat="server" URL="/reports_Overdue.asp"></uc:ContentDownloader>
</div>
<br class="clear">
<div id="footer">
	<!--#include file="footer.aspx" -->
</div>

</div>
</body>
</html>