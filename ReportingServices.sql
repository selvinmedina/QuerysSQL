--Primer query
SELECT TOP 100
	p.FirstName,
	p.MiddleName,
	p.LastName
FROM Person.Person p

--Store
SELECT s.BusinessEntityID,
		s.Name,
		p.FirstName,
		p.MiddleName,
		p.LastName	
FROM Sales.Store s INNER JOIN Sales.SalesPerson sp
ON   s.SalesPersonID = sp.BusinessEntityID INNER JOIN HumanResources.Employee e
ON   sp.BusinessEntityID = e.BusinessEntityID INNER JOIN  Person.Person p
ON   e.BusinessEntityID = p.BusinessEntityID

--listado de productos, categoria y subcategoria

SELECT p.Name 'Producto',
	pc.Name 'Categoria',
	ps.Name 'Subcategoría'
FROM 
Production.Product p
INNER JOIN Production.ProductSubcategory ps
ON p.ProductSubcategoryID = ps.ProductSubcategoryID
INNER JOIN Production.ProductCategory pc ON pc.ProductCategoryID = ps.ProductCategoryID

--Historial de los precios de los productos
SELECT b.Name 'Producto',
	   a.ListPrice 'Historial de precios'
 FROM Production.ProductListPriceHistory a
INNER JOIN Production.Product b ON a.ProductID = b.ProductID

-- listado actual de productos
SELECT DISTINCT p.Name,
		pi.Quantity
  FROM [Production].[Product] p
  JOIN [Production].[ProductInventory] pi
  ON p.ProductID = pi.ProductID
--listado de transacciones, nombre del producto, categoria, subcategoria
SELECT t.TransactionDate 'Transacción' ,
	   p.Name 'Nombre',
	   pc.Name 'Categoría',
	   ps.Name 'Subcategoría'
FROM Production.TransactionHistory t
JOIN Production.Product p ON p.ProductID = t.ProductID
JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Production.ProductCategory pc ON pc.ProductCategoryID = ps.ProductCategoryID


--Listado de empleados

SELECT p.FirstName + ' ' + p.MiddleName+' '+ P.LastName 'Nombre Completo' ,
	   e.JobTitle 'Cargo'
FROM HumanResources.Employee e
JOIN Person.Person P ON E.BusinessEntityID = P.BusinessEntityID 

--Listado de las ordenes de trabajo 
SELECT [WorkOrderID]
      ,[ProductID]
      ,[OrderQty]
      ,[StockedQty]
      ,[ScrappedQty]
      ,[StartDate]
      ,[EndDate]
      ,[DueDate]
      ,[ScrapReasonID]
      ,[ModifiedDate]
  FROM [Production].[WorkOrder]
GO

-----------------------------------------------------------------------------------------------------------------------------

--Info Customers
SELECT P.FirstName + ' ' + P.MiddleName + ' ' + P.LastName AS [NombreCliente],
		PA.AddressLine1 AS [Dirección 1],
		PA.AddressLine2 AS [Dirección 2],
		PPP.PhoneNumber AS [Número de teléfono]
FROM [Sales].[Customer] A 
JOIN Person.BusinessEntity B ON A.PersonID = B.BusinessEntityID
JOIN Person.Person P ON B.BusinessEntityID = P.BusinessEntityID
JOIN Person.BusinessEntityAddress BEA ON BEA.BusinessEntityID = B.BusinessEntityID
JOIN Person.Address PA ON BEA.AddressID = PA.AddressID
JOIN Person.PersonPhone PPP ON PPP.BusinessEntityID = B.BusinessEntityID 

-----------------------------------------------------------------------------------------------------------------------------

--Info Vendedor
SELECT  C.FirstName + ' ' + C.MiddleName + ' ' + C.LastName AS [NombreCompleto],
		A.Name AS [Empresa],
		PA.AddressLine1 AS [Direccion 1],
		PPP.PhoneNumber,
		B.BusinessEntityID
FROM Purchasing.Vendor A
LEFT JOIN Person.BusinessEntity B
ON A.BusinessEntityID = B.BusinessEntityID
LEFT JOIN Person.Person C
ON C.BusinessEntityID = B.BusinessEntityID
LEFT JOIN Person.BusinessEntityAddress BEA
ON BEA.BusinessEntityID = B.BusinessEntityID
LEFT JOIN Person.Address PA
ON PA.AddressID = BEA.AddressID
LEFT JOIN Person.PersonPhone PPP ON PPP.BusinessEntityID = B.BusinessEntityID 
------------------------------------------------------------
SELECT P.FirstName + ' ' + P.MiddleName + ' ' + P.LastName AS [NombreCliente],
		PA.AddressLine1 AS [Dirección 1],
		PA.AddressLine2 AS [Dirección 2],
		PPP.PhoneNumber AS [Número de teléfono]
FROM [Sales].[Customer] A 
JOIN Person.BusinessEntity B ON A.PersonID = B.BusinessEntityID
JOIN Person.Person P ON B.BusinessEntityID = P.BusinessEntityID
JOIN Person.BusinessEntityAddress BEA ON BEA.BusinessEntityID = B.BusinessEntityID
JOIN Person.Address PA ON BEA.AddressID = PA.AddressID
JOIN Person.PersonPhone PPP ON PPP.BusinessEntityID = B.BusinessEntityID 

SELECT * FROM [Person].[BusinessEntityContact]
SELECT * FROM [Purchasing].[Vendor]
SELECT * FROM 
SELECT * FROM [Person].[PersonPhone] where BusinessEntityID = 1492
SELECT * FROM [Sales].[SalesTerritory]
SELECT * FROM [Person].[Address]
SELECT * FROM 
SELECT COUNT(*) - (SELECT COUNT(*) FROM[Person].[Person] ) FROM [Person].[BusinessEntity] 

SELECT * FROM [Purchasing].[Vendor]
SELECT * FROM 
SELECT * FROM [Sales].[SalesPerson]
go
--31465

SELECT SOH.OrderDate AS [Fecha de la orden],
	   P.FirstName + ' ' + P.MiddleName +' '+ P.LastName [Nombre Completo],
	   ST.Name [País],
	   PA.City [Ciudad],
	   PA.AddressLine1 [Dirección 1],
	   PA.AddressLine2 [Dirección 2],
	   PP.PhoneNumber [Número de telefono],
	   E.JobTitle [Cargo]
FROM [Sales].[SalesOrderHeader] SOH
LEFT JOIN [Sales].[Customer] C ON SOH.CustomerID = C.CustomerID
LEFT JOIN Sales.SalesTerritory ST ON ST.TerritoryID = SOH.TerritoryID
LEFT JOIN [Sales].[SalesPerson] SP ON SP.BusinessEntityID = SOH.SalesPersonID
LEFT JOIN [Person].[BusinessEntity] BE ON SP.BusinessEntityID = BE.BusinessEntityID
LEFT JOIN Person.Person P ON P.BusinessEntityID = BE.BusinessEntityID
LEFT JOIN Person.BusinessEntityAddress BEA ON BEA.BusinessEntityID = BE.BusinessEntityID
LEFT JOIN Person.Address PA ON PA.AddressID = BEA.AddressID
LEFT JOIN Person.PersonPhone PP ON PP.BusinessEntityID = BE.BusinessEntityID
LEFT JOIN HumanResources.Employee E ON E.BusinessEntityID = BE.BusinessEntityID

--APEX SQL

SELECT A.SalesOrderID,
	   A.OrderDate,
	   A.DueDate,
	   A.ShipDate,
	   A.SalesOrderNumber,
	   ISNULL(C.FirstName,'')+' ' + ISNULL(C.LastName,' ') SalesPersonName,
	   D.PhoneNumber SalesPersonPhone,
	   F.AddressLine1 SalesPersonAdressm,
	   ISNULL(H.FirstName,' ')+ ' ' + ISNULL(H.LastName,'') CustomerName,
	   I.PhoneNumber CustomerPhone,
	   J.Name AS CustomerAdressTerritory,
	   M.AddressLine1 CustomerAdress,
	   SOD.SalesOrderDetailID,
	   SOD.OrderQty,
	   SOD.ProductID,
	   P.Name,
	   SOD.UnitPrice,
	   SOD.LineTotal
FROM Sales.SalesOrderHeader as A
LEFT JOIN Sales.SalesPerson AS B ON A.SalesPersonID = B.BusinessEntityID
LEFT JOIN Person.Person as C ON B.BusinessEntityID = C.BusinessEntityID
LEFT JOIN Person.PersonPhone AS D ON C.BusinessEntityID = D.BusinessEntityID
LEFT JOIN Person.BusinessEntityAddress AS E ON D.BusinessEntityID = E.BusinessEntityID
LEFT JOIN Person.Address AS F ON F.AddressID = E.AddressID
LEFT JOIN Sales.Customer AS G ON A.CustomerID = G.CustomerID
LEFT JOIN Person.Person AS H ON G.PersonID = H.BusinessEntityID
LEFT JOIN Person.PersonPhone AS I ON H.BusinessEntityID = I.BusinessEntityID
LEFT JOIN Sales.SalesTerritory AS J ON G.TerritoryID = J.TerritoryID
LEFT JOIN Person.BusinessEntityAddress AS L ON H.BusinessEntityID = L.BusinessEntityID
LEFT JOIN Person.Address AS M ON L.AddressID = M.AddressID
LEFT JOIN Sales.SalesOrderDetail AS SOD ON A.SalesOrderID = SOD.SalesOrderID
LEFT JOIN Sales.SpecialOfferProduct SOP ON SOD.SpecialOfferID = SOP.SpecialOfferID AND SOD.ProductID = SOP.ProductID
LEFT JOIN Production.Product P ON SOP.ProductID = P.ProductID
WHERE A.SalesOrderID IN(SELECT TOP 3 SOH.SalesOrderID FROM Sales.SalesOrderHeader SOH ORDER BY SOH.SalesOrderID ASC)

SELECT * FROM [HumanResources].[Employee]
SELECT * FROM [HumanResources].[Employee]
SELECT * FROM [Person].[BusinessEntity]
SELECT * FROM [HumanResources].[EmployeeDepartmentHistory]

--Empleados agrupado por el departamento en el que trabaja




WHERE A.HireDate = (
	SELECT * FROM HumanResources.EmployeeDepartmentHistory AS A
	INNER JOIN HumanResources.Employee AS B ON A.StartDate = B.HireDate
)
SELECT * FROM Sales.Store

--Listado de clientes agrupado por cada tienda
SELECT * FROM [Sales].[Customer] AS A
LEFT JOIN Sales.SalesTerritory AS B ON A.TerritoryID = B.TerritoryID
LEFT JOIN Person.Person AS C ON C.BusinessEntityID = A.PersonID
LEFT JOIN Sales.Store AS D ON D.BusinessEntityID = A.CustomerID

SELECT * FROM Sales.Store

--por terminar
SELECT ISNULL(C.Name,'') AS NombreTienda,
       ISNULL(D.FirstName,'') + ' ' + ISNULL(D.MiddleName,'') + '' +  ISNULL(D.LastName,'') AS NombreCompleto
 FROM Sales.Customer AS A
LEFT JOIN Person.BusinessEntity AS E ON E.BusinessEntityID = A.PersonID
LEFT JOIN Person.Person AS D ON D.BusinessEntityID = E.BusinessEntityID
LEFT JOIN Sales.Store AS C ON A.StoreID = C.BusinessEntityID
ORDER BY C.Name

--Listado de personas agrupado por la provinicia o estado
SELECT ISNULL(F.FirstName,'') + ' ' + ISNULL(F.MiddleName,'') + '' +  ISNULL(F.LastName,'') AS NombreCompleto
	  ,ISNULL(d.Name,'') as [País]
 FROM Sales.Customer AS A
LEFT JOIN Sales.SalesTerritory AS B ON B.TerritoryID = A.TerritoryID
LEFT JOIN Person.CountryRegion AS D ON D.CountryRegionCode = B.CountryRegionCode
LEFT JOIN Person.BusinessEntity AS E ON E.BusinessEntityID = A.PersonID
LEFT JOIN Person.Person AS F ON F.BusinessEntityID = E.BusinessEntityID
ORDER BY D.Name

SELECT * FROM [Person].[Address]
SELECT F.Name AS NombreProvincia,
	   A.FirstName + ' ' + A.MiddleName + ' ' + A.LastName AS NombreCompleto
 FROM Person.Person AS A
 LEFT JOIN Person.BusinessEntity AS B ON B.BusinessEntityID = A.BusinessEntityID
 LEFT JOIN Person.BusinessEntityAddress AS D ON B.BusinessEntityID = D.BusinessEntityID
 LEFT JOIN Person.Address AS E ON E.AddressID = D.AddressID
 LEFT JOIN Person.StateProvince AS F ON F.StateProvinceID = E.StateProvinceID
 ORDER BY F.Name
SELECT * FROM [Person].[CountryRegion]

--Comentario

--Conteo de empleado por cada departamento

SELECT A.JobTitle AS [Departamento],
	   ISNULL(D.FirstName,'') + ' ' + ISNULL(D.MiddleName,'') + ' ' + ISNULL(D.LastName,'') AS NombreEmpleado,
	   C.DepartmentID AS IdDepto
FROM HumanResources.Employee AS A
LEFT JOIN HumanResources.EmployeeDepartmentHistory AS B ON A.BusinessEntityID = B.BusinessEntityID	
LEFT JOIN HumanResources.Department AS C ON  B.DepartmentID = C.DepartmentID
LEFT JOIN Person.Person AS D ON D.BusinessEntityID = A.BusinessEntityID

SELECT * FROM Production.WorkOrder

SELECT *
FROM[Production].[WorkOrder] AS A
LEFT JOIN Production.Product AS B ON B.ProductID = A.ProductID

SELECT TOP 1 A.SalesOrderID AS [IdOrden]
	   ,B.Name AS [Producto]
	   ,ISNULL(E.FirstName,'') + ' ' + ISNULL(E.LastName,'') AS  NombreVendedor
	   ,A.OrderQty AS [Cantidad]
	   ,D.UnitPrice AS [Precio]
	   ,C.ShipDate AS [FechaEnvio]
	   ,C.OrderDate AS [FechaOrden]
	   ,C.SubTotal AS [SubTotal]
	   ,C.TotalDue AS [Total]
FROM [Sales].SalesOrderDetail AS A
LEFT JOIN Production.Product AS B ON B.ProductID = A.ProductID
LEFT JOIN Sales.SalesOrderHeader AS C ON C.SalesOrderID = A.SalesOrderID
LEFT JOIN Sales.SalesOrderDetail AS D ON D.SalesOrderID = C.SalesOrderID
LEFT JOIN Person.Person AS E ON E.BusinessEntityID = C.SalesPersonID
LEFT JOIN Sales.Customer AS F ON F.CustomerID = C.CustomerID
LEFT JOIN Person.Person AS G ON G.BusinessEntityID = F.CustomerID
LEFT JOIN Sales.SalesTerritory AS H ON C.TerritoryID = H.TerritoryID







SELECT   A.SalesOrderID AS [IdOrden]
	   ,B.Name AS [Producto]
	   ,ISNULL(E.FirstName,'') + ' ' + ISNULL(E.LastName,'') AS  NombreVendedor
	   ,A.OrderQty AS [Cantidad]
	   ,D.UnitPrice AS [Precio]
	   ,C.ShipDate AS [FechaEnvio]
	   ,C.OrderDate AS [FechaOrden]
	   ,C.SubTotal AS [SubTotal]
	   ,C.TotalDue AS [Total]
	   ,H.Name AS [Territorio]
	   ,G.FirstName + ' ' + G.MiddleName + ' ' + G.LastName AS Cliente
	   ,J.*
FROM [Sales].SalesOrderDetail AS A
LEFT JOIN Production.Product AS B ON B.ProductID = A.ProductID
LEFT JOIN Sales.SalesOrderHeader AS C ON C.SalesOrderID = A.SalesOrderID
LEFT JOIN Sales.SalesOrderDetail AS D ON D.SalesOrderID = C.SalesOrderID
LEFT JOIN Person.Person AS E ON E.BusinessEntityID = C.SalesPersonID
LEFT JOIN Sales.Customer AS F ON F.CustomerID = C.CustomerID
LEFT JOIN Person.Person AS G ON G.BusinessEntityID = F.CustomerID
LEFT JOIN Sales.SalesTerritory AS H ON C.TerritoryID = H.TerritoryID
LEFT JOIN Person.BusinessEntityAddress AS I ON I.BusinessEntityID = E.BusinessEntityID
LEFT JOIN Person.Address AS J ON J.AddressID = I.AddressID


---------
SELECT TOP 1*
FROM [Sales].SalesOrderDetail AS A
LEFT JOIN Production.Product AS B ON B.ProductID = A.ProductID
LEFT JOIN Sales.SalesOrderHeader AS C ON C.SalesOrderID = A.SalesOrderID
LEFT JOIN Sales.SalesOrderDetail AS D ON D.SalesOrderID = C.SalesOrderID
LEFT JOIN Person.Person AS E ON E.BusinessEntityID = C.SalesPersonID
LEFT JOIN Sales.Customer AS F ON F.CustomerID = C.CustomerID
LEFT JOIN Person.Person AS G ON G.BusinessEntityID = F.CustomerID
LEFT JOIN Sales.SalesTerritory AS H ON C.TerritoryID = H.TerritoryID



SELECT * FROM Sales.Customer AS A
INNER JOIN Person.BusinessEntity AS B ON A.PersonID = B.BusinessEntityID
INNER JOIN Person.Person AS C ON C.BusinessEntityID = B.BusinessEntityID
--


SELECT*
FROM Sales.SalesOrderHeader AS A
INNER JOIN [Sales].[SalesOrderDetail] AS B ON A.SalesOrderID = B.SalesOrderID
LEFT JOIN Production.Product AS C ON C.ProductID = B.ProductID

SELECT * FROM Sales.SalesOrderHeader
SELECT * FROM Sales.SalesOrderDetail
SELECT * FROM Sales.SalesTerritory
SELECT * FROM Sales.Customer


--Matriz que me de el conteo de productos por cada categoria
SELECT A.Name AS [Producto],
	   ISNULL(D.Name,'N/A') AS [Categoria]
	   ,A.ProductID AS [IdProducto]
	   ,ISNULL(B.ProductCategoryID,0) [IdCategoria]
FROM Production.Product AS A
LEFT JOIN Production.ProductSubcategory AS B ON B.ProductSubcategoryID = A.ProductSubcategoryID
LEFT JOIN Production.ProductCategory AS D ON D.ProductCategoryID = B.ProductCategoryID


--Matriz que haga el conte o de clientes por tienda, el conteo va a ser de los 10 primeros clientes donde el territorio sea entre los id 1 y 8
--Donde el conteo de los clientes que pertnecesn a la s tiendas sea mayor a 1
SELECT * 
FROM Sales.Store AS A
INNER JOIN Sales.SalesPerson AS B ON B.BusinessEntityID = A.SalesPersonID

select * from Sales.Customer

SELECT TOP 10 B.Name 
	  ,COUNT(A.CustomerID) AS [Cantidad]
FROM Sales.Customer AS A
LEFT JOIN Sales.Store AS B ON A.StoreID = B.BusinessEntityID
LEFT JOIN Sales.SalesTerritoryHistory AS C ON C.TerritoryID = A.TerritoryID
LEFT JOIN Sales.SalesTerritory AS D ON D.TerritoryID = C.TerritoryID
WHERE D.TerritoryID LIKE'[1-8]'
GROUP BY B.Name
HAVING COUNT(A.CustomerID) > 1


SELECT TOP 10 B.Name 
	  ,COUNT(A.CustomerID) AS [Cantidad]
FROM Sales.Customer AS A
LEFT JOIN Sales.Store AS B ON A.StoreID = B.BusinessEntityID
WHERE A.TerritoryID BETWEEN 1 AND 8
GROUP BY B.Name
HAVING COUNT(A.CustomerID) > 1

SELECT * FROM Sales.SalesTerritory	WHERE TerritoryID BETWEEN '[1-8]'
SELECT * FROM Sales.Customer


SELECT A.SalesOrderID AS [IdOrden]
	   ,B.Name AS [Producto]
	   ,ISNULL(E.FirstName,'') + ' ' + ISNULL(E.LastName,'') AS  NombreVendedor
	   ,A.OrderQty AS [Cantidad]
	   ,D.UnitPrice AS [Precio]
	   ,C.ShipDate AS [FechaEnvio]
	   ,C.OrderDate AS [FechaOrden]
	   ,C.SubTotal AS [SubTotal]
	   ,C.TotalDue AS [Total]
	   ,G.FirstName
FROM [Sales].SalesOrderDetail AS A
LEFT JOIN Production.Product AS B ON B.ProductID = A.ProductID
LEFT JOIN Sales.SalesOrderHeader AS C ON C.SalesOrderID = A.SalesOrderID
LEFT JOIN Sales.SalesOrderDetail AS D ON D.SalesOrderID = C.SalesOrderID
LEFT JOIN Sales.SalesPerson AS I ON I.BusinessEntityID = C.SalesPersonID
LEFT JOIN Person.Person AS E ON E.BusinessEntityID = I.BusinessEntityID
INNER JOIN Sales.Customer AS F ON F.CustomerID = C.CustomerID
INNER JOIN Person.Person AS G ON G.BusinessEntityID = F.CustomerID
INNER JOIN Sales.SalesTerritory AS H ON C.TerritoryID = H.TerritoryID

SELECT * FROM Sales.SalesOrderDetail
SELECT * FROM Sales.SalesPerson
SELECT * FROM Sales.SalesOrderHeader AS A
INNER JOIN Sales.Customer AS C ON C.CustomerID = A.CustomerID
INNER JOIN Person.Person AS B ON B.BusinessEntityID = C.PersonID
