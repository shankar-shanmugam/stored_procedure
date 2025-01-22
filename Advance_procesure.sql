alter PROCEDURE WithdrawAmount
    @AccountID INT,
    @WithdrawalAmount DECIMAL(10, 2)
AS
BEGIN
    BEGIN TRY
        -- Start a transaction
        BEGIN TRANSACTION;

        -- Check if the account exists
        IF NOT EXISTS (SELECT 1 FROM dbo.Accounts WHERE AccountID = @AccountID)
        
            THROW 50001, 'Account does not exist.', 1;
        

        -- Retrieve the current balance
        DECLARE @CurrentBalance DECIMAL(10, 2);
        SELECT @CurrentBalance = Balance
        FROM dbo.Accounts
        WHERE AccountID = @AccountID;

        -- Check if the balance is sufficient
        IF @CurrentBalance < @WithdrawalAmount
        
            THROW 50002, 'Insufficient balance.', 1;
        

        -- Deduct the withdrawal amount from the balance
        UPDATE dbo.Accounts
        SET Balance = @CurrentBalance - @WithdrawalAmount
        WHERE AccountID = @AccountID;

        -- Print a success message
        PRINT 'Withdrawal successful. Remaining balance: ' 
            + CAST((@CurrentBalance - @WithdrawalAmount) AS NVARCHAR(50));

        -- Commit the transaction
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Rollback the transaction if it's still active
        IF XACT_STATE() <> 0
        BEGIN
            ROLLBACK TRANSACTION;
            PRINT 'Transaction rolled back due to error: ' + @ErrorMessage;
        END;

        -- Re-throw the error with the original message
       throw;
    END CATCH
END;

exec WithdrawAmount 3,56;