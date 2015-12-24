<!--#include file="includes/security.inc" -->
<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<%
unlockLogs
%>
	<section id="secondary_bar">
<!--#include file="includes/logged_in_user.inc"-->

		<div class="breadcrumbs_container">
			<article class="breadcrumbs"><a href="http://www.masoftwaresystems.us/miat/splash.aspx">Action Log</a> <div class="breadcrumb_divider"></div> <a class="current">Hazard Search</a></article>
		</div>
	</section><!-- end of secondary bar -->

<!--#include file="includes/sms_header3.inc"-->
<br/><br/>

<article class="module width_full">
<div class="module_content">
<h3>Hazard Search</h3>

<form name="frm" action="divisional_LogDisplay.aspx" method="get" >

<center>
<table cellpadding="0" cellspacing="2" style="font-family:Helvetica, Arial, Verdana, sans-serif;font-size:12px;">
    <tr>
        <td style="width:155px; text-align: right;">Please Enter Search Term:&nbsp;</td>
        <td><input type="TEXT" name="searchStr" id="searchStr" displayName="Search Term" style="width: 250px;" value="" class="textbox"></td>
    </tr>
        <tr>
			<td style="color: #cc0000; text-align: right;width:155px;"></td>
            <td style="padding-left:10px;text-align: left;width: 410px;">
<input type="submit" value="Search" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-right:0px;">
            </td>
        </tr>
</table>


<div style="height:15px;"></div>


</center>

</form>
    </div>
    </article>
<p></p>
