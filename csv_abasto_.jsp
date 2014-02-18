<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="java.io.*" import ="com.csvreader.CsvReader" import="javax.swing.*" import="java.util.*" errorPage="" %>
 <%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
  <%java.text.DateFormat df2 = new java.text.SimpleDateFormat("HH:mm:ss"); %>
<%
//objeto de la Clase Connection, nos sirve para hacer la conexión a la base correspondiente
	Connection conexion=null;
	Connection conexion2=null;
	Statement stmt = null;
	Statement stmt2 = null;
	Statement stmt3 = null;
	ResultSet rset = null,rset2=null,rset3=null;

// Variables de entorno
String clave="", descrip="", lote="", cad="", cant="", ori="", clave_inv="", lote_inv="", cad_inv="", cant_inv="", pasti_ampu="";
String mensaje="";
int canti=0, cant_invi=0, tot_up=0;
int ban1=0;
/*parametros para la conexión*/
    String driver = "org.gjt.mm.mysql.Driver";
    String url = "jdbc:mysql://localhost:3306/abastos";
	String url2 = "jdbc:mysql://localhost:3306/r_nayarit";
    String usuario = "";
    //String clave = "";
    
  /*procedimiento de la conexion*/
    try{
         Class.forName(driver);
         conexion = DriverManager.getConnection(url,"root","eve9397");
		 conexion2 = DriverManager.getConnection(url2,"root","eve9397");

         /*guardando la conexion en la session*/

        
		 stmt=conexion.createStatement(); 
		 stmt2=conexion2.createStatement(); 
		 mensaje="conectado";
       } catch (Exception ex){mensaje=ex.toString();}

    if(conexion.isClosed())
        {mensaje="desconectado";}	 

	
	String query_abasto = "SELECT a.ClaPro, p.DesPro, a.ClaLot, a.FecCad, a.CanReq, a.Origen FROM abastos a INNER JOIN productos p ON a.ClaPro = p.ClaPro INNER JOIN abasto_unidades au ON a.IdAbasto = au.IdAbasto WHERE Folio = '3082';";
	String query_inven="";
						   
	rset=stmt.executeQuery(query_abasto);
    while (rset.next()) 
	{
		clave=rset.getString(1);
		descrip=rset.getString(2);
		lote=rset.getString(3);
		cad=rset.getString(4);
		cant=rset.getString(5);
		ori=rset.getString(6);
			
		
		out.print (clave+" "+descrip+" "+lote+" "+cad+" "+cant+" "+ori+"<br>");
		
		//---------------------------------------------------------------------------------------------------------------------------------------------
		query_inven="select clave, lote, caducidad, cajas from inventario_uni where clave = '"+clave+"' and lote = '"+lote+"' and caducidad='"+cad+"'";
		out.print (query_inven+"<br>");
		rset2=stmt2.executeQuery(query_inven);
		while (rset2.next()) 
		{
			clave_inv=rset2.getString(1);
			lote_inv=rset2.getString(2);
			cad_inv=rset2.getString(3);
			cant_inv=rset2.getString(4);
			if (cant_inv.equals("")){
				cant_inv="0";
			}
			ban1=1;
			out.print("-------------------"+clave_inv+lote_inv+cad_inv+" "+ban1+"--------------------<br>");
		}
		
		//---------------------------------------------------------------------------------------------------------------------------------------------
		query_inven="select clave, lote, caducidad, cajas from inventario_uni where clave = '"+clave+"' and lote = '"+lote+"' and caducidad='"+cad+"'";
		out.print (query_inven+"<br>");
		rset2=stmt2.executeQuery(query_inven);
		while (rset2.next()) 
		{
			clave_inv=rset2.getString(1);
			lote_inv=rset2.getString(2);
			cad_inv=rset2.getString(3);
			cant_inv=rset2.getString(4);
			if (cant_inv.equals("")){
				cant_inv="0";
			}
			ban1=1;
			out.print("-------------------"+clave_inv+lote_inv+cad_inv+" "+ban1+"--------------------<br>");
		}
		//---------------------------------------------------------------------------------------------------------------------------------------------
		
		if (ban1==0){
			String qry_inserta="insert into inventario_uni (clave, descrip, lote, caducidad, cajas, present, existencias, ingreso, salidas, origen, ampuleo, mov, fecha, hora) values ( '"+clave+"', '"+descrip+"', '"+lote+"', '"+cad+"', '"+cant+"', '1', '"+cant+"', '"+cant+"', '0', '"+ori+"', 'NA', '1', '"+df.format(new java.util.Date())+"', '"+df2.format(new java.util.Date())+"' )";
			out.print(qry_inserta+"<br>");
		}
		if (ban1==1){
			canti=Integer.parseInt(cant);
			cant_invi=Integer.parseInt(cant_inv);
			//	tot_up=canti+cant_inv;
			String qryup_cajas="update inventario_uni set cajas='"+tot_up+"',  existencias='"+tot_up+"'  where clave='"+clave+"' and lote = '"+lote+"' and caducidad= '"+cad+"'";
			String qryup_ingreso="update inventario_uni set cajas='"+tot_up+"' where clave='"+clave+"' and lote = '"+lote+"' and caducidad= '"+cad+"'";
		}
		ban1=0;
		
	}
	/*
	
		*/
%>
<%
// ----- try que cierra la conexión a la base de datos
		 try{
               // Se cierra la conexión dentro del try
                 conexion.close();
				 conexion2.close();
	          }catch (Exception e){mensaje=e.toString();}
           finally{ 
               if (conexion!=null){
                   conexion.close();
		                if(conexion.isClosed()){
                             mensaje="desconectado2";}
                 }
             }
			 //out.print(mensaje);
		// ---- fin de la conexión	 	  

%>

