<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%option explicit%>
<!--#include virtual="/ASPSpellCheck/ASPSpellInclude.inc"-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ASPSpellCheck - Any number of Elements</title>
</head>
<body>

<p>
By using myLink.fields intelligently - you can easily select 1 or all textareas on a page.
<ul>
<li>Select 1: myLink.fields="myFieldId"</li>
<li>Select Multiple: myLink.fields="myFieldId1,myFieldId2,myFieldId3"</li>
<li>Select all viable field on the page:  myLink.fields="all"</li>
<li>Select all textareas:  myLink.fields="textareas"</li>
<li>Select all input boxes: myLink.fields="textinputs"</li>
<li>Select all Rich HTML Editors: myLink.fields="editors"</li>
<li>Select all fields with a given CSS class: myLink.fields=".myCSSClassName"  </li>
</ul>
</p>

<textarea name="MyTextArea1" id="MyTextArea1" cols="50" rows="7" >Hello worlb. </textarea>
<textarea name="MyTextArea2" id="MyTextArea2" cols="50" rows="7" >Hello worlb. </textarea>
<textarea name="MyTextArea3" id="MyTextArea3" cols="50" rows="7" >Hello worlb. </textarea>
<textarea name="MyTextArea4" id="MyTextArea4" cols="50" rows="7" >Hello worlb. </textarea>
<textarea name="MyTextArea5" id="MyTextArea5" cols="50" rows="7" >Hello worlb. </textarea>

	   <%  
			dim myLink
			set myLink = new AspSpellLink
			myLink.fields="all"
			response.write myLink.imageButtonHTML("","","") 'Spell As You Type is only available for Textareas
			set myLink=nothing
		%>
</body>
</html>
