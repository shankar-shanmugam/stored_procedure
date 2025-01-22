
----------storing query result in variable----
DECLARE @product_count INT;
SET @product_count = (
    SELECT 
        COUNT(*) 
    FROM 
        production.products 
);
PRINT 'The number of products is ' + CAST(@product_count AS VARCHAR(MAX));

------------stored procedure using output parameters-----------


CREATE PROCEDURE GetProductCount
    @ProductCount INT OUTPUT
AS
BEGIN
    SELECT @ProductCount = COUNT(*) 
    FROM production.products;
END;

-- To call the procedure and get the count:
DECLARE @Result INT;
EXEC GetProductCount @Result OUTPUT;
PRINT 'The number of products is ' + CAST(@Result AS VARCHAR(MAX));


CREATE  PROC uspGetProductList(
    @model_year SMALLINT
) AS 
BEGIN
    DECLARE @product_list VARCHAR(MAX);

    SET @product_list = '';

    SELECT
        @product_list = @product_list + product_name 
                        + CHAR(10)
    FROM 
        production.products
    WHERE
        model_year = @model_year
    ORDER BY 
        product_name;

    PRINT @product_list;
END;

uspGetProductList 2018


---------------output parameters---------------

create proc spgetProductListByModel_year(@model_year smallint,@product_count tinyint output)
as
begin
	select  @product_count=count(*)
	from production.products
	where model_year=@model_year
end

declare @totalcountproductinyear tinyint

exec spgetProductListByModel_year @model_year=2018, @product_count=@totalcountproductinyear output

print cast(@totalcountproductinyear as nvarchar(20))+' no of products in the year'; 