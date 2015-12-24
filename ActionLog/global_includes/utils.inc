<%
function getDaysBetween(d1,d2)

  numdays	= datediff("d",d1,d2)
  
  getDaysBetween = numdays
end function


function isInternal
  dim rval
  rval = false
  ipaddress = Request.ServerVariables("REMOTE_ADDR")
  
  if(ipaddress = "62.189.176.75") then 'ragnarok
  	rval = true
  end if
  if(ipaddress = "62.189.176.73") then 'fafnir
  	rval = true
  end if
  if(ipaddress = "12.27.232.178") then 'US router
  	rval = true
  end if
  if(ipaddress = "74.231.227.34") then 'NI router
  	rval = true
  end if
  if(ipaddress = "72.214.124.218") then 'Manta
  	rval = true
  end if
  if(ipaddress = "70.250.59.181") then 'Houston router
  	rval = true
  end if
  if(ipaddress = "70.250.59.182") then 'Turtle
  	rval = true
  end if
  if(ipaddress = "74.124.41.68") then 'Turtle (alternate)
  	rval = true
  end if
  if(ipaddress = "212.39.164.170") then 'brokk
  	rval = true
  end if
  if(ipaddress = "212.39.164.172") then 'starfish
  	rval = true
  end if
  if(ipaddress = "203.45.17.246") then 'taniwha
  	rval = true
  end if
  if(ipaddress = "76.105.80.150") then 'mike aaron
  	'rval = true
  end if
  
  isInternal = rval
end function

%>