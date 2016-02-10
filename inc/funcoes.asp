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
function BotaoForm(strExibir,strPermissao)
	strBotoes = ""
	if strExibir <> "" then
		if inStr(strExibir,",") > 0 then
			strExibir = split(strExibir,",")
			for i = 0 to ubound(strExibir)
				if strExibir(i) = "C" then
					if ValidaExibicaoBotao(strPermissao,strExibir(i)) then
						
					end if
				elseif strExibir(i) = "I" then
					if ValidaExibicaoBotao(strPermissao,strExibir(i)) then
						
					end if
				elseif strExibir(i) = "A" then
					if ValidaExibicaoBotao(strPermissao,strExibir(i)) then
						
					end if
				elseif strExibir(i) = "D" then
					if ValidaExibicaoBotao(strPermissao,strExibir(i)) then
						
					end if
				elseif strExibir(i) = "E" then
					if ValidaExibicaoBotao(strPermissao,strExibir(i)) then
						
					end if
				elseif strExibir(i) = "L" then
				
				end if
			next
		else
			BotaoForm = "Faltam parametros na string:strExibir"
		end if
	end if	
end function

function ValidaExibicaoBotao(strPermissao,strBotao)
	ValidaExibicaoBotao = false
	
	if strPermissao <> "" then
		strPermissao = split(strPermissao,",")
		for i = 0 to ubound(strPermissao)
			if strBotao = "C" then
				if i = 0 and strPermissao(i) = "S"  then ValidaExibicaoBotao = true
			end if
			if strBotao = "I" then
				if i = 1 and strPermissao(i) = "S"  then ValidaExibicaoBotao = true
			end if
			if strBotao = "A" then
				if i = 2 and strPermissao(i) = "S"  then ValidaExibicaoBotao = true
			end if
			if strBotao = "D" then
				if i = 3 and strPermissao(i) = "S"  then ValidaExibicaoBotao = true
			end if
			if strBotao = "E" then
				if i = 4 and strPermissao(i) = "S"  then ValidaExibicaoBotao = true
			end if
		next
	end if
end if


%>