<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%option explicit%>
<!--#include virtual="/ASPSpellCheck/ASPSpellInclude.inc"-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ASPSpellCheck - Spellchecking and then Submitting a form</title>
</head>
<body>
<form id='form1' method='get' action='default.asp'>
<p>The formToSubmit property allows you to submit a form when spellchecking (in a dialog window) is complete</p>
<p>The hideSummary property is used to turn off the spell checker's summary screen after spell checking.</p>
<p>In more complex cases you may wish o use the javascript events model (such as onDialogComplete) instead see example 8. </p>

<textarea name="MyTextArea" cols="50" rows="7" id="MyTextArea">Hello worlb. </textarea>

	   <%  
			dim myLink
			set myLink = new AspSpellLink
			myLink.fields="MyTextArea"
			myLink.hideSummary=true
			myLink.formToSubmit="form1" ' id of the main form
			response.write myLink.buttonHTML("Spell Check & Submit","") 'Adds a spell & submit button
			response.write myLink.spellAsYouType() 'Activates the "as-you-type" spelling suggestions
			set myLink=nothing
		%>
</form>		
</body>
</html>
