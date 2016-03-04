<!--#include file="conexao.asp"-->
<%
strSqlModulo = "select distinct * from (select  mo.modulo_id, mo.nome nome_modulo, mo.url url_modulo, mo.ordem ordem_modulo " & _
			   "			from  [EVA].[dbo].[usuario] usu,  " & _
				"							[EVA].[dbo].[perfil_usuario] pu, " & _
				"							[EVA].[dbo].[autorizacao_perfil] ap, " & _
				"							[EVA].[dbo].[perfil] pe, " & _
				"							[EVA].[dbo].[modulo] mo, " & _
				"							[EVA].[dbo].[funcao] fu " & _
				"			where usu.usuario_id  = pu.usuario_id " & _
				"				  and pu.perfil_id = ap.perfil_id " & _
				"				  and pu.perfil_id = pe.perfil_id " & _
				"				  and ap.modulo_id = mo.modulo_id " & _
				"				  and ap.funcao_id = fu.funcao_id " & _
				"				  and fu.situacao = 'A' " & _
				"				  and mo.situacao = 'A' " & _
				"				  and usu.usuario_id = " & session("usuario_id") & _
") a " & _
"order by ordem_modulo "

strSqlFuncao = " select distinct * from (select    ap.funcao_id, " & _
 				" 							fu.nome nome_funcao, " & _
 				" 							fu.url url_funcao, " & _
 				" 							fu.ordem ordem_funcao, " & _
 				" 							ap.consultar, " & _
 				" 							ap.inserir, " & _
 				" 							ap.atualizar, " & _
 				" 							ap.deletar, " & _
 				" 							ap.executar " & _
 				" 			from  [EVA].[dbo].[usuario] usu, " & _
 				" 							[EVA].[dbo].[perfil_usuario] pu, " & _
 				" 							[EVA].[dbo].[autorizacao_perfil] ap, " & _
 				" 							[EVA].[dbo].[perfil] pe, " & _
 				" 							[EVA].[dbo].[modulo] mo, " & _
 				" 							[EVA].[dbo].[funcao] fu " & _
 				" 			where usu.usuario_id  = pu.usuario_id " & _
 				" 				  and pu.perfil_id = ap.perfil_id " & _
 				" 				  and pu.perfil_id = pe.perfil_id " & _
 				" 				  and ap.modulo_id = mo.modulo_id " & _
 				" 				  and ap.funcao_id = fu.funcao_id " & _
 				" 				  and fu.situacao = 'A' " & _
 				" 				  and mo.situacao = 'A' " & _
 				" 				  and usu.usuario_id = " & session("usuario_id") & _
 				" 				  and ap.modulo_id = @modulo_id " & _
 " ) a " & _
 " order by ordem_funcao "

intModulo = request("intModulo")
 
set objRS = server.CreateObject("adodb.recordset")
objRS.open strSqlModulo,conexao,3,3
%>
<script>
	function enviaFormaPerm(url,perm,modulo){
		document.formPerm.strPermUsuario.value = perm;
		document.formPerm.intModulo.value = modulo;
		document.formPerm.action = url;
		document.formPerm.submit();	
	}
</script>
<form name="formPerm" method="post">
<ul class="nav" id="side-menu">
	<li>
		<a href="<%=getSiteURL()%>/index2.asp" class="active"><i class="fa fa-home nav_icon"></i>Dashboard</a>
	</li>
	<%
	strUrlModulo = ""
	if not objRS.eof then
		do while not objRS.eof
			if objRS("url_modulo") = "" then
				strUrlModulo = "#"
			else
				strUrlModulo = objRS("url_modulo")
			end if
			
			if intModulo <> "" then
				if cstr(intModulo) = cstr(objRs("modulo_id")) then
					strDisplay = "style=display:block"
				else 
					strDisplay = "style=display:none"
				end if		
			end if
			
			%>
			<li>
				<a href="<%=strUrlModulo%>"><i class="fa fa-check-square-o nav_icon"></i><%=objRS("nome_modulo")%><span class="fa arrow"></span></a>
				<ul class="nav nav-second-level collapse" <%=strDisplay%> >
					<%
					set objRSFunc = server.CreateObject("adodb.recordset")
					objRSFunc.open replace(strSqlFuncao,"@modulo_id",objRs("modulo_id")), conexao, 3, 3
					if not objRSFunc.eof then
						do while not objRSFunc.eof
							'strUrlFuncao = objRSFunc("url_funcao") & "?strPermUsuario=" & objRSFunc("consultar") &"|"& objRSFunc("inserir") &"|"& objRSFunc("atualizar") &"|"& objRSFunc("deletar") &"|"& objRSFunc("executar")
							
							strUrlFuncao =  objRSFunc("url_funcao") 
							strPermUsuario = objRSFunc("consultar") &"|"& objRSFunc("inserir") &"|"& objRSFunc("atualizar") &"|"& objRSFunc("deletar") &"|"& objRSFunc("executar")
							%>
							<li>
								<a href="javascript:enviaFormaPerm('<%=getSiteURL()&strUrlFuncao%>','<%=strPermUsuario%>','<%=objRs("modulo_id")%>');"><%=objRSFunc("nome_funcao")& Application("site")%></a>
							</li>
							<%
							objRSFunc.movenext
						loop
					end if
					objRSFunc.close
					set objRSFunc = nothing
					%>
				</ul>
				<!-- //nav-second-level -->
			</li>
			<%
			objRS.movenext
		loop
	end if
	%>

</ul>
<input type="hidden" name="strPermUsuario" value="">
<input type="hidden" name="intModulo" value="">
</form>
<%
objRS.close
set objRS = nothing
%>