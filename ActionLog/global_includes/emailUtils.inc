<%
Dim objMail
Dim objConfig
Dim objFields

Set objMail = CreateObject("CDO.Message")
Set objConfig = CreateObject("CDO.configuration")


'set eXML					= CreateObject("Microsoft.XMLDOM")
'eXML.async					= false
'eXML.load("c:\\inetpub\\wwwroot\\focus\\config.xml")
'eXML.load(server.mappath("/focus/config.xml"))


Set objFields = objConfig.Fields

With objFields
 .Item("http://schemas.microsoft.com/cdo/configuration/sendusing")= 2
 .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver")= "10.1.21.47"
 .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport")= 25
 .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate")= 0
 '.Item("http://schemas.microsoft.com/cdo/configuration/sendusername")= "mass@infinitevisions.ws"
 '.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword")= "demo4mail"
 
 .Update
End With

sub sendEmail(email_to, email_cc, email_bcc, email_from, email_subject, ByRef email_body)

email_from = "support@masoftwaresystems.com"

With objMail
  Set .Configuration = objConfig
      .To            = email_to
      .Cc		= email_cc
      .Bcc           = email_bcc
      .From          = email_from
      '.ReplyTo = "alex.vargas@delta.com,bunty.ramakrishna@delta.com"
      .Subject       = email_subject
      .TextBody = vbcrlf & email_body & vbcrlf
      .HTMLBody = email_body
      .Send
End With
  
end sub


sub sendSRTEmail(email_to, email_cc, email_bcc, email_from, email_subject, ByRef email_body, attachments)

email_from = "support@masoftwaresystems.com"

attachmentsArr = split(attachments,",")

Set objFSO = CreateObject("Scripting.FileSystemObject")

for a = 0 to ubound(attachmentsArr)
  sql = "select real_file_name, file_name from SRT_Attachments where recid = "& sqlnum(attachmentsArr(a))
  set tmprs = conn_asap.execute(sql)
  if not tmprs.eof then
    real_file_name = tmprs("real_file_name")
    file_name      = tmprs("file_name")
  
    objFSO.CopyFile Server.MapPath("./attachments/"& real_file_name), Server.MapPath("./attachments/"& file_name), true
  
    objMail.AddAttachment Server.MapPath("./attachments/"& tmprs("file_name"))
  end if
next 

email_cc = email_cc &","& session("email_address")

With objMail
  Set .Configuration = objConfig
      .To            = email_to
      .Cc		= email_cc
      .Bcc           = email_bcc
      .From          = email_from
      .ReplyTo = ""
      .Subject       = email_subject
      .TextBody = vbcrlf & email_body & vbcrlf
      .HTMLBody = email_body
      .Send
End With
  
end sub

%>