-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[UPDATE_USER_INFO]
(
    @userName nvarchar(50),
    @token nvarchar(200)
)
AS
BEGIN
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    SET LOCK_TIMEOUT 5000

    BEGIN TRY

        UPDATE dbo.GT_USER SET Token = @token
        WHERE UserName = @userName;

    END TRY
    BEGIN CATCH
        IF(@@TRANCOUNT > 0)
            BEGIN
                ROLLBACK TRANSACTION;
            END
        DECLARE @ErrorInputValue nvarchar(1024)
        SET @ErrorInputValue = CONVERT(nvarchar, 'no parameter') + ' ,'

        RETURN -1--알수없는 DB 에러

    END CATCH
END