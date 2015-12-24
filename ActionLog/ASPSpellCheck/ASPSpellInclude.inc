<%


class AspSpellLink

private  setting_Session, setting_Fields, setting_DictPath, setting_CustomDict, setting_AllCaps, setting_Web  , setting_Numeric  , setting_NewLine  , setting_CSS, setting_Grammar, setting_CaseSensitive ,setting_UILang , setting_Langs, setting_MultiLang, setting_ASPSPELLPATH, setting_AutoClose, setting_strAlert, G_callback, included_yet, setting_form, setting_strict, setting_ShowMeanings, setting_WindowMode

public scriptID
public AddWordsToDictionary
public property let dictionary(strInput)
dim arrLangs, intLangItterand, strLangItterand, intLangCount, strLangs
setting_MultiLang=false
strInput = trim(""&strInput)
if strInput="" then setting_Langs="" : exit property 

arrLangs = split(strInput,",")
intLangCount=0

strLangs="" 
for intLangItterand = 0 to ubound(arrLangs) 
strLangItterand=trim(""&arrLangs(intLangItterand))
if strLangItterand<>"" then intLangCount=intLangCount+1
if strLangs<>"" then strLangs=strLangs&","
strLangs=strLangs&strLangItterand
next
setting_Langs = strLangs
if intLangCount>1 then setting_MultiLang=true
end property

public property get dictionary
dictionary=setting_Langs
end property


public property let javaScriptCallback (strInput)
	G_callback=strInput&""
end property

public property get javaScriptCallback
	javaScriptCallback=G_callback
end property


public property let aspSpellPath(strInput)
	setting_ASPSPELLPATH=strInput
end property

public property get aspSpellPath
	aspSpellPath=setting_ASPSPELLPATH
end property


public property let hideSummary(binFlag)
	setting_AutoClose=(binFlag=true)
end property

public property get hideSummary
	hideSummary=setting_AutoClose
end property

public property let fields (strInput)
	setting_Fields=(strInput)
end property

public property get fields
	fields=setting_Fields
end property

public property let ignoreAllCaps (binFlag)
	setting_AllCaps=(binFlag=true)
end property

public property get ignoreAllCaps
	ignoreAllCaps=setting_AllCaps
end property

public property let ignoreNumbers (binFlag)
	setting_Numeric=(binFlag=true)
end property

public property get ignoreNumbers
	ignoreNumbers=setting_Numeric
end property

public property let checkGrammar (binFlag)
	setting_Grammar=(binFlag=true)
end property

public property get checkGrammar 
	checkGrammar=setting_Grammar
end property

public property let caseSensitive (binFlag)
	setting_CaseSensitive=(binFlag=true)
end property

public property get caseSensitive
	caseSensitive=setting_CaseSensitive
end property

public property let CSSTheme (strInput)
	setting_CSS=strInput
end property

public property get CSSTheme
	externalCSS=setting_CSS
end property

public property let dialogLanguage (strInput)
	setting_UILang=strInput
end property

public property get dialogLanguage
	dialogLanguage=setting_UILang
end property

public property let formToSubmit (strInput)
	setting_form=strInput
end property

public property get formToSubmit
	formToSubmit=setting_form
end property



public property let strict (strInput)
	setting_strict=strInput
end property

public property get strict
	strict=setting_strict
end property


public property let showMeanings (binFlag)
	setting_ShowMeanings=(binFlag=true)
end property

public property get showMeanings
	showMeanings=setting_ShowMeanings
end property


public property let windowMode (binFlag)
	setting_WindowModes=strInput
end property

public property get windowMode
	windowMode=setting_WindowMode
end property

public function linkHTML(linkText,CSSclass)
linkHTML =  addCodeBlocks( getInstance()&".DrawSpellLink(false,'"&linkText&"','"&CSSclass&"','');")
end function

public function buttonHTML(buttonText,CSSclass)
buttonHTML =  addCodeBlocks( getInstance()&".DrawSpellButton(false,'"&buttonText&"','"&CSSclass&"','');")
end function


public function imageButtonHTML(buttonImage,rolloverImage, buttonText)
imageButtonHTML =  addCodeBlocks( getInstance()&".DrawSpellImageButton(false, '"&buttonImage&"','"&rolloverImage&"','"&buttonText&"','aspspellcheck','');")
end function

public function spellAsYouType()
spellAsYouType =  addCodeBlocks( getInstance()&".ActivateAsYouTypeOnLoad();")
end function


public function initializeJavaScript()
initializeJavaScript =  addCodeBlocks( "$Spelling.ServerModel='asp';$Spelling.isUniPacked=false;$Spelling.Theme='classic';$Spelling.PopUpStyle='modal';$Spelling.ShowLanguagesInContextMenu=true;$Spelling.ShowStatisticsScreen=true;")
end function



private function  getInstance()
dim id
id = getId()
getInstance =  "var "&id&"=new LiveSpellInstance();"&id&".ServerModel=""asp"";"

if(Not IsEmpty(setting_Fields)) then getInstance = getInstance & id&".Fields='"&setting_Fields&"';"	
if(Not IsEmpty(setting_UILang)) then getInstance = getInstance & id&".SetUserInterfaceLanguage('"&setting_UILang&"');"	
if(Not IsEmpty(setting_CSS)) then getInstance = getInstance & id&".setting_CSS='"&setting_CSS&"';"
if(Not IsEmpty(setting_CaseSensitive)) then getInstance = getInstance & id&".CaseSensitive="&bool2str(setting_CaseSensitive)&";"	
if(Not IsEmpty(setting_Grammar)) then getInstance = getInstance & id&".CheckGrammar="&bool2str(setting_Grammar)&";"	
if(Not IsEmpty(setting_Numeric)) then getInstance = getInstance & id&".IgnoreNumeric="&bool2str(setting_Numeric)&";"	
if(Not IsEmpty(setting_AllCaps)) then getInstance = getInstance & id&".IgnoreAllCaps="&bool2str(setting_AllCaps)&";"	
if(Not IsEmpty(setting_AutoClose)) then getInstance = getInstance & id&".ShowSummaryScreen="&bool2str(NOT setting_AutoClose)&";"	
if(Not IsEmpty(setting_Langs)) then getInstance = getInstance & id&".Language='"&setting_Langs&"';"
if(Not IsEmpty(setting_WindowMode)) then getInstance = getInstance & id&".WindowMode='"&setting_WindowMode&"';"
if(Not IsEmpty(setting_strict)) then getInstance = getInstance & id&".Strict="&bool2str(setting_strict)&";"
if(Not IsEmpty(setting_ShowMeanings)) then getInstance = getInstance & id&".FormToSubmit="&bool2str(setting_ShowMeanings)&";"
if(Not IsEmpty(setting_form)) then getInstance = getInstance & id&".FormToSubmit='"&setting_form&"';"
if(setting_MultiLang = true) then getInstance = getInstance & id&".MultiDictionary=true;"
if(AddWordsToDictionary <> "USER") then getInstance = getInstance & id&".AddWordsToDictionary='"&AddWordsToDictionary&"';"	
	
	
	getInstance = getInstance&id
end function

private function  bool2str(i)
if i = true then bool2str = "true" else bool2str = "false"
end function


private function  getId()
pASPSpellLinkCount = pASPSpellLinkCount+1
scriptID = "$ASPSpellCheck$"&pASPSpellLinkCount
getId = scriptID
end function

private function includeJS()
	dim pmap
	if(included_yet=setting_ASPSPELLPATH) then includeJS = "" : exit function
	pmap = setting_ASPSPELLPATH
	included_yet = pmap
	if(right(pmap,1)<>"/") then	pmap = pmap & "/"
	pmap = pmap & "include.js"
	includeJS =  "<script type='text/javascript' src='"&pmap&"'></script>"
end function

private function addCodeBlocks(input)

	addCodeBlocks = includeJS()&"<script type='text/javascript'>"&input&"</script>"

end function

private sub Class_Initialize() 
G_callback=""
included_yet = false
setting_ASPSPELLPATH="/ASPSpellCheck/"
AddWordsToDictionary = "USER"
end sub  

 
private sub Class_Terminate() 
end sub  

end class

Dim pASPSpellLinkCount
pASPSpellLinkCount = 0
%>