<%
'ConnString = "Driver={SQL Native Client};Server=sqlserver01.juriscan.com.br;Database=juriscan2;Uid=juriscan2;Pwd=r04060406a;"
'Set Conexao = Server.CreateObject("ADODB.Connection")
'Conexao.Open ConnString

host   = "RAFAEL-PC" '186.202.148.147 '186.202.148.207
usuario="rafael"
senha  ="123456"
banco  ="EVA"

'##Monta a string de conex�o utilizando os dados informados anteriormente
stringConexao = "Provider=SQLOLEDB.1;SERVER="&host&";DATABASE="&banco&";UID="&usuario&";PWD="&senha&";"

'##Instancia o objeto de conex�o com o banco
SET conexao = Server.CreateObject("ADODB.Connection")

'On Error Resume Next

'##Abre a conex�o junto ao banco
conexao.Open stringConexao

'##Tratamento de erro. Caso ocorra problemas na conex�o, exibe esta informa��o e apresenta detalhes.
If Err.Number <> 0 Then
    response.write "<b><font color='red'> Conex�o com o banco '" & banco & "' Microsoft SQL Server falhou !</font></b>"
    response.write "<BR><BR>"
    response.write "<b>Erro.Description:</b> " & Err.Description & "<br>"
    response.write "<b>Erro.Number:</b> " & Err.Number & "<br>"
    response.write "<b>Erro.Source:</b> " & Err.Source & "<br>"
Else
   '##Caso a conex�o seja bem sucedida, mostra mensagem de confirma��o.
   'response.write "<b><font color='blue'> Conex�o com o banco '" & banco & "' Microsoft SQL Server estabelecida com sucesso !</font>"
End If

'##Fecha a conex�o com o banco
'conexao.close

'##Remove as refer�ncia do objeto da mem�ria
'SET conexao = Nothing
%>