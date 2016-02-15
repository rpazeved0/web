<!DOCTYPE HTML>
<!--#include file="inc\conexao.asp"-->
<!--#include file="inc\funcoes.asp"-->
<%
strLogin = LimpaSQLInjection(request("login"))
strSenha = Encripta(LimpaSQLInjection(request("senha")))
bolLoginOK = true

'response.write Decripta(strSenha)
if strLogin <> "" then
	'strsql = "update usuario set senha = '" & strSenha & "'"
	'conexao.execute strsql
	
	strSQL = "select * from usuario usu where usu.login =  '" & strLogin & "' and usu.senha = '" & strSenha & "'"
	set objRS = server.CreateObject("adodb.recordset")
	objRS.open strSQL,conexao,3,3

	if objRS.EOF then
		bolLoginOK = false
	else
		bolLoginOK = true
		session("usuario_id") = objRS("usuario_id")
		response.redirect("index2.asp")
	end if
	objRS.close
	set objRS = nothing
end if
%>
<html>
<head>
<title>EVA::Login</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="esquadrias, vidros, aluminio" />
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

<body class="">
</br>
</br>
</br>
		<div class="login-body">
			<div class="login-heading">
				<h1>EVA-LOGIN</h1>
			</div>
			<div class="panel panel-widget">
				<div class="validation-grids validation-grids-right">
					<div class="widget-shadow login-form-shadow" data-example-id="basic-forms"> 
						<div class="form-body form-body-info">
							<form data-toggle="validator" novalidate="true" name="form01" action="index.asp" method="post">
								<div class="alert alert-danger" role="alert" id="msgErro" style="display:none">
									
							    </div>
								<div class="form-group has-feedback">
									<input type="text" class="form-control" name="login" id="login" placeholder="Login" data-error="Login inválido" required="">
									<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
								</div>
								<div class="form-group">
									<input type="password" data-toggle="validator" data-minlength="6" name="senha" class="form-control" id="senha" placeholder="Senha" required="">
								</div>
								<div class="bottom">
									<div class="form-group">
										<div class="forgot">
											<a href="#">Esqueceu a senha?</a>
										</div>
									</div>
									<div class="form-group">
										<button type="submit" class="btn-primary">Entrar</button>
									</div>
									<div class="clearfix"></div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		<div class="copyright login-copyright">
           <p>© EVA. All Rights Reserved.</p>    
		</div>
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

			$(document).ready(function() {

				<%if bolLoginOK = false then%>		
					document.getElementById("msgErro").innerHTML = "Login ou senha invalidos!";
					document.getElementById("msgErro").style.display = "block";
				<%else%>
					document.getElementById("msgErro").style.display = "none";
				<%end if%>
				
				// show Valida's version.
				$('#version').valida( 'version' );

				// Exemple 1
				//$('.valida').valida();

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
					$('form').valida('partial', '#field-1'); // validate only field-1
					$('form').valida('partial', '#field-1-3'); // validate only field-1-3
				});

			});

		</script>
		<!-- //input-forms -->
		<!--validator js-->
		<script src="js/validator.min.js"></script>
		<!--//validator js-->
			
</body>
</html>