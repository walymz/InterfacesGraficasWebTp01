<%-- 
    Document   : Clientes
    Created on : 16 abr. 2021, 17:39:22
    Author     : carlos
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="ar.org.centro8.curso.java.connectors.Connector"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Clientes</title>
        <link rel="stylesheet" type="text/css" href="css/style.css"/>
    </head>
    <body>
        <h1>Mantenimiento de Clientes</h1>
        <form>
            <table>
                <tr>
                    <td>Nombre:                 </td>
                    <td><input type="text"  name="nombre" minlength="3" maxlength="20" required style="width: 200px;"/></td>
                </tr>
                <tr>
                    <td>Apellido:               </td>
                    <td><input type="text"  name="apellido" minlength="3" maxlength="20" required style="width: 200px;"/></td>
                </tr>
                <tr>
                    <td>Edad:                   </td>
                    <td><input type="number" name="edad" min="18" max="120" style="width: 200px;"/></td>
                </tr>
                <tr>
                    <td>Dirección:              </td>
                    <td><input type="text"  name="direccion" minlength="6" maxlength="50" required style="width: 200px;"/></td>
                </tr>
                <tr>
                    <td>Email:                  </td>
                    <td><input type="email" name="email" minlength="3" maxlength="30" style="width: 200px;"/></td>
                </tr>
                <tr>
                    <td>Telefono:               </td>
                    <td><input type="text"  name="telefono" minlength="3" maxlength="25" required style="width: 200px;"/></td>
                </tr>
                <tr>
                    <td>Tipo de Documento:      </td>
                    <td>
                        <select name="tipoDocumento" style="width: 208px;">
                            <option value="DNI" selected >DNI</option>
                            <option value="LIBRETA_CIVICA">LIBRETA CIVICA</option>
                            <option value="LIBRETA_ENROLAMIENTO">LIBRETA ENROLAMIENTO</option>
                            <option value="PASS">PASS</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Número de Documento:    </td>
                    <td><input type="text" name="numeroDocumento" minlength="6" maxlength="8" style="width: 200px;"/></td>
                </tr>
                <tr>
                    <td><input type="reset" value="Borrar"/></td>
                    <td><input type="submit" value="Enviar"/></td>
                </tr>
            </table>
        </form>
        
        <%
            try {
                 String nombre=request.getParameter("nombre");
                 String apellido=request.getParameter("apellido");
                 int edad=Integer.parseInt(request.getParameter("edad"));
                 String direccion=request.getParameter("direccion");
                 String email=request.getParameter("email");
                 String telefono=request.getParameter("telefono");
                 String tipoDocumento=request.getParameter("tipoDocumento");
                 String numeroDocumento=request.getParameter("numeroDocumento");
                
                try(PreparedStatement ps=Connector
                        .getConnection()
                        .prepareStatement(
                            "insert into clientes "
                                + "(nombre,apellido,edad,direccion,email,telefono,tipoDocumento,numeroDocumento) "
                                + "values (?,?,?,?,?,?,?,?)",
                                PreparedStatement.RETURN_GENERATED_KEYS
                        )){
                         ps.setString(1,nombre);
                         ps.setString(2,apellido);
                         ps.setInt(3,edad);
                         ps.setString(4,direccion);
                         ps.setString(5,email);
                         ps.setString(6,telefono);
                         ps.setString(7,tipoDocumento);
                         ps.setString(8,numeroDocumento);
                         ps.execute();
                         ResultSet rs=ps.getGeneratedKeys();
                         int id=0;
                         if(rs.next()) id=rs.getInt(1);
                         if(id==0){
                             out.println("<h3>No se pudo dar de alta el registro</h3>");
                         }else{
                             out.println("<h3>Se guardo el cliente id: "+id+"</h3>");
                         }
                } catch (Exception e) {
                    System.out.println(e);
                }
                 
            } catch (Exception e) {
                out.println("Falta ingresar parametros");
            }
            
            
            
            
        %>
        
        
        <form>
            Buscar Apellido:
            <input type="text" name="buscarApellido" value="" /><br>
            Buscar Número Documento
            <input type="text" name="buscarNumeroDocumento" value="" /><br>
            <input type="submit" value="Buscar"/>
        </form>
        
        <%
        String buscarApellido=request.getParameter("buscarApellido");
        if(buscarApellido==null) buscarApellido="";
        String buscarNumeroDocumento=request.getParameter("buscarNumeroDocumento");
        if(buscarNumeroDocumento==null) buscarNumeroDocumento="";
        try (ResultSet rs=Connector
                .getConnection()
                .createStatement()
                .executeQuery(
                        "select * from clientes "
                            + "where apellido like '%"+buscarApellido+"%' "
                            + "and numeroDocumento like '%"+buscarNumeroDocumento+"%'")){
            out.println("<table border=1>");
            out.println("<tr><th>Id</th><th>Nombre</th><th>Apellido</th><th>Edad</th>"
                    + "<th>Dirección</th><th>Email</th><th>Telefono</th>"
                    + "<th>Tipo de Documento</th><th>Numero de Documento</th></tr>");
            while(rs.next()){
                out.println("<tr>");
                out.println("<td>"+rs.getInt("id")+"</td>");
                out.println("<td>"+rs.getString("nombre")+"</td>");
                out.println("<td>"+rs.getString("apellido")+"</td>");
                out.println("<td>"+rs.getInt("edad")+"</td>");
                out.println("<td>"+rs.getString("direccion")+"</td>");
                out.println("<td>"+rs.getString("email")+"</td>");
                out.println("<td>"+rs.getString("telefono")+"</td>");
                out.println("<td>"+rs.getString("tipoDocumento")+"</td>");
                out.println("<td>"+rs.getString("numeroDocumento")+"</td>");
                out.println("</tr>");
            }
            out.println("</table>");
        } catch (Exception e) {
            System.out.println(e);
        }
            
        %>
        
    </body>
</html>
