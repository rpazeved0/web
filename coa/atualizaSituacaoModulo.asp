<!--#include file="..\inc\conexao.asp"-->
<!--#include file="..\inc\funcoes.asp"-->
<%
on error resume next

strSituacao = request("situacaoNova")
strSituacaoNova = split(strSituacao,"|")(0)
intModuloId = split(strSituacao,"|")(1)

if strSituacao <> "" then

	strSql = "update modulo set situacao='" & strSituacaoNova & "' where modulo_id=" & intModuloId
	conexao.execute strSql

	response.write err.number
end if

%>