<!--#include file="inc\conexao.asp"-->
<!--#include file="inc\funcoes.asp"-->
<%
intClienteID = request("cliente_id")
strLinhaVazia = request("linhaVazia")
intLojaId = request("loja_id")

if intClienteID <> "" then
	strSql = "select lo.loja_id, en.nome from loja lo, entidade en where lo.entidade_id = en.entidade_id and lo.situacao = 'A' and lo.cliente_id = " & intClienteID
	set objRS = server.createobject("adodb.recordset")
	objRS.open strSql,conexao,3,3
	%>
	<select name="loja" id="loja" class="form-control" >
	<%
		if strLinhaVazia <> "" then
			%>
			<option value=""></option>
			<%
		end if
		if not objRS.eof then
			do while not objRS.eof
			%>
				<option <%if intLojaId = objRS("loja_id") then %> selected <%end if%> value="<%=objRS("loja_id")%>"><%=objRS("nome")%></option>
			<%
			objRS.movenext
			loop
		end if
	%>
	</select>
	<%
	objRS.close
	set objRS = nothing
else%>
	<select name="loja" id="loja" class="form-control" >
		<option value=""></option>
	</select>
	<%
end if
%>
	
	