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

--