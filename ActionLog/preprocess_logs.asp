<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<%
response.end

tmpLogNumber = ""

sql = "select logNumber, recid from EHD_Data where formname = 'iSRT_LogInput' and archived = 'n' order by logNumber desc, recid desc"
set rs = conn_asap.execute(sql)
do while not rs.eof

  log_number	= rs("logNumber")
  recid			= rs("recid")

  if(tmpLogNumber <> log_number) then
    tmpLogNumber = log_number

    sql = "update EHD_Data set active = 'y' where recid = "& sqlnum(recid)
    conn_asap.execute(sql)
  else
    sql = "update EHD_Data set active = 'n' where recid = "& sqlnum(recid)
    conn_asap.execute(sql)
  end if

  rs.movenext
loop


tmpLogNumber = ""

sql = "select logNumber, recid from EHD_Data where formname = 'risk' and archived = 'n' order by logNumber desc, recid desc"
set rs = conn_asap.execute(sql)
do while not rs.eof

  log_number	= rs("logNumber")
  recid			= rs("recid")

  if(tmpLogNumber <> log_number) then
    tmpLogNumber = log_number

    sql = "update EHD_Data set active = 'y' where recid = "& sqlnum(recid)
    conn_asap.execute(sql)
  else
    sql = "update EHD_Data set active = 'n' where recid = "& sqlnum(recid)
    conn_asap.execute(sql)
  end if

  rs.movenext
loop


%>