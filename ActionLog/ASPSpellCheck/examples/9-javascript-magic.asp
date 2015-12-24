<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%option explicit%>
<!--#include virtual="/ASPSpellCheck/ASPSpellInclude.inc"-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ASPSpellCheck - Javascript</title>
  <%  
		dim myLink
		set myLink = new AspSpellLink
		response.write myLink.initializeJavaScript()
		set myLink=nothing
	%>
</head>
<body>
<p>The initializeJavaScript function gives us full access to control the spellchecker using javascript using the $Spelling object.</p>
<p>This example creates live field validators ... but the possibilities are endless</p>

<label>
	<input name="input1" id="input1" type="text" value="Hello worlb" />
	<span id='message1' style='color:red;display:none'>* 
		<a href="#" onclick="$Spelling.SpellCheckInWindow('input1'); return false;">Check Spelling</a>
	</span>
</label>
<br/>
<label>
	<input name="input2" id="input2" type="text" value="Hello world" />
	<span id='message2' style='color:red;display:none'>* 
		<a href="#" onclick="$Spelling.SpellCheckInWindow('input2'); return false;">Check Spelling</a>
	</span>
</label>	
		
<script type='text/javascript'>	
$Spelling.LiveFormValidation  ('input1', 'message1'  )
$Spelling.LiveFormValidation  ('input2', 'message2'  )
</script>


</body>
</html>
