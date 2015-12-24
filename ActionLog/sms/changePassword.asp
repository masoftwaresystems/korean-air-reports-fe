<!--#include file="includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta name="robots" content="noindex,nofollow" />
<title>Bristow Action Log</title>
<script type="text/javascript">
         function isEmpty(str) {
            // Check whether string is empty.
            for (var intLoop = 0; intLoop < str.length; intLoop++)
               if (" " != str.charAt(intLoop))
                  return false;
            return true;
         }

         function checkRequired() {
            f = frm;
            var strError = "";
            for (var intLoop = 0; intLoop < f.elements.length; intLoop++)
               if (null!=f.elements[intLoop].getAttribute("required"))
                  if (isEmpty(f.elements[intLoop].value))
                     strError += "  " + f.elements[intLoop].name + "\n";
            if ("" != strError) {
               alert("Required data is missing:\n" + strError);
               return false;
            } else {
            //checkCheckboxes();
            //checkAgreement();
              if(fieldsMatch()) {
                f.submit();
                return true;
              } else {
                return false;
              }
            }
         }
         function fieldsMatch() {
           if(frm.password.value != frm.password2.value) {
             alert("Passwords do not match");
             frm.password.value = "";
             frm.password2.value = "";
             frm.password.focus();
             return false;
           } else {
             return true;
           }
         }
</script>
<!--Add Link to Style Sheet-->
<link rel="stylesheet" href="/sms_ehd3/css/smalStyles.css" type="text/css" media="screen" />
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
    <td align="center" valign="top"><img src="smal_images/header.jpg" alt="Bristow Safety Management Action Log" width="950" height="123" /></td>
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
		<!--Begin Login Form-->
  <div id="loginPage">
          <form name="frm" id="frm" action="do_changePassword.asp" method="post">
          <center>
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:20px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:14px;color:#737579;">Password Change<br><span style="font-size:12px;font-weight:bold;">You must change your password</span></span></td></tr>
</table>

<% if(len(msg) > 0) then %>
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:10px;color:red;font-weight:bold;"><%= msg %></span></td></tr>
</table>
<% end if %>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pgrey.gif" width="100%" height="1"></td></tr>
</table>

<table border="0" cellspacing="5" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">New Password :</span></td>
    <td width="60%" align="left"><input type="password" class="input6" name="password" style="width:195px;" value="" required></td>
  </tr>
  <tr>
    <td width="40%" align="right"><span class="fonts1" style="color:#737579;">Retype Password :</span></td>
    <td width="60%" align="left"><input type="password" class="input6" name="password2" style="width:195px;" value="" required></td>
  </t
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:25px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pgrey.gif" width="100%" height="1"></td></tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="margin-top:15px;margin-left:10px;" bgColor="white" >
  <tr>
    <td width="100%" align="center">
      <input type="button" value="Change Password" class="button1" style="width:250" onclick="checkRequired()">
    </td>
  </tr>
  <tr>
    <td width="100%" align="center" height="50"></td>
  </tr>
</table>
</center>
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