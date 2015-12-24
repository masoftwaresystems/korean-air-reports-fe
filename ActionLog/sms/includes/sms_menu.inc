<% srt_admin = session("srt_admin") %>
<ul id="nav_menu">
    <li><a href="#">Action Log</a>
        <ul>
            <% if srt_admin = "y" then %>

	    <li><a href="admin_LogDisplay.asp">Division<img src="images/arrow-right.gif" style="padding-left:20px;" alt="arrow-right" /></a>
		<ul>
		    <li><a href="admin_LogDisplay.asp?viewdivision=GLOBAL">GLOBAL</a></li>
		</ul>
		</li>
	    <li><a href="#">Business Unit<img src="images/arrow-right.gif" style="padding-left:20px;" alt="arrow-right" /></a>
		<ul>	    
		    <li><a href="#">EBU<img src="images/arrow-right.gif" style="padding-left:20px;" alt="arrow-right" /></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=EBU&viewtype=ALL">All Hazards</a></li>
		    		<li><a href="divisional_Base.asp?viewdivision=EBU&viewtype=BASE">Hazards by Base</a></li>
		    		<!-- <li><a href="divisional_Equipment.asp?viewdivision=EBU&viewtype=AIRCRAFT">Hazards by Aircraft</a></li> -->
		    	</ul>
		    </li>
		    <li><a href="#">COBU<img src="images/arrow-right.gif" style="padding-left:20px;" alt="arrow-right" /></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=COBU&viewtype=ALL">All Hazards</a></li>
		    		<li><a href="divisional_Base.asp?viewdivision=COBU&viewtype=BASE">Hazards by Base</a></li>
		    	</ul>
		    </li>
		    <li><a href="#">IBU<img src="images/arrow-right.gif" style="padding-left:20px;" alt="arrow-right" /></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=IBU&viewtype=ALL">All Hazards</a></li>
		    		<li><a href="divisional_Base.asp?viewdivision=IBU&viewtype=BASE">Hazards by Base</a></li>
		    	</ul>
		    </li>
		    <li><a href="#">NABU<img src="images/arrow-right.gif" style="padding-left:20px;" alt="arrow-right" /></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=NABU&viewtype=ALL">All Hazards</a></li>
		    		<li><a href="divisional_Base.asp?viewdivision=NABU&viewtype=BASE">Hazards by Base</a></li>
		    	</ul>
		    </li>
		    <li><a href="#">WASBU<img src="images/arrow-right.gif" style="padding-left:20px;" alt="arrow-right" /></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=WASBU&viewtype=ALL">All Hazards</a></li>
		    		<li><a href="divisional_Base.asp?viewdivision=WASBU&viewtype=BASE">Hazards by Base</a></li>
		    	</ul>
		    </li>
		    <li><a href="#">AUSBU<img src="images/arrow-right.gif" style="padding-left:20px;" alt="arrow-right" /></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=AUSBU&viewtype=ALL">All Hazards</a></li>
		    		<li><a href="divisional_Base.asp?viewdivision=AUSBU&viewtype=BASE">Hazards by Base</a></li>
		    	</ul>
		    </li>
		    <li><a href="#">TEST<img src="images/arrow-right.gif" style="padding-left:20px;" alt="arrow-right" /></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=TEST&viewtype=ALL">All Hazards</a></li>
		    		<li><a href="divisional_Base.asp?viewdivision=TEST&viewtype=BASE">Hazards by Base</a></li>
		    	</ul>
		    </li>
		</ul>
		</li>
            <% elseif ((srt_admin = "l") or (srt_admin = "p")) then %>
            <li><a href="admin_LogDisplay.asp">SMS Action Log</a></li>
            <li><a href="divisional_LogDisplay.asp?viewDivision=<%= session("division") %>">Divisional Action Log</a></li>
            <% else %>
            <li><a href="divisional_LogDisplay.asp?viewDivision=<%= session("division") %>">Divisional Action Log</a></li>
            <% end if %>
	    <li><a href="#">Generic<img src="images/arrow-right.gif" style="padding-left:20px;" alt="arrow-right" /></a>	    
		<ul>	    
		    <li><a href="#">Aircraft<img src="images/arrow-right.gif" style="padding-left:20px;" alt="arrow-right" /></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=AS332&viewtype=ALL">AS332</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=AW139&viewtype=ALL">AW139</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=B206&viewtype=ALL">B206</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=B412&viewtype=ALL">B412</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=BK117&viewtype=ALL">BK117</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=EC155&viewtype=ALL">EC155</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=EC225&viewtype=ALL">EC225</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=S61&viewtype=ALL">S61</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=S76&viewtype=ALL">S76</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=S92&viewtype=ALL">S92</a></li>
		    	</ul>
		    </li>
		    <li><a href="divisional_LogDisplay.asp?viewdivision=BASE&viewtype=ALL">Base</a></li>
		    <li><a href="#">Mission<img src="images/arrow-right.gif" style="padding-left:20px;" alt="arrow-right" /></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=SAR&viewtype=ALL">SAR</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=CAT&viewtype=ALL">CAT</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=HHO&viewtype=ALL">HHO</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=USL&viewtype=ALL">USL</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=TR&viewtype=ALL">TR</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=FT&viewtype=ALL">FT</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=Task&viewtype=ALL">Task</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=NOPS&viewtype=ALL">NOPS</a></li>
		    	</ul>
		    </li>
		</ul>
		</li>
            <li><a href="filterForm.asp">Advanced Search</a></li>
            <% if srt_admin = "x" then %>
            <li><a href="loginRequests.asp">Login Requests</a></li>
            <% end if %>
            <li><a href="Splash.asp">Home</a></li>
        </ul>
    </li>
    <li><a href="#">Reports</a>
        <ul>
        	<li><a href="reports_Custom.asp">Custom</a></li>
        	<li><a href="reports_Overdue.asp">Overdue</a></li>
        	<!-- <li><a href="reports_Standard.asp">Standard</a></li> -->
        </ul>
    </li>
    <!--
    <li><a href="#">Reports</a>
        <ul>
        	<li></li>
            <% if srt_admin = "y" then %>
            <li><a href="admin_LogReport.asp?overflow=y">SMS Report<img src="images/arrow-right.gif" style="padding-left:20px;" alt="arrow-right" /></a>
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
	    <% if viewdivision = "" or viewdivision = "SMS" then 
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
            <li><a href="admin_LogReport.asp?overflow=y">SMS Report</a></li>
            <li><a href="#">SMS Items<img src="images/arrow-right.gif" style="padding-left:20px;" alt="arrow-right" /></a>
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
    -->
    <% if(session("admin") <> "r") then %>
    <li><a href="#">New Item</a>
        <ul>            
		    <li><a href="#">Aircraft<img src="images/arrow-right.gif" style="padding-left:20px;" alt="arrow-right" /></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=AS332&viewtype=ALL">AS332</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=AW139&viewtype=ALL">AW139</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=B206&viewtype=ALL">B206</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=B412&viewtype=ALL">B412</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=BK117&viewtype=ALL">BK117</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=EC155&viewtype=ALL">EC155</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=EC225&viewtype=ALL">EC225</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=S61&viewtype=ALL">S61</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=S76&viewtype=ALL">S76</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=S92&viewtype=ALL">S92</a></li>
		    	</ul>
		    </li>
		    <li><a href="divisional_LogDisplay.asp?viewdivision=BASE&viewtype=ALL">Base</a></li>
		    <li><a href="#">Mission<img src="images/arrow-right.gif" style="padding-left:20px;" alt="arrow-right" /></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=SAR&viewtype=ALL">SAR</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=CAT&viewtype=ALL">CAT</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=HHO&viewtype=ALL">HHO</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=USL&viewtype=ALL">USL</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=TR&viewtype=ALL">TR</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=FT&viewtype=ALL">FT</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=Task&viewtype=ALL">Task</a></li>
		    		<li><a href="divisional_LogDisplay.asp?viewdivision=NOPS&viewtype=ALL">NOPS</a></li>
		    	</ul>
		    </li>
        </ul>
    </li>
    <% end if %>
   <!--
   <li><a href="#">Stage Area</a>
         <ul>
             <li><a href="divisional_StageInput.asp?viewDivision=<%= viewdivision %>"><%= viewdivision %> Stage Input</a></li>
             <li><a href="divisional_StageList.asp?viewDivision=<%= viewdivision %>"><%= viewdivision %> Stage List</a></li>
         </ul>
    </li>

   <li><a href="#">Library</a>
         <ul>
             <li><a href="#">Divisional Manuals</a></li>
             <li><a href="#">Training Docs</a></li>
         </ul>
    </li>
   -->
   <li><a href="#">Print</a>
         <ul>
             <% if(viewDivision = "EH:DIV") then %>
             <li><a href="javascript:window.print();">Print Page</a></li>
             <li><a href="admin_LogDisplay.asp?overflow=y&amp;searchVal=&amp;filterSelect=all&amp;divisionSelect=All&amp;viewDivision=<%= viewdivision %>">Printer Friendly</a></li>
             <li><a href="admin_LogDisplay.asp?searchVal=&amp;filterSelect=all&amp;divisionSelect=All&amp;viewDivision=<%= viewdivision %>">Browser Friendly</a></li>
             <% else %>
             <li><a href="javascript:window.print();">Print Page</a></li>
             <li><a href="divisional_LogDisplay.asp?viewDivision=<%= viewdivision %>&amp;overflow=y">Printer Friendly</a></li>
             <li><a href="divisional_LogDisplay.asp?viewDivision=<%= viewdivision %>">Browser Friendly</a></li>
             <% end if %>
         </ul>
    </li>
    <% if(session("sms_admin") = "y") then %>
    <li><a href="#">Admin</a>
        <ul>
            <li><a href="users.asp">Users</a></li>
        </ul>
    </li>
    <% end if %>
</ul>
