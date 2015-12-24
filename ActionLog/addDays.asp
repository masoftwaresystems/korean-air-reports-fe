<%
opendate		= request("date")
daystoadd		= request("numdays")

duedate = DateAdd("d",daystoadd,opendate)

%><response><due.date><%= duedate %></due.date></response>