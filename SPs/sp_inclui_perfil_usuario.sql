GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('sp_inclui_perfil_usuario') IS NULL
    EXEC('CREATE PROCEDURE sp_inclui_perfil_usuario AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[sp_inclui_perfil_usuario]

--######################
-- Parametros Cliente 
@perfil_id int,
@usuario_id int
AS
BEGIN
			
	begin transaction
	
	insert into [EVA].[dbo].[perfil_usuario] (usuario_id,perfil_id) values (@usuario_id,@perfil_id)
	
	
	IF (@@ERROR = 0)
		begin
			COMMIT
		end	
	ELSE
		begin
			ROLLBACK
		end	
END
GO