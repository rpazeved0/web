<%
strSql = "select distinct * from (select    ap.funcao_id, " & _
"        									ap.modulo_id, " & _
" 											mo.nome nome_modulo, " & _ 
" 											mo.url url_modulo, " & _ 
" 											fu.nome nome_funcao, " & _ 
" 											fu.url url_funcao, " & _ 
" 											mo.ordem ordem_modulo, " & _ 
" 											fu.ordem ordem_funcao " & _
" 							from  [EVA].[dbo].[usuario] usu, " & _ 
" 											[EVA].[dbo].[perfil_usuario] pu, " & _
" 											[EVA].[dbo].[autorizacao_perfil] ap, " & _
" 											[EVA].[dbo].[perfil] pe, " & _
" 											[EVA].[dbo].[modulo] mo, " & _
" 											[EVA].[dbo].[funcao] fu " & _
" 							where usu.usuario_id  = pu.usuario_id " & _
" 								  and pu.perfil_id = ap.perfil_id " & _
" 								  and pu.perfil_id = pe.perfil_id " & _
" 								  and ap.modulo_id = mo.modulo_id " & _
" 								  and ap.funcao_id = fu.funcao_id " & _
" 								  and fu.situacao = 'A' " & _
" 								  and mo.situacao = 'A' " & _
" 								  and usu.usuario_id = " & session("usuario_id") & _
" ) a " & _
" order by ordem_modulo, ordem_funcao "

set objRs = server.createobject("adodb.recordset")
objRs.open strSql, conexao,  3, 3
%>

<ul class="nav" id="side-menu">
	<li>
		<a href="index2.asp" class="active"><i class="fa fa-home nav_icon"></i>Dashboard</a>
	</li>
	<li>
		<a href="#"><i class="fa fa-check-square-o nav_icon"></i>ADM-Cadastro<span class="fa arrow"></span></a>
		<ul class="nav nav-second-level collapse">
			<li>
				<a href="inputs.html">Clientes</a>
			</li>			
			<li>
				<a href="cadUsuarioADM_01.asp">Usuário</a>
			</li>
			<li>
				<a href="inputs.html">Lojas</a>
			</li>
		</ul>
		<!-- //nav-second-level -->
	</li>
	<li>
		<a href="#"><i class="fa fa-check-square-o nav_icon"></i>Cadastro<span class="fa arrow"></span></a>
		<ul class="nav nav-second-level collapse">
			<li>
				<a href="cadProd_01.asp">Produtos</a>
			</li>
			<li>
				<a href="inputs.html">Clientes</a>
			</li>
			<li>
				<a href="inputs.html">Orçamento</a>
			</li>
			
		</ul>
		<!-- //nav-second-level -->
	</li>
</ul>