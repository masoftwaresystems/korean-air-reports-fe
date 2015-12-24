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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta name="robots" content="noindex,nofollow" />
<title>KE Hazard Safety Action Log</title>

<script>
function forgotPassword() {
<% if(request("rc") = "1") then %>
  document.getElementById("passwordSPAN3").style.display = "none";
<% end if %>
  f = document.frm;
  if(f.employee_number.value == "") {
    alert("Please enter your Username into the field above   ");
  } else {
    loadXMLDoc("http://infinitevisions.ws/$sitepreview/citsouth.com/safety/sms_gal3/forgotPassword.asp?username="+f.employee_number.value);
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

<!--Add Link to Style Sheet-->
<link rel="stylesheet" href="css/smalStyles.css" type="text/css" media="screen" />
<!--End Link to Style Sheet-->

<script type="text/javascript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
</head>
<body onload="init();MM_preloadImages('smal_images/bttnActionLog_r.jpg','smal_images/bttnReports_r.jpg','smal_images/bttnNewItem_r.jpg','smal_images/bttnPrint_r.jpg','smal_images/bttnAdmin_r.jpg')">

<!--Begin Header-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td background="smal_images/headerBG.jpg">
    <table width="950" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="left" valign="bottom" style="padding-top:20px;"><img src="/global_images/ke_logo.png"></td>
  </tr>
  <tr>
    <td align="left" valign="bottom" height2="80" style="padding-top:0px;"><span style="font-size:20px;font-weight:bold;">Hazard Action Log System</span></td>
  </tr>
</table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#edeae3"><img src="smal_images/clear.gif" alt="clear" width="1" height="5"></td>
  </tr>
  <tr>
    <td background="smal_images/headerStripe.gif"><img src="smal_images/headerStripe.gif" alt="stripe" width="6" height="27"></td>
  </tr>
</table>
<!--End Header-->

<!--Begin Common Content-->
<div id="page-box">

      <!--Begin Login Row-->
      <p style="text-align: center;">Global Operations Action Log</p>
		<!--Begin Login Form-->
  <div id="loginPage">
          <form name="frm" id="frm" action="validateLogin.asp" method="post">
            <table width="500" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td align="center" valign="top">Hazard Action Log System
                      Login</td>
                  </tr>
                </table>
                  <table border="0" align="center" cellpadding="3" cellspacing="0">
                    <tr>
                      <td>Username:</td>
                      <td><input class="loginTextfield" type="text" style="width:245px; border:none; border: 0px solid black;" name="employee_number" value="" /></td>
                    </tr>
                    <tr>
                      <td align="right">Password:</td>
                      <td><input class="loginTextfield" style="width:245px; border:none; border:0px solid black;" type="password" name="password" value="" /></td>
                    </tr>
                    <tr>
                      <td align="right">&nbsp;</td>
                      <td><span onclick2="document.location='manage_focus.asp'" onclick="document.frm.submit()"><img src="global_images/loginBttn.gif" alt="login button" width="47" height="22" /></span><br><br><a style="color:black;" href="javascript:forgotPassword();">Forgot Password</a></td>
                    </tr>
<% if(isInternal) then %>
                    <tr>
                      <td align="right">&nbsp;</td>
                      <td><a style="color:black;" href="internalReports.asp" target="_blank">View Reports</a></td>
                    </tr>
<% end if %>
                    <tr>
                      <td align="right">&nbsp;</td>
                      <td>
<span id="passwordSPAN1" style="color:red;font-weight:normal;display:none;">** Password Sent **</span>
<span id="passwordSPAN2" style="color:red;font-weight:normal;display:none;">** Username Does Not Exist **</span>
<% if(request("rc") = "1") then %>
<span id="passwordSPAN3" style="color:red;font-weight:normal;display:block;">** Invalid Username or Password **</span>
<% end if %>
                      </td>
                    </tr>
                  </table></td>
              </tr>
            </table>
            </form>
</div>

<!--End Login Form-->

</div>
<!--End Page Box-->
<br class="clear">
<!--Begin Copyright Row-->
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#edeae3">
  <tr>
    <td>
    <!--Begin Copyright Include-->
    <div id="copyright">
    <!--#include file="capacitSoft_copyright.inc"-->
    </div>
    <!--End Copyright Include-->


    </td>
  </tr>
</table>

<!--End Copyright Row-->
</body>
</html>

<xml id="xmlhttpSvc"></xml>