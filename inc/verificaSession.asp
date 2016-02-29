<%
if session("usuario_id") = "" then
%>
<script>
 alert("<%=getSiteURL()%>/index.asp");
 location.href="<%=getSiteURL()%>/index.asp";
</script>
<%end if%>

