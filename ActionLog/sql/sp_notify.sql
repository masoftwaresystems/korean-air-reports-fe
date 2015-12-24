drop procedure sp_notify
go

create procedure [dbo].[sp_notify]
as

	declare @log_number bigint
	declare @hold_log_number bigint
	declare @formdataXML xml
	declare @item_number nvarchar(150)
	declare @date_due nvarchar(20)
	declare @tmpdate datetime
	declare @subject nvarchar(255)
	declare @body nvarchar(4000)
	declare @emailaddress nvarchar(255)
	
	set @hold_log_number = 0

	declare upcoming_cursor cursor for 
	select logNumber, formdataXML
	from SRT_Data
	where formname = 'iSRT_LogInput' and archived = 'n'
	order by logNumber desc, recid desc

	open upcoming_cursor

	fetch next from upcoming_cursor 
	into @log_number, @formdataXML
	print 'fetch status:'+Convert(varchar(10),@@fetch_status)
	while @@fetch_status = 0
	begin
	        --print 'fetched'

                if(@log_number <> @hold_log_number)
                begin
                  set @hold_log_number = @log_number
		  print 'log number:'+Convert(varchar(255),@log_number)
		  select @date_due = x.item.value('date_due[1]', 'nvarchar(150)')from @formdataXML.nodes('/formdata') as x(item)
		  print 'date_due:'+Convert(varchar(255),@date_due)
		  
		  if(@date_due <> '')
		  begin
		    print 'date diff:'+Convert(varchar(255),datediff(d,getDate(),@date_due))
		    if(datediff(d,getDate(),@date_due) = 1)
		    begin
                      set @subject='SRT Reminder, Log Number '+Convert(varchar(255),@log_number)
		      set @body='The iSRT action log item number '+Convert(varchar(255),@log_number)+' is due on '+@date_due+'<br><br>Please advise your Aviation Safety liaison of any potential issues that may prevent your division from completing this action log item.'
		      set @emailaddress='mike.aaron@gmail.com;alex.vargas@delta.com;pepper1a669@gmail.com'
		      exec msdb.dbo.sp_send_dbmail
		      @profile_name = 'DBMailProfile',
		      @recipients = @emailaddress,
		      @body_format = 'html',
		      @body = @body,
                      @subject = @subject;
		    end
		  end
		  
                end
	
		fetch next from upcoming_cursor 
		into @log_number, @formdataXML
	end
	close upcoming_cursor
	deallocate upcoming_cursor

return




