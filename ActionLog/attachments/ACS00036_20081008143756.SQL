set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

ALTER procedure [dbo].[sp_showContacts]
as

	declare @last_name nvarchar(30)
	declare @first_name nvarchar(30)
	declare @id_code nvarchar(10)
	declare @user1 nvarchar(30)
	declare @user4 nvarchar(30)
	declare @mkey int
	declare @phone_type int
	declare @phone_number nvarchar(80)
	declare @phone_extension nvarchar(10)
	declare @phone_description nvarchar(50)
	declare @phone_city nvarchar(50)
	declare @phone_exchange nvarchar(50)
	declare @phone_key int
	declare @phone_pin nvarchar(15)
	
	declare @hold_last_name nvarchar(30)
	declare @hold_first_name nvarchar(30)
	declare @hold_id_code nvarchar(10)
	declare @hold_user1 nvarchar(30)
	declare @hold_user4 nvarchar(30)
	declare @hold_mkey int
	
	declare @phone_number1 nvarchar(80), @phone_number2 nvarchar(80), @phone_number3 nvarchar(80), @phone_number4 nvarchar(80), @phone_number5 nvarchar(80), @phone_number7 nvarchar(80)
	declare @phone_extension1 nvarchar(10), @phone_extension2 nvarchar(10), @phone_extension3 nvarchar(10), @phone_extension4 nvarchar(10), @phone_extension5 nvarchar(10), @phone_extension7 nvarchar(10)
	declare @phone_description1 nvarchar(50), @phone_description2 nvarchar(50), @phone_description3 nvarchar(50), @phone_description4 nvarchar(50), @phone_description5 nvarchar(50), @phone_description7 nvarchar(50)
	declare @phone_city1 nvarchar(50), @phone_city2 nvarchar(50), @phone_city3 nvarchar(50), @phone_city4 nvarchar(50), @phone_city5 nvarchar(50), @phone_city7 nvarchar(50)
	declare @phone_exchange1 nvarchar(50), @phone_exchange2 nvarchar(50), @phone_exchange3 nvarchar(50), @phone_exchange4 nvarchar(50), @phone_exchange5 nvarchar(50), @phone_exchange7 nvarchar(50)
	declare @phone_key1 nvarchar(50), @phone_key2 nvarchar(50), @phone_key3 nvarchar(50), @phone_key4 nvarchar(50), @phone_key5 nvarchar(50), @phone_key7 nvarchar(50)
	declare @phone_pin1 nvarchar(15), @phone_pin2 nvarchar(15), @phone_pin3 nvarchar(15), @phone_pin4 nvarchar(15), @phone_pin5 nvarchar(15), @phone_pin7 nvarchar(15)
	
	set @hold_mkey = 0
	
	set @phone_number1 = ''
	set @phone_number2 = ''
	set @phone_number3 = ''
	set @phone_number4 = ''
	set @phone_number5 = ''
	set @phone_number7 = ''
	
	set @phone_extension1 = ''
	set @phone_extension2 = ''
	set @phone_extension3 = ''
	set @phone_extension4 = ''
	set @phone_extension5 = ''
	set @phone_extension7 = ''
	
	set @phone_description1 = ''
	set @phone_description2 = ''
	set @phone_description3 = ''
	set @phone_description4 = ''
	set @phone_description5 = ''
	set @phone_description7 = ''
	
	set @phone_city1 = ''
	set @phone_city2 = ''
	set @phone_city3 = ''
	set @phone_city4 = ''
	set @phone_city5 = ''
	set @phone_city7 = ''
	
	set @phone_exchange1 = ''
	set @phone_exchange2 = ''
	set @phone_exchange3 = ''
	set @phone_exchange4 = ''
	set @phone_exchange5 = ''
	set @phone_exchange7 = ''
	
	set @phone_key1 = ''
	set @phone_key2 = ''
	set @phone_key3 = ''
	set @phone_key4 = ''
	set @phone_key5 = ''
	set @phone_key7 = ''
	
	set @phone_pin1 = ''
	set @phone_pin2 = ''
	set @phone_pin3 = ''
	set @phone_pin4 = ''
	set @phone_pin5 = ''
	set @phone_pin7 = ''

	declare phone_cur cursor for 
        SELECT Roster.LastName, Roster.FirstName, Roster.IDCode, Roster.User1, Roster.User4, Roster.MKey, Phone.Type, Phone.PNumber, Phone.Extension, Phone.Descript, Phone.City, Phone.Exchange, Phone.PhoneKey, Phone.PIN
        from Roster, Groups, GroupMembers, Phone
        where Roster.MKey = GroupMembers.MKey and GroupMembers.GKey = Groups.GKey and Roster.MKey = Phone.MKey
        GROUP BY Roster.LastName, Roster.FirstName, Roster.IDCode, Roster.User1, Roster.User4, Roster.MKey, Phone.Type, Phone.PNumber, Phone.Extension, Phone.Descript, Phone.Script, Phone.Country, Phone.City, Phone.Exchange, Phone.PhoneKey, Phone.PIN
        ORDER BY Roster.MKey asc

	open phone_cur
	
	print '<table border=1>'

	fetch next from phone_cur into 
	@last_name, @first_name, @id_code, @user1, @user4, @mkey, @phone_type, @phone_number, @phone_extension, @phone_description, @phone_city, @phone_exchange, @phone_key, @phone_pin
	-- print 'fetch status:'+Convert(varchar(10),@@fetch_status)
	while @@fetch_status = 0
	begin
	        --print 'fetched'

                if(@hold_mkey <> @mkey)
                begin
                
                  if(@hold_mkey = 0)
                  begin
                    -- print header
                    print '<tr><td>LastName</td><td>FirstName</td><td>IDCode</td><td>User1</td><td>User4</td><td>PNumber1</td><td>Extension1</td><td>Descript1</td><td>City1</td><td>Exchange1</td><td>PhoneKey1</td><td>PIN1</td><td>PNumber2</td><td>Extension2</td><td>Descript2</td><td>City2</td><td>Exchange2</td><td>PhoneKey2</td><td>PIN2</td><td>PNumber3</td><td>Extension3</td><td>Descript3</td><td>City3</td><td>Exchange3</td><td>PhoneKey3</td><td>PIN3</td><td>PNumber4</td><td>Extension4</td><td>Descript4</td><td>City4</td><td>Exchange4</td><td>PhoneKey4</td><td>PIN4</td><td>PNumber5</td><td>Extension5</td><td>Descript5</td><td>City5</td><td>Exchange5</td><td>PhoneKey5</td><td>PIN5</td><td>PNumber7</td><td>Extension7</td><td>Descript7</td><td>City7</td><td>Exchange7</td><td>PhoneKey7</td><td>PIN7</td></tr>'
                  end
                  else
                  begin
                  
                    -- print record
                    print '<tr><td>'+Convert(varchar(255),@hold_last_name)+'</td><td>'+Convert(varchar(255),@hold_first_name)+'</td><td>'+Convert(varchar(255),@hold_id_code)+'</td><td>'+Convert(varchar(255),@hold_user1)+'</td><td>'+Convert(varchar(255),@hold_user4)+'</td>'
                    
                    if(@phone_key1 = '0')
                      set @phone_key1 = ''
                    print '<td>'+Convert(varchar(255),@phone_number1)+'</td><td>'+Convert(varchar(255),@phone_extension1)+'</td><td>'+Convert(varchar(255),@phone_description1)+'</td><td>'+Convert(varchar(255),@phone_city1)+'</td><td>'+Convert(varchar(255),@phone_exchange1)+'</td><td>'+Convert(varchar(255),@phone_key1)+'</td><td>'+Convert(varchar(255),@phone_pin1)+'</td>'
                    
                    if(@phone_key2 = '0')
                      set @phone_key2 = ''
                    print '<td>'+Convert(varchar(255),@phone_number2)+'</td><td>'+Convert(varchar(255),@phone_extension2)+'</td><td>'+Convert(varchar(255),@phone_description2)+'</td><td>'+Convert(varchar(255),@phone_city2)+'</td><td>'+Convert(varchar(255),@phone_exchange2)+'</td><td>'+Convert(varchar(255),@phone_key2)+'</td><td>'+Convert(varchar(255),@phone_pin2)+'</td>'
                    
                    if(@phone_key3 = '0')
                      set @phone_key3 = ''
                    print '<td>'+Convert(varchar(255),@phone_number3)+'</td><td>'+Convert(varchar(255),@phone_extension3)+'</td><td>'+Convert(varchar(255),@phone_description3)+'</td><td>'+Convert(varchar(255),@phone_city3)+'</td><td>'+Convert(varchar(255),@phone_exchange3)+'</td><td>'+Convert(varchar(255),@phone_key3)+'</td><td>'+Convert(varchar(255),@phone_pin3)+'</td>'
                    
                    if(@phone_key4 = '0')
                      set @phone_key4 = ''
                    print '<td>'+Convert(varchar(255),@phone_number4)+'</td><td>'+Convert(varchar(255),@phone_extension4)+'</td><td>'+Convert(varchar(255),@phone_description4)+'</td><td>'+Convert(varchar(255),@phone_city4)+'</td><td>'+Convert(varchar(255),@phone_exchange4)+'</td><td>'+Convert(varchar(255),@phone_key4)+'</td><td>'+Convert(varchar(255),@phone_pin4)+'</td>'
                    
                    if(@phone_key5 = '0')
                      set @phone_key5 = ''
                    print '<td>'+Convert(varchar(255),@phone_number5)+'</td><td>'+Convert(varchar(255),@phone_extension5)+'</td><td>'+Convert(varchar(255),@phone_description5)+'</td><td>'+Convert(varchar(255),@phone_city5)+'</td><td>'+Convert(varchar(255),@phone_exchange5)+'</td><td>'+Convert(varchar(255),@phone_key5)+'</td><td>'+Convert(varchar(255),@phone_pin5)+'</td>'
                    
                    if(@phone_key7 = '0')
                      set @phone_key7 = ''
                    print '<td>'+Convert(varchar(255),@phone_number7)+'</td><td>'+Convert(varchar(255),@phone_extension7)+'</td><td>'+Convert(varchar(255),@phone_description7)+'</td><td>'+Convert(varchar(255),@phone_city7)+'</td><td>'+Convert(varchar(255),@phone_exchange7)+'</td><td>'+Convert(varchar(255),@phone_key7)+'</td><td>'+Convert(varchar(255),@phone_pin7)+'</td>'
                    
                    print '</tr>'
                  end
                  
	          set @phone_number1 = ''
	          set @phone_number2 = ''
	          set @phone_number3 = ''
	          set @phone_number4 = ''
	          set @phone_number5 = ''
	          set @phone_number7 = ''
	
	          set @phone_extension1 = ''
	          set @phone_extension2 = ''
	          set @phone_extension3 = ''
	          set @phone_extension4 = ''
	          set @phone_extension5 = ''
	          set @phone_extension7 = ''
	
	          set @phone_description1 = ''
	          set @phone_description2 = ''
	          set @phone_description3 = ''
	          set @phone_description4 = ''
	          set @phone_description5 = ''
	          set @phone_description7 = ''
	
	          set @phone_city1 = ''
	          set @phone_city2 = ''
	          set @phone_city3 = ''
	          set @phone_city4 = ''
	          set @phone_city5 = ''
	          set @phone_city7 = ''
	
	          set @phone_exchange1 = ''
	          set @phone_exchange2 = ''
	          set @phone_exchange3 = ''
	          set @phone_exchange4 = ''
	          set @phone_exchange5 = ''
	          set @phone_exchange7 = ''
	
	          set @phone_key1 = ''
	          set @phone_key2 = ''
	          set @phone_key3 = ''
	          set @phone_key4 = ''
	          set @phone_key5 = ''
	          set @phone_key7 = ''
	
	          set @phone_pin1 = ''
	          set @phone_pin2 = ''
	          set @phone_pin3 = ''
	          set @phone_pin4 = ''
	          set @phone_pin5 = ''
	          set @phone_pin7 = ''
	            
	          set @hold_mkey = @mkey
	          set @hold_last_name = @last_name
	          set @hold_first_name = @first_name
	          set @hold_id_code = @id_code
	          set @hold_user1 = @user1
	          set @hold_user4 = @user4
	          
	        end 
	        
	        if(@phone_type = 1)
	        begin
	          set @phone_number1 = @phone_number
	          set @phone_extension1 = @phone_extension
	          set @phone_description1 = @phone_description
	          set @phone_city1 = @phone_city
	          set @phone_extension1 = @phone_extension
	          set @phone_key1 = Convert(varchar(50),@phone_key)
	          set @phone_pin1 = @phone_pin
	        end
	        
	        if(@phone_type = 2)
	        begin
	          set @phone_number2 = @phone_number
	          set @phone_extension2 = @phone_extension
	          set @phone_description2 = @phone_description
	          set @phone_city2 = @phone_city
	          set @phone_extension2 = @phone_extension
	          set @phone_key2 = Convert(varchar(50),@phone_key)
	          set @phone_pin2 = @phone_pin
	        end
	        
	        if(@phone_type = 3)
	        begin
	          set @phone_number3 = @phone_number
	          set @phone_extension3 = @phone_extension
	          set @phone_description3 = @phone_description
	          set @phone_city3 = @phone_city
	          set @phone_extension3 = @phone_extension
	          set @phone_key3 = Convert(varchar(50),@phone_key)
	          set @phone_pin3 = @phone_pin
	        end
	        
	        if(@phone_type = 4)
	        begin
	          set @phone_number4 = @phone_number
	          set @phone_extension4 = @phone_extension
	          set @phone_description4 = @phone_description
	          set @phone_city4 = @phone_city
	          set @phone_extension4 = @phone_extension
	          set @phone_key4 = Convert(varchar(50),@phone_key)
	          set @phone_pin4 = @phone_pin
	        end
                
	        if(@phone_type = 5)
	        begin
	          set @phone_number5 = @phone_number
	          set @phone_extension5 = @phone_extension
	          set @phone_description5 = @phone_description
	          set @phone_city5 = @phone_city
	          set @phone_extension5 = @phone_extension
	          set @phone_key5 = Convert(varchar(50),@phone_key)
	          set @phone_pin5 = @phone_pin
	        end
	        
	        if(@phone_type = 7)
	        begin
	          set @phone_number7 = @phone_number
	          set @phone_extension7 = @phone_extension
	          set @phone_description7 = @phone_description
	          set @phone_city7 = @phone_city
	          set @phone_extension7 = @phone_extension
	          set @phone_key7 = Convert(varchar(50),@phone_key)
	          set @phone_pin7 = @phone_pin
	        end
                
	
	        fetch next from phone_cur into
	        @last_name, @first_name, @id_code, @user1, @user4, @mkey, @phone_type, @phone_number, @phone_extension, @phone_description, @phone_city, @phone_exchange, @phone_key, @phone_pin
	end
	close phone_cur
	deallocate phone_cur
	
        print '<tr><td>'+Convert(varchar(255),@hold_last_name)+'</td><td>'+Convert(varchar(255),@hold_first_name)+'</td><td>'+Convert(varchar(255),@hold_id_code)+'</td><td>'+Convert(varchar(255),@hold_user1)+'</td><td>'+Convert(varchar(255),@hold_user4)+'</td>'
        
        print '<td>'+Convert(varchar(255),@phone_number1)+'</td><td>'+Convert(varchar(255),@phone_extension1)+'</td><td>'+Convert(varchar(255),@phone_description1)+'</td><td>'+Convert(varchar(255),@phone_city1)+'</td><td>'+Convert(varchar(255),@phone_exchange1)+'</td><td>'+Convert(varchar(255),@phone_key1)+'</td><td>'+Convert(varchar(255),@phone_pin1)+'</td>'
        
        print '<td>'+Convert(varchar(255),@phone_number2)+'</td><td>'+Convert(varchar(255),@phone_extension2)+'</td><td>'+Convert(varchar(255),@phone_description2)+'</td><td>'+Convert(varchar(255),@phone_city2)+'</td><td>'+Convert(varchar(255),@phone_exchange2)+'</td><td>'+Convert(varchar(255),@phone_key2)+'</td><td>'+Convert(varchar(255),@phone_pin2)+'</td>'
        
        print '<td>'+Convert(varchar(255),@phone_number3)+'</td><td>'+Convert(varchar(255),@phone_extension3)+'</td><td>'+Convert(varchar(255),@phone_description3)+'</td><td>'+Convert(varchar(255),@phone_city3)+'</td><td>'+Convert(varchar(255),@phone_exchange3)+'</td><td>'+Convert(varchar(255),@phone_key3)+'</td><td>'+Convert(varchar(255),@phone_pin3)+'</td>'
        
        print '<td>'+Convert(varchar(255),@phone_number4)+'</td><td>'+Convert(varchar(255),@phone_extension4)+'</td><td>'+Convert(varchar(255),@phone_description4)+'</td><td>'+Convert(varchar(255),@phone_city4)+'</td><td>'+Convert(varchar(255),@phone_exchange4)+'</td><td>'+Convert(varchar(255),@phone_key4)+'</td><td>'+Convert(varchar(255),@phone_pin4)+'</td>'
        
        print '<td>'+Convert(varchar(255),@phone_number5)+'</td><td>'+Convert(varchar(255),@phone_extension5)+'</td><td>'+Convert(varchar(255),@phone_description5)+'</td><td>'+Convert(varchar(255),@phone_city5)+'</td><td>'+Convert(varchar(255),@phone_exchange5)+'</td><td>'+Convert(varchar(255),@phone_key5)+'</td><td>'+Convert(varchar(255),@phone_pin5)+'</td>'
        
        print '<td>'+Convert(varchar(255),@phone_number7)+'</td><td>'+Convert(varchar(255),@phone_extension7)+'</td><td>'+Convert(varchar(255),@phone_description7)+'</td><td>'+Convert(varchar(255),@phone_city7)+'</td><td>'+Convert(varchar(255),@phone_exchange7)+'</td><td>'+Convert(varchar(255),@phone_key7)+'</td><td>'+Convert(varchar(255),@phone_pin7)+'</td>'
        
        print '</tr>'
	
	print '</table>'

return
