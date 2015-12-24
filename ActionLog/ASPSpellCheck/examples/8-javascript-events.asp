<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%option explicit%>
<!--#include virtual="/ASPSpellCheck/ASPSpellInclude.inc"-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ASPSpellCheck - Javascript Events</title>
</head>
<body>

<p>The scriptID property lets us access our spellchecker to attach client-side events</p>

<textarea name="MyTextArea" cols="50" rows="7" id="MyTextArea">Hello worlb. </textarea>
	   <%  
			dim myLink
			set myLink = new AspSpellLink
			myLink.fields="MyTextArea"
			response.write myLink.imageButtonHTML("","","") 'Adds a button
		%>
		
		<script type='text/javascript'>
			<%=myLink.scriptID%>.onDialogOpen = function(){ alert ('Custom Event: onDialogOpen')}
		</script>
		
		<%  
			set myLink=nothing
		%>
		
<p>
Available javascript events - which work with SpellAsYouType aswell as with buttons.
<ul>
<li>   	onDialogOpen () </li>
<li>    onDialogComplete () </li>
<li>    onDialogCancel () </li>
<li>    onDialogClose () </li>
<li>    onChangeLanguage (Language) </li>
<li>    onIgnore (Word) </li>
<li>    onIgnoreAll (Word) </li>
<li>    onChangeWord (From, To) </li>
<li>    onChangeAll (From, To) </li>
<li>    onLearnWord (Word) </li>
<li>    onLearnAutoCorrect (From, To) </li>
<li>    onUpdateFields (arrFieldIds) </li>
</ul>
</p>

</body>
</html>
