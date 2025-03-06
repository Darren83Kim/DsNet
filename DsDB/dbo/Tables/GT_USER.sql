CREATE TABLE [dbo].[GT_USER] (
    [UserSeq]         BIGINT        IDENTITY (1, 1) NOT NULL,
    [Token]           NVARCHAR (200) NOT NULL,
    [UserName]        NVARCHAR (50) NOT NULL,
    [UserPass]        NVARCHAR (50) NOT NULL,
    [CharType]        INT           NOT NULL, 
    [UserPoint]       INT           NOT NULL,
    [MaxScore]        INT           NOT NULL,
    [LetestLoginDate] DATETIME      NOT NULL,
    [CreateDate]      DATETIME      NOT NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([UserSeq] ASC, [UserName] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_Users_UserID_UserName]
    ON [dbo].[GT_USER]([UserSeq] ASC, [UserName] ASC);

