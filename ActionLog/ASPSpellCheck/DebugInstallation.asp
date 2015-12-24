<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%option explicit%>
<!--#include file="ASPSpellInclude.inc"-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ASPSpellCheck Sample</title>
</head>
<body>
<textarea name="MyTextArea" cols="50" rows="7" id="MyTextArea">Ths iz a tezt sampl. </textarea>
	   <%  
			dim myLink
			set myLink = new AspSpellLink
			myLink.fields="MyTextArea"
			response.write myLink.imageButtonHTML("","","")
			response.write myLink.spellAsYouType()
			set myLink=nothing
		%>
		<script type="text/javascript">
		    var LIVESPELL_DEBUG_MODE = true;
		</script>
</body>
</html>
