<!--#include file="inc\conexao.asp"-->
<!--#include file="inc\funcoes.asp"-->
<!--#include file="inc\verificaSession.asp"-->
<%
on error resume next

strNomeUsuario = request("nomeUsuario")
strEmail = request("email1")
strLogin = request("login")
strSenha = Encripta(request("senha"))
strSexo = request("sexo")
intEmpresa = request("empresa")
intLoja = request("loja")
strPerfil = request("perfil")
strSituacao = request("situacao")
intTipoEntidade = 2 'Loja
dtDataCadastro = year(date()) &"-"& right("00"&month(date()),2) &"-"& right("00"&day(date()),2) &" "& right("00"&hour(Now),2) & ":" & right("00"&minute(Now),2) & ":" & right("00"&second(Now),2)
bolErro = false
session("msgRetornoErro") = ""
session("msgRetornoSucesso") = ""

if intEmpresa = "" then	intEmpresa = "null"
if intLoja = "" then intLoja = "null"

'response.write "intLoja:"&intLoja & "<br>"

conexao.begintrans

strSql = "insert into [EVA].[dbo].[entidade] (tipo_entidade_id,nome,email,data_cadastro) values ("& intTipoEntidade &",'"& strNomeUsuario &"','"& strEmail &"',{ts '"& dtDataCadastro &"'})"
'response.write strSql & "<br>"
conexao.execute(strSql)
if err.number <> 0 then	bolErro = true

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
	
	'response.write strSql & "<br>"
	
	if err.number <> 0 then bolErro = true
end if

if bolErro = false and strPerfil <> "" then
	
	if instr(strPerfil,",") > 0 then
		arPerfil = split(strPerfil,",")
		for i = 0 to ubound(arPerfil)
			strSql = "insert into [EVA].[dbo].[perfil_usuario] (usuario_id,perfil_id) values ("& intUltimoIdUsuario &","& trim(arPerfil(i)) &")"
			'response.write strSql & "<br>"
			conexao.execute(strSql)
		next
	else
		strSql = "insert into [EVA].[dbo].[perfil_usuario] (usuario_id,perfil_id) values ("& intUltimoIdUsuario &","& strPerfil &")"
		'response.write strSql & "<br>"
		conexao.execute(strSql)
	end if
	
end if

if bolErro = false then
	'Segurança
	if err.number = 0 then
		conexao.committrans
		session("msgRetornoSucesso") = "Usu&aacute;rio cadastrado com sucesso"
	else
		conexao.rollbacktrans
		session("msgRetornoErro") = "Erro na inclusao do usuario:" & err.number & "-" & err.description
	end if
else
	conexao.rollbacktrans
	session("msgRetornoErro") = "Erro na inclusao do usuario:" & err.number & "-" & err.description
end if

response.write session("msgRetornoErro")
response.redirect("cadUsuarioADM_01.asp")
%>