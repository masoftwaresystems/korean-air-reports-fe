<% ' vi: set foldmethod=marker syn=aspvbs linebreak softtabstop=2 tabstop=2 shiftwidth=2 expandtab: %>
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/security.inc"-->

<!--#include file="includes/loginInfo.inc"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>Bristow Group: Action Log</title>
    <meta name="keywords" content="Bristow Group"/>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
<!--#include file="script/nav.js"-->
    <% ' {{{ script %>
    <script type="text/javascript">
<!--#include file="script/display.asp"-->
    </script>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
<!--#include file="script/nav.js"-->
    <% ' }}} %>
    <script src="script/filterForm.js" type="text/javascript">
    </script>
  </head>
  <body onload="init()">
<!--#include file="includes/sms_header.inc"-->
    <div id="content">
      <form method="get" action="doFilter.asp">
        <div id="inputArea">
        </div>
        <input type="hidden" name="numFields" id="numFields" value="0" />
        <input type="button" onclick="javascript:addInput()" value="Add Input" />
        <input type="button" onclick="javascript:deleteInput()" value="Delete Input" />
        <input type="submit" />
      </form>
<!--#include file="includes/sms_footer.inc"-->
    </div>
  </body>
</html>
