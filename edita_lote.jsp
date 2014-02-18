<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" errorPage="" %>
 <%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
 <%
HttpSession sesion = request.getSession();
String val="", user="", id="", lote_new="", but="";



if (sesion.getAttribute("valida")!=null){
	val=(String)sesion.getAttribute("valida");
	user=(String)sesion.getAttribute("usuario");
	id=(String)sesion.getAttribute("id");
}


if(!val.equals("valido")){
	
	%>
    <script>self.location='index.jsp';</script>
    <%
}
//out.print (val+user+id);
%>
<% 
/*------------------------------------------------------------------------------------------
Nombre de archivo: carga_clave.jsp
Funcion: Carga Clave a inventario de forma manual, se queda registro del asiento
  -----------------------------------------------------------------------------------------*/
// Conexión BDD vía JDBC
  Class.forName("org.gjt.mm.mysql.Driver");
  Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/r_nayarit","root","eve9397");
  Statement stmt = conn.createStatement();
  ResultSet rset=null;
// fin conexión bdd  

// Para tomar datos fechas
java.util.Calendar currDate = new java.util.GregorianCalendar();
   // add 1 to month because Calendar's months start at 0, not 1
   int month = currDate.get(currDate.MONTH)+1;
   int day = currDate.get(currDate.DAY_OF_MONTH);
   int year = currDate.get(currDate.YEAR);
	String date="";
	String date2=""; 
   String res=""; 
   String day1=""; 
 
 if(month >=1 && month <= 9)  
 {
 res ="0"+month;
   date=" "+day;
   date= date+"/"+res;
   date= date+"/"+year;  
 }
 else 
{
      date=" "+day;
      date= date+"/"+month;
      date= date+"/"+year;  
	  res+=month;
}
 
 
 if(day >=1 && day <= 9)  
 {
 day1 ="0"+day;
// month=Integer.parseInt(res);
   date2=" "+day;
   date2= date2+"/"+day1;
   date2= date2+"/"+year;  
 //out.print(""+res); 
 }
 else 
{
      date2=" "+day;
      date2= date2+"/"+month;
      date2= date2+"/"+year;  
	  day1+=day;
}  
 //fin de fechas





//Obtención de la hora
        Calendar calendario = new GregorianCalendar();
		//Calendar calendario = Calendar.getInstance();
		
		int hora=0, minutos=0, segundos=0;
		String min_0="",hora_com="";
		hora =calendario.get(Calendar.HOUR_OF_DAY);
		minutos = calendario.get(Calendar.MINUTE);
		segundos = calendario.get(Calendar.SECOND);
		
		if(minutos>=0 && minutos<=9){
		  min_0="0"+minutos;
		  hora_com=hora + ":" + min_0 + ":" + segundos;
		}
		else{
		hora_com=hora + ":" + minutos + ":" + segundos;
		}
// -------------------


// Variables de entorno
String clave="", lote="", descrip="", caducidad="", origen="", existencia="", mensaje=""; 
// fin variables de entorno



try { 
        but=""+request.getParameter("Submit");
		lote_new=""+request.getParameter("txtf_lote2");
		lote=""+request.getParameter("txtf_lote");
		caducidad=""+request.getParameter("txtf_cad");
    }catch(Exception e){System.out.print("not");} 

if (but.equals("Actualizar"))
{
	String actualiza="update inventario_uni set lote = '"+lote+"' where id = '"+id+"'";
	stmt.execute(actualiza);
	 actualiza="update inventario_uni set caducidad = '"+caducidad+"' where id = '"+id+"'";
	//out.print(actualiza);
	stmt.execute(actualiza);
	
		%>
        <script>alert ('Actualizacion Correcta');</script>
        <%
	
}

String qry_datos="select * from inventario_uni where id='"+id+"'";
rset=stmt.executeQuery(qry_datos);
while(rset.next())
{
	clave=rset.getString("clave");
	lote=rset.getString("lote");
	descrip=rset.getString("descrip");
	caducidad=rset.getString("caducidad");
	origen=rset.getString("present");
	existencia=rset.getString("cajas");
}
		


// recibe valores de usuario y el valor del botón oprimido


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>.: ENTRADA MANUAL:.</title>
<script language="javascript" src="list02.js"></script>
<script language="javascript" src="scw.js"></script>
<script>
function foco_inicial(){
if (document.form.txtf_clave2.value==""){
document.form.txtf_clave.focus();
}
else
{
document.form.txtf_cant.focus();
}
}
</script>
<link rel="stylesheet" href="mm_restaurant1.css" type="text/css" />
</head>

<body onLoad="foco_inicial();">
<table width="666" height="346" border="3" align="center" cellpadding="2" bgcolor="#FFFFFF">
  <tr>
  
    <td width="650"><form id="form" name="form" method="post" action="edita_lote.jsp">
      <table width="650" height="289" border="0" align="center" cellpadding="2">
        <tr>
          <td height="49" bgcolor="#FFFFFF" class="logo style1"><div align="center" class="logo style1"><img src="imagenes/nay_ima1.jpg" width="142" height="72" /></div></td>
          <td height="49" colspan="2" bgcolor="#FFFFFF" class="logo style1"><div align="center">Ajuste al Inventario<br />
            ENTRADAS </div></td>
          <td height="49" bgcolor="#FFFFFF" class="logo style1"><img src="imagenes/ssn.jpg" width="156" height="65" /></td>
        </tr>
        <tr>
          <td height="14" colspan="4" bgcolor="#EC3237"><span class="style2"></span></td>
          </tr>
        <tr>
          <td width="114" height="20">&nbsp;</td>
          <td width="90" class="bodyText">&nbsp;</td>
          <td width="306">&nbsp;</td>
          <td width="114">&nbsp;</td>
        </tr>
        <tr>
          <td height="20"><div align="right">
            <div align="left" class="Estilo6">Clave: </div>
            </div></td>
          <td colspan="2" class="style5"><label>
            <input name="txtf_clave2" type="text" id="txtf_clave2" onChange="mayNomm(this.form)" onKeyPress="return handleEnter(this, event)"  value="<%=clave%>" size="10" readonly/>
            </label></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20"><div align="right">
            <div align="left" class="Estilo6">Descripci&oacute;n:</div>
          </div></td>
          <td colspan="2" class="style5"><label>
            <textarea name="txtf_descrip" cols="50" id="txtf_descrip" onChange="mayApepm(this.form)" onKeyPress="return handleEnter(this, event)" readonly><%=descrip%></textarea>
          </label></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20"><div align="right">
            <div align="left"><span class="Estilo6">Lote: </span></div>
          </div></td>
          <td colspan="2" class="style5"><input name="txtf_lote" type="text" id="txtf_lote" onChange="mayApemm(this.form)" onKeyPress="return handleEnter(this, event)" value="<%=lote%>" size="10" /></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20"><div align="right">
            <div align="left"><span class="Estilo6">Caducidad: </span></div>
          </div></td>
          <td colspan="2" class="style5"><input name="txtf_cad" type="text" id="txtf_cad" onChange="mayApemm(this.form)" onKeyPress="return handleEnter(this, event)" value="<%=caducidad%>" size="10" readonly="readonly"/><img src="imagenes/cal.jpg" width="26" height="27" border="0" onClick="scwShow(scwID('txtf_cad'), event)" /></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20"><div align="right">
            <div align="left"><span class="Estilo6">Origen: </span></div>
          </div></td>
          <td colspan="2" class="style5"><input name="txtf_origen" type="text" id="txtf_origen" onChange="mayApemm(this.form)" onKeyPress="return handleEnter(this, event)" value="<%=origen%>" size="10" readonly="readonly" /></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20"><div align="right">
            <div align="left"><span class="Estilo6">Existencia: </span></div>
          </div></td>
          <td colspan="2" class="style5"><span class="style5"><label></label>
              </span>            <label>
          <input name="txtf_exist" type="text" id="txtf_exist" onChange="mayApemm(this.form)" onKeyPress="return handleEnter(this, event)" value="<%=existencia%>" size="10" readonly/>
            </label></td>
          <td>&nbsp;</td>
        </tr>
        
        <tr>
          <td height="20">&nbsp;</td>
          <td class="style5"><span class="style5"><label></label>
          </span></td>
          <td><input type="submit" name="Submit" value="Actualizar" />&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
  <tr>
          <td height="20">&nbsp;</td>
          <td colspan="2" class="style5">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>     
        
        <tr>
          <td height="20">&nbsp;</td>
          <td colspan="2"><div align="center">&nbsp;&nbsp;<!--input type="submit" name="Submit" value="Limpiar Claves" /-->
          &nbsp;Cerrar Aplicación <button name="boton" type="button" class="style7" onClick="CloseWin()" /><img src="imagenes/borr.jpg" /></button></div></div></td>
          <td>&nbsp;</td>
        </tr>
      </table>
          </form>
    </td>
  </tr>
</table>
<%
// ----- try que cierra la conexión a la base de datos
		 try{
               // Se cierra la conexión dentro del try
                 conn.close();
	          }catch (Exception e){mensaje=e.toString();}
           finally{ 
               if (conn!=null){
                   conn.close();
		                if(conn.isClosed()){
                             mensaje="desconectado2";}
                 }
             }
			 //out.print(mensaje);
		// ---- fin de la conexión	 	  

%>
</body>
</html>
