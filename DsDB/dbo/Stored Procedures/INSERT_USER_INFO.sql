-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[INSERT_USER_INFO]
(
    @userName nvarchar(50),
    @userPass nvarchar(50),
    @charType int
)
AS
BEGIN
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    SET LOCK_TIMEOUT 5000

    BEGIN TRY

        INSERT INTO dbo.GT_USER ([UserName], [UserPass], [CharType],
                                 [UserPoint], [MaxScore], [LetestLoginDate], [CreateDate])
        VALUES (@userName, @userPass, @charType, 
                0, 0, GETDATE(), GETDATE());

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