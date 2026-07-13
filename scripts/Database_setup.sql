/* 
==============================================
CREATE DATABASE AND SCHEMAS 
==============================================

Script Purpose :
		This script creates a new database called DataWarehouse.
		Additionally it set up three schemas - Bronze,Silver, Gold

*/

---- Create database DataWarehouse 

CREATE DATABASE DataWarehouse;
GO

Use DataWarehouse;
Go            ----- Go seperate batches when dealing with multiple run statements 


---- Create Schemas 
CREATE SCHEMA Bronze;
GO

CREATE SCHEMA Silver;
GO

CREATE SCHEMA Gold;
Go
