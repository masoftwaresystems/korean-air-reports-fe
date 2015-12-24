<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%option explicit%>
<!--#include virtual="/ASPSpellCheck/ASPSpellInclude.inc"-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ASPSpellCheck Hello World Example</title>
</head>
<body>
<textarea name="MyTextArea" cols="50" rows="7" id="MyTextArea">Hello worlb. </textarea>
	   <%  
			dim myLink
			set myLink = new AspSpellLink
			myLink.fields="MyTextArea"
			response.write myLink.imageButtonHTML("","","") 'Adds a button
			response.write myLink.spellAsYouType() 'Activates the "as-you-type" spelling suggestions
			set myLink=nothing
		%>
</body>
</html>
