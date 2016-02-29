<!--#include file="..\inc\conexao.asp"-->
<!--#include file="..\inc\funcoes.asp"-->
<%
strLogin = request("login")

strSql = "select count(usu.usuario_id) total from [eva].[dbo].usuario usu where upper(usu.login) = '" & ucase(strLogin) & "'"
'response.write strSql
set objRS = server.createobject("adodb.recordset")
objRS.open strSql,conexao,3,3

if not objRS.eof then
	if objRS("total") > 0 then
		response.write "Login informado ja existe"
	end if	
end if

objRS.close
set objRS = nothing
%>
	
	