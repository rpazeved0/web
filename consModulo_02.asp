<!DOCTYPE HTML>
<!--#include file="inc\verificaSession.asp"-->
<!--#include file="inc\conexao.asp"-->
<%
strNome = request("nome")
strSituacao = request("situacao")

strSql = ""
strSql = strSql & " select * from "
strSql = strSql & "       	modulo mo "
strSql = strSql & " where "

if strNome <> "" then
	strSql = strSql & "	  upper(mo.nome) like upper('%" &  strNome & "%') "
end if

if strSituacao <> "" then
	strSql = strSql & "	  and mo.situacao = '" &  strSituacao & "'"
end if

strSql = strSql & " order by mo.nome "

alterar = split(session("PermUsuario"),"|")(2)

%>
<html>
<head>
<title>EVA ::Home </title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
<!-- Custom CSS -->
<link href="css/style.css" rel='stylesheet' type='text/css' />
<!-- font CSS -->
<link rel="icon" href="favicon.ico" type="image/x-icon" >
<!-- font-awesome icons -->
<link href="css/font-awesome.css" rel="stylesheet"> 
<!-- //font-awesome icons -->
<!-- chart -->
<script src="js/Chart.js"></script>
<!-- //chart -->
 <!-- js-->
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/modernizr.custom.js"></script>
<!--webfonts-->
<link href='//fonts.googleapis.com/css?family=Roboto+Condensed:400,300,300italic,400italic,700,700italic' rel='stylesheet' type='text/css'>
<!--//webfonts--> 
<!--animate-->
<link href="css/animate.css" rel="stylesheet" type="text/css" media="all">
<script src="js/wow.min.js"></script>
	<script>
		 new WOW().init();
	</script>
<!--//end-animate-->
<!-- Metis Menu -->



<!--//Metis Menu -->
<!-- Metis Menu -->
<script src="js/metisMenu.min.js"></script>
<script src="js/custom.js"></script>
<link href="css/custom.css" rel="stylesheet">
<!--//Metis Menu -->
</head> 
<body class="cbp-spmenu-push">
	<div class="main-content">
		<!--left-fixed -navigation-->
		<div class="sidebar" role="navigation">
            <div class="navbar-collapse">
				<nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-right dev-page-sidebar mCustomScrollbar _mCS_1 mCS-autoHide mCS_no_scrollbar" id="cbp-spmenu-s1">
					<div class="scrollbar scrollbar1">
						<!--#include file="inc\menuDireito.asp"-->
					</div>
					<!-- //sidebar-collapse -->
				</nav>
			</div>
		</div>
		<!--left-fixed -navigation-->
		<!-- header-starts -->
		<div class="sticky-header header-section ">
			<!--#include file="inc\topo.asp"-->
		</div>
		<!-- //header-ends -->
		<!-- main content start-->
		<div id="page-wrapper">
			<div class="main-page">
					<!--grids-->
				<div class="grids">
					<div class="progressbar-heading grids-heading">
						<h2>Consulta M&oacute;dulo</h2>
					</div>
					<div class="forms-grids">
						<div class="col-md-12">
							<div class="panel panel-widget">
								<div class="my-div">
									<form method="post" class="valida"  id="form01" name="form01" action="">
										<div class="row" >
											<div class="col-xs-12 col-sm-5" >
												<label><b>Nome:</b>&nbsp; <%=strNome%></label>
											</div>

											<div class="col-xs-12 col-sm-7" >
												<%
												if strSituacao = "A" then 
													strSituacaoDesc = "Ativo" 
												elseif strSituacao = "I" then
													strSituacaoDesc = "Inativo" 
												end if
												%>
												<label><b>Situacão:</b>&nbsp; <%=strSituacaoDesc%></label>
											</div>
										</div>
										<hr >
										<p>
										<div class='alert alert-danger' role='alert' id='msgErro' style="display:none">
										</div>
										<div class='alert alert-success' role='alert' id='msgSucesso' style="display:none">
										</div>
										<div class="tables">
											<table class="table"> 
												<thead> 
													<tr>
														<th>#</th>
														<th>Nome</th>
														<th>Descricao</th>
														<th>Ordem</th>
														<th>Situação</th>
														<%if alterar = "S" then%>
														<th></th>
														<%end if%>
													</tr>
												</thead>
												<tbody>
													<%
													'Define a quantidade de registros por pagina
													registrosPagina = 10
													
													'response.write strSql												
													set objRs = server.createobject("adodb.recordset")
													objRs.open strSql,conexao,1
													
													totalRegistros = objRs.recordCount ' Pega o total de registros
													response.write "Total:" & objRs.recordCount 
    											    totalRegistroPagina = totalRegistros/registrosPagina ' Calcula o total de registro por página
												    If (Int(totalRegistroPagina)-totalRegistroPagina < 0) then ' Verifica se o valor é menor que 0
														totalRegistroPagina = int(totalRegistroPagina) + 1
												    End If
												    pagina = 1
												    If Request.QueryString("pagina")<>"" Then  'Pega a pagina para listar
														pagina = CInt(Request.QueryString("pagina"))
												    End If
												    inicio = ( pagina - 1 ) * registrosPagina 'Defini o inicio da lista
												    final = registrosPagina + inicio 'Define o final da lista
												    contador = 0 'Seta variavel de Contador
													
													
													if not objRs.eof then
														do while not objRs.eof and contador<final
															contador = contador + 1 'Contador
															If contador>inicio Then
															%>
															<tr <%if contador mod 2 then %>class="info" <%end if%>>
																<td><%=objRs("modulo_id")%></td>
																<td><%=objRs("nome")%></td>
																<td><%=objRs("Descricao")%></td>
																<td><%=objRs("ordem")%></td>
																<td>
																	<select name="situacaoUsuario" id="situacaoUsuario" class="form-control" onchange="javascript:atualizaSituacao(this.value);" >
																		<option value="A|<%=objRs("modulo_id")%>" <%if objRs("situacao") = "A" then response.write "selected"%>>Ativo</option>
																		<option value="I|<%=objRs("modulo_id")%>" <%if objRs("situacao") = "I" then response.write "selected"%>>Inativo</option>
																	</select>
																</td>
																<%if alterar = "S" then%>
																<td align="center"><button type="button" class="btn btn-info" onclick="javascript:alterar('<%=objRs("modulo_id")%>')">Alterar</button></td>
																<%end if%>
															</tr>
															<%
															end if
															objRs.movenext
														loop
													end if
													objRs.close
													set objRs = nothing
													%>
													<!--Paginação-->
													<tr>
														<td colspan="6" align="center">
															<nav>
															  <ul class="pagination">
																<li class="<%if pagina = 1 then%>disabled<%end if%>"><a href="javascript:paginar('consModulo_02.asp?pagina=<%=(pagina-1)%>','<%=(pagina-1)%>')" aria-label="Previous"><i class="fa fa-angle-left"></i></a></li>
																<%
																For i=1 to totalRegistroPagina
																	If i=pagina Then
																		response.Write "<li class='active'><a href=javascript:paginar('consModulo_02.asp?pagina="&i&"','" & pagina &"')> "&i&"<span class='sr-only'>(current)</span></a></li>"
																	Else
																		response.Write "<li><a href=javascript:paginar('consModulo_02.asp?pagina="&i&"','" & pagina& "')> "&i&" </a></li>"
																	End if
																Next
																%>
																<%If totalRegistroPagina>pagina Then%><li><a href="javascript:paginar('consModulo_02.asp?pagina=<%=(pagina+1)%>','<%=(pagina+1)%>')" aria-label="Next"><i class="fa fa-angle-right"></i></a></li><%end if%>
															 </ul>
														   </nav>
														</td>
													</tr>
													<!--Paginação-->
												</tbody>
											</table> 
											
										</div>
										
										<%
										'C'onsultar, 'I'ncluir,'A'lterar,'D'eletar,'E'xecutar,'L'impar	
										'Consultar,Incluir,Alterar,Deletar,Executar
										'S        ,S      ,S      ,S      ,S       
										strBotoesExibir = "N|I|N|N|N|N|V"		
										call BotaoForm(cstr(strBotoesExibir),cstr(session("PermUsuario")))
										%>
										</p>
										<input type="hidden" name="nome" value="<%=strNome%>">
										<input type="hidden" name="situacao" value="<%=strSituacao%>">
									</form>
								</div>
							</div>
						</div>
						<div class="clearfix"> </div>
					</div>
				</div>
				<!--//grids-->
			</div>
		</div>
		<!--footer-->
   	    <div class="dev-page">
			<!-- page footer -->   
			<!-- dev-page-footer-closed dev-page-footer-fixed -->
			<!--#include file="inc\rodape.asp"-->
            <!-- /page footer -->
		</div>
        <!--//footer-->
	</div>
	<!-- Classie -->
		<script src="js/classie.js"></script>
		<script>
			var menuLeft = document.getElementById( 'cbp-spmenu-s1' ),
				showLeftPush = document.getElementById( 'showLeftPush' ),
				body = document.body;
				
			showLeftPush.onclick = function() {
				classie.toggle( this, 'active' );
				classie.toggle( body, 'cbp-spmenu-push-toright' );
				classie.toggle( menuLeft, 'cbp-spmenu-open' );
				disableOther( 'showLeftPush' );
			};
			

			function disableOther( button ) {
				if( button !== 'showLeftPush' ) {
					classie.toggle( showLeftPush, 'disabled' );
				}
			}
			
			function alterar(usuarioId){
				document.form01.action = "cadUsuarioADM_01.asp?acao=A&usuarioId=" + usuarioId;
				document.form01.submit();
			}
		</script>
	<!-- Bootstrap Core JavaScript --> 
		
        <script type="text/javascript" src="js/bootstrap.min.js"></script>

        <script type="text/javascript" src="js/dev-loaders.js"></script>
        <script type="text/javascript" src="js/dev-layout-default.js"></script>
		<script type="text/javascript" src="js/jquery.marquee.js"></script>
		<link href="css/bootstrap.min.css" rel="stylesheet">

		<script type="text/javascript" src="js/jquery.jqcandlestick.min.js"></script>
		<link rel="stylesheet" type="text/css" href="css/jqcandlestick.css" />
		
		<!--max-plugin-->
		<script type="text/javascript" src="js/plugins.js"></script>
		<!--//max-plugin-->
		
		<!--scrolling js-->
		<script src="js/jquery.nicescroll.js"></script>
		<script src="js/scripts.js"></script>
		<!--//scrolling js-->
		<!-- input-forms -->
		<script type="text/javascript" src="js/valida.2.1.6.min.js"></script>
		<script type="text/javascript" >
			function verificaForcaSenha(){
				senha = document.getElementById("senha").value;
				forca = 0;
				mostra = document.getElementById("mostra");
				if((senha.length >= 4) && (senha.length <= 7)){
					forca += 10;
				}else if(senha.length>7){
					forca += 25;
				}
				if(senha.match(/[a-z]+/)){
					forca += 10;
				}
				if(senha.match(/[A-Z]+/)){
					forca += 20;
				}
				if(senha.match(/d+/)){
					forca += 20;
				}
				if(senha.match(/W+/)){
					forca += 25;
				}
				return mostra_res();
			}
			function mostra_res(){
				if(forca < 30){
					mostra.innerHTML = '<tr><td bgcolor="red" width="'+forca+'"></td><td>Fraca </td></tr>';
				}else if((forca >= 30) && (forca < 60)){
					mostra.innerHTML = '<tr><td bgcolor="yellow" width="'+forca+'"></td><td>Justa </td></tr>';;
				}else if((forca >= 60) && (forca < 85)){
					mostra.innerHTML = '<tr><td bgcolor="blue" width="'+forca+'"></td><td>Forte </td></tr>';
				}else{
					mostra.innerHTML = '<tr><td bgcolor="green" width="'+forca+'"></td><td>Excelente </td></tr>';
				}
			}
			
			function paginar(paginaSubmit,nuPagina){
				if (nuPagina>0){
					$('form').attr('action', paginaSubmit);
					$('form').trigger( 'submit' );
				}
			}
			
			function atualizaSituacao(valor){
				var dados = $(this).serialize();
				$.ajax({
					url: 'atualizaSituacaoModulo.asp?situacaoNova=' + valor,
					type: 'POST',
					dataType: 'html',
					data: dados,
					success: function(data){
						if (data != ''){
							if (data == '0'){
								$("#msgSucesso").text('Situação alterada com sucesso!');
								$("#msgSucesso").show();
								$("#msgErro").text('');
								$("#msgErro").hide();
							}else{
								$("#msgErro").text('Erro ao atualizar a situação do usuário!');
								$("#msgErro").show();
								$("#msgSucesso").text('');
								$("#msgSucesso").hide();
							}
						}else{
							$("#msgErro").text("");
							$("#msgSucesso").text("");
						}
					}
				});
			}
			
		
			$(document).ready( function(){
				
				$('#cadastrar').click( function(){
					$('form').attr('action', 'cadModulo_01.asp');
					$('form').trigger( 'submit' );
				});
				
				$('#voltar').click( function(){
					$('form').attr('action', 'consModulo_01.asp');
					$('form').trigger( 'submit' );
				});
				
				
			});
			
			/*$(function()
			{
				$("form").submit(function()
				{
					alert('oi');
					
					if(combo == "ha")
					{
						return true;	// NÃO PREVINE o envio do formulário
					}
					else
					{
						return false;	// PREVINE o envio do formulário
					}
				});
			});*/
			
			
			$(document).ready(function() {
	
				/*desabilita o submit do form*/
				$("#form01").submit(function(){
					return true; 
				});
  
				// show Valida's version.
				$('#version').valida( 'version' );

				// Exemple 1
				$('.valida').valida();

				// Exemple 2
				/*
				$('.valida').valida({

					// basic settings
					validate: 'novalidate',
					autocomplete: 'off',
					tag: 'p',

					// default messages
					messages: {
						submit: 'Wait ...',
						required: 'Este campo é obrigatório',
						invalid: 'Field with invalid data',
						textarea_help: 'Digitados <span class="at-counter">{0}</span> de {1}'
					},

					// filters & callbacks
					use_filter: true,

					// a callback function that will be called right before valida runs.
					// it must return a boolan value (true for good results and false for errors)
					before_validate: null,

					// a callback function that will be called right after valida runs.
					// it must return a boolan value (true for good results and false for errors)
					after_validate: null

				});
				*/

        // setup the partial validation
				$('#partial-1').on('click', function( ev ) {
					ev.preventDefault();
					$('#res-1').click(); // clear form error msgs
					//$('form').valida('partial', '#field-1'); // validate only field-1
					// 	$('form').valida('partial', '#field-1-3'); // validate only field-1-3
				});

			});

		</script>
		<!-- //input-forms -->
		<!--validator js-->
		<script src="js/validator.min.js"></script>
		<!--//validator js-->
	
		



</body>
</html>