<div name="QuickSearch" id="QuickSearch" style="float:right;width:120px;">
<% if(request("viewDivision") = "EH:DIV") then %>
<form action="admin_LogDisplay.asp" method="post">
<% else %>
<form action="divisional_LogDisplay.asp" method="post">
<% end if %>
<input type="hidden" name="viewDivision" value="<%= request("viewDivision") %>">
<p>
<input type="text" name="searchVal" id="searchVal" <% if(searchVal <> "") then %>value="<%= searchVal %>"<% end if %> style="border:1px solid black;width:110px;font-size:9px;margin-right:2px;" />
<input type="submit" value="Quick Search" onclick="doSearch('<%= request("viewDivision") %>')" style="width:100px;font:normal 10px verdana;color:black;" />
</p>
</form>
</div>
