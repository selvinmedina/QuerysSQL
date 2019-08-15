--listado del inventario agrupado por categoria
--Debe de estar de forma horizontal y colocar la info mas importante
--nombre de columna que no se repita por groupo y que aparezca una vez
--info principal categoria tiene que estar en negrta y esté al inicio de la agrupación

SELECT B.ProductID AS [Id Producto],
	   B.Name AS [NombreProducto],
	   B.ListPrice AS [Precio],
	   A.Quantity AS [Cantidad],
	   ISNULL(D.Name,'N/A') AS [NombreCategoria],
	   B.Name AS [NombreSubcategoria]
 FROM Production.ProductInventory AS A
LEFT JOIN Production.Product AS B ON A.ProductID =  B.ProductID
LEFT JOIN Production.ProductSubcategory AS C ON B.ProductSubcategoryID = C.ProductSubcategoryID
LEFT JOIN Production.ProductCategory AS D ON D.ProductCategoryID = C.ProductCategoryID

SELECT * FROM Production.ProductInventory

--Historial precios de productos agrupados por categoria

SELECT * FROM Production.Product AS A
LEFT JOIN Production.ProductSubcategory AS B ON A.ProductSubcategoryID = B.ProductSubcategoryID
LEFT JOIN Production.ProductCategory AS C ON B.ProductCategoryID = C.ProductCategoryID


SELECT B.Name AS [NombreProducto],
	   ISNULL(A.ListPrice,0) [Precio],
	   ISNULL(D.Name,'N/A') AS [Categoría]
 FROM Production.Product AS B 
LEFT JOIN [Production].[ProductListPriceHistory] AS A  ON B.ProductID  = A.ProductID
LEFT JOIN Production.ProductSubcategory AS C ON C.ProductSubcategoryID = B.ProductSubcategoryID
LEFT JOIN Production.ProductCategory AS D ON D.ProductCategoryID = C.ProductCategoryID
WHERE B.ProductID = 2

SELECT * FROM Production.Product AS A 
WHERE ListPrice = 0
WHERE Name = 'Bearing Ball'


--Listado de Works order agrupadas por el color de producto
-- Si el color del producto está nulo, le adignamos un color diferente al que existe en esa tabla, 
--el color depende de la categoría

SELECT * FROM Production.ProductCategory

SELECT ISNULL(B.Color,CASE (SELECT ISNULL(D.ProductCategoryID,5))
	     WHEN 1 THEN 'Golden' 
	     WHEN 2 THEN 'Pink' 
	     WHEN 3 THEN 'Purple'
	     WHEN 4 THEN 'Green'
		 WHEN 5 THEN 'Orange'
	     END) 
 AS [Color],
	   A.WorkOrderID AS [IdOrden],
	   ISNULL(D.Name,'N/A') AS [Categoria]
FROM Production.WorkOrder AS A
LEFT JOIN Production.Product AS B ON A.ProductID = B.ProductID
LEFT JOIN Production.ProductSubcategory AS C ON C.ProductSubcategoryID = B.ProductSubcategoryID
LEFT JOIN Production.ProductCategory AS D ON D.ProductCategoryID = C.ProductCategoryID


SELECT ISNULL (B.Color,
	CASE (D.ProductCategoryID)
	   WHEN 1 THEN 'Golden' 
	   WHEN 2 THEN 'Pink' 
	   WHEN 3 THEN 'Purple'
	   WHEN 4 THEN 'Green'
	   END) AS [Color],
	   A.WorkOrderID AS [IdOrden],
	   ISNULL(D.Name,'N/A') AS [Categoria]
FROM Production.WorkOrder AS A
LEFT JOIN Production.Product AS B ON A.ProductID = B.ProductID
LEFT JOIN Production.ProductSubcategory AS C ON C.ProductSubcategoryID = B.ProductSubcategoryID
LEFT JOIN Production.ProductCategory AS D ON D.ProductCategoryID = C.ProductCategoryID

SELECT * FROM Production.Product AS A



-------Reporte de personas agrupados por trestipos: clientes, vendedores y empleados

SELECT A.BusinessEntityID AS [IdPersona],
		ISNULL(A.FirstName,'') +' '+ ISNULL(A.MiddleName,'') +' '+ ISNULL(A.LastName,'') AS [NombreCompleto],
	   (CASE A.PersonType
	    WHEN 'EM' THEN 'Empleado' 
		WHEN 'IN' THEN 'Cliente' 
		WHEN 'SP' THEN 'Vendedor' END) AS [TipoPersona]
FROM Person.Person AS A
LEFT JOIN Sales.SalesPerson AS B ON B.BusinessEntityID = A.BusinessEntityID
LEFT JOIN HumanResources.Employee AS C ON C.BusinessEntityID = A.BusinessEntityID
LEFT JOIN Sales.Customer AS D ON D.PersonID = A.BusinessEntityID
WHERE A.PersonType IN('EM','IN','SP')

-- Listado de transacciones agrupado por la categoria del producto