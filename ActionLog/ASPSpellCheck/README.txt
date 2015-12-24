Manual
=====================================
web:  http://www.aspspellcheck.com/manual 

Installation Basics
=====================================
In brief, ASPSpellCheck is installed by copying the downloaded directory "ASPSpellCheck" to the root of your website.
    E.g. /ASPSpellCheck in your website or localhost


Usage Basics
=====================================
You can add a spell-check link or button to almost any Form Field or HTML element within your application using the ASPSpellLink Class.
Its basic usage is shown below:

    <!--#include virtual="/ASPSpellCheck/ASPSpellInclude.inc"-->
     
    <textarea id="MyTextArea" name="MyTextArea" cols="30" rows="10" >
    Hello World. Ths iz a tezt sampl.
    </textarea>
     
    <%
    dim myLink
    set myLink = new AspSpellLink
    myLink.fields="MyTextArea" ''Sets the Field id(s) to be spell-checked
    response.write myLink.imageButtonHTML("","","")
    response.write myLink.spellAsYouType()
    set myLink=nothing
    %>


Dictionary Basics
=====================================
You can install additional language dictionaries such as French, Spanish, German, Dutch, Portuguese and many Specialized English dictionaries. The dictionaries have the file extension .dic.

To install these dictionaries - first download them from www.aspspellcheck.com/downloads/ and place them in the "dictionaries" directory within your ASPSpellCheck Directory.


Support
=====================================
email:  support@aspspellcheck.com

