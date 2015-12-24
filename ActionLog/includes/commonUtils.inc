<%
'###############################################
'# 
'# commonUtils.inc
'# 
'# Commonly-used functions
'# 
%>
<%

function format_createdate(d)
  dim tmpd, tmparr
  tmpd = ""
  if(len(d) > 0) then
    tmparr = split(d,"/")
  
    tmpd = string(2-len(tmparr(0)),"0") & tmparr(0) &"/"& string(2-len(tmparr(1)),"0") & tmparr(1) &"/"& left(tmparr(2),4)
  
  end if
  
  format_createdate = tmpd
  'format_createdate = d
end function


function getCatDict(c)
  dim v
  v = ""
  if(catdict.Exists(c)) then
    v = catdict.Item(c)
  end if
  getCatDict = v
end function

function isValidHazardID(h)
   r = true
   hArr = split(h,"-")
   if(hArr(0) = "") then
     r = false
   end if
   if(hArr(1) = "") then
     r = false
   end if
   'if(hArr(2) = "") then
   '  r = false
   'end if
   'if(hArr(3) = "") then
   '  r = false
   'end if
   'if(cint(hArr(3)) = 0) then
   '  r = false
   'end if
   
   isValidHazardID = r
end function
%>