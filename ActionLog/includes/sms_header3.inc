<%
if(len(request("cookie_employee_number")) > 0) then
  loggedin_as = " <span style='font-weight:bold;'>"& request("cookie_first_name") &" "& request("cookie_last_name") &"</span>"
else
  loggedin_as = "&nbsp;"
end if

if(viewdivision = "") then
  viewdivision = request("cookie_division")
end if
viewdivisionStr = viewdivision

if(viewdivision = "ACSE") then
  viewdivisionStr = "Generic Base"
end if
%>

<!--Begin Common Content-->
<!--End Login Row-->

<!--Begin Nav -->

<div id="nav_div" style="width: 100%; padding-top: 0px; margin: 0pt auto;">

<ul id="nav_menu">
    <li><a href="splash.aspx">Home</a></li>

    <li><a href="#">Action Log</a>
        <ul>


	    <li><a href="#">Division</a>
		<ul>
<%
if(request("cookie_seeDivision") = "y") then
  sqlStr = " where code = '"& request("cookie_division") &"' "
end if
sql = "select * from division_t "& sqlStr &" order by division asc"
'response.write(sql)
'response.end
set tmprs = conn_asap.execute(sql)
do while not tmprs.eof
%>
		    <li><a href="#"><%= tmprs("code") %></a>
		    	<ul>
		    		<li><a href="divisional_LogDisplay.aspx?viewdivision=<%= tmprs("code") %>&amp;viewtype=ALL">Detail Listing</a></li>
		    		<li><a href="divisional_Base.aspx?viewdivision=<%= tmprs("code") %>&amp;viewtype=ACSE">Short Listing</a></li>
		    	</ul>
		    </li>
<%
  tmprs.movenext
loop
%>
		</ul>
		</li>
<% if(request("cookie_administrator") = "y") then %>
	    <li><a href="#">Generic</a>

		    	<ul>
		    		<li><a href="divisional_LogDisplay.aspx?viewdivision=GEN&amp;viewtype=ALL">Detail Listing</a></li>
		    		<li><a href="divisional_Base.aspx?viewdivision=GEN&amp;viewtype=ACSE">Short Listing</a></li>
		    	</ul>

		</li>
<% end if %>
            <li><a href="search.aspx?viewDivision=<%= viewdivision %>">Hazard Search</a></li>

        </ul>
    </li>
    <li><a href="#">Reports</a>
        <ul>
        	<li><a href="reports_Custom.aspx">All Hazards</a></li>
        	<li><a href="reports_Overdue.aspx">Overdue Hazards</a></li>
        </ul>
    </li>
	    <li><a href="#">Add New</a>
		<ul>
<% if((request("cookie_administrator") = "y") or (request("cookie_seeAll") = "y")) then %>
<%
sql = "select * from division_t order by division asc"
set tmprs = conn_asap.execute(sql)
do while not tmprs.eof
%>
				<li><a href="#"><%= tmprs("code") %></a>
				<ul>
		    		  <li><a href="divisional_LogInput2.aspx?viewdivision=<%= tmprs("code") %>&base=GEN&type=HAZ&amp;viewtype=ALL">Hazard</a></li>
		    		</ul>
		    		</li>	
<%
  tmprs.movenext
loop
%>
<% else %>
				<li><a href="#"><%= viewdivision %></a>
				<ul>
		    		  <li><a href="divisional_LogInput2.aspx?viewdivision=<%= viewdivision %>&base=GEN&type=HAZ&amp;viewtype=ALL">Hazard</a></li>
		    		</ul>
		    		</li>	
<% end if %>
		</ul>
	    </li>
<% if(request("cookie_administrator") = "y") then %>
    <li><a href="#">Admin</a>
        <ul>
            <li><a href="load_generic.aspx">Load Generic</a></li>
            <li><a href="admin_user.aspx">User</a></li>
            <li><a href="editNews.aspx">Bulletins</a></li>
        </ul>
    </li>
<% end if %>
    <li><a href="myOpen.aspx">My Open</a></li>
    <li><a href="javascript:confirmLogout()">Logout</a></li>
</ul>
</div>

<!--End Nav -->


</div>
<!--End Common Content-->
<div style="display:none;">
<form name="logoutfrm" id="logoutfrm" action="logout.asp">
</form>
</div>
<script>
function confirmLogout() {
var r=confirm("Please save any unsaved work.\nPress OK to logout");
if (r==true)
  {
    //document.location = "logout.asp";
    document.getElementById("logoutfrm").submit();
  }
}
</script>