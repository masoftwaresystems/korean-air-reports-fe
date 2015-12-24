<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%option explicit%>
<!--#include virtual="/ASPSpellCheck/ASPSpellInclude.inc"-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ASPSpellCheck Spell Buttons Example</title>
</head>
<body>
<p>Use the imageButtonHTML, linkHTML or buttonHTML functions to create an button that launches an MS Word&trade; style spellchecking pop-up window. </p>
<textarea name="MyTextArea1" id="MyTextArea1" cols="50" rows="7" >Hello teh worlb.  </textarea>

<textarea name="MyTextArea2" id="MyTextArea2" cols="50" rows="7" >You can use a comma seperated list of feilds ids ("MyTextArea1,MyTextArea2" ) or "all" to spellcheck multiplle fields at the same time. </textarea>

	   <%  
			dim myLink
			set myLink = new AspSpellLink
			myLink.fields="MyTextArea1,MyTextArea2"  '  "all" would also work

			response.write "<br>"			
			response.write myLink.imageButtonHTML("","","") 'Adds an image button to open the spellcheck

			response.write "<br>"			
			response.write myLink.linkHTML("Spell Check Link","") 'Adds a link to open the spellcheck
			
			response.write "<br>"
			response.write myLink.buttonHTML("Spell Check Button","") 'Adds a button to open the spellcheck

			set myLink=nothing
		%>

</body>
</html>
