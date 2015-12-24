<%
function replaceSpace(s)
   s = trim(s)
   s = replace(s," ","_")
   s = replace(s,"/","_")
   s = replace(s,",","_")
   s = replace(s,"-","_")
   s = replace(s,"(","_")
   s = replace(s,")","")
   replaceSpace = s
end function

function sqltext(t)
   dim temp
   temp = replace(t,"'","''")
   temp = Replace(temp, vbCrLf, " ")
   temp = Replace(temp, vbCr, " ")
   temp = Replace(temp, vbLf, " ")
   temp = rtrim(temp)
   sqltext = temp
end function

function sqltext2(t)
   dim temp
   if((len(t) = 0) or (isnull(t))) then
     t = ""
   end if
   temp = replace(t,"'","''")
   'temp = replace(t,"""","""""")
   temp = Replace(temp, vbCrLf, " ")
   temp = Replace(temp, vbCr, " ")
   temp = Replace(temp, vbLf, " ")
   temp = rtrim(temp)
   sqltext2 = "'"&temp&"'"
end function

function sqlnum(n)
   if((len(n) = 0) or (isnull(n))) then
     sqlnum = "null"
   else
     sqlnum = n
   end if
end function

function urlify(u)
  dim temp
  temp = replace(u,"&","%26")
  urlify = temp
end function

function changeBlankToZero(v)
  if(len(v) = 0) then
    v = 0
  end if
  changeBlankToZero = v
end function

function extraSQL(s)
  s = "SET NOCOUNT ON;"& s &";SELECT rowcnt = @@ROWCOUNT"
  extraSQL = s
end function

function getCount(r)
  dim n
  n = 0
  dim tmpArr
  if not r.eof then 
    tmpArr = r.GetRows() 
    n = UBound(tmpArr,2) +1 
    r.movefirst
  end if
  getCount = n
end function

function transRisk(v)
  tmpv = ""
  if(v = "Acceptable") then
    tmpv = "1"
  end if
  if(v = "Acceptable With Mitigation") then
    tmpv = "2"
  end if
  if(v = "Unacceptable") then
    tmpv = "3"
  end if
  transRisk = tmpv
end function

function transSOI(s)
  tmps = s
  if(s = "SYS") then
    tmps = "Systemic"
  end if
  if(s = "REA") then
    tmps = "Reactive"
  end if
  if(s = "PRE") then
    tmps = "Predictive"
  end if
  if(s = "PRO") then
    tmps = "Proactive"
  end if
  transSOI = tmps
end function

function transFlag(v)
  tmpv = "No"
  if(v = "1") then
    tmpv = "Yes"
  end if
  transFlag = tmpv
end function

Text       = 1
adCmdTable      = 2
adCmdStoredProc = 4
adCmdUnknown    = 8

'---- CursorTypeEnum Values ----
Const adOpenForwardOnly = 0
Const adOpenKeyset = 1
Const adOpenDynamic = 2
Const adOpenStatic = 3

Server.ScriptTimeout = 60000

%>
