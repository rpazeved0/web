<!DOCTYPE HTML>
<!--#include file="inc\conexao.asp"-->
<!--#include file="inc\funcoes.asp"-->
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
						<h2>Cadastro de Usuário</h2>
					</div>
					<div class="forms-grids">
						<div class="col-md-6">
							<div class="panel panel-widget">
								<div class="my-div">
									<form method="post" class="valida"  id="form01" name="form01" action="cadUsuarioADM_02.asp">
										<label for="nomeUsuario" >Nome:</label>
										<div class="form-group" >
											<input type="text" name="nomeUsuario" id="nomeUsuario" required="true" class="form-control"	/>
										</div>
										<div class="row" >

											<div class="col-xs-12 col-sm-5" >

												<label for="field-1-2" >E-mail:</label>
												<div class="form-group" >
													<input type="text" name="email1" id="email1" filter="email" class="form-control" required="true"
														data-invalid="Campo com e-mail inválido"  />
												</div>

											</div>

											<div class="col-xs-12 col-sm-7" >

												<label for="field-1-2" >Redigite o e-mail:</label>
												<div class="form-group" >
													<input type="text" name="email2" id="email2" filter="email|matches:email1" class="form-control" required="true"
														data-invalid="E-mail inválido ou diferente do digitado"  />
												</div>

											</div>

										</div>

										<label for="field-1-3" >Login:</label>
										<div class="form-group">
										  <input type="text"  maxlength="30" name="login" minlength="6" class="form-control" id="login"   required="true"
										   class="form-control" />
										   <div id="MsgErroLogin"></div>
										   <div id="MsgVerificaLogin"></div>
										  <span class="help-block">Mínimo de 6 caracteres</span>
										</div>
										
										<label for="senha" >Senha:</label>
										<div class="form-group">
										  <input type="password"  maxlength="20" class="form-control" name="senha" id="senha" placeholder="Senha" required="true">
										  <div id="MsgErroSenha"></div>
										  <span class="help-block">Mínimo de 6 caracteres</span>
										</div>
										<div class="form-group">
										  <input type="password" class="form-control" maxlength="20" id="senha2" filter="password|matches:senha" data-invalid="Senha diferente do campo anterior" placeholder="Confirme a senha" required="true">
										  <div id="MsgErroSenha2"></div>
										  <div class="help-block with-errors"></div>
										</div>
										<div class="form-group">
											<div class="radio">
												<label>
													<input type="radio" name="sexo" required="true" value="M">
													Masculino
												</label>
											</div>
											<div class="radio">
												<label>
													<input type="radio" name="sexo" required="true" value="F">
													Feminino
												</label>
											</div>
										</div>
										<label for="empresa" >Empresa:</label>
										<div class="form-group" >
											<select name="empresa" id="empresa" class="form-control" >
												<option value=""></option>
												<%
												'coclocar por perfil, se o usuario for adm traz todos, se nao traz somente o cliente logado
												strSql = "SELECT *  FROM [EVA].[dbo].[cliente] cl, [EVA].[dbo].[entidade] en where cl.entidade_id = en.entidade_id and cl.situacao = 'A';"
												set objRS = server.createobject("adodb.recordset")
												objRS.open strSql,conexao,3,3
												if not objRS.eof then
													do while not objRS.eof
													%>
														<option value="<%=objRS("cliente_id")%>"><%=objRS("nome")%></option>
													<%
													objRS.movenext
													loop
												end if
												objRS.close
												set objRS = nothing
												%>
											</select>
										</div>
										<label for="loja" >Loja:</label>
										<div class="form-group" id="loja" >
											<select name="loja" id="loja" class="form-control" >
												<option value=""></option>
											</select>
										</div>
										<label for="perfil" >Perfil de acesso:</label>
										<div class="form-group" id="perfilacesso" >
											<select name="perfil" id="perfil" class="form-control" required="true" multiple>
												<option value=""></option>
												<%
												strSql = "select * from perfil p"
												set objRS = server.createobject("adodb.recordset")
												objRS.open strSql,conexao,3,3
												if not objRS.eof then
													do while not objRS.eof
													%>
														<option value="<%=objRS("perfil_id")%>"><%=objRS("nome")%></option>
													<%
													objRS.movenext
													loop
												end if
												objRS.close
												set objRS = nothing
												%>
											</select>
										</div>
										<hr >
										<p>
										
										<%
										'C'onsultar, 'I'ncluir,'A'lterar,'D'eletar,'E'xecutar,'L'impar	
										'Consultar,Incluir,Alterar,Deletar,Executar
										'S        ,S      ,S      ,S      ,S       
										strBotoesExibir = "N|I|N|N|N|L"		
										strPermUsuario = "S|S|S|S|S"
										call BotaoForm(strBotoesExibir,strPermUsuario)
										%>
										</p>
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
			$(document).ready( function(){
				$('#empresa').change( function(){
					//$('form').submit( function(){
						var dados = $(this).serialize();
						$.ajax({
							url: 'carregaLoja.asp?cliente_id=' + $('#empresa').val(),
							type: 'POST',
							dataType: 'html',
							data: dados,
							success: function(data){
								
								$('#loja'). empty(). html(data);
							}
						});
					//return false;
					//});
					//$('form').trigger( 'submit' );
				});
				
				$('#login').blur( function(){
						var dados = $(this).serialize();
						$.ajax({
							url: 'verificaLoginExiste.asp?login=' + $('#login').val(),
							type: 'POST',
							dataType: 'html',
							data: dados,
							success: function(data){
								//$('#loja'). empty(). html(data);
								if (data != ''){
									$("#MsgVerificaLogin").text(data);
									$('#login').focus();
								}else{
									$("#MsgVerificaLogin").text("");
								}
							}
						});
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
			
			$('#login').blur(function(e){
				if($('#login').val().length < 6){
				   $('#login').focus()
				   $("#MsgErroLogin").text("Campo de conter entre 6 a 30 caracteres.");
				}else{
					$("#MsgErroLogin").text("");
				}
			});
			
			$('#senha').blur(function(e){
				if($('#senha').val().length < 6){
				   $('#senha').focus()
				   $("#MsgErroSenha").text("Campo de conter entre 6 a 20 caracteres.");
				}else{
					$("#MsgErroSenha").text("");
				}
			});
			
			
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