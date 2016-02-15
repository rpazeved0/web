<!--#include file="inc\conexao.asp"-->
<!--#include file="inc\funcoes.asp"-->
<%
intClienteID = request("cliente_id")

strSql = "select lo.loja_id, en.nome from loja lo, entidade en where lo.entidade_id = en.entidade_id and lo.situacao = 'A' and lo.cliente_id = " & intClienteID
set objRS = server.createobject("adodb.recordset")
objRS.open strSql,conexao,3,3
%>
<select name="loja" id="loja" class="form-control" >
<%
	if not objRS.eof then
		do while not objRS.eof
		%>
			<option value="<%=objRS("loja_id")%>"><%=objRS("nome")%></option>
		<%
		objRS.movenext
		loop
	end if
%>
</select>
<%
objRS.close
set objRS = nothing
%>
	
	