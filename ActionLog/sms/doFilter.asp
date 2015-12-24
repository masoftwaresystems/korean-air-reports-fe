<%  ' vi: set foldmethod=marker syn=aspvbs linebreak softtabstop=2 tabstop=2 shiftwidth=2 expandtab: %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%  ' Note: if the page starts taking too long to load,
    ' the indententation can be removed to reduce the size of the HTML.  %>
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<!--#include file="includes/security.inc"-->

<!--#include file="includes/loginInfo.inc"-->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>BristowGroup: Action Log</title>
    <meta name="keywords" content="Evan McClain"/>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
      function setRowColor(row, color) {
        cells = row.getElementsByTagName('td');
        // NOTE: there are 5 columns.
        for(a=0; a < 5; a++) {
          cells[a].style.backgroundColor = color;
        }
      }
    </script>
  </head>
  <body>
<!--#include file="includes/sms_header.inc"-->
    <div id="content">
<%
dim numFields
numFields = Request.QueryString("numFields")
numFields = numFields-1
dim searchFields()
dim searchValues()
sql_select="select logNumber, division, recid, loginID, createDate, formdataXML from EHD_Data "
sql_where="where archived = 'n' and active = 'y' "
sql_sort=" order by logNumber desc, recid desc"
' {{{ SQL select statements
' Remove semicolons (should help against injection
set objSQLRegExp = new RegExp
objSQLRegExp.Global = True
objSQLRegExp.IgnoreCase = True
objSQLRegExp.Pattern = ";"
num_xml_if = 0
for i=0 to numFields
  redim preserve searchFields(i)
  redim preserve searchValues(i)
  searchFields(i) = Request.QueryString("searchField" & i)
  searchValues(i) = Request.QueryString("searchValue" & i)
  if searchFields(i) = "log_number" then
    sql_where = sql_where &" and logNumber like '%"& objSQLRegExp.Replace(searchValues(i),"") &"%'"
  end if
  if searchFields(i) = "division" then
    sql_where = sql_where &" and division = '"& objSQLRegExp.Replace(searchValues(i),"") &"'"
  end if
next
' }}}
' response.write(sql_where &"<br />"& vbCrLf)
sql = sql_select & sql_where & sql_sort
set rs=conn_asap.execute(sql)
if rs.eof then
  ' NOTE: This will only appear if there are no results from the SQL query,
  ' if the XML results don't return anything the table header will show, but nothing else will.
  response.write("<p>No Results.</p>"& vbCrLf)
else
  results = rs.getrows() %>
      <table>
        <tr class="head">
          <td>
            Log <br /> Number
          </td>
          <td>
            Item Title
          </td>
          <td>
            Accountable <br /> Leader
          </td>
          <td>
            Date Due
          </td>
          <td>
            Item <br /> Status
          </td>
        </tr>
<% ' {{{ formdataXML statements
  set oXML = CreateObject("Microsoft.XMLDOM")
  for i=0 to ubound(results,2)
    oXML.loadXML(results(5,i))
    ' Here are the fields to show in the summary display
    log_number = results(0,i)
    if IsNull(log_number) Then
      log_numberStr = "00000"
    else
      log_numberStr = string(4-len(log_number),"0") & log_number & ""
    end if
    accountable_leader = selectNode(oXML,"accountable_leader","")
    sql = "select first_name, last_name from Tbl_Logins where employee_number = "& sqltext2(accountable_leader)
    set get_name=conn_asap.execute(sql)
    if get_name.eof then
    else
      name = get_name.getrows()
      first_name = name(0,0)
      last_name = name(1,0)
    end if
    division = results(1,i)
    item_status = selectNode(oXML,"item_status","")
    source = selectNode(oXML,"source","")
    item_description = selectNode(oXML,"item_description","")
    item_title = selectNode(oXML,"item_title","")
    ' Remove non-ascii characters from description
    set objRegExp = new RegExp
    objRegExp.Global = True
    objRegExp.IgnoreCase = True
    objRegExp.Pattern = "[^\x20-\x7E]"
    item_description = objRegExp.Replace(item_description,"")
    opened = selectNode(oXML,"date_opened","")
    if IsDate(opened) then
      date_opened = CDate(opened)
    end if
    due = selectNode(oXML,"date_due","")
    if IsDate(due) then
      date_due = CDate(due)
    end if
    completed = selectNode(oXML,"date_completed","")
    if IsDate(completed) then
      date_completed = CDate(completed)
    end if
    xml_where = 1
    ' Remove entries with no division or status (not sure where these came from...)
    if(len(trim(division)) < 2 or IsNull(division)) then
      xml_where = 0
    end if
    if(len(trim(division)) < 2 or IsNull(division)) then
      xml_where = 0
    end if
    if(len(trim(item_status)) < 2 or IsNull(item_status)) then
      xml_where = 0
    end if
    for j=0 to numFields
      ' {{{ item_status
      if searchFields(j) = "item_status" then
        if InStr(ucase(item_status), ucase(searchValues(j))) then
          xml_where = xml_where * 1
        else
          xml_where = 0
        end if
      end if ' }}}
      ' {{{ source
      if searchFields(j) = "source" then
        if InStr(ucase(source), ucase(searchValues(j))) then
          xml_where = xml_where * 1
        else
          xml_where = 0
        end if
      end if ' }}}
      ' {{{ opened_before
      if searchFields(j) = "opened_before" then
        opened_before = searchValues(j)
        if IsDate(opened_before) and IsDate(opened) then
          opened_before_date = CDate(opened_before)
          if DateDiff("d",date_opened,opened_before_date) > 0 then
            ' response.write(DateDiff("d",date_opened,opened_before_date) &"&amp;"& opened &"&amp;"& opened_before_date &"<br />")
            xml_where = xml_where * 1
          else
            xml_where = 0
          end if
        else
          xml_where = 0
        end if
      end if ' }}}
      ' {{{ opened_after
      if searchFields(j) = "opened_after" then
        opened_after = searchValues(j)
        if IsDate(opened_after) and IsDate(opened) then
          opened_after_date = CDate(opened_after)
          if DateDiff("d",date_opened,opened_after_date) < 0 then
            xml_where = xml_where * 1
          else
            xml_where = 0
          end if
        else
          xml_where = 0
        end if
      end if ' }}}
      ' {{{ completed_before
      if searchFields(j) = "completed_before" then
        completed_before = searchValues(j)
        if IsDate(completed_before) and IsDate(completed) then
          completed_before_date = CDate(completed_before)
          if DateDiff("d",date_completed,completed_before_date) > 0 then
            ' response.write(DateDiff("d",date_completed,completed_before_date) &"&amp;"& completed &"&amp;"& completed_before_date &"<br />")
            xml_where = xml_where * 1
          else
            xml_where = 0
          end if
        else
          xml_where = 0
        end if
      end if ' }}}
      ' {{{ completed_after
      if searchFields(j) = "completed_after" then
        completed_after = searchValues(j)
        if IsDate(completed_after) and IsDate(completed) then
          completed_after_date = CDate(completed_after)
          if DateDiff("d",date_completed,completed_after_date) < 0 then
            xml_where = xml_where * 1
          else
            xml_where = 0
          end if
        else
          xml_where = 0
        end if
      end if ' }}}
      ' {{{ item_description
      if searchFields(j) = "item_description" then
        if InStr(ucase(item_description),ucase(searchValues(j))) then
          xml_where = xml_where * 1
        else
          xml_where = 0
        end if
      end if ' }}}
      ' {{{ accountable_leader
      if searchFields(j) = "accountable_leader" then
        if InStr(ucase(first_name),ucase(searchValues(j))) or InStr(ucase(last_name),ucase(searchValues(j))) or InStr(ucase(first_name &" "& last_name),ucase(searchValues(j))) then
          xml_where = xml_where * 1
        else
          xml_where = 0
        end if
      end if ' }}}
    next
    ' }}}
    if xml_where = 1 then %>
<% ' {{{ Check Log
isLocked = isLogLocked(log_number,division)
if(isLocked = "n") then
  if(division = "iSRT") then
    if(srt_admin = "y" or srt_admin = "l" or srt_admin = "p") then
      clickloc = "document.location='admin_Logdisplay.asp?searchVal="& log_numberStr &"'"
    else
      clickloc = "alert('Please contact the Action Log Admin to view "& division & log_numberStr &"')"
    end if
  else
    if(division = session("division") or srt_admin = "y") then
      clickloc = "document.location='divisional_LogDisplay.asp?searchVal="& log_numberStr &"&amp;viewDivision="& division &"'"
    else
      clickloc = "alert('Please contact the Action Log Admin to view "& division & log_numberStr &"')"
    end if
  end if
else
  clickloc = "alert('"& division & log_numberStr &" locked by "& isLocked &"')"
end if
' }}} %>
        <tr onclick="<%= clickloc %>" onmouseover="setRowColor(this, '#f0f0f0');" onmouseout="setRowColor(this, 'white')">
          <td>
            <%= division%><%= log_numberStr %>
          </td>
          <td class="description">
            <%= item_title %>
          </td>
          <td>
            <%= first_name &" "& last_name %>
          </td>
          <td>
            <%= date_due %>
          </td>
          <td>
            <%= item_status %>
          </td>
        </tr>
<%  end if
  next %>
      </table>
<% end if %>
      <div id="NewSearch">
        <input type="button" onclick="document.location='filterForm.asp'" value="New Search" title="New Search"/>
      </div>
<!--#include file="includes/sms_footer.inc"-->
    </div>
  </body>
</html>


<!--
log_number
business_unit
base
item_title
item_description
equipment
accountable_leader
soi
hl
date_opened
date_due
date_completed
item_status
mission
hazard_owner
hazard_editor
next_review_date
endorsed
endorsed_by
item_comments
alarp_statement
further_risk_reduction_needed
hazard_ok_alarp
-->