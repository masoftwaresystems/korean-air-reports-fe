// vi: set syn=javascript foldmethod=marker linebreak tabstop=2 shiftwidth=2 expandtab:
var overflow = "<%= overflow %>";
function printPage() {
  <% if(overflow = "y") then %>
  if(document.all) {
    document.all.divButtons.style.visibility = 'hidden';
    document.all.divButtons.style.visibility = 'visible';
  } else {
    document.getElementById('divButtons').style.visibility = 'hidden';
    document.getElementById('divButtons').style.visibility = 'visible';
  }
  <% else %>
  document.location = "admin_LogDisplay.asp?overflow=y&amp;searchVal=<%= searchVal %>&amp;filterSelect=<%= filterSelect %>&amp;divisionSelect=<%= divisionSelect %>";
  <% end if %>
}
function printPage2() {
  <% if(overflow = "y") then %>
  <% else %>
  window.open ("admin_LogDisplay.asp?overflow=y&amp;searchVal=<%= searchVal %>&amp;filterSelect=<%= filterSelect %>&amp;divisionSelect=<%= divisionSelect %>","printwindow");
  <% end if %>
}
<% if(overflow = "y") then %>
printPage2();
<% end if %>
function printPage3() {
  alert('Please adjust your printer settings to Landscape');window.print(); orientation='landscape';
}
function switchView() {
  if(overflow != "y") {
  document.location = "admin_LogDisplay.asp?overflow=y&amp;searchVal=<%= searchVal %>&amp;filterSelect=<%= filterSelect %>&amp;divisionSelect=<%= divisionSelect %>";
  } else {
  document.location = "admin_LogDisplay.asp?searchVal=<%= searchVal %>&amp;filterSelect=<%= filterSelect %>&amp;divisionSelect=<%= divisionSelect %>";
  }
}
function getDaysBetween(d1,d2) {
  var currNode;
  xmlhttpSvc.async = false;
  xmlhttpSvc.resolveExternals = false;
  xmlhttpSvc.load("/ets/acvbusers/getDefaults.asp?eventID=<%= eventid %>");
  currNode = xmlhttpSvc.selectSingleNode("//p.<%= a %>");

  document.frm.percentage_<%= a %>.value = currNode.text;
}
function setRowColor(row, color) {
  cells = row.getElementsByTagName('td');
  for(a=0; a<12; a++) {
    cells[a].style.backgroundColor = color;
  }
}
function setRowColor2(row, color) {
  cells = row.getElementsByTagName('td');
  for(a=0; a<11; a++) {
    cells[a].style.backgroundColor = color;
  }
}
function newWindow(url) {
  var day = new Date();
  var id = day.getTime();
  var win = open(url,id,'width=600,height=200,scrollbars,resizable');
}
function doSearch(d) {
<% if(d = "EH:DIV") then %>
  document.location = "admin_LogDisplay.asp?searchVal="+ document.getElementById("searchVal").value +"&amp;filterSelect=<%= filterSelect %>&amp;divisionSelect=<%= divisionSelect %>&amp;overflow=<%= overflow %>&viewdivision=<%= request("viewDivision") %>";
<% else %>
  document.location = "divisional_LogDisplay.asp?searchVal="+ document.getElementById("searchVal").value +"&amp;filterSelect=<%= filterSelect %>&amp;divisionSelect=<%= divisionSelect %>&amp;overflow=<%= overflow %>&viewdivision=<%= request("viewDivision") %>";
<% end if %>
}

function doFilter() {
  document.location = "admin_LogDisplay.asp?searchVal=<%= searchVal %>&amp;filterSelect="+ document.getElementById("filterSelect").value +"&amp;divisionSelect=<%= divisionSelect %>&amp;overflow=<%= overflow %>";
}

function doDivision() {
  document.location = "admin_LogDisplay.asp?searchVal=<%= searchVal %>&amp;filterSelect=<%= filterSelect %>&amp;divisionSelect="+ document.getElementById("divisionSelect").value +"&amp;overflow=<%= overflow %>";
}

function toggleSearches(v) {
  if(v == "advanced") {
    document.getElementById("advancedSearchDIV").style.display = "block";
    document.getElementById("advancedsearchSPAN").style.display = "block";
    document.getElementById("basicsearchSPAN").style.display = "none";
  }
  if(v == "basic") {
    document.getElementById("advancedSearchDIV").style.display = "none";
    document.getElementById("advancedsearchSPAN").style.display = "none";
    document.getElementById("basicsearchSPAN").style.display = "block";
  }
}
function requestUnlock(d,l) {
  var currNode;
  xmlhttpSvc.async = false;
  xmlhttpSvc.resolveExternals = false;
  xmlhttpSvc.load("/sms_gal3/requestUnlock.asp?division="+d+"&log_number="+l+"&requestor=<%= session("employee_number") %>");
  currNode = xmlhttpSvc.selectSingleNode("//result");
  alert(currNode.text);
}
function getWindowHeight() {
  var myHeight = 0;
  if ( typeof( window.innerHeight ) == 'number' ) {
    // for standard browsers
    myHeight = window.innerHeight;
    return myHeight;
  } else if ( document.documentElement && document.documentElement.clientHeight ) {
    // for IE 6+
    myHeight = document.documentElement.clientHeight;
    return myHeight;
  } else if ( document.body && document.body.clientHeight ) {
    // for old IE
    myHeight = document.body.clientHeight;
    return myHeight;
  }
}
function getWindowWidth() {
  var myWidth = 0;
  if ( typeof( window.innerWidth ) == 'number' ) {
    // for standard browsers
    myWidth = window.innerWidth;
    return myWidth;
  } else if ( document.documentElement && document.documentElement.clientWidth ) {
    // for IE 6+
    myWidth = document.documentElement.clientWidth;
    return myWidth;
  } else if ( document.body && document.body.clientWidth ) {
    // for old IE
    myWidth = document.body.clientWidth;
    return myWidth;
  }
}
function getIdHeight(id) {
  var myHeight = 0;
  var myId = document.getElementById(id);
  myHeight = myId.offsetHeight;
  return myHeight;
}
function init() {
  var height = 0, width = 0;
  height = getWindowHeight() - getIdHeight("headerDiv") - getIdHeight("footerDiv");
  height = 0.87 * height + "px";
  //document.getElementById("overflowDiv").style.height = height;
}
