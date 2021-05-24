<%-- 
    Document   : Articulos
    Created on : 20 mayo 2021, 11:06
    Author     : Waleska
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="ar.org.centro8.curso.java.connectors.Connector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
   <head>
     <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
     
     <title>Articulos</title>

     <!-- CSS only -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
     <!-- Hoja de estilo -->
     <link rel="stylesheet" type="text/css" href="css/style.css"/>
   </head>
   <body>
     <div class="jumbotron">
         <h1>Mantenimiento de Artículos</h1>
     </div>  
     <div class="container">
       <div class="card">
         <div class="card-body">
           <h5 class="card-title">Nuevo artículo:</h5>     
                <form>
                    <div class="row g-2">
                        <div class="col-6"> 
                            <div class="p-3 border bg-light">  
                               <input type="text" class="form-control" id="descripcion" name="descripcion" minlength="3" maxlength="20" placeholder="Descripción" aria-label="Descripcion" required>
                            </div> 
                        </div>
                        <div class="col-6 invalid-feedback">
                            Por favor ingrese un texto entre 3 y 20 caracteres.
                        </div>
                        <div class="col-6">
                            <div class="p-3 border bg-light">
                                <select class="form-select" id="tipo" name="tipo" required>
                                        <option selected disabled value="">Seleccione el tipo de artículo</option>
                                        <option value="CALZADO">Calzado</option>
                                        <option value="ROPA">Ropa</option>                                            
                                </select>
                            </div>
                        </div>
                        <div class="col-6 invalid-feedback">
                            Por favor ingrese un valor.
                        </div>
                    </div>
                    <div class="row g-2">     
                        <div class="col-6">
                            <div class="p-3 border bg-light">
                                <input type="text" class="form-control" id="color" name="color" minlength="3" maxlength="20" placeholder="Color" aria-label="color" required> 
                            </div>   
                        </div>
                        <div class="col-6 invalid-feedback">
                            Por favor ingrese un texto entre 3 y 20 caracteres.
                        </div>    
                        <div class="col-6">
                           <div class="p-3 border bg-light">   
                              <input type="text" class="form-control" id="talle_num" name="talle_num" minlength="3" maxlength="20" placeholder="Talle" aria-label="talle_num" required>
                           </div>  
                        </div>
                        <div class="col-6 invalid-feedback">
                            Por favor ingrese un valor.
                        </div>    
                    </div>
                    <div class="row g-2">
                        <div class="col-6">
                           <div class="p-3 border bg-light">    
                               <input type="number" class="form-control" id="stock" name="stock" placeholder="Stock" aria-label="stock" required> 
                           </div>    
                        </div>
                        <div class="col-6 invalid-feedback">
                            Por favor ingrese un valor.
                        </div>
                        <div class="col-6">
                           <div class="p-3 border bg-light">    
                               <input type="number" class="form-control" id="stockMin" name="stockMin" placeholder="Stock mínimo" aria-label="stockMin" required> 
                           </div>    
                        </div>
                        <div class="col-6 invalid-feedback">
                          Por favor ingrese un valor.
                        </div>
                    </div>    
                    <div class="row g-2">
                        <div class="col-6">
                            <div class="p-3 border bg-light">    
                               <input type="number" class="form-control" id="stockMax" name="stockMax" placeholder="Stock máximo" aria-label="stockMax" required> 
                            </div>    
                        </div>
                        <div class="col-6 invalid-feedback">
                            Por favor ingrese un valor.
                        </div>
                        <div class="col-6">
                           <div class="p-3 border bg-light">    
                               <input type="number" class="form-control" id="costo" name="costo" placeholder="Costo" aria-label="costo" required> 
                           </div>    
                        </div>
                        <div class="col-6 invalid-feedback">
                          Por favor ingrese un valor.
                        </div>
                    </div>    
                    <div class="row g-2">    
                        <div class="col-6">
                           <div class="p-3 border bg-light">    
                               <input type="number" class="form-control" id="precio" name="precio" placeholder="Precio" aria-label="precio" required> 
                           </div>    
                        </div>
                        <div class="col-6 invalid-feedback">
                          Por favor ingrese un valor.
                        </div>
                        <div class="col-6">
                            <div class="p-3 border bg-light">
                                <select class="form-select" id="temporada" name="temporada" required>
                                        <option selected disabled value="">Seleccione la temporada</option>
                                        <option value="VERANO">Verano</option>
                                        <option value="OTOÑO">Otoño</option>                                            
                                        <option value="INVIERNO">Invierno</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-6 invalid-feedback">
                          Por favor ingrese un valor.
                        </div>
                    </div>
                    <div class="row gy-2">
                        <div class="col-12">
                           <div class="d-grid gap-2 d-md-flex justify-content-center boton">
                             <button class="principal btn btn-success btn-lg" type="submit">Crear</button>
                             <button class="principal btn btn-success btn-lg" type="reset">Borrar</button>
                           </div>   
                        </div> 
                    </div>    
                </form>                                         
             </div>  
           </div>
         
         <%
               //////////////////////// INSERTAR ARTÍCULO NUEVO ////////////////////////////  
             
             try {
               String descripcion = request.getParameter("descripcion");
               String tipo = request.getParameter("tipo");
               String color = request.getParameter("color");
               String talle_num = request.getParameter("talle_num");
               int stock = Integer.parseInt(request.getParameter("stock"));
               int stockMin = Integer.parseInt(request.getParameter("stockMin"));
               int stockMax = Integer.parseInt(request.getParameter("stockMax"));
               Double costo = Double.parseDouble(request.getParameter("costo"));
               Double precio = Double.parseDouble(request.getParameter("precio"));
               String temporada = request.getParameter("temporada");

               try (PreparedStatement ps = Connector
                        .getConnection()
                        .prepareStatement(
                         "insert into articulos "
                       + "(descripcion,tipo,color,talle_num,stock,stockMin,stockMax,costo,precio,temporada) "
                       + "values (?,?,?,?,?,?,?,?,?,?)",
                         PreparedStatement.RETURN_GENERATED_KEYS
                            )) 
                            
                           {
                                ps.setString(1, descripcion);
                                ps.setString(2, tipo);
                                ps.setString(3, color);
                                ps.setString(4, talle_num);
                                ps.setInt(5, stock);
                                ps.setInt(6, stockMin);
                                ps.setInt(7, stockMax);
                                ps.setDouble(8, costo);
                                ps.setDouble(9, precio);
                                ps.setString(10, temporada);

                                ps.execute();
                                ResultSet rs = ps.getGeneratedKeys();
                                int id = 0;
                                if (rs.next()) {
                                    id = rs.getInt(1);
                                }
                                if (id == 0) {
                                    out.println("No se pudo dar de alta el registro");
                                } else {
                                    out.println("Se guardo el articulo id: " + id);
                                }
                            } catch (Exception e) {
                                out.println(e.toString());
                            }

                        } catch (Exception e) {
                            out.println("Debe completar todos los campos");
                        }
                %>    
         
           <div class="card">
              <div class="card-body">
                 
                 <div id="buscar">
                     <form>
                         <div class="card-footer d-grid gap-2 d-md-flex border bg-light justify-content-center">
                            <div class="col-auto">  
                               <input type="text" class="form-control" id="buscarDescripcion" name="buscarDescripcion" placeholder="Buscar por descripción" aria-label="buscarDescripcion">
                            </div>
                            <div class="col-auto">  
                               <button class="btn btn-outline-success me-md-2" type="submit">Aceptar</button>
                            </div>
                            <div class="col-auto">  
                               <select class="form-select" id="buscarTipo" name="buscarTipo">
                                        <option selected disabled value="">Buscar por tipo</option>
                                        <option value="CALZADO">Calzado</option>
                                        <option value="ROPA">Ropa</option>                                            
                                </select>
                            </div>
                            <div class="col-auto">  
                               <button class="btn btn btn-outline-success me-md-2" type="submit">Aceptar</button>
                            </div>
                            <div class="col-auto">  
                               <select class="form-select" id="buscarTemporada" name="buscarTemporada">
                                        <option selected disabled value="">Buscar por temporada</option>
                                        <option value="VERANO">Verano</option>
                                        <option value="OTOÑO">Otoño</option>                                            
                                        <option value="INVIERNO">Invierno</option>                                            
                                </select>
                            </div> 
                            <div class="col-auto">  
                               <button class="btn btn btn-outline-success me-md-2" type="submit">Aceptar</button>
                            </div>
                        </div>
                     </form>
                 </div>
                  
                 <h5 class="card-title principal">Artículos registrados</h5>
                 
                <% 
                //////////////////////// MOSTRAR ARTÍCULOS EN TABLA  ////////////////////////////  
                
                    String tabla = "";

                    String buscarDescripcion = request.getParameter("buscarDescripcion");
                    
                    if (buscarDescripcion == null) {
                        buscarDescripcion = "";
                    }   
                    String buscarTipo = request.getParameter("buscarTipo");
                    if (buscarTipo == null) {
                        buscarTipo = "";
                    }   
                    String buscarTemporada = request.getParameter("buscarTemporada");
                    if (buscarTemporada == null) {
                        buscarTemporada = "";
                    }   
                    String buscarTalle = request.getParameter("buscarTalle");
                    if (buscarTalle == null) {
                        buscarTalle = "";
                    }
                    String buscarColor = request.getParameter("buscarColor");
                    if (buscarColor == null) {
                        buscarColor = "";
                    }
                    
                    try (ResultSet rs = Connector
                           .getConnection()
                           .createStatement()
                           .executeQuery(
                                    "select * from articulos "
                                  + "where descripcion like '%" + buscarDescripcion + "%' "
                                  + "and temporada like '%" + buscarTemporada + "%'"
                                  + "and tipo like '%" + buscarTipo + "%'"
                                  + "and talle_num like '%" + buscarTalle + "%'"
                                  + "and color like '%" + buscarColor + "%'"
                          )) {
                            tabla += "<table class=\"table table-striped\">";
                            tabla += "<tr><th>Id</th><th>Descripcion</th><th>Tipo</th><th>Color</th>"
                                    + "<th>Talle/num</th><th>Stock</th><th>StockMin</th>"
                                    + "<th>StockMax</th><th>Costo</th><th>Precio</th><th>Temporada</th></tr>";
                            while (rs.next()) {
                                tabla += "<tr>";
                                tabla += "<td>" + rs.getInt("id") + "</td>";
                                tabla += "<td>" + rs.getString("descripcion") + "</td>";
                                tabla += "<td>" + rs.getString("tipo") + "</td>";
                                tabla += "<td>" + rs.getString("color") + "</td>";
                                tabla += "<td>" + rs.getString("talle_num") + "</td>";
                                tabla += "<td>" + rs.getInt("stock") + "</td>";
                                tabla += "<td>" + rs.getInt("stockMin") + "</td>";
                                tabla += "<td>" + rs.getInt("stockMax") + "</td>";
                                tabla += "<td>" + rs.getDouble("costo") + "</td>";
                                tabla += "<td>" + rs.getDouble("precio") + "</td>";
                                tabla += "<td>" + rs.getString("temporada") + "</td>";
                                tabla += "</tr>";
                            }
                            tabla += "</table>";
                            out.println(tabla);

                        } catch (Exception e) {
                            out.println(e.toString());
                        }
                %> 
                 
            </div>
          </div>   
        </div>
        
    </body>
</html>
