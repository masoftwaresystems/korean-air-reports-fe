<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%option explicit%>
<!--#include virtual="/ASPSpellCheck/ASPSpellInclude.inc"-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ASPSpellCheck - HTML DOM Elements Example</title>
</head>
<body>
<div id='myDOM' style='border:1px dotted red;width:50%' >To spell check an HTML element, add its id to the ASPSpellLink fields property. You can check almmost any tag or element.  Just like ths one.</div>

	   <%  
			dim myLink
			set myLink = new AspSpellLink
			myLink.fields="myDOM"
			response.write myLink.imageButtonHTML("","","") 'Spell As You Type is only available for Textareas
			set myLink=nothing
		%>
</body>
</html>
