<!--#include file="includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<!--#include virtual="/global_includes/utils.inc"-->
<%
unlockLogs
%>
<%
if(request("logout") = "y") then
  session("loginID") = ""
  session("srt_admin") = ""
  session("username") = ""
  session("employee_number") = ""
  session("employee_type") = ""
  session("first_name") = ""
  session("last_name") = ""
  session("division") = ""
  session.abandon
end if

if(request("rc") = "1") then
  msg = "** Invalid Login **"
end if
if(request("rc") = "2") then
  msg = "** Not Administrator **"
end if
'msg = "** Down for Maintenance. Renumbering system. Please check back shortly. **"
'disable_buttons = "disabled"
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>SMAL</title>
		<style media="all" type="text/css">@import "css/styles-all.css";</style>
<script>
function forgotPassword() {
<% if(request("rc") = "1") then %>
  document.getElementById("passwordSPAN3").style.display = "none";
<% end if %>
  f = document.frm;
  if(f.employee_number.value == "") {
    alert("Please enter your Username into the field above   ");
  } else {
    loadXMLDoc("http://www.masoftwaresystems.us/miat/forgotPassword.asp?username="+f.employee_number.value);
  }
}
</script>
<script>
var req;
var responseXML;
var xmlDoc;
var passwordFound;

if(window.ActiveXObject)
{
  xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
} else {
  //xmlDoc = document.implementation.createDocument("","",null);
}

function loadXMLDoc(url) {
	req = false;
    // branch for native XMLHttpRequest object
    if(window.XMLHttpRequest && !(window.ActiveXObject)) {
    	try {
			req = new XMLHttpRequest();
        } catch(e) {
			req = false;
        }
    // branch for IE/Windows ActiveX version
    } else if(window.ActiveXObject) {
       	try {
        	req = new ActiveXObject("Msxml2.XMLHTTP");
      	} catch(e) {
        	try {
          		req = new ActiveXObject("Microsoft.XMLHTTP");
        	} catch(e) {
          		req = false;
        	}
		}
    }
    //alert("here 1");
	if(req) {
	    //alert("here 2");
	    //alert(url);
		req.onreadystatechange = processReqChange;
		req.open("GET", url, true);
		req.send("");
	}
}

function processReqChange() {
    // only if req shows "loaded"

    if (req.readyState == 4) {
        // only if "OK"
        if (req.status == 200) {
            // ...processing statements go here...
            //alert("seemed to work");
            //alert("response:"+req.responseText);
            responseXML = req.responseText;
            processResponse();
        } else {
            alert("There was a problem retrieving the XML data:\n" +
                req.statusText);
        }
    } else {
        //alert("not loaded");
    }
}

function processResponse() {
  //alert("responseXML:"+responseXML);

if(window.ActiveXObject)
{
  xmlDoc.async=false;
  xmlDoc.loadXML(responseXML);
  //alert(xmlDoc.xml);
  passwordFound = xmlDoc.selectSingleNode("//found").text;
} else {
  oParser = new DOMParser();
  xmlDoc = oParser.parseFromString(responseXML,"text/xml");
  x = xmlDoc.documentElement.childNodes;
  passwordFound = x[0].childNodes[0].nodeValue;
}
  //alert(minutesVal);
  //document.getElementById("minutes").value = minutesVal;
  document.getElementById("passwordSPAN1").style.display = "none";
  document.getElementById("passwordSPAN2").style.display = "none";
  if(passwordFound == "true") {
    document.getElementById("passwordSPAN1").style.display = "";
  } else {
    document.getElementById("passwordSPAN2").style.display = "";
  }
}
</script>

</head>

<body>
<div id="page-box-home">
  <div id="logo"> <a href="splash.aspx"><img src="images/miat_logo.png" alt="SMAL" /></a></div>
<br class="clear">
  <div id="topNav">
	<!--#include virtual="/miat/topNav.aspx" -->
    </div>
<br class="clear">

	<div id="tagline1">
    <img src="images/tagline-Corporate-Safety.png" width="750" height="107" alt="Corporate Safety, Security &amp; Compliance" />
    </div>
<br class="clear">

  <div id="tagline2">
    <img src="images/tagline-Action-Log.png" width="174" height="33" alt="Action Log" />
    </div>

  <div id="navRightActionLog">
<div id="loginTitle" style="visibility:hidden;"><img src="images/SMAL-Login.png" width="530" height="33" alt="ActionLog" /></div>
  	<div id="loginForm">
<span id="passwordSPAN1" style="color:red;font-weight:normal;display:none;">** Password Sent **</span>
<span id="passwordSPAN2" style="color:red;font-weight:normal;display:none;">** Username Does Not Exist **</span>
<% if(request("rc") = "1") then %>
<span id="passwordSPAN3" style="color:red;font-weight:normal;display:block;">** Invalid Username or Password **</span>
<% end if %>
		 <form name="frm" id="frm" action="validateLogin.asp" method="post">
         <div id="loginArrow"><img src="images/arrow-Login.png" alt="Login" width="145" height="102"  onclick="document.frm.submit()" /></div>
         <table width="375" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="loginForm">Username:&nbsp;</td>
    <td><label for="textfield"></label>
      <input name="employee_number" type="text" id="employee_number" size="40" style="width:300px;" /></td>
  </tr>
  <tr>
    <td class="loginForm">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="loginForm">&nbsp;Password: </td>
    <td><input name="password" type="password" id="password" size="40" style="width:300px;" /></td>
  </tr>
</table>
         <div id="forgetPswd"><a href="javascript:forgotPassword();">Forgot Password</a></div>
      </form>




    </div>
  </div>


<div id="footer-home">
	<!--#include virtual="/footer.aspx" -->
</div>

</div>
</body>
