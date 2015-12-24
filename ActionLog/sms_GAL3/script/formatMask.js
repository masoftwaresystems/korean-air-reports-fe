function checkPhoneFormatMask(n) {
  if(n.value.length > 0) {
    if(!n.value.match(/^\d{3}-\d{3}-\d{4}$/)) { 
      n.select();
      alert("Incorrect format. Please use '999-999-9999'.");
    }
  }
}
function checkDateFormatMask(n) {
  if(n.value.length > 0) {
    if(!n.value.match(/^\d{1,2}\/\d{1,2}\/(\d{2}||\d{4})$/)) { 
      n.select();
      alert("Incorrect format. Please use 'mm/dd/yyyy'.");
    }
  }
}
function checkTimeFormatMask(n) {
  if(n.value.length > 0) {
    if(!n.value.match(/^((\d{1,2}\:\d{2})||(\d{1,2}))$/)) { 
      n.select();
      alert("Incorrect format. Please use 'hh:mi' or 'hh'.");
    }
  }
}
		function checkdate(objName, check) {
			var datefield = objName;
			var result = chkdate(objName, check);
			if (result != '') {
				alert(" Please enter a valid date");
				setTimeout(function() {datefield.focus();}, 1);
        		datefield.select();
				return false;
			} else
				return true;
		}
		function chkdate(objName, checkState) {
			var strDatestyle = "mm/dd/yy";  //(dd/mm/yyyy) o (mm/dd/yyyy)
			var intCheckToday = checkState; // (0= None; 1= +today 2= -today)
			var strDate, strDateArray, strDay, strMonth, strYear, intday, intMonth, intYear;
			var booFound = false;
			var datefield = objName;
			var strSeparatorArray = new Array("-"," ","/",".");
			var intElementNr;
			var err = '';
			strDate = datefield.value;
			if (strDate.length < 1)
				return err;
		        for (intElementNr = 0; intElementNr < strSeparatorArray.length; intElementNr++) {
					if (strDate.indexOf(strSeparatorArray[intElementNr]) != -1) {
            			strDateArray = strDate.split(strSeparatorArray[intElementNr]);
		                if (strDateArray.length != 3) {
        		        	err = 1;
                		    return err;
						} else {
							strMonth = strDateArray[0];
							strDay = strDateArray[1];
							strYear = strDateArray[2];
							if (strYear.length == 2)
								strYear = '20' + strYear;
							if (strYear.length == 1)
								strYear = '200' +strYear;
		                    if (strYear.length > 4 || strYear.length == 3) {
        		                err = 1;
                		        return err;
		                    }
						}
						booFound = true;
					}
		        }
				if (booFound == false) {
					if (strDate.length > 5) {
						strMonth = strDate.substr(0, 2);
						strDay = strDate.substr(2, 2);
						strYear = strDate.substr(4);
						if (strYear.length == 2)
							strYear = '20' + strYear;
					}
				}
		        intday = parseInt(strDay, 10);
        		if (isNaN(intday)) {
                		err = 2;
		                return err;
        		}
		        intMonth = parseInt(strMonth, 10);
		        if (isNaN(intMonth)) {
					for (i = 0; i < 12; i++) {
						if (strMonth.toUpperCase() == strMonthArray[i].toUpperCase()) {
							intMonth = i+1;
							strMonth = strMonthArray[i];
							i = 12;
						}
					}
					if (isNaN(intMonth)) {
						err = 3;
						return err;
					}
        		}
				if (intMonth > 12 || intMonth < 1) {
        		    err = 5;
		            return err;
        		}
				if ((intMonth == 1 || intMonth == 3 || intMonth == 5 || intMonth == 7 || intMonth == 8 || intMonth == 10 || intMonth == 12) && (intday > 31 || intday < 1)) {
        		    err = 6;
		            return err;
        		}
		        if ((intMonth == 4 || intMonth == 6 || intMonth == 9 || intMonth == 11) && (intday > 30 || intday < 1)) {
        		    err = 7;
		            return err;
        		}
		        intYear = parseInt(strYear, 10);
				if (isNaN(intYear)) {
					err = 4;
					return err;
		        }
		        if (intMonth == 2) {
					if (intday < 1) {
            			err = 8;
		                return err;
					}
					if (LeapYear(intYear) == true) {
						if (intday > 29) {
							err = 9;
							return err;
						}
					} else {
						if (intday > 28) {
							err = 10;
							return err;
						}
					}
        		}
		        if (intCheckToday != 0) {
        		    var dateObj = new Date(strYear, intMonth - 1, intday);
		            var dateToday = new Date();
		            if (intCheckToday == 1 && dateObj > dateToday) {
						err = 15;
                		return err;
					}
        		    if (intCheckToday == 2 && dateObj < dateToday) {
						err = 16;
        		        return err;
					}
        		}
		        if (strDatestyle == "mm/dd/yyyy" || strDatestyle == "mm/dd/yy")
					datefield.value = intMonth + "/" + intday + "/" + strYear;
		        else
					datefield.value = intday + "/" + intMonth + "/" + strYear;
		        return err;
		}
		function LeapYear(intYear) {
        	if (intYear % 100 == 0) {
		    	if (intYear % 400 == 0)
                	return true;
	        } else {
                if ((intYear % 4) == 0)
                        return true;
    	    }
        	return false;
		}
		var win= null;
		function NewWindow(mypage,myname,w,h,scroll){
			var winl = (screen.width-w)/2;
			var wint = (screen.height-h)/2;
			settings='height='+h+',width='+w+',top='+wint+',left='+winl+',scrollbars='+scroll+',toolbar=no,location=no,status=no,menubar=no,resizable=no,dependent=no'
			win=window.open(mypage,myname,settings)
				if(parseInt(navigator.appVersion) >= 4){win.window.focus();}
			}

		// Calendar pop-up
		var calendarLoaded = false;
		var lastOpenedForm;
		var lastOpenedElement;
		calendarLoaded = true;
		function openCalendar(pos, minDate, maxDate, f, e, fieldSalida, minimumStay, maximumStay) {

			var l, t;
		    var off;
		    daC = document.all.CalFrame;
		    wfC = window.frames.CalFrame;
		    if (lastOpenedForm == f && lastOpenedElement == e && daC.style.display == "block") {
        		daC.style.display = "none";
		        return;
		    }
		    if (lastOpenedForm != f || lastOpenedElement != e && daC.style.display == "block") {
        		daC.style.display = "none";
		    }
		    if (calendarLoaded) {
        		if (daC.style.display == "none") {
		            o = eval("document.all." + pos);
					if (fieldSalida) {
						fechaSalida = eval("document.all." + fieldSalida);
						if (fechaSalida.value != "") {
							if (!minimumStay) {
								minimumStay = 0;
							}
							var sAux = fechaSalida.value.split("/");
							var dateAux = new Date(sAux[2], sAux[0] - 1, sAux[1]);
							var dateAux2 = new Date(dateAux.getTime() + minimumStay * 24 * 60 * 60 * 1000);
							minDate = (dateAux2.getMonth() + 1) + "/" + dateAux2.getDate() + "/" + dateAux2.getFullYear()
							if (maximumStay) {
								dateAux2 = new Date(dateAux.getTime() + maximumStay * 24 * 60 * 60 * 1000);
								maxDate = dateAux2.getMonth() + 1 + "/" + dateAux2.getDate() + "/" + dateAux2.getFullYear()
							};
						}
					}
		            wfC.setStartDate(minDate);
        		    wfC.setEndDate(maxDate);
		            wfC.setFormElement(f, e, minDate, maxDate);
        		    wfC.drawCalendar();
		            t = o.offsetTop + o.height;
        		    off = o.offsetParent;
		            while (off != null) {
		                t += off.offsetTop;
        		        off = off.offsetParent;
		            }
        		    daC.style.top = t -13;
		            l = o.offsetLeft;
        		    off = o.offsetParent;
		            while (off != null) {
        		        l += off.offsetLeft;
		                off = off.offsetParent;
        		    }
		            daC.style.left = l-125;
		            daC.style.display = "block";
        		    lastOpenedForm = f;
		            lastOpenedElement = e;
        		}
		    } else
        		alert("Error loading calendar.\r\nPlease reload the page.");
		}
		function closeCalendar() {
		    daC = document.all.CalFrame;
		    if (daC.style.display != "none")
        		daC.style.display = "none";
		}
		function isCalendarLoaded() {
		    if (calendarLoaded)
        		return true;
		    else {
        		alert('Calendar not loaded yet.\r\nPlease try again');
		        return false;
		    }
		}
		function getCurrentDate() {
			today = new Date();
			currentDate = today.getMonth()+1 + "/" + today.getDate() + "/" + today.getFullYear();
			return currentDate;
		}
		function getNextYear() {
			today = new Date();
			currentDate = today.getMonth()+1 + "/" + today.getDate() + "/" + today.getFullYear() + 1;
			return currentDate;
		}