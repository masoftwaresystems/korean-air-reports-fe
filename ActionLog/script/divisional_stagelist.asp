// vi: set syn=javascript foldmethod=marker linebreak tabstop=2 shiftwidth=2 expandtab:
var overflow = "<%= overflow %>";
function printPage() {
  <% if(overflow = "y") then %>
  if(document.all) {
    document.all.divButtons.style.visibility = 'hidden';
    //window.print();
    document.all.divButtons.style.visibility = 'visible';
  } else {
    document.getElementById('divButtons').style.visibility = 'hidden';
    //window.print();
    document.getElementById('divButtons').style.visibility = 'visible';
  }
  <% else %>
  document.location = "divisional_StageList.asp?overflow=y&searchVal=<%= searchVal %>&filterSelect=<%= filterSelect %>&divisionSelect=<%= divisionSelect %>&viewDivision=<%= viewDivision %>";
  <% end if %>
}
function printPage2() {
  <% if(overflow = "y") then %>
  //window.print(); orientation='landscape'
  <% else %>
  window.open ("divisional_StageList.asp?overflow=y&searchVal=<%= searchVal %>&filterSelect=<%= filterSelect %>&divisionSelect=<%= divisionSelect %>&viewDivision<%= viewDivision %>","printwindow");
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
  document.location = "divisional_StageList.asp?overflow=y&searchVal=<%= searchVal %>&filterSelect=<%= filterSelect %>&divisionSelect=<%= divisionSelect %>&viewDivision=<%= viewDivision %>";
  } else {
  document.location = "divisional_StageList.asp?searchVal=<%= searchVal %>&filterSelect=<%= filterSelect %>&divisionSelect=<%= divisionSelect %>&viewDivision=<%= viewDivision %>";
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
  for(a=0; a < 5; a++) {
   // alert(color);
  cells[a].style.backgroundColor = color;
  }
}
function newWindow(url) {
  var day = new Date();
  var id = day.getTime();
  var win = open(url,id,'width=600,height=200,scrollbars,resizable');
}
function doSearch() {
  document.location = "divisional_StageList.asp?searchVal="+ document.getElementById("searchVal").value +"&filterSelect=<%= filterSelect %>&divisionSelect=<%= divisionSelect %>&overflow=<%= overflow %>";
}

function doFilter() {
  document.location = "divisional_StageList.asp?searchVal=<%= searchVal %>&filterSelect="+ document.getElementById("filterSelect").value +"&divisionSelect=<%= divisionSelect %>&overflow=<%= overflow %>";
}

function doDivision() {
  document.location = "divisional_StageList.asp?searchVal=<%= searchVal %>&filterSelect=<%= filterSelect %>&divisionSelect="+ document.getElementById("divisionSelect").value +"&overflow=<%= overflow %>";
}

function toggleSearches(v) {
  if(v == "advanced") {
    //alert("advanced");
    document.getElementById("advancedSearchDIV").style.display = "block";
    document.getElementById("advancedsearchSPAN").style.display = "block";
    document.getElementById("basicsearchSPAN").style.display = "none";
  }
  if(v == "basic") {
    //alert("basic");
    document.getElementById("advancedSearchDIV").style.display = "none";
    document.getElementById("advancedsearchSPAN").style.display = "none";
    document.getElementById("basicsearchSPAN").style.display = "block";
  }
}
function requestUnlock(d,l) {
  //alert(d+":"+l);
  //document.getElementById("ROW_"+l).onclick.value = alert('x');
  var currNode;
  xmlhttpSvc.async = false;
  xmlhttpSvc.resolveExternals = false;
  xmlhttpSvc.load("/sms_gal3/requestUnlock.asp?division="+d+"&log_number="+l+"&requestor=<%= session("employee_number") %>");
  //xmlhttpSvc.load("/testXML.asp");
  currNode = xmlhttpSvc.selectSingleNode("//result");
  //alert(xmlhttpSvc.xml);
  alert(currNode.text);
  //alert("/requestUnlock.asp?division="+d+"&log_number="+l+"&requestor=<%= session("employee_number") %>");
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
  document.getElementById("overflowDiv").style.height = height;
}
