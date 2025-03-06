-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SELECT_USER_INFO](
	@userName nvarchar(50)
)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    SET NOCOUNT ON
    SET LOCK_TIMEOUT 5000

    BEGIN TRY
        SELECT UserSeq, UserName, UserPass, CharType, UserPoint, MaxScore, LetestLoginDate, CreateDate FROM DBO.GT_USER 
		WHERE UserName = @userName;
    end try
    begin catch
        IF(@@TRANCOUNT > 0)
            BEGIN
                ROLLBACK TRANSACTION;
            END
        DECLARE @ErrorInputValue nvarchar(1024)
        SET @ErrorInputValue = CONVERT(nvarchar, 'no parameter') + ' ,'

        RETURN -1--알수없는 DB 에러

    end catch
END
