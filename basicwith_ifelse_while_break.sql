
--------------Begin and end with if else --------------
begin

	declare @model_year as int =2020;
	declare @data smallint
	select
		@data=count(*)
	from
		production.products
	where
		model_year=@model_year
	if @data > 0
		begin
			print 'total count of products present in '+ cast(@model_year as nvarchar(max)) +' is :'+cast(@data as nvarchar(30))
		end
	else
		begin
			print 'no products found in the year ('+cast(@model_year as nvarchar(max))+')'
		end
end



--------------------while---------------
begin
declare @count as int = 1

while @count <=5
		begin		
			print @count
			set @count=@count+1
		end
end

--------------------using while with if else------------
begin
declare @data int = 1
while @data <= 20
		begin

			if @data % 2 =0
			print cast(@data as varchar(max))+ ' number is even'
			else
			print cast(@data as varchar(max))+ ' number is odd'
				
		set @data=@data + 1
	
		end

end

-------------break--------------------
DECLARE @counter INT = 0;

WHILE @counter <= 5
BEGIN
    SET @counter = @counter + 1;
    IF @counter = 4
        BREAK;
    PRINT @counter;
END

--------------------------------
