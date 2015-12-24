set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

alter procedure [dbo].[sp_notifyPOC]
as

	declare @log_number bigint
	declare @hold_log_number bigint
	declare @formdataXML xml
	declare @item_number nvarchar(150)
	declare @date_due nvarchar(20)
	declare @tmpdate datetime
	declare @subject nvarchar(255)
	declare @body nvarchar(4000)
	declare @poc_emailaddress nvarchar(255)
	declare @pm_emailaddress nvarchar(255)
	declare @emailaddresses nvarchar(4000)
	declare @emailaddresses2 nvarchar(4000)
	declare @division nvarchar(150)
	declare @accountable_leader nvarchar(150)
	declare @log_numberStr nvarchar(255)
	declare @today datetime
	
	set @hold_log_number = 0
	
	set @today = CONVERT( CHAR(8), GetDate(), 112) 
	print '@today:'+convert(varchar(255),@today)

	declare new_cursor cursor for 
	select logNumber, formdataXML, division
	from SRT_Data
	where formname = 'iSRT_LogInput' and archived = 'n'
	and active = 'y' and createDate >= @today
	order by logNumber desc, division desc, recid desc

	open new_cursor

	fetch next from new_cursor 
	into @log_number, @formdataXML, @division
	print 'fetch status:'+Convert(varchar(10),@@fetch_status)
	while @@fetch_status = 0
	begin
	        --print 'fetched'

                if not exists (select lognumber, division from SRT_Data where lognumber = @log_number and division = @division and createDate < @today)
                begin
                
                  set @log_numberStr = @division+Replicate('0',5-len(@log_number))+Convert(varchar(150),@log_number)
                  print ''
		  print 'log number:'+Convert(varchar(255),@log_numberStr)
		  print 'division:'+Convert(varchar(255),@division)
		  select @accountable_leader = x.item.value('accountable_leader[1]', 'nvarchar(150)')from @formdataXML.nodes('/formdata') as x(item)
		  print 'accountable_leader:'+Convert(varchar(255),@accountable_leader)
		  
		  select @poc_emailaddress = email_address from db_owner.tbl_logins where employee_number = @accountable_leader
		  print 'poc_emailaddress:'+Convert(varchar(255),@poc_emailaddress)
		  
		  select @pm_emailaddress = email_address from db_owner.tbl_logins where division = @division and srt_admin = 'p'
		  print 'pm_emailaddress:'+Convert(varchar(255),@pm_emailaddress)
		  
		  set @emailaddresses=@poc_emailaddress+';'+@pm_emailaddress+';mike.aaron@gmail.com;alex.vargas@delta.com;pepper1a669@gmail.com'
		  
		  set @emailaddresses2='mike.aaron@gmail.com;alex.vargas@delta.com;pepper1a669@gmail.com'
		  
                  set @subject='New SRT Action Log Item: '+Convert(varchar(255),@log_numberStr)
		  set @body=''+@division+' SRT Action Log item '+@log_numberStr+' has been created.  
		  The email would have ACTUALLY gone to '+@emailaddresses
		  print 'emailaddresses:'+Convert(varchar(4000),@emailaddresses)
		  exec msdb.dbo.sp_send_dbmail
		  @profile_name = 'DBMailProfile',
		  @recipients = @emailaddresses2,
		  @body_format = 'html',
		  @body = @body,
                  @subject = @subject;		  
 
                end
	
		fetch next from new_cursor 
		into @log_number, @formdataXML, @division
	end
	close new_cursor
	deallocate new_cursor

return
