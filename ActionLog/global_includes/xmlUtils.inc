<%
' vi:foldmethod=marker
Function obj_exists(oRef)
   if TypeName(oRef) = "Empty" or TypeName(oRef) = "Nothing" then
        obj_exists = false
   else
        obj_exists = true
   end if
end Function

Dim S3Temp(1,1)


FUNCTION URLDecode(str)
	'// This function:
	'// - decodes any utf-8 encoded characters into unicode characters eg. (%C3%A5 = a)
	'// - replaces any plus sign separators with a space character
	'//
	'// IMPORTANT:
	'// Your webpage must use the UTF-8 character set. Easiest method is to use this META tag:
	'// <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	'//    
	Dim objScript    
	Set objScript = Server.CreateObject("ScriptControl")    
	objScript.Language = "JavaScript"    
	URLDecode = objScript.Eval("decodeURIComponent(""" & str & """.replace(/\+/g,"" ""))")
	Set objScript = NOTHING
END FUNCTION


function selectNode(x,n,alt)
  dim rval
  dim tmpNode
  rval = alt
  set tmpNode = x.selectSingleNode("//"& n)
  if(obj_exists(tmpNode)) then
    rval = x.selectSingleNode("//"& n).text
  end if
  
  if(len(rval) > 0) then
    rval = replace(rval,"|",",")
  end if
  
  'if(len(rval) = "NaN") then
  '  rval = alt
  'end if
  
  'selectNode = URLDecode(rval)
  selectNode = rval
end function

function selectNode2(x,n,alt)
  dim rval
  dim tmpNode
  rval = alt
  set tmpNode = x.selectSingleNode("//"& n)
  if(obj_exists(tmpNode)) then
    rval = x.selectSingleNode("//"& n).text
  end if
   
  'selectNode2 = URLDecode(rval)
  selectNode2 = rval
end function

function selectNodesText(x,n)

  dim rval
  dim tmpNodeList
  dim cnt
  rval = ""
  cnt = 0
  set tmpNodeList = x.selectNodes("//"& n) 
  for each node in tmpNodeList 
   if(cnt > 0) then
     rval = rval &","
   end if
   rval = rval & node.text 
   cnt = cnt +1
  next
  
  selectNodesText = rval
end function

' {{{ function xdata_test(d)
function xdata_test(d)
    ' {{{ Replacing ASCII Entities with Entity Names
    if(len(d) > 0) then
	d = replace(d,chr(38),"&amp;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(34),"&quot;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(39),"&apos;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(60),"&lt;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(62),"&gt;")
    end if
    ' }}}
    ' {{{ ISO 8859-1 Symbol Entities
    if(len(d) > 0) then
	d = replace(d,chr(160),"&nbsp;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(161),"&iexcl;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(162),"&cent;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(163),"&pound;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(164),"&curren;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(165),"&yen;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(166),"&brvbar;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(167),"&sect;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(168),"&uml;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(169),"&copy;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(170),"&ordf;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(171),"&laquo;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(172),"&not;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(173),"&shy;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(174),"&reg;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(175),"&macr;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(176),"&deg;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(177),"&plusmn;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(178),"&sup2;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(179),"&sup3;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(180),"&acute;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(181),"&micro;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(182),"&para;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(183),"&middot;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(184),"&cedil;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(185),"&sup1;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(186),"&ordm;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(187),"&raquo;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(188),"&frac14;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(189),"&frac12;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(190),"&frac34;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(191),"&iquest;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(215),"&times;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(247),"&divide;")
    end if
    ' }}}
    ' {{{ ISO 8859-1 Character Entities
    if(len(d) > 0) then
	d = replace(d,chr(192),"&Agrave;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(193),"&Aacute;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(194),"&Acirc;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(195),"&Atilde;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(196),"&Auml;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(197),"&Aring;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(198),"&AElig;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(199),"&Ccedil;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(200),"&Egrave;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(201),"&Eacute;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(202),"&Ecirc;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(203),"&Euml;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(204),"&Igrave;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(205),"&Iacute;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(206),"&Icirc;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(207),"&Iuml;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(208),"&ETH;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(209),"&Ntilde;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(210),"&Ograve;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(211),"&Oacute;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(212),"&Ocirc;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(213),"&Otilde;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(214),"&Ouml;")
    end if
    ' 215 is &times;
    if(len(d) > 0) then
	d = replace(d,chr(216),"&Oslash;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(217),"&Ugrave;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(218),"&Uacute;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(219),"&Ucirc;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(220),"&Uuml;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(221),"&Yacute;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(222),"&THORN;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(223),"&szlig;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(224),"&agrave;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(225),"&aacute;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(226),"&acirc;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(227),"&atilde;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(228),"&auml;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(229),"&aring;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(230),"&aelig;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(231),"&ccedil;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(232),"&egrave;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(233),"&eacute;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(234),"&ecirc;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(235),"&euml;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(236),"&igrave;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(237),"&iacute;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(238),"&icirc;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(239),"&iuml;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(240),"&eth;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(241),"&ntilde;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(242),"&ograve;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(243),"&oacute;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(244),"&ocirc;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(245),"&otilde;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(246),"&ouml;")
    end if
    ' 247 is &divide;
    if(len(d) > 0) then
	d = replace(d,chr(248),"&oslash;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(249),"&ugrave;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(250),"&uacute;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(251),"&ucirc;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(252),"&uuml;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(253),"&yacute;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(254),"&thorn;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(255),"&yuml;")
    end if
    ' }}}
    ' {{{ Some Other Entities Supported by HTML -> ISO 8859-1 characters
    ' http://www.swcs.com.au/ansi.htm oct codes as reference for Microsoft Windows Code Page 1252 Windows-1252 Latin
    ' These don't seem to work...
    ' convert left and right single quotation marks to &apos;
    d = replace(d,chr("&0221"),"&apos;")
    d = replace(d,chr("&0222"),"&apos;")
    ' convert left and right double quotes to &quot;
    d = replace(d,chr("&0223"),"&quot;")
    d = replace(d,chr("&0224"),"&quot;")
    ' convert en and em dash to -
    d = replace(d,chr("&0226"),"-")
    d = replace(d,chr("&0227"),"-")
    ' convert ellipsis to ...
    d = replace(d,chr("&0205"),"...")
    ' }}}

    xdata_test = d
end function
' }}}

function xdata(d)

  if(len(d) > 0) then
    d = replace(d,"&","&amp;")
  end if
  if(len(d) > 0) then
    d = replace(d,"""","&quot;")
  end if
  if(len(d) > 0) then
    d = replace(d,"<","&lt;")
  end if
  if(len(d) > 0) then
    d = replace(d,">","&gt;")
  end if
  if(len(d) > 0) then
    d = replace(d,"'","&apos;")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O221"),"&apos;")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O223"),"&apos;")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O222"),"&quot;")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O224"),"&quot;")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O225"),"-")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O226"),"-")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O227"),"-")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O230"),"")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O235"),"")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O215"),"")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O217"),"")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O220"),"")
  end if
  
'&O221 Left single-quote
'&O223 Left double-quote
'&O222 Right single-quote
'&O224 Right double-quote
'&O225 Small bullet
'&O226 En dash
'&O227 Em dash
'&O230 Tilde
'&O235 Unknown
'&O215 Unknown
'&O217 Unknown
'&O220 Unknown
  
  xdata = d
end function

function xdata2(d)

  if(len(d) > 0) then
    d = replace(d,"&","&amp;")
  end if
  if(len(d) > 0) then
    d = replace(d,"""","&quot;")
  end if
  if(len(d) > 0) then
    d = replace(d,"<","&lt;")
  end if
  if(len(d) > 0) then
    d = replace(d,">","&gt;")
  end if
  if(len(d) > 0) then
    d = replace(d,"'","&apos;")
  end if
  
  if(len(d) > 0) then
    d = replace(d,chr("&O221"),"'")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O223"),"""")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O222"),"'")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O224"),"""")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O225"),"-")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O226"),"-")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O227"),"-")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O230"),"")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O235"),"")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O215"),"")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O217"),"")
  end if
  if(len(d) > 0) then
    d = replace(d,chr("&O220"),"")
  end if
  
  if(len(d) > 0) then
    d = replace(d,chr("&O245"),"YEN")
  end if
  
  if(len(d) > 0) then
    d = replace(d,vbCrLf,"&#013;&#010;")
  end if
  if(len(d) > 0) then
    d = replace(d,vbCr,"&#013;")
  end if
  if(len(d) > 0) then
    d = replace(d,vbLf,"&#010;")
  end if
   
  
'&O221 Left single-quote
'&O223 Left double-quote
'&O222 Right single-quote
'&O224 Right double-quote
'&O225 Small bullet
'&O226 En dash
'&O227 Em dash
'&O230 Tilde
'&O235 Unknown
'&O215 Unknown
'&O217 Unknown
'&O220 Unknown
  
  xdata2 = d
end function



function rev_xdata2(d)

  if(len(d) > 0) then
    d = replace(d,"&amp;","&")
  end if
  if(len(d) > 0) then
    d = replace(d,"&quot;","""")
  end if
  if(len(d) > 0) then
    d = replace(d,"&lt;","<")
  end if
  if(len(d) > 0) then
    d = replace(d,"&gt;",">")
  end if
  if(len(d) > 0) then
    d = replace(d,"&apos;","'")
  end if
  
  if(len(d) > 0) then
    d = replace(d,"&#013;&#010;",vbCrLf)
  end if
  if(len(d) > 0) then
    d = replace(d,"&#013;",vbCr)
  end if
  if(len(d) > 0) then
    d = replace(d,"&#010;",vbLf)
  end if 
  
  rev_xdata2 = d
end function


function addTags(d)

  if(len(d) > 0) then
    d = replace(d,vbCrLf,"<br>")
  end if

  addTags = d
end function

function xdata5(d)
    if(len(d) > 0) then
	d = replace(d,chr(38),"&#38;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(62),"&#62;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(34),"&#34;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(39),"&#39;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(60),"&#60;")
    end if
    
    if(len(d) > 0) then
	d = replace(d,chr(120),"&#120;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(121),"&#121;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(122),"&#122;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(123),"&#123;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(124),"&#124;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(125),"&#125;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(126),"&#126;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(127),"&#127;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(128),"&#128;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(129),"&#129;")
    end if

    if(len(d) > 0) then
	d = replace(d,chr(130),"&#130;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(131),"&#131;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(132),"&#132;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(133),"&#133;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(134),"&#134;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(135),"&#135;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(136),"&#136;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(137),"&#137;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(138),"&#138;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(139),"&#139;")
    end if
    
    if(len(d) > 0) then
	d = replace(d,chr(140),"&#140;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(141),"&#141;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(142),"&#142;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(143),"&#143;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(144),"&#144;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(145),"&#145;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(146),"&#146;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(147),"&#147;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(148),"&#148;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(149),"&#149;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(150),"&#150;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(160),"&#160;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(161),"&#161;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(162),"&#162;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(163),"&#163;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(164),"&#164;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(165),"&#165;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(166),"&#166;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(167),"&#167;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(168),"&#168;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(169),"&#169;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(170),"&#170;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(171),"&#171;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(172),"&#172;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(173),"&#173;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(174),"&#174;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(175),"&#175;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(176),"&#176;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(177),"&#177;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(178),"&#178;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(179),"&#179;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(180),"&#180;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(181),"&#181;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(182),"&#182;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(183),"&#183;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(184),"&#184;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(185),"&#185;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(186),"&#186;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(187),"&#187;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(188),"&#188;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(189),"&#189;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(190),"&#190;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(191),"&#191;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(215),"&#215;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(247),"&#247;")
    end if

    if(len(d) > 0) then
	d = replace(d,chr(192),"&#192;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(193),"&#193;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(194),"&#194;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(195),"&#195;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(196),"&#196;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(197),"&#197;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(198),"&#198;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(199),"&#199;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(200),"&#200;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(201),"&#201;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(202),"&#202;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(203),"&#203;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(204),"&#204;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(205),"&#205;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(206),"&#206;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(207),"&#207;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(208),"&#208;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(209),"&#209;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(210),"&#210;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(211),"&#211;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(212),"&#212;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(213),"&#213;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(214),"&#214;")
    end if
    ' 215 is &times;
    if(len(d) > 0) then
	d = replace(d,chr(216),"&#216;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(217),"&#217;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(218),"&#218;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(219),"&#219;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(220),"&#220;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(221),"&#221;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(222),"&#222;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(223),"&#223;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(224),"&#224;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(225),"&#225;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(226),"&#226;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(227),"&#227;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(228),"&#228;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(229),"&#229;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(230),"&#230;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(231),"&#231;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(232),"&#232;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(233),"&#233;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(234),"&#234;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(235),"&#235;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(236),"&#236;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(237),"&#237;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(238),"&#238;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(239),"&#239;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(240),"&#240;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(241),"&#241;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(242),"&#242;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(243),"&#243;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(244),"&#244;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(245),"&#245;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(246),"&#246;")
    end if
    ' 247 is &divide;
    if(len(d) > 0) then
	d = replace(d,chr(248),"&#248;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(249),"&#249;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(250),"&#250;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(251),"&#251;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(252),"&#252;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(253),"&#253;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(254),"&#254;")
    end if
    if(len(d) > 0) then
	d = replace(d,chr(255),"&#255;")
    end if

    xdata5 = d
end function
%>
