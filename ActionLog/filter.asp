<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
	<META http-equiv="Content-Type" content="text/html; charset=utf-8">
    </head>
    <body>
	<div bgcolor="#ffffff">
	    <!--
	    <form onsubmit="return window.confirm(&quot;You are submitting information to an external page.\nAre you sure?&quot;);">
	    -->
	    <form method="get" action="doFilter.asp">
		<table cellspacing="0" cellpadding="1" width="100%" border="0">
		    <tr>
			<td style="font-weight:bold;font-size:12pt;color:#000040;font-family:Arial" align="center" width="100%" bgcolor="#ffffff" colspan="4">Search/Filter</td>
		    </tr>
		    <tr>
			<td style="font-weight:normal;font-size:8pt;font-family:Arial" align="right" width="20%" bgcolor="#ffffff">Search by:</td>
			<td style="font-weight:normal;font-size:8pt;font-family:Arial" align="left" width="8%" bgcolor="#ffffff">
			    <select name="srt_searchfield1">
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
			<td><input type="text" name="srt_searchvalue1" size="50" width="70%" value=""></td>
		    </tr>
		    <tr>
			<td align="right" width="15%">
			    <select name="srt_boolean2">
				<option value="And">And</option>
				<option value="Or">Or</option>
				<!--
				These values will need to be worked into the disfunctional date query
				<option value="=">=</option>
				<option value="&gt;">&gt;</option>
				<option value="&lt;">&lt;</option>
				<option value="&lt;&gt;">&lt;&gt;</option>
				-->
			    </select>
			</td>
			<td style="font-weight:normal;font-size:8pt;font-family:Arial" align="left" width="8%" bgcolor="#ffffff">
			    <select name="srt_searchfield2">
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
			<td><input type="text" name="srt_searchvalue2" size="50" maxlength="100" value=""></td>
		    </tr>
		</table><br></br>
		<input type="submit" value="Submit" />
	    </form>
	</div>
    </body>
</html>
