<!--#include file="inc\conexao.asp"-->
<!--#include file="inc\funcoes.asp"-->
<%
on error resume next

strSituacaoIdUsuario = request("situacaoNova")
strSituacaoNova = split(strSituacaoIdUsuario,"|")(0)
intUsuarioId = split(strSituacaoIdUsuario,"|")(1)

if strSituacaoIdUsuario <> "" then

	strSql = "update usuario set situacao='" & strSituacaoNova & "' where usuario_id=" & intUsuarioId
	conexao.execute strSql

	response.write err.number
end if




%>