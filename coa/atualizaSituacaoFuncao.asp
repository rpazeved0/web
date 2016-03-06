<!--#include file="..\inc\conexao.asp"-->
<!--#include file="..\inc\funcoes.asp"-->
<%
on error resume next

strSituacao = request("situacaoNova")
strSituacaoNova = split(strSituacao,"|")(0)
intFuncaoId = split(strSituacao,"|")(1)

if strSituacao <> "" then

	strSql = "update funcao set situacao='" & strSituacaoNova & "' where funcao_id=" & intFuncaoId
	conexao.execute strSql

	response.write err.number
end if

%>