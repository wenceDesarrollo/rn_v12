
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
  <%java.text.DateFormat df2 = new java.text.SimpleDateFormat("hh:mm:ss"); %>
 
<% java.util.Calendar currDate = new java.util.GregorianCalendar();
Class.forName("org.gjt.mm.mysql.Driver");
Connection conn_001 = DriverManager.getConnection("jdbc:mysql://localhost/r_nayarit");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/r_nayarit");
   // add 1 to month because Calendar's months start at 0, not 1
   int month = currDate.get(currDate.MONTH)+1;
   int day = currDate.get(currDate.DAY_OF_MONTH);
   int year = currDate.get(currDate.YEAR);
	String date="";
	String date2=""; 
   String res=""; 
   String day1=""; 
 	String mensaje="";
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
 //out.print(""+res); 
 //fecha2=
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
%>
<%

/*----------------------------------------------------------------------------------------------------------------------
Nombre del Archivo: elim_folio.jsp
------------------------------------------------------------------------------------------------------------------------*/
ResultSet rset =null;
ResultSet rset_re =null;
Statement stmt = null ;
Statement stmt_re = null ;
Statement stmt1 = null ;

stmt = conn_001.createStatement();
stmt1 = conn_001.createStatement();
stmt_re = conn_001.createStatement();

String fecha1=request.getParameter("txtf_caduc");
String fecha2=request.getParameter("txtf_caduci");

String but="";
 try { 
        but=""+request.getParameter("Submit");
       
    }catch(Exception e){System.out.print("not");}
	
	
	
if (but.equals("Por Fechas")){



String fmod1="", fmod2="";

Statement stmt_date = conn.createStatement();
ResultSet rset_date = stmt_date.executeQuery("SELECT STR_TO_DATE('"+fecha1+"', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%m/%d/%Y')
         while(rset_date.next())
		 {
             fmod1= rset_date.getString("STR_TO_DATE('"+fecha1+"', '%d/%m/%Y')");//STR_TO_DATE('"+date_jv+"', '%m/%d/%Y')
		 }
rset_date = stmt_date.executeQuery("SELECT STR_TO_DATE('"+fecha2+"', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%m/%d/%Y')
         while(rset_date.next())
		 {
             fmod2= rset_date.getString("STR_TO_DATE('"+fecha2+"', '%d/%m/%Y')");//STR_TO_DATE('"+date_jv+"', '%m/%d/%Y')
		 }




stmt.execute("update receta set folio_re = replace (folio_re, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set fecha_re = replace (fecha_re, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set hora = replace (hora, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set juris = replace (juris, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set no_juris = replace (no_juris, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set unidad = replace (unidad, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set nombre_pac = replace (nombre_pac, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set edad = replace (edad, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set afiliado = replace (afiliado, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set univer_medi = replace (univer_medi, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set cedula_medi = replace (cedula_medi, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set causes = replace (causes, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set clave = replace (clave, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set descrip = replace (descrip, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set cant_sol = replace (cant_sol, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set cant_sur = replace (cant_sur, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set surtido = replace (surtido, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set encargado = replace (encargado, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set clave_uni = replace (clave_uni, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set id_med = replace (id_med, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set cv_uni_dgo = replace (cv_uni_dgo, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set cv_tipo_unidad = replace (cv_tipo_unidad, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set cv_financ = replace (cv_financ, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set fuente = replace (fuente, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set layout = replace (layout, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set partida = replace (partida, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set present = replace (present, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set cant_pendi = replace (cant_pendi, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set status_receta = replace (status_receta, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set tipo_receta = replace (tipo_receta, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set precio = replace (precio, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set precio_tt = replace (precio_tt, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set lote = replace (lote, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set caducidad = replace (caducidad, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set carnet = replace (carnet, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set servicio = replace (servicio, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set dias = replace (dias, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set cause = replace (cause, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set aux7 = replace (aux7, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set aux8 = replace (aux8, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set aux9 = replace (aux9, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set aux10 = replace (aux10, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set aux11 = replace (aux11, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set aux12 = replace (aux12, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set aux13 = replace (aux13, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set corte = replace (corte, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set ampuleo = replace (ampuleo, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set folio_sp = replace (folio_sp, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set nombre_medi = replace (nombre_medi, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 



stmt.execute("update receta_colectiva set folio_re = replace (folio_re, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set fecha_re = replace (fecha_re, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set hora = replace (hora, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set juris = replace (juris, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set no_juris = replace (no_juris, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set unidad = replace (unidad, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set nombre_pac = replace (nombre_pac, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set edad = replace (edad, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set afiliado = replace (afiliado, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set univer_medi = replace (univer_medi, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set cedula_medi = replace (cedula_medi, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set causes = replace (causes, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set clave = replace (clave, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set descrip = replace (descrip, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set cant_sol = replace (cant_sol, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set cant_sur = replace (cant_sur, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set surtido = replace (surtido, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set encargado = replace (encargado, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set clave_uni = replace (clave_uni, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set id_med = replace (id_med, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set cv_uni_dgo = replace (cv_uni_dgo, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set cv_tipo_unidad = replace (cv_tipo_unidad, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set cv_financ = replace (cv_financ, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set fuente = replace (fuente, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set layout = replace (layout, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set partida = replace (partida, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set present = replace (present, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set cant_pendi = replace (cant_pendi, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set status_receta = replace (status_receta, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set tipo_receta = replace (tipo_receta, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set precio = replace (precio, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set precio_tt = replace (precio_tt, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set lote = replace (lote, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set caducidad = replace (caducidad, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set carnet = replace (carnet, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set servicio = replace (servicio, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set aux5 = replace (aux5, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set aux6 = replace (aux6, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set aux7 = replace (aux7, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set aux8 = replace (aux8, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set aux9 = replace (aux9, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set aux10 = replace (aux10, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set aux11 = replace (aux11, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set aux12 = replace (aux12, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set aux13 = replace (aux13, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set aux14 = replace (aux14, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set aux15 = replace (aux15, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set folio_sp = replace (folio_sp, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set nombre_medi = replace (nombre_medi, CHAR(13), '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 




stmt.execute("update receta set folio_re = replace (folio_re, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set fecha_re = replace (fecha_re, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set hora = replace (hora, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set juris = replace (juris, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set no_juris = replace (no_juris, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set unidad = replace (unidad, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set nombre_pac = replace (nombre_pac, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set edad = replace (edad, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set afiliado = replace (afiliado, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set univer_medi = replace (univer_medi, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set cedula_medi = replace (cedula_medi, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set causes = replace (causes, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set clave = replace (clave, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set descrip = replace (descrip, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set cant_sol = replace (cant_sol, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set cant_sur = replace (cant_sur, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set surtido = replace (surtido, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set encargado = replace (encargado, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set clave_uni = replace (clave_uni, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set id_med = replace (id_med, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set cv_uni_dgo = replace (cv_uni_dgo, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set cv_tipo_unidad = replace (cv_tipo_unidad, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set cv_financ = replace (cv_financ, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set fuente = replace (fuente, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set layout = replace (layout, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set partida = replace (partida, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set present = replace (present, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set cant_pendi = replace (cant_pendi, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set status_receta = replace (status_receta, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set tipo_receta = replace (tipo_receta, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set precio = replace (precio, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set precio_tt = replace (precio_tt, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set lote = replace (lote, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set caducidad = replace (caducidad, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set carnet = replace (carnet, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set servicio = replace (servicio, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set dias = replace (dias, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set cause = replace (cause, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set aux7 = replace (aux7, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set aux8 = replace (aux8, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set aux9 = replace (aux9, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set aux10 = replace (aux10, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set aux11 = replace (aux11, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set aux12 = replace (aux12, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set aux13 = replace (aux13, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set corte = replace (corte, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set ampuleo = replace (ampuleo, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set folio_sp = replace (folio_sp, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta set nombre_medi = replace (nombre_medi, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 



stmt.execute("update receta_colectiva set folio_re = replace (folio_re, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set fecha_re = replace (fecha_re, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set hora = replace (hora, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set juris = replace (juris, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set no_juris = replace (no_juris, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set unidad = replace (unidad, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set nombre_pac = replace (nombre_pac, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set edad = replace (edad, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set afiliado = replace (afiliado, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set univer_medi = replace (univer_medi, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set cedula_medi = replace (cedula_medi, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set causes = replace (causes, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set clave = replace (clave, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set descrip = replace (descrip, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set cant_sol = replace (cant_sol, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set cant_sur = replace (cant_sur, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set surtido = replace (surtido, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set encargado = replace (encargado, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set clave_uni = replace (clave_uni, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set id_med = replace (id_med, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set cv_uni_dgo = replace (cv_uni_dgo, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set cv_tipo_unidad = replace (cv_tipo_unidad, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set cv_financ = replace (cv_financ, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set fuente = replace (fuente, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set layout = replace (layout, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set partida = replace (partida, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set present = replace (present, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set cant_pendi = replace (cant_pendi, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set status_receta = replace (status_receta, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set tipo_receta = replace (tipo_receta, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set precio = replace (precio, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set precio_tt = replace (precio_tt, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set lote = replace (lote, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set caducidad = replace (caducidad, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set carnet = replace (carnet, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set servicio = replace (servicio, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set aux5 = replace (aux5, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set aux6 = replace (aux6, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set aux7 = replace (aux7, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set aux8 = replace (aux8, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set aux9 = replace (aux9, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set aux10 = replace (aux10, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set aux11 = replace (aux11, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set aux12 = replace (aux12, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set aux13 = replace (aux13, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set aux14 = replace (aux14, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set aux15 = replace (aux15, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set folio_sp = replace (folio_sp, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 
stmt.execute("update receta_colectiva set nombre_medi = replace (nombre_medi, '\n', '') where fecha_re between '"+fmod1+"' and '"+fmod2+ " ' ; " ) ; 







String qry_receta="select * from receta  where fecha_re between '"+fmod1+"' and '"+fmod2+"' into outfile 'c:/receta_del_"+fmod1+"_al_"+fmod2+".txt';";
String qry_col="select * from receta_colectiva  where fecha_re between '"+fmod1+"' and '"+fmod2+"' into outfile 'c:/receta_col_del"+fmod1+"_al_"+fmod2+".txt';";
//out.print(qry_receta);
//out.print(qry_col);
stmt1.execute(qry_receta);
stmt1.execute(qry_col);



out.print("Se descargaron las bases correctamente.");

}
%>

<hmtml>
<head>
<script language="javascript" src="scw.js"></script>
</head>
<body>
<form method="get" action="bajar_base.jsp">
<table width="600" border="1" align="center">
  <tr>
    <td>&nbsp;</td>
    <td><div align="center">GNKL Software </div></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center">Seleccione el rango de Fechas </div></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center">Del: 
        <input name="txtf_caduc" type="text" id="txtf_caduc" size="10" readonly title="dd/mm/aaaa"> <img src="imagenes/cal.jpg" width="26" height="27" border="0" onClick="scwShow(scwID('txtf_caduc'), event)" />
        al
	    <input name="txtf_caduci" type="text" id="txtf_caduci" size="10" readonly title="dd/mm/aaaa"><img src="imagenes/cal.jpg" width="26" height="27" border="0" onClick="scwShow(scwID('txtf_caduci'), event)" />
	    <input type="submit" name="Submit" value="Por Fechas" class="style1"/> 
    </div></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</form>
</body>


<%
// ----- try que cierra la conexión a la base de datos
		 try{
               // Se cierra la conexión dentro del try
                 conn_001.close();
	          }catch (Exception e){mensaje=e.toString();}
           finally{ 
               if (conn_001!=null){
                   conn_001.close();
		                if(conn_001.isClosed()){
                             mensaje="desconectado2";}
                 }
             }
			 //out.print(mensaje);
		// ---- fin de la conexión	 	  

%>
</html>