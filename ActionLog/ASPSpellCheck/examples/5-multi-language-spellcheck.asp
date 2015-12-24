<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%option explicit%>
<!--#include virtual="/ASPSpellCheck/ASPSpellInclude.inc"-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ASPSpellCheck Multi Language Example</title>
</head>
<body>
<p>Example: Spell Checks in French and English simultaneously, with a french User-Interface.</p>
<p>Use dictionary to set the default dictionary language and dialogLanguage to set the user interface locale.  Note - you need to download and install the French dictionary to use this example properly.</p>

<textarea name="MyTextArea" cols="50" rows="7" id="MyTextArea">Hello World. Bonjour la Monde.</textarea>
	   <%  
			dim myLink
			set myLink = new AspSpellLink
			myLink.fields="MyTextArea"
			myLink.dictionary = "Francais, English (International)"
			myLink.dialogLanguage = "fr"
			response.write myLink.imageButtonHTML("","","") 'Adds a button
			response.write myLink.spellAsYouType() 'Activates the "as-you-type" spelling suggestions
			set myLink=nothing
		%>
</body>
</html>
