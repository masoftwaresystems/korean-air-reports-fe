// vim: set foldmethod=marker
var frmInput = [];
var frmValue = [];
var searchValue = [];
function addInput() {
  frmInput.push(frmInput.length);
  frmValue.push("");
  searchValue.push("");
  display();
}
function deleteInput() {
  if(frmInput.length > 0) {
    frmInput.pop();
    frmValue.pop();
    searchValue.pop();
  }
  display();
}
function display() {
  document.getElementById('inputArea').innerHTML="";
  for (i=0; i<frmInput.length; i++) {
    document.getElementById('inputArea').innerHTML+=createInput(frmInput[i], frmValue[i], searchValue[i]);
  }
  document.getElementById('numFields').value=frmInput.length;
}
// {{{ createInput


function createInput(id, inptValue, srchValue) {
  var returnString = "";
  returnString = "<select onchange='javascript:saveSearchValue("+ id +", this.value)' name='searchField"+ id +"' id='searchField"+ id +"'>";
  returnString += "<option value=''></option>";
  // {{{ log_number
  if (srchValue == 'log_number') {
    returnString += "<option value='log_number' selected='selected'>Log Nbr.</option>";
  } else {
    returnString += "<option value='log_number'>Log Nbr.</option>";
  } // }}}
  // {{{ business_unit
  if (srchValue == 'business_unit') {
    returnString += "<option value='business_unit' selected='selected'>Business Unit</option>";
  } else {
    returnString += "<option value='business_unit'>Business Unit</option>";
  } // }}}
  // {{{ base
  if (srchValue == 'base') {
    returnString += "<option value='base' selected='selected'>Base</option>";
  } else {
    returnString += "<option value='base'>Base</option>";
  } // }}}
  // {{{ item_title
  if (srchValue == 'item_title') {
    returnString += "<option value='item_title' selected='selected'>Title</option>";
  } else {
    returnString += "<option value='item_title'>Title</option>";
  } // }}}
//  // {{{ item_description
//  if (srchValue == 'item_description') {
//    returnString += "<option value='item_description' selected='selected'>Description</option>";
//  } else {
//    returnString += "<option value='item_description'>Description</option>";
//  } // }}}
  // {{{ equipment
  if (srchValue == 'equipment') {
    returnString += "<option value='equipment' selected='selected'>Equipment</option>";
  } else {
    returnString += "<option value='equipment'>Equipment</option>";
  } // }}}
  // {{{ accountable_leader
  if (srchValue == 'accountable_leader') {
    returnString += "<option value='accountable_leader' selected='selected'>Accountable Leader</option>";
  } else {
    returnString += "<option value='accountable_leader'>Accountable Leader</option>";
  } // }}}
  // {{{ soi
  if (srchValue == 'soi') {
    returnString += "<option value='soi' selected='selected'>SOI</option>";
  } else {
    returnString += "<option value='soi'>SOI</option>";
  } // }}}
  // {{{ hl
  if (srchValue == 'hl') {
    returnString += "<option value='hl' selected='selected'>HL</option>";
  } else {
    returnString += "<option value='hl'>HL</option>";
  } // }}}
  // {{{ date_opened
  if (srchValue == 'date_opened') {
    returnString += "<option value='date_opened' selected='selected'>Date Opened</option>";
  } else {
    returnString += "<option value='date_opened'>Date Opened</option>";
  } // }}}
  // {{{ date_due
  if (srchValue == 'date_due') {
    returnString += "<option value='date_due' selected='selected'>Date Due</option>";
  } else {
    returnString += "<option value='date_due'>Date Due</option>";
  } // }}}
  
  if (srchValue == 'date_completed') {
    returnString += "<option value='date_completed' selected='selected'>Date Completed</option>";
  } else {
    returnString += "<option value='date_completed'>Date Completed</option>";
  }
  if (srchValue == 'item_status') {
    returnString += "<option value='item_status' selected='selected'>Status</option>";
  } else {
    returnString += "<option value='item_status'>Status</option>";
  }
  if (srchValue == 'mission') {
    returnString += "<option value='mission' selected='selected'>Mission</option>";
  } else {
    returnString += "<option value='mission'>Mission</option>";
  }
  if (srchValue == 'hazard_owner') {
    returnString += "<option value='hazard_owner' selected='selected'>Hazard Owner</option>";
  } else {
    returnString += "<option value='hazard_owner'>Hazard Owner</option>";
  }
  if (srchValue == 'hazard_editor') {
    returnString += "<option value='hazard_editor' selected='selected'>Hazard Editor</option>";
  } else {
    returnString += "<option value='hazard_editor'>Hazard Editor</option>";
  }
  if (srchValue == 'next_review_date') {
    returnString += "<option value='next_review_date' selected='selected'>Next Review Date</option>";
  } else {
    returnString += "<option value='next_review_date'>Next Review Date</option>";
  }
  if (srchValue == 'endorsed') {
    returnString += "<option value='endorsed' selected='selected'>Endorsed</option>";
  } else {
    returnString += "<option value='endorsed'>Endorsed</option>";
  }
  if (srchValue == 'endorsed_by') {
    returnString += "<option value='endorsed_by' selected='selected'>Endorsed By</option>";
  } else {
    returnString += "<option value='endorsed_by'>Endorsed By</option>";
  }
  if (srchValue == 'item_comments') {
    returnString += "<option value='item_comments' selected='selected'>Comments</option>";
  } else {
    returnString += "<option value='item_comments'>Comments</option>";
  }
  if (srchValue == 'alarp_statement') {
    returnString += "<option value='alarp_statement' selected='selected'>ALARP Statement</option>";
  } else {
    returnString += "<option value='alarp_statement'>ALARP Statement</option>";
  }
  if (srchValue == 'further_risk_reduction_needed') {
    returnString += "<option value='further_risk_reduction_needed' selected='selected'>Further Risk Reduction Needed</option>";
  } else {
    returnString += "<option value='further_risk_reduction_needed'>Further Risk Reduction Needed</option>";
  }
  if (srchValue == 'hazard_ok_alarp') {
    returnString += "<option value='hazard_ok_alarp' selected='selected'>Hazard Ok ALARP</option>";
  } else {
    returnString += "<option value='hazard_ok_alarp'>Hazard Ok ALARP</option>";
  }
  
  returnString += "</select> <input type='text' name='searchValue"+ id +"' id='searchValue"+ id +"' onchange='javascript:saveInputValue("+ id +", this.value)' value='"+ inptValue +"' /><br />";
  return returnString;
}
// }}}
function saveInputValue(id, value) {
  frmValue[id] = value;
}
function saveSearchValue(id, value) {
  searchValue[id] = value;
}
function getNumInpts() {
  return frmInput.length;
}
function init() {
  addInput();
}
