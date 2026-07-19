/* =================================================
Stored Procedure: Loading data into the Bronze layer
====================================================

Script Purpose 
	The following code loads data into the bronze layer from external CSV files.
  Creates a stored procedure to make the process of data loading simpler
	It performs the following functions:
	--- Truncates the table before loading the data
	--- Usage of BULK insert to load the data from the CSV files
*/



CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
  DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
  BEGIN TRY 
  SET @batch_start_time = GETDATE();
		PRINT '==================================';
		PRINT 'Loading Bronze layer';
		PRINT '==================================';

		PRINT '-----------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '-----------------------------------';

		SET @start_time = GETDATE();
				PRINT '>>> Truncating the table: bronze.crm_cust_info';
				TRUNCATE TABLE bronze.crm_cust_info; 
				PRINT '>>>> Bulk Inserting data into: bronze.crm_cust_info';
				BULK INSERT bronze.crm_cust_info
				FROM 'C:\Users\Admin\Downloads\cust_info.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK 
				);
		SET @end_time = GETDATE();
		PRINT '>>>>> LOAD TIME;' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>>>>>>> -----------';

		SET @start_time = GETDATE() 
				PRINT '>>> Truncating the table: bronze.crm_prd_info';
				TRUNCATE TABLE bronze.crm_prd_info; 

				PRINT '>>>> Bulk Inserting Data into: bronze.crm_prd_info';
				BULK INSERT bronze.crm_prd_info
				FROM 'C:\Users\Admin\Downloads\prd_info.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK 
				);
		SET @end_time = GETDATE();
		PRINT '>>>>> LOAD TIME;' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>>>>>>> -----------';

		SET @start_time = GETDATE();
				PRINT ' Truncating the table:bronze.crm_sales_details'; 
				TRUNCATE TABLE bronze.crm_sales_details; 

				PRINT '>>>> Bulk Inserting Data into: bronze.crm_sales_details';
				BULK INSERT bronze.crm_sales_details
				FROM 'C:\Users\Admin\Downloads\sales_details.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK 
				);
		SET @end_time = GETDATE();
		PRINT '>>>>> LOAD TIME;' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>>>>>>> -----------';

		PRINT '----------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '----------------------------';

		SET @start_time = GETDATE();
				PRINT '>>>>>> Truncating table: bronze.erp_cust_az12';
				TRUNCATE TABLE bronze.erp_cust_az12; 

				PRINT '>>>>>> Bulk Inserting data into: bronze.erp_cust_az12';
				BULK INSERT bronze.erp_cust_az12
				FROM 'C:\Users\Admin\Downloads\CUST_AZ12.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK 
				);
		SET @end_time = GETDATE();
		PRINT '>>>>> LOAD TIME;' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>>>>>>> -----------';


		SET @start_time = GETDATE();
				PRINT '>>>> Truncating the table: bronze.erp_loc_a101';
				TRUNCATE TABLE bronze.erp_loc_a101; 

				PRINT '>>>>> Bulk Inserting Data into:bronze.erp_loc_a101';
				BULK INSERT bronze.erp_loc_a101
				FROM 'C:\Users\Admin\Downloads\LOC_A101.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK 
				);
		SET @end_time = GETDATE();
		PRINT '>>>>> LOAD TIME;' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>>>>>>> -----------';


		SET @start_time = GETDATE();
				PRINT '>>>> Truncating the table: bronze.erp_px_cat_g1v2';
				TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		
				PRINT '>>>> Bulk Inserting into: bronze.erp_px_cat_g1v2';
				BULK INSERT bronze.erp_px_cat_g1v2
				FROM 'C:\Users\Admin\Downloads\PX_CAT_G1V2.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK 
				);
		SET @end_time = GETDATE();
		PRINT '>>>>> LOAD TIME;' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>>>>>>> -----------';

		SET @batch_end_time = GETDATE();
		PRINT 'The bronze Layer has been completly loaded';
		PRINT '>>>>> Total Load Time ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>>>>>>> -----------';
	
	END TRY 
	BEGIN CATCH 
			PRINT '========================================';
			PRINT 'ERROR OCCURED WHILE LOADING BRONZE LAYER';
			PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
			PRINT 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
			PRINT 'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
			PRINT '=========================================';
	END CATCH
END;


EXEC bronze.load_bronze;
