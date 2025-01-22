------------stored procedure------------

---1)creating simple stored procedure

create proc spviewproductlist
as 
begin
	select
		product_name,
		list_price
	from
		production.products
	order by
		list_price

end

exec  spviewproductlist

------------------Modify stored procedure -------------------
alter proc spviewproductlist
as
begin
	select
		product_name,
		list_price
	from
		production.products
	order by
		product_name
end

---------------------deleting procedure-----------
drop proc spviewproductlist