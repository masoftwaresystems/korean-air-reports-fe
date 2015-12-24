<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%option explicit%>
<!--#include virtual="/ASPSpellCheck/ASPSpellInclude.inc"-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ASPSpellCheck Spell-As-You-Type Example</title>
</head>
<body>
<p>Use spellAsYouType to add in-context spellchecking with 'red-wiggly-underlines' to any or all textareas on a web page.</p>
<textarea name="MyTextArea" cols="50" rows="7" id="MyTextArea">This is is a spelll check as yuo type tezt. </textarea>
	   <%  
			dim myLink
			set myLink = new AspSpellLink
			myLink.fields="all"
			response.write myLink.spellAsYouType() 'Activates the "as-you-type" spelling suggestions
			set myLink=nothing
		%> 
</body>
</html>
