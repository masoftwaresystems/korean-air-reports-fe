set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

ALTER procedure [dbo].[sp_oneyearclosed]
as
    declare @log_number         bigint
    declare @hold_log_number    varchar(10)
    declare @formdataXML        xml
    declare @item_number        nvarchar(150)
    declare @date_due           nvarchar(20)
    declare @tmpdate            datetime
    declare @subject            nvarchar(255)
    declare @body               nvarchar(4000)
    declare @emailaddress       nvarchar(255)
    declare @division           nvarchar(150)
    declare @log_numberStr      varchar(150)
    declare @date_completed     datetime
    
    set @hold_log_number = 0

    declare logs_cursor cursor for 
    select division, logNumber, formdataXML
        from SRT_Data
        where formname = 'iSRT_LogInput' and archived = 'n'
        and active = 'y'
        and division is not null
        and division <> ''
        order by division asc, logNumber asc

    open logs_cursor

    fetch next from logs_cursor 
    into @division, @log_number, @formdataXML
    print 'fetch status:'+Convert(varchar(10),@@fetch_status)
    while @@fetch_status = 0
    begin
        --print 'fetched'

        select @date_completed = x.item.value('date_completed[1]', 'datetime')from @formdataXML.nodes('/formdata') as x(item)

        if(@date_completed <> '')
        begin
            print ''
            print 'division:'+@division
            print 'log number:'+Convert(varchar(255),@log_number)
            print 'date_completed:'+Convert(varchar(255),@date_completed)
            print 'date add:'+Convert(varchar(255),dateadd(year,1,@date_completed))
            if(datediff(day,getDate(),dateadd(year,1,@date_completed)) = 0)
            begin

                set @hold_log_number = Convert(varchar(10),@log_number)
                set @log_numberStr = @division+Replicate('0',5-len(@hold_log_number))+@hold_log_number

                print 'sending email'
                set @subject='SRT One Year Closed: '+@log_numberStr
                set @body='The iSRT action log item number '+@log_numberStr+' was closed on '+left(datename(month,@date_completed),3)+' '+Convert(varchar(2),day(@date_completed))+' '+Convert(varchar(4),year(@date_completed))+'<br><br>Follow up:<br><br>This action log item is due for quality control to ensure the policies, processes, and/or procedures that were used to mitigate the associated risk are in place.<br><br>________________________________________________________________________________________<br><br>Please comment on the above statement and give suggestions for the notification from Aviation Safety to the accountable leader that owns the action log item in question.'
                set @emailaddress='mike.aaron@gmail.com;'
                exec msdb.dbo.sp_send_dbmail
                @profile_name = 'DBMailProfile',
                @recipients = @emailaddress,
                @body_format = 'html',
                @body = @body,
                @subject = @subject;
            end
        end

        fetch next from logs_cursor 
        into @division, @log_number, @formdataXML
    end
      
    close logs_cursor
    deallocate logs_cursor

return

