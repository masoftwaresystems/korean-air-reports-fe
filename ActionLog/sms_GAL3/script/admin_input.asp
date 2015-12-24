// vi: set foldmethod=marker syn=javascript linebreak softtabstop=2 tabstop=2 shiftwidth=2 expandtab:
function printPage() {
  if(document.all) {
    document.all.divButtons.style.visibility = 'hidden';
    window.print();
    document.all.divButtons.style.visibility = 'visible';
  } else {
    document.getElementById('divButtons').style.visibility = 'hidden';
    window.print();
    document.getElementById('divButtons').style.visibility = 'visible';
  }
}
// {{{ calcDueDate(v)
function calcDueDate(v) {
  var openDate;
  var dueDate;
  var newDate;
  var daysToAdd;
  var newMonth;
  var tmpOpenDateArr;
  if(v =="" ) {

    if(document.getElementById("date_opened").value != "") {
    //alert(document.getElementById("date_opened").value.split('/'));
    tmpOpenDateArr = document.getElementById("date_opened").value.split('/');
    //alert(tmpOpenDateArr[1]+'/'+tmpOpenDateArr[0]+'/'+tmpOpenDateArr[2]);
    openDate = new Date(tmpOpenDateArr[1]+'/'+tmpOpenDateArr[0]+'/'+tmpOpenDateArr[2]);

    dueDate = document.getElementById("date_due");
    daysToAdd = 90;
    newDate = openDate;
    newDate.setDate(newDate.getDate() + daysToAdd);
    if( (newDate.getMonth()+1) < 10)
	    newMonth = "0"+(newDate.getMonth()+1);
	  else
	    newMonth = newDate.getMonth()+1;
    // Need the +1 for the month because the months go from 0-11, don't ask why.
    dueDate.value = newDate.getDate()+"/"+newMonth+"/"+newDate.getFullYear();
    }
  } else {
    if(document.getElementById("safety_action_open_"+v).value != "") {
    tmpOpenDateArr = document.getElementById("safety_action_open_"+v).value.split('/');
    //alert(tmpOpenDateArr[1]+'/'+tmpOpenDateArr[0]+'/'+tmpOpenDateArr[2]);

    openDate = new Date(tmpOpenDateArr[1]+'/'+tmpOpenDateArr[0]+'/'+tmpOpenDateArr[2]);
    dueDate = document.getElementById("safety_action_due_"+v);
    daysToAdd = 45;
    newDate = openDate;
    newDate.setDate(newDate.getDate() + daysToAdd);
    if( (newDate.getMonth()+1) < 10)
      newMonth = "0"+(newDate.getMonth()+1);
    else
      newMonth = newDate.getMonth()+1;
    //dueDate.value = newMonth+"/"+newDate.getDate()+"/"+newDate.getFullYear();
    dueDate.value = newDate.getDate()+"/"+newMonth+"/"+newDate.getFullYear();
    }
  }
}
// }}} end calcDueDate(v)
function setFieldValue(f,v) {
  document.getElementById(f).value = v;
}
function deleteSafetyAction(a) {
  var tmpnbr = document.getElementById("safety_action_nbr_"+a).value;
  var tmpnbrArr = tmpnbr.split(".");
  //alert(tmpnbrArr[1]);
  document.getElementById("deleted_item_nbr").value = tmpnbrArr[1];
  document.getElementById("safety_action_nbr_"+a).name = "x"+document.getElementById("safety_action_nbr_"+a).name;
  document.getElementById("safety_action_type_"+a).name = "x"+document.getElementById("safety_action_type_"+a).name;
  document.getElementById("safety_action_"+a).name = "x"+document.getElementById("safety_action_"+a).name;
  document.getElementById("safety_action_poc_"+a).name = "x"+document.getElementById("safety_action_poc_"+a).name;
  //document.getElementById("safety_action_poc2_"+a).name = "x"+document.getElementById("safety_action_poc2_"+a).name;
  document.getElementById("safety_action_open_"+a).name = "x"+document.getElementById("safety_action_open_"+a).name;
  document.getElementById("safety_action_due_"+a).name = "x"+document.getElementById("safety_action_due_"+a).name;
  document.getElementById("safety_action_completed_"+a).name = "x"+document.getElementById("safety_action_completed_"+a).name;
  document.getElementById("safety_action_status_"+a).name = "x"+document.getElementById("safety_action_status_"+a).name;

  document.getElementById("safety_action_other_name_"+a).name = "x"+document.getElementById("safety_action_other_name_"+a).name;
  document.getElementById("safety_action_other_email_"+a).name = "x"+document.getElementById("safety_action_other_email_"+a).name;

  try {
    document.getElementById("deleted_item_division").value = document.getElementById("safety_action_division_"+a).value;
    document.getElementById("safety_action_division_"+a).name = "x"+document.getElementById("safety_action_division_"+a).name;
  } catch(err) {
    //
  }
  try {
    document.getElementById("deleted_item_division").value = document.getElementById("safety_action_assigned_division_"+a).value;
    document.getElementById("safety_action_assigned_division_"+a).name = "x"+document.getElementById("safety_action_assigned_division_"+a).name;
  } catch(err) {
    //
  }
  var startNum = a++;
  var endNum = parseInt(document.getElementById("safety_action_cnt").value)
  for (var x = startNum; x <= endNum; x++) {
    newNum = x -1;
    tmpnbr = document.getElementById("safety_action_nbr_"+x).value;
    tmpNbrArr = tmpnbr.split(".");
    tmpnbr = tmpNbrArr[0] +"."+ newNum;
    document.getElementById("safety_action_nbr_"+x).value = tmpnbr;
    document.getElementById("safety_action_nbr_"+x).name = "safety_action_nbr_"+newNum;
    document.getElementById("safety_action_type_"+x).name = "safety_action_type_"+newNum;
    document.getElementById("safety_action_"+x).name = "safety_action_"+newNum;
    document.getElementById("safety_action_poc_"+x).name = "safety_action_poc_"+newNum;
    //document.getElementById("safety_action_poc2_"+x).name = "safety_action_poc2_"+newNum;
    //document.getElementById("safety_action_poc_email_"+x).name = "safety_action_poc_email_"+newNum;
    document.getElementById("safety_action_open_"+x).name = "safety_action_open_"+newNum;
    document.getElementById("safety_action_due_"+x).name = "safety_action_due_"+newNum;
    document.getElementById("safety_action_completed_"+x).name = "safety_action_completed_"+newNum;
    document.getElementById("safety_action_status_"+x).name = "safety_action_status_"+newNum;
    document.getElementById("safety_action_other_name_"+x).name = "safety_action_other_name_"+newNum;
    document.getElementById("safety_action_other_email_"+x).name = "safety_action_other_email_"+newNum;
  }
  tmpcnt = parseInt(document.getElementById("safety_action_cnt").value);
  tmpcnt--;
  document.getElementById("safety_action_cnt").value = tmpcnt;
  document.getElementById("get_max_recid").value = "y";
  document.getElementById("resultPage").value = "admin_LogInput.asp";
  //frm.submit();
  checkRequired();
}
function goToRisk() {
  frm.action = "admin_risk.asp";
  //frm.submit();
  checkRequired();
}
function goToEmail() {
  frm.action = "admin_emailInfo.asp";
  //frm.submit();
  checkRequired();
}
function toggleLink() {
  //alert("test");
  if(document.getElementById("linkDIV").style.display == "none") {
    document.getElementById("linkDIV").style.display = "";
  } else {
    document.getElementById("linkDIV").style.display = "none";
  }
}
function saveLinks() {
  //frm.action = "saveLinks.asp";
  document.getElementById("resultPage").value = "admin_LogInput.asp";
  //frm.submit();
  checkRequired();
}
function goToAttachments() {
  frm.action = "admin_Attachments.asp";
  //frm.submit();
  checkRequired();
}
function deleteLogNumber() {
  frm.action = "admin_deleteLogNumber.asp";
  //frm.submit();
  checkRequired();
}
function isEmpty(str) {
  // Check whether string is empty.
  for (var intLoop = 0; intLoop < str.length; intLoop++)
    if (" " != str.charAt(intLoop))
      return false;
  return true;
}

function checkRequired() {
  f = frm;
  var strError = "";
  for (var intLoop = 0; intLoop < f.elements.length; intLoop++)
    if (null!=f.elements[intLoop].getAttribute("required"))
      if (isEmpty(f.elements[intLoop].value))
         strError += "  " + f.elements[intLoop].name + "\n";
      if ("" != strError) {
        alert("Required data is missing:\n" + strError);
        return false;
      } else {
        //checkCheckboxes();
        //checkAgreement();
        f.submit();
        return true;
      }
}
function validateDate(fld) {
    return true;

    var RegExPattern = /^(?=\d)(?:(?:(?:(?:(?:0?[13578]|1[02])(\/|-|\.)31)\1|(?:(?:0?[1,3-9]|1[0-2])(\/|-|\.)(?:29|30)\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})|(?:0?2(\/|-|\.)29\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))|(?:(?:0?[1-9])|(?:1[0-2]))(\/|-|\.)(?:0?[1-9]|1\d|2[0-8])\4(?:(?:1[6-9]|[2-9]\d)?\d{2}))($|\ (?=\d)))?(((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))|([01]\d|2[0-3])(:[0-5]\d){1,2})?$/;
    var errorMessage = 'Invalid date\nPlease use the following format: mm/dd/yyyy';
    if(fld.value.length > 0) {
      if ((fld.value.match(RegExPattern)) && (fld.value!='')) {
          //alert('Date is OK');
          return true;
      } else {
          alert(errorMessage);
          fld.value = "";
          fld.focus();
          fld.select();
          return false;
      }
    } else {
      return true;
    }
}