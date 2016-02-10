<%
'ConnString = "Driver={SQL Native Client};Server=sqlserver01.juriscan.com.br;Database=juriscan2;Uid=juriscan2;Pwd=r04060406a;"
'Set Conexao = Server.CreateObject("ADODB.Connection")
'Conexao.Open ConnString

host   = "RAFAEL-PC" '186.202.148.147 '186.202.148.207
usuario="rafael"
senha  ="123456"
banco  ="EVA"

'##Monta a string de conexão utilizando os dados informados anteriormente
stringConexao = "Provider=SQLOLEDB.1;SERVER="&host&";DATABASE="&banco&";UID="&usuario&";PWD="&senha&";"

'##Instancia o objeto de conexão com o banco
SET conexao = Server.CreateObject("ADODB.Connection")

'On Error Resume Next

'##Abre a conexão junto ao banco
conexao.Open stringConexao

'##Tratamento de erro. Caso ocorra problemas na conexão, exibe esta informação e apresenta detalhes.
If Err.Number <> 0 Then
    response.write "<b><font color='red'> Conexão com o banco '" & banco & "' Microsoft SQL Server falhou !</font></b>"
    response.write "<BR><BR>"
    response.write "<b>Erro.Description:</b> " & Err.Description & "<br>"
    response.write "<b>Erro.Number:</b> " & Err.Number & "<br>"
    response.write "<b>Erro.Source:</b> " & Err.Source & "<br>"
Else
   '##Caso a conexão seja bem sucedida, mostra mensagem de confirmação.
   'response.write "<b><font color='blue'> Conexão com o banco '" & banco & "' Microsoft SQL Server estabelecida com sucesso !</font>"
End If

'##Fecha a conexão com o banco
'conexao.close

'##Remove as referência do objeto da memória
'SET conexao = Nothing
%>