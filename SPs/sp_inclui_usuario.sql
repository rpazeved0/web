USE [EVA]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('sp_inclui_usuario') IS NULL
    EXEC('CREATE PROCEDURE sp_inclui_usuario AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[sp_inclui_usuario]

--######################
-- Parametros Cliente 
@nome varchar(60),
@email varchar(60), 
@login varchar(30),
@senha varchar(20),
@sexo varchar(1),
@cliente_id int,
@loja_id int,
--@perfil_id int,
@tipo_entidade_id int,
@data_cadastro datetime,
@situacao_usuario varchar(1)
--,@usuario_id int OUTPUT
AS
BEGIN
			
	declare @entidade_id int
	declare @usuario_id int
	
	insert into [EVA].[dbo].[entidade] (tipo_entidade_id,nome,email,sexo,data_cadastro) values (@tipo_entidade_id,@nome,@email,@sexo,@data_cadastro)
	set @entidade_id =  @@IDENTITY
	
	insert into [EVA].[dbo].[usuario] (cliente_id,entidade_id,login,senha,situacao) values (@cliente_id,@entidade_id,@login,@senha,@situacao_usuario)
	set @usuario_id =  @@IDENTITY
	select @usuario_id as usuario_id
	
	
	if (@loja_id is not null)
		insert into [EVA].[dbo].[loja_usuario] (usuario_id,loja_id) values (@usuario_id,@loja_id)
	
	
	--insert into [EVA].[dbo].[perfil_usuario] (usuario_id,perfil_id) values (@usuario_id,@perfil_id)
	
	return @usuario_id
	

END

GO