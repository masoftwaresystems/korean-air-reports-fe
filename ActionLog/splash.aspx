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
 
       <script type="text/javascript" src="https://www.google.com/jsapi"></script>
 	<script src="/miat/louis-template-design-elements/js/jquery-1.5.2.min.js" type="text/javascript"></script>
 	<script src="/miat/louis-template-design-elements/js/hideshow.js" type="text/javascript"></script>
 	<script src="/miat/louis-template-design-elements/js/jquery.tablesorter.min.js" type="text/javascript"></script>
 	<script type="text/javascript" src="/miat/louis-template-design-elements/js/jquery.equalHeight.js"></script>
     <script type="text/javascript">
       google.load("visualization", "1", {packages:["corechart"]});
       google.setOnLoadCallback(drawChart);
       function drawChart() {
         var data = google.visualization.arrayToDataTable([
           ['Task', 'Hours per Day'],
           ['data element 1',     11],
           ['data element 2',      2],
           ['data element 3',  2],
           ['data element 4', 2],
           ['data element 5',    7]
         ]);
 
         var options = {
           title: 'Pie Chart Example'
 
         };
 
 
 
         var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
         chart.draw(data, options);
       }
     </script>
 	<script type="text/javascript">
 	$(document).ready(function()
     	{
       	  $(".tablesorter").tablesorter();
    	 }
 	);
 	$(document).ready(function() {
 
 	//When page loads...
 	$(".tab_content").hide(); //Hide all content
 	$("ul.tabs li:first").addClass("active").show(); //Activate first tab
 	$(".tab_content:first").show(); //Show first tab content
 
 	//On Click Event
 	$("ul.tabs li").click(function() {
 
 		$("ul.tabs li").removeClass("active"); //Remove any "active" class
 		$(this).addClass("active"); //Add "active" class to selected tab
 		$(".tab_content").hide(); //Hide all tab content
 
 		var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
 		$(activeTab).fadeIn(); //Fade in the active ID content
 		return false;
 	});
 
 });
     </script>
     <script type="text/javascript">
     $(function(){
         $('.column').equalHeight();
     });
</script>


 <script>
  <!--#include file="script/formatMask.js"-->
  </script>
<!--Add Link to Style Sheet-->
<link rel="stylesheet" href="css/smalStyles.css" type="text/css" media="screen" />
<!--End Link to Style Sheet-->
		<style media="all" type="text/css">@import "css/styles-all.css";</style>
</head>

<body >
<div id="page-box">
  <div id="logo"> <a href="splash.aspx"><img src="images/miat_logo.png" alt="SMAL" /></a></div>
<br class="clear">    
  <div id="topNav">
	<!--#include virtual="topNav.aspx" -->
    </div>
<div id="mainContent">
<uc:ContentDownloader id="Menu" runat="server" URL="/splash.asp"></uc:ContentDownloader>
</div>
<br class="clear">
<div id="footer">
	<!--#include file="footer.aspx" -->
</div>

</div>
</body>
</html>