<!--#include file="inc\conexao.asp"-->
<!--#include file="inc\funcoes.asp"-->
<%
strNomeUsuario = request("nomeUsuario")
strEmail = request("email1")
strLogin = request("login")
strSenha = request("senha")
strSexo = request("sexo")
intEmpresa = request("empresa")
intLoja = request("loja")
strPerfil = request("perfil")
intTipoEntidade = 2 'Loja
dtDataCadastro = year(date()) &"-"& right("00"&month(date()),2) &"-"& right("00"&day(date()),2) &" "& right("00"&hour(Now),2) & ":" & right("00"&minute(Now),2) & ":" & right("00"&second(Now),2)
'response.write dtDataCastro & "<br>"

if intEmpresa = "" then	intEmpresa = "null"
if intLoja = "" then intLoja = "null"

'executar chamando um recordset
'set objRs = server.createobject("adodb.recordset")
strSql = "[eva].[dbo].sp_inclui_usuario '" & strNomeUsuario & "','" & strEmail & "','" & strLogin & "','" & strSenha & "','" & strSexo & "'," &  intEmpresa & "," & intLoja & "," & intTipoEntidade & ",'" & dtDataCadastro & "','A'"
response.write strSql & "<br>"

retorno = conexao.execute (strSql)
response.write retorno

'if not objRs.eof then
'	intUsuarioId = objRs("usuario_id")
'else	
'	intUsuarioId = 0
'end if 
'objRS.Open strSql, conexao , 3,3
'objRs.close
'set objRs = nothing
response.write objRs("usuario_id") & "<br>"

strPerfil = split(strPerfil)
response.write ubound(strPerfil)
if intUsuarioId > 0 then
	if ubound(strPerfil) > 0 then
		for i=0 to ubound(strPerfil)
			strSql = "sp_inclui_perfil_usuario " &  strPerfil(i) & "," & intUsuarioId
			response.write strSql & "<br>"
		next
	else
		strSql = "sp_inclui_perfil_usuario " &  strPerfil(i) & "," & intUsuarioId
		response.write strSql & "<br>"
	end if
end if
%>