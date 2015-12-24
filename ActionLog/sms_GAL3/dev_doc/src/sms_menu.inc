<% srt_admin = session("srt_admin") %>
<ul id="nav_menu">
  <li><a href="#">Action Log</a>
    <ul>
      <% if srt_admin = "y" then %>
      <li><a href="admin_LogDisplay.asp">iSRT Action Log</a></li>
    <li><a href="#">Divisional Log<img src="images/arrow-right.gif" style="padding-left:20px;" alt="arrow-right" /></a>
    <ul>
      <li><a href="divisional_LogDisplay.asp?viewdivision=ACS">ACS</a></li>
      <li><a href="divisional_LogDisplay.asp?viewdivision=CGO">CGO</a></li>
      <li><a href="divisional_LogDisplay.asp?viewdivision=FOP">FOP</a></li>
      <li><a href="divisional_LogDisplay.asp?viewdivision=IFS">IFS</a></li>
      <li><a href="divisional_LogDisplay.asp?viewdivision=OCC">OCC</a></li>
      <li><a href="divisional_LogDisplay.asp?viewdivision=TOP">TOP</a></li>
    </ul>
    </li>
      <% elseif ((srt_admin = "l") or (srt_admin = "p")) then %>
      <li><a href="admin_LogDisplay.asp">iSRT Action Log</a></li>
      <li><a href="divisional_LogDisplay.asp?viewDivision=<%= session("division") %>">Divisional Action Log</a></li>
      <% else %>
      <li><a href="divisional_LogDisplay.asp?viewDivision=<%= session("division") %>">Divisional Action Log</a></li>
      <% end if %>
      <li><a href="filterForm.asp">Advanced Search</a></li>
      <% if srt_admin = "y" then %>
      <li><a href="loginRequests.asp">Login Requests</a></li>
      <% end if %>
      <li><a href="Splash.asp">Home</a></li>
    </ul>
  </li>
  <li><a href="#">Reports</a>
    <ul>
      <% if srt_admin = "y" then %>
      <li><a href="admin_LogReport.asp?overflow=y">iSRT Report<img src="images/arrow-right.gif" style="padding-left:20px;" alt="arrow-right" /></a>
    <ul>
      <li><a href="admin_LogReport.asp?searchVal=&amp;filterSelect=open&amp;divisionSelect=All&amp;overflow=y">Open</a></li>
      <li><a href="admin_LogReport.asp?searchVal=&amp;filterSelect=closed&amp;divisionSelect=All&amp;overflow=y">Closed</a></li>
      <li><a href="admin_LogReport.asp?searchVal=&amp;filterSelect=void&amp;divisionSelect=All&amp;overflow=y">Void</a></li>
      <li><a href="admin_LogReport.asp?searchVal=&amp;filterSelect=re-opened&amp;divisionSelect=All&amp;overflow=y">Re-Opened</a></li>
      <li><a href="admin_LogReport.asp?searchVal=&amp;filterSelect=demoted&amp;divisionSelect=All&amp;overflow=y">Demoted</a></li>
      <li><a href="admin_LogReport.asp?searchVal=&amp;filterSelect=removed&amp;divisionSelect=All&amp;overflow=y">Removed</a></li>  
      <li><a href="admin_LogReport.asp?searchVal=&amp;filterSelect=not%20accepted&amp;divisionSelect=All&amp;overflow=y">Not Accepted</a></li> 
    </ul>
    </li>
    <% if viewdivision = "" or viewdivision = "iSRT" then 
    else %>
      <li><a href="divisional_LogReport.asp?viewdivision=<%= viewdivision %>&amp;overflow=y"><%= viewdivision %> Report<img src="images/arrow-right.gif" style="padding-left:20px;" alt="arrow-right" /></a>
    <ul>
      <li><a href="divisional_LogReport.asp?viewdivision=<%= viewdivision %>&amp;searchVal=&amp;filterSelect=open&amp;divisionSelect=All&amp;overflow=y">Open</a></li>
      <li><a href="divisional_LogReport.asp?viewdivision=<%= viewdivision %>&amp;searchVal=&amp;filterSelect=closed&amp;divisionSelect=All&amp;overflow=y">Closed</a></li>
      <li><a href="divisional_LogReport.asp?viewdivision=<%= viewdivision %>&amp;searchVal=&amp;filterSelect=void&amp;divisionSelect=All&amp;overflow=y">Void</a></li>
      <li><a href="divisional_LogReport.asp?viewdivision=<%= viewdivision %>&amp;searchVal=&amp;filterSelect=re-opened&amp;divisionSelect=All&amp;overflow=y">Re-Opened</a></li>
      <li><a href="divisional_LogReport.asp?viewdivision=<%= viewdivision %>&amp;searchVal=&amp;filterSelect=demoted&amp;divisionSelect=All&amp;overflow=y">Demoted</a></li>
      <li><a href="divisional_LogReport.asp?viewdivision=<%= viewdivision %>&amp;searchVal=&amp;filterSelect=removed&amp;divisionSelect=All&amp;overflow=y">Removed</a></li> 
      <li><a href="divisional_LogReport.asp?viewdivision=<%= viewdivision %>&searchVal=&amp;filterSelect=not%20accepted&amp;divisionSelect=All&amp;overflow=y">Not Accepted</a></li>
    </ul>
    </li> <% end if %>
      <% elseif ((srt_admin = "l") or (srt_admin = "p")) then %>
      <li><a href="admin_LogReport.asp?overflow=y">iSRT Report</a></li>
      <li><a href="#">iSRT Items<img src="images/arrow-right.gif" style="padding-left:20px;" alt="arrow-right" /></a>
    <ul>
      <li><a href="admin_LogReport.asp?searchVal=&amp;filterSelect=open&amp;divisionSelect=All&amp;overflow=y">Open</a></li>
      <li><a href="admin_LogReport.asp?searchVal=&amp;filterSelect=closed&amp;divisionSelect=All&amp;overflow=y">Closed</a></li>
      <li><a href="admin_LogReport.asp?searchVal=&amp;filterSelect=void&amp;divisionSelect=All&amp;overflow=y">Void</a></li>
      <li><a href="admin_LogReport.asp?searchVal=&amp;filterSelect=re-opened&amp;divisionSelect=All&amp;overflow=y">Re-Opened</a></li>
      <li><a href="admin_LogReport.asp?searchVal=&amp;filterSelect=demoted&amp;divisionSelect=All&amp;overflow=y">Demoted</a></li>
      <li><a href="admin_LogReport.asp?searchVal=&amp;filterSelect=removed&amp;divisionSelect=All&amp;overflow=y">Removed</a></li>
    </ul>
    </li>
      <li><a href="divisional_LogReport.asp?viewDivision=<%= session("division") %>&amp;overflow=y">Divisional Report</a></li>      
      <li><a href="#">Divisional Items<img src="images/arrow-right.gif" style="padding-left:20px;" alt="arrow-right" /></a>
    <ul>
      <li><a href="divisional_LogReport.asp?viewDivision=<%= session("division") %>&amp;searchVal=&amp;filterSelect=open&amp;divisionSelect=All&amp;overflow=y">Open</a></li>
      <li><a href="divisional_LogReport.asp?viewDivision=<%= session("division") %>&amp;searchVal=&amp;filterSelect=closed&amp;divisionSelect=All&amp;overflow=y">Closed</a></li>
      <li><a href="divisional_LogReport.asp?viewDivision=<%= session("division") %>&amp;searchVal=&amp;filterSelect=void&amp;divisionSelect=All&amp;overflow=y">Void</a></li>
      <li><a href="divisional_LogReport.asp?viewDivision=<%= session("division") %>&amp;searchVal=&amp;filterSelect=re-opened&amp;divisionSelect=All&amp;overflow=y">Re-Opened</a></li>
      <li><a href="divisional_LogReport.asp?viewDivision=<%= session("division") %>&amp;searchVal=&amp;filterSelect=demoted&amp;divisionSelect=All&amp;overflow=y">Demoted</a></li>
      <li><a href="divisional_LogReport.asp?viewDivision=<%= session("division") %>&amp;searchVal=&amp;filterSelect=removed&amp;divisionSelect=All&amp;overflow=y">Removed</a></li>
    </ul>
    </li>
      <% else %>
      <li><a href="divisional_LogReport.asp?viewDivision=<%= session("division") %>&amp;overflow=y">Divisional Report</a></li>
      <li><a href="divisional_LogReport.asp?viewDivision=<%= session("division") %>&amp;searchVal=&amp;filterSelect=open&amp;divisionSelect=All&amp;overflow=y">Open</a></li>
      <li><a href="divisional_LogReport.asp?viewDivision=<%= session("division") %>&amp;searchVal=&amp;filterSelect=closed&amp;divisionSelect=All&amp;overflow=y">Closed</a></li>
      <li><a href="divisional_LogReport.asp?viewDivision=<%= session("division") %>&amp;searchVal=&amp;filterSelect=void&amp;divisionSelect=All&amp;overflow=y">Void</a></li>
      <li><a href="divisional_LogReport.asp?viewDivision=<%= session("division") %>&amp;searchVal=&amp;filterSelect=re-opened&amp;divisionSelect=All&amp;overflow=y">Re-Opened</a></li>
      <li><a href="divisional_LogReport.asp?viewDivision=<%= session("division") %>&amp;searchVal=&amp;filterSelect=demoted&amp;divisionSelect=All&amp;overflow=y">Demoted</a></li>
      <li><a href="divisional_LogReport.asp?viewDivision=<%= session("division") %>&amp;searchVal=&amp;filterSelect=removed&amp;divisionSelect=All&amp;overflow=y">Removed</a></li>   
      <% end if %>
    </ul>
  </li>
  <li><a href="#">New Item</a>
    <ul>
      <% if srt_admin = "y" then %>
      <li><a href="admin_LogInput.asp">iSRT Action Log</a></li>
        <% if viewdivision = "" or viewdivision = "iSRT" then 
        else %>
      <li><a href="divisional_LogInput.asp?viewDivision=<%= viewdivision %>"><%= viewdivision%> Action Log</a></li>
        <% end if %>
      <% else %>
      <li><a href="divisional_LogInput.asp?viewDivision=<%= session("division") %>"><%= viewdivision %> Action Log</a></li>
      <% end if %>
    </ul>
  </li>
  <li><a href="#">Stage Area</a>
    <ul>
      <% if srt_admin = "y" then %>
      <li><a href="admin_StageInput.asp?viewDivision=iSRT">iSRT Stage Input</a></li>
      <li><a href="admin_StageList.asp">iSRT Stage List</a></li>
       <% if viewdivision = "" or viewdivision = "iSRT" then 
       else %>
      <li><a href="divisional_StageInput.asp?viewDivision=<%= viewdivision %>"><%= viewdivision %> Stage Input</a></li>
      <li><a href="divisional_StageList.asp?viewDivision=<%= viewdivision %>"><%= viewdivision %> Stage List</a></li>
       <% end if %>
      <% else %>
      <li><a href="divisional_StageInput.asp?viewDivision=<%= session("division") %>"><%= session("division") %> Stage Input</a></li>
      <li><a href="divisional_StageList.asp?viewDivision=<%= session("division") %>"><%= session("division") %> Stage List</a></li>
      <% end if %>
    </ul>
  </li>
  <li><a href="#">Print</a>
    <ul>
      <% if srt_admin = "y" then %>
      <li><a href="javascript:window.print();">Print Page</a></li>
      <li><a href="admin_LogDisplay.asp?overflow=y&amp;searchVal=&amp;filterSelect=all&amp;divisionSelect=All">Printer Friendly</a></li>
      <li><a href="admin_LogDisplay.asp?searchVal=&amp;filterSelect=all&amp;divisionSelect=All">Browser Friendly</a></li>
      <% else %>
      <li><a href="javascript:window.print();">Print Page</a></li>
      <li><a href="divisional_LogDisplay.asp?viewDivision=<%= viewdivision %>&amp;overflow=y">Printer Friendly</a></li>
      <li><a href="divisional_LogDisplay.asp?viewDivision=<%= viewdivision %>">Browser Friendly</a></li>
      <% end if %>
    </ul>
  </li>
</ul>
