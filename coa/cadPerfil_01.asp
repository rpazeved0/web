<!DOCTYPE HTML>
<!--#include file="..\inc\verificaSession.asp"-->
<!--#include file="..\inc\conexao.asp"-->
<%
intPerfil = request("perfilId")
strAcao = request("acao")

'response.write intUsuarioId
'response.write strAcao
if strAcao = "A" then
	
	strSql = ""
	strSql = strSql & " select p.perfil_id,  p.nome from "
	strSql = strSql & "       	perfil p "
	strSql = strSql & " where p.perfil_id = " & intPerfil
	
	set objRs = server.createobject("adodb.recordset")
	objRs.open strSql,conexao,3,3
	if not objRs.eof then
		strNome = objRs("nome")
	end if
	objRs.close
	set objRs = nothing
end if
%>
<html>
<head>
<title>EVA ::Home </title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- Bootstrap Core CSS -->
<link href="../css/bootstrap.css" rel='stylesheet' type='text/css' />
<!-- Custom CSS -->
<link href="../css/style.css" rel='stylesheet' type='text/css' />
<!-- font CSS -->
<link rel="icon" href="favicon.ico" type="image/x-icon" >
<!-- font-awesome icons -->
<link href="../css/font-awesome.css" rel="stylesheet"> 
<!-- //font-awesome icons -->
<!-- chart -->
<script src="../js/Chart.js"></script>
<!-- //chart -->
 <!-- js-->
<script src="../js/jquery-1.11.1.min.js"></script>
<script src="../js/modernizr.custom.js"></script>
<!--webfonts-->
<link href='//fonts.googleapis.com/css?family=Roboto+Condensed:400,300,300italic,400italic,700,700italic' rel='stylesheet' type='text/css'>
<!--//webfonts--> 
<!--animate-->
<link href="../css/animate.css" rel="stylesheet" type="text/css" media="all">
<script src="../js/wow.min.js"></script>
	<script>
		 new WOW().init();
	</script>
<!--//end-animate-->
<!-- Metis Menu -->



<!--//Metis Menu -->
<!-- Metis Menu -->
<script src="../js/metisMenu.min.js"></script>
<script src="../js/custom.js"></script>
<link href="../css/custom.css" rel="stylesheet">
<!--//Metis Menu -->
</head> 
<body class="cbp-spmenu-push">
	<div class="main-content">
		<!--left-fixed -navigation-->
		<div class="sidebar" role="navigation">
            <div class="navbar-collapse">
				<nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-right dev-page-sidebar mCustomScrollbar _mCS_1 mCS-autoHide mCS_no_scrollbar" id="cbp-spmenu-s1">
					<div class="scrollbar scrollbar1">
						<!--#include file="..\inc\menuDireito.asp"-->
					</div>
					<!-- //sidebar-collapse -->
				</nav>
			</div>
		</div>
		<!--left-fixed -navigation-->
		<!-- header-starts -->
		<div class="sticky-header header-section ">
			<!--#include file="..\inc\topo.asp"-->
		</div>
		<!-- //header-ends -->
		<!-- main content start-->
		<div id="page-wrapper">
			<div class="main-page">
					<!--grids-->
				<div class="grids">
					<div class="progressbar-heading grids-heading">
						<h2><%if strAcao = "A" then%>Alterar Perfil<%else%>Cadastro de Perfil<%end if%></h2>
					</div>
					<div class="forms-grids">
						<div class="col-md-8">
							<div class="panel panel-widget">
								<div class="my-div">
									<form method="post" class="valida"  id="form01" name="form01" action="cadPerfil_02.asp">
  									    <div class="" id="msg">
											<%call msgRetornoSucesso()%>
											<%call msgRetornoErro()%>
										</div>
										<label for="nome" >Nome:</label>
										<div class="form-group" >
											<input type="text" name="nome" value="<%=trim(strNome)%>" id="nome" required="true" class="form-control"	/>
										</div>
										<hr >
										<p>
										
										<%
										'C'onsultar, 'I'ncluir,'A'lterar,'D'eletar,'E'xecutar,'L'impar,Voltar
										'Consultar,Incluir,Alterar,Deletar,Executar
										'S        ,S      ,S      ,S      ,S       
										if strAcao = "A" then
											strBotoesExibir = "N|N|A|N|N|N|V"		
										else
											strBotoesExibir = "N|I|N|N|N|L|V"		
										end if										
										call BotaoForm(strBotoesExibir,session("PermUsuario"))
										%>
										</p>
										<input type="hidden" name="acao" value="<%=strAcao%>">
										<input type="hidden" name="perfil_id" value="<%=intPerfil%>">

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
			<!--#include file="..\inc\rodape.asp"-->
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
		
        <script type="text/javascript" src="../js/bootstrap.min.js"></script>

        <script type="text/javascript" src="../js/dev-loaders.js"></script>
        <script type="text/javascript" src="../js/dev-layout-default.js"></script>
		<script type="text/javascript" src="../js/jquery.marquee.js"></script>
		<link href="../css/bootstrap.min.css" rel="stylesheet">

		<script type="text/javascript" src="../js/jquery.jqcandlestick.min.js"></script>
		<link rel="stylesheet" type="text/css" href="../css/jqcandlestick.css" />
		
		<!--max-plugin-->
		<script type="text/javascript" src="../js/plugins.js"></script>
		<!--//max-plugin-->
		
		<!--scrolling js-->
		<script src="../js/jquery.nicescroll.js"></script>
		<script src="../js/scripts.js"></script>
		<!--//scrolling js-->
		<!-- input-forms -->
		<script type="text/javascript" src="../js/valida.2.1.6.min.js"></script>
		<script type="text/javascript" >
		
			$(document).ready( function(){
				
				$('#voltar').click( function(){
					$('form').attr('action', 'consPerfil_01.asp');
					$('form').trigger( 'submit' );
				});
				
				$(document).ready(function () {
				   $('body').bind('cut copy paste', function (e) {
					  e.preventDefault();
				   });
				});
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
		<script src="../js/validator.min.js"></script>
		<!--//validator js-->
	
		
</body>
</html>