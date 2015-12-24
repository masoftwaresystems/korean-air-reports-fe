<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/emailUtils.inc"-->
<%

division = request("division")
log_number = request("log_number")
requestor = request("requestor")

sql = "select lockedDate, lockedUser from SRT_Locks where log_number = "& sqlnum(log_number) &" and division = "& sqltext2(division)
set rs=conn_asap.execute(sql)
if not rs.eof then

  lockedDate = rs("lockedDate")
  lockedUser = rs("lockedUser")

  sql = "select email_address from Tbl_Logins where employee_number = "& sqltext2(lockedUser)
  set rs2=conn_asap.execute(sql)
  if not rs2.eof then
    email_to = rs2("email_address")
  else
    email_to = "support@masoftwaresystems.com"
  end if

  sql = "select first_name, last_name from Tbl_Logins where employee_number = "& sqltext2(requestor)
  set rs3=conn_asap.execute(sql)
  if not rs3.eof then
    requestor_name = rs3("first_name") &" "& rs3("last_name")
  end if

  msg = "Unlock request sent."

  log_numberStr	= string(4-len(log_number),"0")&log_number

  body = ""
  body = body& "Unlock Request<br><br>"
  body = body& "Log Number: "& division & log_numberStr &"<br>"
  body = body& "Requestor: "& requestor_name &"<br><br>"
  body = body& "<a href='http://www2.bristowsafety.com/sms_gal3/unlockLog.asp?division="& division &"&log_number="& log_number &"&employee_number="& lockedUser &"&requestor="& requestor &"'>Click here for unlock shortcut</a>"

  email_cc = ""
  email_bcc = "support@masoftwaresystems.com"
  email_from = ""
  email_subject = "SMS Unlock Request ("& division & log_numberStr &")"

  sendEmail email_to, email_cc, email_bcc, email_from, email_subject, body

else

  msg = "Log currently unlocked. Please refresh your browser."

end if
%><root><result><%= msg %></result></root>