<%
function isLogLocked(l,d)
  dim rval
  dim rs
  dim sql
  dim tmprs
  
  sql = "select * from SRT_Locks where log_number = "& sqlnum(l) &" and division = "& sqltext2(d)
  set rs = conn_asap.execute(sql)
  if not rs.eof then
    rval = rs("lockedUser")
  else
    rval = "n"
  end if
  
  if(rval = session("employee_number")) then
    rval = "n"
  end if
  
  if(rval <> "n") then
    sql = "select first_name, last_name from Tbl_Logins where employee_number = "& sqltext2(rval)
    set tmprs = conn_asap.execute(sql)
    if not tmprs.eof then
      rval = left(tmprs("first_name"),1) &" "& tmprs("last_name")
    end if
  end if
     
  isLogLocked = rval
end function

function lockLog(l,d)
  dim rval
  dim rs
  dim sql
  
  sql = "select isnull(max(recid),0) maxid from SRT_Locks"
  set rs = conn_asap.execute(sql)
  if not rs.eof then
    maxid = rs("maxid")
  end if
  maxid = cint(maxid) +1
  
  sql = "insert into SRT_Locks (recid, log_number, lockedUser, division, lockeddate) values ("& sqlnum(maxid) &","& sqlnum(l) &","& sqltext2(session("employee_number")) &","& sqltext2(d) &", getDate())"
  conn_asap.execute(sql)
  rval = "0"
     
  lockLog = rval
end function

function unlockLogs
  dim rval
  dim rs
  dim sql
  
  sql = "delete from SRT_Locks where lockedUser = "& sqltext2(session("employee_number"))
  conn_asap.execute(sql)
  rval = "0"
     
  unlockLog = rval
end function

sql = "delete from SRT_Locks"
conn_asap.execute(sql)
%>