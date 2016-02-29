<!--#include file="..\inc\conexao.asp"-->
<!--#include file="..\inc\funcoes.asp"-->
<!--#include file="..\inc\verificaSession.asp"-->
<%
on error resume next

strNomeUsuario = trim(request("nomeUsuario"))
strEmail = trim(request("email1"))
strLogin = trim(request("login"))
strSenha = Encripta(request("senha"))
strSexo = trim(request("sexo"))
intEmpresa = trim(request("empresa"))
intLoja = trim(request("loja"))
strPerfil = trim(request("perfil"))
strSituacao = trim(request("situacao"))
strAcao = request("acao")
intEntidadeId = request("entidade_id")
intTipoEntidade = 1 'Usuario
intUsuarioId = request("usuario_id")
dtDataCadastro = year(date()) &"-"& right("00"&month(date()),2) &"-"& right("00"&day(date()),2) &" "& right("00"&hour(Now),2) & ":" & right("00"&minute(Now),2) & ":" & right("00"&second(Now),2)
bolErro = false
session("msgRetornoErro") = ""
session("msgRetornoSucesso") = ""

if intEmpresa = "" then	intEmpresa = "null"
if intLoja = "" then intLoja = "null"

response.write strAcao

conexao.begintrans

if strAcao = "A" then
	
	strSql = "update [EVA].[dbo].[entidade] set tipo_entidade_id="& intTipoEntidade &",nome='"& strNomeUsuario &"',email='"& strEmail &"',data_alteracao={ts '"& dtDataCadastro &"'} where entidade_id = " & intEntidadeId
	conexao.execute(strSql)
	if err.number <> 0 then	bolErro = true
	
	response.write strSql & "<br>"
	
	strSql = "update [EVA].[dbo].[usuario] set cliente_id=" & intEmpresa & ",entidade_id="& intEntidadeId &",login='"& strLogin &"',senha='"& strSenha &"',situacao='"& strSituacao &"' where usuario_id = " & intUsuarioId
	conexao.execute(strSql)
	if err.number <> 0 then	bolErro = true
	
	response.write strSql & "<br>"
	
	
	strSql = "delete from [EVA].[dbo].[loja_usuario] where usuario_id="& intUsuarioId
	conexao.execute(strSql)
	response.write strSql & "<br>"
	if err.number <> 0 then bolErro = true
	
	if intLoja <> "null" and intUsuarioId <> "" then
		
		strSql = "insert into [EVA].[dbo].[loja_usuario] (usuario_id,loja_id) values ("& intUsuarioId &","& intLoja &")"
		conexao.execute(strSql)
		
		response.write strSql & "<br>"
		
		if err.number <> 0 then bolErro = true
	end if
	
	
	strSql = "delete from [EVA].[dbo].[perfil_usuario] where usuario_id="& intUsuarioId
	conexao.execute(strSql)
	
	'response.write strSql & "<br>"
	
	if err.number <> 0 then bolErro = true
	
	if bolErro = false and strPerfil <> "" then
		
		if instr(strPerfil,",") > 0 then
			arPerfil = split(strPerfil,",")
			for i = 0 to ubound(arPerfil)
				if arPerfil(i) <> "" then
					strSql = "insert into [EVA].[dbo].[perfil_usuario] (usuario_id,perfil_id) values ("& intUsuarioId &","& trim(arPerfil(i)) &")"
					response.write strSql & "<br>"
					conexao.execute(strSql)
				end if	
			next
		else
			strSql = "insert into [EVA].[dbo].[perfil_usuario] (usuario_id,perfil_id) values ("& intUsuarioId &","& strPerfil &")"
			response.write strSql & "<br>"
			conexao.execute(strSql)
		end if
		
	end if
	

else
	

	strSql = "insert into [EVA].[dbo].[entidade] (tipo_entidade_id,nome,email,data_cadastro) values ("& intTipoEntidade &",'"& strNomeUsuario &"','"& strEmail &"',{ts '"& dtDataCadastro &"'})"
	conexao.execute(strSql)
	if err.number <> 0 then	bolErro = true
	response.write strSql & "<br>"
	
	'response.write "bolErro:" & bolErro & err.description &"<br>"
	if bolErro = false then

		set objRs = server.createobject("adodb.recordset")
		strSql = "select max(entidade_id) ultimo_id from [EVA].[dbo].[entidade]"
		objRs.open strSql, conexao, 3, 3
		'response.write objRs("ultimo_id")&"<br>"
		if not objRs.eof then
			intUltimoIdEntidade = objRs("ultimo_id")
		else
			bolErro = true
		end if
		
		'response.write intUltimoIdEntidade & "<br>"
		
		if err.number <> 0 then bolErro = true
		
		objRs.close
		set objRs = nothing
	end if	

	strSql = "insert into [EVA].[dbo].[usuario] (cliente_id,entidade_id,login,senha,situacao) values (" & intEmpresa & ","& intUltimoIdEntidade &",'"& strLogin &"','"& strSenha &"','"& strSituacao &"')"
	conexao.execute(strSql)
	'response.write strSql & "<br>"
	if err.number <> 0 then	bolErro = true

	if bolErro = false then
		set objRs = server.createobject("adodb.recordset")
		strSql = "select max(usuario_id) ultimo_id from [EVA].[dbo].[usuario]"
		objRs.open strSql, conexao, 3, 3
		response.write strSql & "<br>"
		
		if not objRs.eof then
			intUltimoIdUsuario = objRs("ultimo_id")
		else
			bolErro = true
		end if
		
		'response.write intUltimoIdUsuario & "<br>"
		
		if err.number <> 0 then bolErro = true
		
		objRs.close
		set objRs = nothing
	end if	

	if intLoja <> "null" and intUltimoIdUsuario <> "" then
		
		strSql = "insert into [EVA].[dbo].[loja_usuario] (usuario_id,loja_id) values ("& intUltimoIdUsuario &","& intLoja &")"
		conexao.execute(strSql)
		
		response.write strSql & "<br>"
		
		if err.number <> 0 then bolErro = true
	end if

	if bolErro = false and strPerfil <> "" then
		
		if instr(strPerfil,",") > 0 then
			arPerfil = split(strPerfil,",")
			for i = 0 to ubound(arPerfil)
				if arPerfil(i) <> "" then
					strSql = "insert into [EVA].[dbo].[perfil_usuario] (usuario_id,perfil_id) values ("& intUltimoIdUsuario &","& trim(arPerfil(i)) &")"
					response.write strSql & "<br>"
					conexao.execute(strSql)
				end if	
			next
		else
			strSql = "insert into [EVA].[dbo].[perfil_usuario] (usuario_id,perfil_id) values ("& intUltimoIdUsuario &","& strPerfil &")"
			response.write strSql & "<br>"
			conexao.execute(strSql)
		end if
		
	end if
end if

response.write bolErro & "<br>"
response.write strAcao & "<br>"
response.write err.number & "<br>"
'response.end
if bolErro = false then
	'Segurança
	if err.number = 0 then
		conexao.committrans
		response.write "Commit"  &"<br>"
		if strAcao = "A" then
			session("msgRetornoSucesso") = "Usu&aacute;rio alterado com sucesso"
		else
			session("msgRetornoSucesso") = "Usu&aacute;rio cadastrado com sucesso"
		end if	
	else
		conexao.rollbacktrans
		if strAcao = "A" then
			session("msgRetornoErro") = "Erro na alteração do usuario:" & err.number & "-" & err.description
		else
			session("msgRetornoErro") = "Erro na inclusão do usuario:" & err.number & "-" & err.description
		end if	
	end if
else
	conexao.rollbacktrans
	if strAcao = "A" then
		session("msgRetornoErro") = "Erro na alteração do usuario:" & err.number & "-" & err.description
	else
		ession("msgRetornoErro") = "Erro na inclusão do usuario:" & err.number & "-" & err.description
	end if	
end if

response.write session("msgRetornoErro")
if strAcao = "A" then
	response.redirect("consUsuario_01.asp")
else
	response.redirect("cadUsuarioADM_01.asp")
end if	
%>