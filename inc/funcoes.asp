<%
'fazendo isso quando vc for inserir um dado via ASP no banco de dados vc faz assim:
'insert into tabela (campo) values('" & Encripta("algumacoisa") & "');")
'e depois pra chamar no seu asp vc usa:
'variavel = Decripta(rs("campo")
'Se precisar de ajuda estou ai ok. 

Const EncC1 = 100
Const EncC2 = 105
Const EncKey = 115

'==============================================================
'########################
'Criptografa informações
'########################
Function Encripta(Texto)
	TempStr = Texto
	TempResult = ""
	TempKey = ((EncKey * EncC1) + EncC2) Mod 65536

	For i = 1 To Len(TempStr)
		TempNum = (Asc(Mid(TempStr, i, 1)) Xor (AuxShr(TempKey, 8))) Mod 256
		TempChar = Chr(TempNum)
		TempKey = (((Asc(TempChar) + TempKey) * EncC1) + EncC2) Mod 65536
		TempResult = TempResult & TempChar
	Next

	Encripta = TempResult
End Function

'==============================================================
'########################
'Descriptografa informações
'########################

Function Decripta(Texto)
	TempStr = Texto
	TempResult = ""
	TempKey = ((EncKey * EncC1) + EncC2) Mod 65536

	For i = 1 To Len(TempStr)
		TempNum = (Asc(Mid(TempStr, i, 1)) Xor (AuxShr(TempKey, 8))) Mod 256
		TempChar = Chr(TempNum)
		TempKey = (((Asc(Mid(TempStr, i, 1)) + TempKey) * EncC1) + EncC2) Mod 65536
		TempResult = TempResult & TempChar
	Next

	Decripta = TempResult
End Function

Private Function AuxShr(Numero, BShr)
	AuxShr = Int(Numero / (2 ^ BShr))
End Function


function LimpaSQLInjection(texto)
	texto = replace(replace(replace(replace(texto,"'",""),"""",""),"=",""),";","")
	LimpaSQLInjection = texto
end function

'strExibir = Botoes que seram exibidos na pagina: 'C'onsultar, 'I'ncluir,'A'lterar,'D'eletar,'E'xecutar,'L'impar
'strPermissao = permissao que o usuário tem 
'Consultar,Incluir,Alterar,Deletar,Executar
'S        ,S      ,S      ,S      ,S       
'C'onsultar, 'I'ncluir,'A'lterar,'D'eletar,'E'xecutar,'L'impar	
'Consultar,Incluir,Alterar,Deletar,Executar
'S        ,S      ,S      ,S      ,S       

function BotaoForm(strExibir,strPermissao)
	
	permissaoUsuario = strPermissao
	strBotoes = ""
	if strExibir <> "" then
		if inStr(strExibir,"|") > 0 then
			strExibir = split(strExibir,"|")
			
			for i = 0 to ubound(strExibir)
				if strExibir(i) = "C" then
					if ValidaExibicaoBotao(permissaoUsuario,strExibir(i)) then
						
					end if
				elseif strExibir(i) = "I" then
					if ValidaExibicaoBotao(permissaoUsuario,strExibir(i)) then
						strBotoes = strBotoes & "<input type='submit' name='cadastrar' value='Cadastrar' class='btn btn-primary'/>&nbsp;"
					end if
				elseif strExibir(i) = "A" then
					if ValidaExibicaoBotao(permissaoUsuario,strExibir(i)) then
						
					end if
				elseif strExibir(i) = "D" then
					if ValidaExibicaoBotao(permissaoUsuario,strExibir(i)) then
						
					end if
				elseif strExibir(i) = "E" then
					if ValidaExibicaoBotao(permissaoUsuario,strExibir(i)) then
						
					end if
				elseif strExibir(i) = "L" then
					strBotoes = strBotoes & "<input type='reset' name='limpar' id='limpar' value='Limpar' class='btn btn-danger'/>&nbsp;"
				end if
			next
			response.write strBotoes
		else
			BotaoForm = "Faltam parametros na string:strExibir"
		end if
	end if	
end function

function ValidaExibicaoBotao(strPerm,strBotao)
	ValidaExibicaoBotao = false
	if strPerm <> "" then
		strPerm = split(strPerm,"|")
		for i = 0 to ubound(strPerm)
			if strBotao = "C" then
				if i = 0 and strPerm(i) = "S"  then ValidaExibicaoBotao = true
			end if
			if strBotao = "I" then
				if i = 1 and strPerm(i) = "S"  then ValidaExibicaoBotao = true
			end if
			if strBotao = "A" then
				if i = 2 and strPerm(i) = "S"  then ValidaExibicaoBotao = true
			end if
			if strBotao = "D" then
				if i = 3 and strPerm(i) = "S"  then ValidaExibicaoBotao = true
			end if
			if strBotao = "E" then
				if i = 4 and strPerm(i) = "S"  then ValidaExibicaoBotao = true
			end if
		next
	end if
end function

function msgRetornoErro()
	
	if session("msgRetornoErro") <> "" then
		strMsgErro = "<div class='alert alert-danger' role='alert' id='msgErro'>"
		strMsgErro = strMsgErro & session("msgRetornoErro")
		strMsgErro = strMsgErro & "</div> </br>"
		response.write strMsgErro
		session("msgRetornoErro")=""
	end if

end function

function msgRetornoSucesso()
	
	if session("msgRetornoSucesso") <> "" then
		strMsgSucesso = "<div class='alert alert-success' role='alert' id='msgSucesso'>"
		strMsgSucesso = strMsgSucesso & session("msgRetornoSucesso")
		strMsgSucesso = strMsgSucesso & "</div> </br>"
		response.write strMsgSucesso
		session("msgRetornoSucesso")=""
	end if

end function
%>