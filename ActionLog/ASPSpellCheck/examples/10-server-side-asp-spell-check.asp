<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%option explicit%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ASPSpellCheck Server Side pell Check Example</title>
</head>
<body>
<!--#include virtual="/ASPSpellCheck/core/asp/ASPSpellClass.asp"-->

<!--#include virtual="/ASPSpellCheck/core/settings/default-settings.asp"-->
<%
DIM LicenseKey, SaveToCentralDictionary, objASPSpell

Set objASPSpell = ASPSpellObjectProvider.Create("aspspellcheck")

  objASPSpell.ignoreCaseMistakes =false
  objASPSpell.ignoreAllCaps = true
  objASPSpell.IgnoreNumeric = true
  objASPSpell.IgnoreEmailAddresses = true
  objASPSpell.IgnoreWebAddresses = true
  objASPSpell.newLineNewSentance = false
  objASPSpell.LicenseKey = LicenseKey
  objASPSpell.DictionaryPath = "/ASPSpellCheck/dictionaries/"
  objASPSpell.AddCustomDictionary("custom.txt")
  objASPSpell.AddDictionary("English (International)")
  objASPSpell.LoadCustomBannedWords("language-rules/banned-words.txt")


DIM MyWord, AllDicts, BinSpellCheck, ArrSuggestions
 MyWord = "Helllo"


'''''''''''''''Dictionaries Loaded
AllDicts = objASPSpell.ListDictionaries()
RESPONSE.WRITE "Dictionaries: "&join(AllDicts,",")
RESPONSE.WRITE "<br/>"

'''''''''''''''Spellcheck True/False
BinSpellCheck = objASPSpell.SpellCheck(MyWord)
RESPONSE.WRITE	"Spellchecking ("&MyWord&") :  "&BinSpellCheck
RESPONSE.WRITE "<br/>"

'''''''''''''''Suggestions=
ArrSuggestions = objASPSpell.Suggestions(MyWord)
RESPONSE.WRITE "Suggestions: "&join(ArrSuggestions,",")



%>
</body>
</html>