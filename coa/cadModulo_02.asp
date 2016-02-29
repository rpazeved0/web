<!--#include file="..\inc\conexao.asp"-->
<!--#include file="..\inc\funcoes.asp"-->
<!--#include file="..\inc\verificaSession.asp"-->
<%
on error resume next

intModuloId = request("modulo_id")
strNome = trim(request("nome"))
strSituacao = trim(request("situacao"))
strDescricao = trim(request("descricao"))
strUrl = trim(request("url"))
intOrdem = trim(request("ordem"))
strAcao = trim(request("acao"))
dtDataCadastro = year(date()) &"-"& right("00"&month(date()),2) &"-"& right("00"&day(date()),2) &" "& right("00"&hour(Now),2) & ":" & right("00"&minute(Now),2) & ":" & right("00"&second(Now),2)
bolErro = false
session("msgRetornoErro") = ""
session("msgRetornoSucesso") = ""

if intOrdem = "" then intOrdem = "null"

response.write strAcao

conexao.begintrans

if strAcao = "A" then

	strSql = "update [EVA].[dbo].[modulo] set nome='"& strNome &"',descricao='"& strDescricao &"',ordem="& intOrdem &",url='" & strUrl & "' where modulo_id = " & intModuloId
	conexao.execute(strSql)
	if err.number <> 0 then	bolErro = true
	response.write strSql & "<br>"

else

	strSql = "insert into [EVA].[dbo].[modulo] (nome,descricao,ordem,situacao,url) values ('"& strNome &"','"& strDescricao &"',"& intOrdem &",'"& strSituacao &"','"& strUrl &"')"
	conexao.execute(strSql)
	if err.number <> 0 then	bolErro = true
	response.write strSql & "<br>"
	
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
			session("msgRetornoSucesso") = "M&oacute;rio alterado com sucesso"
		else
			session("msgRetornoSucesso") = "M&oacute;rio cadastrado com sucesso"
		end if	
	else
		conexao.rollbacktrans
		if strAcao = "A" then
			session("msgRetornoErro") = "Erro na alteração do M&oacute;rio:" & err.number & "-" & err.description
		else
			session("msgRetornoErro") = "Erro na inclusão do M&oacute;rio:" & err.number & "-" & err.description
		end if	
	end if
else
	conexao.rollbacktrans
	if strAcao = "A" then
		session("msgRetornoErro") = "Erro na alteração do M&oacute;rio:" & err.number & "-" & err.description
	else
		ession("msgRetornoErro") = "Erro na inclusão do M&oacute;rio:" & err.number & "-" & err.description
	end if	
end if

response.write session("msgRetornoErro")
if strAcao = "A" then
	response.redirect("consModulo_01.asp")
else
	response.redirect("cadModulo_01.asp")
end if	
%>