		<div class="user">
			<p><% if(request("cookie_last_name") <> "") then %><%= request("cookie_last_name") %>, <% end if %><%= request("cookie_first_name") %> - <%= request("cookie_division") %></p>
		</div>