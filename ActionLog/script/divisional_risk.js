// vim: set foldmethod=marker linebreak softtabstop=2 tabstop=2 shiftwidth=2 expandtab autoindent:
function toggleSection(o,t){
  if(o.checked) {
    document.getElementById(t).style.display = 'block';
  } else {
    document.getElementById(t).style.display = 'none';
  }
}
var active_errors_cnt = 1;
var contributing_factors_cnt = 1;
var latent_conditions_cnt = 1;
var causal_factors_cnt = 1;
function addTextbox(t,r,f) {
  
  currCnt = parseInt(document.getElementById(f+"s_cnt").value);
  
  currCnt = currCnt +1;
  
  document.getElementById(f+"s_cnt").value = currCnt;
  
  //alert(f+":"+document.getElementById(f+"s_cnt").value);
  var inputTable = document.getElementById(t);
  
  //alert(inputTable.id);
  var inputTableRow = document.getElementById(r);
  //alert(inputTableRow.id);
  
  //alert(inputTableRow.id);
  var newTR1 = document.createElement('TR');
  var newTD1 = document.createElement('TD');
  
  inputTable.insertBefore(newTR1, inputTableRow);
  
  newTR1.appendChild(newTD1);
  newTD1.innerHTML = "<textarea name='"+f+"_"+currCnt+"' style='width:540px;margin-left:0px;margin-top:5px;' rows='2'></textarea>";
}

function addTextbox2(t,r,f) {
  
  currCnt = parseInt(document.getElementById(f+"s_cnt").value);
  
  currCnt = currCnt +1;
  
  document.getElementById(f+"s_cnt").value = currCnt;
  
  //alert(f+":"+document.getElementById(f+"s_cnt").value);
  var inputTable = document.getElementById(t);
  
  //alert(inputTable.id);
  var inputTableRow = document.getElementById(r);
  //alert(inputTableRow.id);
  
  //alert(inputTableRow.id);
  var newTR1 = document.createElement('TR');
  var newTD1 = document.createElement('TD');
  
  inputTable.insertBefore(newTR1, inputTableRow);
  
  newTR1.appendChild(newTD1);
  newTD1.innerHTML = "<textarea name='"+f+"_"+currCnt+"' style='width:540px;margin-left:0px;margin-top:5px;' rows='2'></textarea><select name='' style='width:180px;margin-left:0px;margin-bottom:15px;'><option value=''>Associate with Action Item</option><option value='All'>All</option><option value='None'>None</option><%= safetyactionOptionsStr %></select>";
}

function addTextbox3(t,r,f) {
  
  currCnt = parseInt(document.getElementById(f+"s_cnt").value);
  
  currCnt = currCnt +1;
  
  document.getElementById(f+"s_cnt").value = currCnt;
  
  //alert(f+":"+document.getElementById(f+"s_cnt").value);
  var inputTable = document.getElementById(t);
  
  //alert(inputTable.id);
  var inputTableRow = document.getElementById(r);
  //alert(inputTableRow.id);
  
  //alert(inputTableRow.id);
  var newTR1 = document.createElement('TR');
  var newTD1 = document.createElement('TD');
  
  inputTable.insertBefore(newTR1, inputTableRow);
  
  newTR1.appendChild(newTD1);
  newTD1.innerHTML = "<textarea name='"+f+"_"+currCnt+"' style='width:540px;margin-left:0px;margin-top:5px;' rows='2'></textarea>";
}

function setFieldValue(f,v) {
  document.getElementById(f).value = v;
}
