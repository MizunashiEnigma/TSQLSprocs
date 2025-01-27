use S00237686
GO
-- Create the sproc
CREATE PROC CheckCustomerCreditWhenPlacingOrder
--external variable : given values when executed
@ECustomerID INT,
@EProductId INT,
@EQuantityBeingOrdered INT
as 
Begin
--internal variable: data read in from tables
Declare @ICreditLimit money;
DECLARE @IOrderCost money;
Declare @IUnitPrice money;
--business logic
SELECT @ICreditLimit = CustomerCreditValue
FROM oct.CustomerTBL
WHERE CustomerID = @ECustomerID;

SELECT @IUnitPrice = UnitPrice
from dbo.ProductTBL
WHERE ProductID = @EProductId;

SET @IOrderCost = @IUnitPrice * @EQuantityBeingOrdered;

IF @IOrderCost > @ICreditLimit
Print 'Customer has enough credit'
ELSE
PRINT 'Customer does not have enough credit'
END;