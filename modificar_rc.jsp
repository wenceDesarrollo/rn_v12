<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="" %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%
/* ----------------------------------------------------------------------------------
Nombre de Archivo: modificar_rc.jsp
Función: Modifica datos de la receta colectiva
-------------------------------------------------------------------------------------*/
// Conexiones a la BDD
Class.forName("org.gjt.mm.mysql.Driver");

				  Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/r_nayarit","root","eve9397");
                  Statement stmt = conn.createStatement();
				  Statement stmt2 = conn.createStatement();
				  Statement stmt3 = conn.createStatement();
				  Statement stmt_001 = conn.createStatement();
				  ResultSet rset = null;
				  ResultSet rset_001 = null;
				  ResultSet rset1 = null;
				  ResultSet rset2 = null;
				  ResultSet rset3 = null;
				  ResultSet rset_org = null; 
				  ResultSet rset_re =null;
				  ResultSet rset_inv =null;
				  Statement stmt_re = conn.createStatement();
				  Statement stmt_inv = conn.createStatement();
				  Statement stmt_inv2 = conn.createStatement();
				  Statement stmt1= conn.createStatement();
// fin conexiones
// Rutina para fecha
  java.util.Calendar currDate = new java.util.GregorianCalendar();
   // add 1 to month because Calendar's months start at 0, not 1
   int month = currDate.get(currDate.MONTH)+1;
   int day = currDate.get(currDate.DAY_OF_MONTH);
   int year = currDate.get(currDate.YEAR);
	String date="",date2=""; 
   String res="",cant_ant=""; 
 
 if(month >=1 && month <= 9)  
 {
 res ="0"+month;
// month=Integer.parseInt(res);
   date=" "+day;
   date= date+"/"+res;
   date= date+"/"+year;  

 //out.print(""+res); 
 }
 else 
{
      date=" "+day;
      date= date+"/"+month;
      date= date+"/"+year;  
	  res+=month;
}
// fin rutina para fecha   
// Variables de entorno	
String hora_ini_jv="";
String lugar_jv="";
String cb_jv="",nombre_jv="",edad_jv="",folio_jv="",cause_jv="",foliore_jv="",foliore2_jv="",radiopro_jv="",radiosur_jv="",date_jv="",reloj_jv="",encar_jv="",juris_jv="",clave_jv="",eliminar_jv="",usu_jv="",equipo_jv="",integrantes_jv="",recibe_id_jv="",t2_jv="",t3_jv="",id_send="",usuario="";
String but="r";
String but2="r";
String nom_unidad="",no_jur="";

//variables medicamento 1
String med1_jv="",descrip1_jv="",indica1_jv="",sol1_jv="",sur1_jv="",present1_jv="",clave1_jv="";

//variables medicamento 1
String med2_jv="",descrip2_jv="",indica2_jv="",sol2_jv="",sur2_jv="",present2_jv="",clave2_jv="";

//variables medicamento 1
String med3_jv="",descrip3_jv="",indica3_jv="",sol3_jv="",sur3_jv="",present3_jv="",clave3_jv="";
//varibles medico
String medico_jv="",uni_jv="",cedu_jv="",nomed_jv="";
String cv_dgo_jv="",cv_uni_jv="",cv_mpio_jv="",id_med_jv="",part_jv="";
String cantsur="",cantsur2="",clavesur="",partidasur="",cantinv="",descripsur="",cant_jv="",t1_jv="",status="",carnet_jv="",programa_jv="";
int cantinv2=0,cont1=0,cant2_jv=0,cant22_jv=0,mtotal=0,mtotal2=0,sur11=0,sol2=0,sur2=0,resto_jv=0;
String perfil="",sexo_jv="",lote="",caducidad="",mensaje="",hora_com="";
int cant_mod_sol=0,cant_mod_sur=0,sol1_jv_int=0,sur1_jv_int=0,reint_dif=0,cant_sur_neg=0,sal_inv=0,ing_inv=0,reintegrar=0,existencias=0,sal_idas=0;
// fin variables de entorno
 	  try {
	   		eliminar_jv = request.getParameter("id_prov");
	    	nom_unidad=request.getParameter("uni");
		 	no_jur=request.getParameter("juris");    
		    foliore_jv=request.getParameter("foliore");
			clave1_jv=request.getParameter("clave1");
			descrip1_jv=request.getParameter("descrip1");
			lote=request.getParameter("lote");
			caducidad=request.getParameter("cadu");
			sol1_jv=request.getParameter("sol1");   
		    sur1_jv=request.getParameter("sur1");
			part_jv=request.getParameter("part");
			id_send=request.getParameter("id");
			t2_jv=request.getParameter("mes5");
			usuario=request.getParameter("usuario");   
		 }catch(Exception e){ System.out.print("Doesn't make the altaOK"); }
try { 
        but=""+request.getParameter("Submit");
		//out.print("but ="+but);
    }catch(Exception e){System.out.print("not");} 



if(but.equals("Modificar"))
   {
	   //out.print("Receta"+sol1_jv+sur1_jv);
	   sol1_jv_int=Integer.parseInt(sol1_jv);
	   sur1_jv_int=Integer.parseInt(sur1_jv);
	   cant_mod_sol=Integer.parseInt(request.getParameter("txtf_sol1"));
	   cant_mod_sur=Integer.parseInt(request.getParameter("txtf_sur1"));
	   hora_com=request.getParameter("reloj");
	   date2=request.getParameter("txtf_date1");
	   out.print("Receta Modificada en Fecha y Hora:"+date2+hora_com);
	   if(cant_mod_sur>sur1_jv_int)
	   {
	   %>
       <script>
	   alert("Introduzca cantidad VÁLIDA a Modificar")
	   </script>
       <%
	   }
	   else
	     {
			//out.print("Proceso para realizar Modificación con valor válido"+cant_mod_sol+cant_mod_sur);
			reint_dif=sur1_jv_int-cant_mod_sur;	
			cant_sur_neg=(reint_dif)*(-1);
			// camboar formato de fecha
			rset = stmt.executeQuery("SELECT STR_TO_DATE('"+date2+"', '%d/%m/%Y')"); 
                    while(rset.next()){
                    date2= rset.getString("STR_TO_DATE('"+date2+"', '%d/%m/%Y')");
					}
			// fin formato
			// agregar a movimientos salidas la cantidad a regresar en negativo
			stmt.execute("insert into movimientos_salidas values ('"+clave1_jv+"','"+descrip1_jv+"','"+lote+"','"+caducidad+"','"+cant_sur_neg+"','1','"+cant_sur_neg+"','"+part_jv+"','-','"+df.format(new java.util.Date())+"','"+hora_com+"','4')"); 
			// fin agregar
		//sal_inv=0,ing_inv=0,reintegrar=0,existencias=0
		
		rset_re = stmt_re.executeQuery("select cajas,existencias,salidas,id,ingreso from inventario_uni where clave='"+clave1_jv+"' and lote='"+lote+"' and caducidad='"+caducidad+"' and origen='"+part_jv+"'; ");
			while (rset_re.next())
			{
				sal_inv=Integer.parseInt(rset_re.getString("salidas"));
				cant_ant=rset_re.getString("existencias");
				ing_inv=Integer.parseInt(rset_re.getString("ingreso"));
				recibe_id_jv=rset_re.getString("id");
				break;
			}
			reintegrar=sal_inv-reint_dif;
			existencias=ing_inv-reintegrar;
			//sal_idas=sal_inv-reint_dif
			
			 stmt.execute("update inventario_uni set salidas='"+reintegrar+"',cajas='"+existencias+"', existencias='"+existencias+"' where id='"+recibe_id_jv+"'");
			 
			  // se agrega info a la tabla modificacion
				      stmt.execute("insert into modificacion values ('"+clave1_jv+"','"+descrip1_jv+"','"+lote+"','"+caducidad+"','"+cant_ant+"','"+part_jv+"','"+reint_dif+"','"+existencias+"','"+df.format(new java.util.Date())+"','"+usuario+"','MODIFICACION DE INSUMO','SALIDA DE INSUMO AL INVENTARIO VIA MODIFICACION MANUAL EN RC',current_timestamp,'"+foliore_jv+"','-','11','-','-','"+existencias+"',0)");						 
					 // fin tabla modi 			
			
		stmt.execute("insert into receta_colectiva_modi(SELECT * from receta where folio_re='"+foliore_jv+"'); ");	
		stmt.execute("update receta_colectiva set cant_sol='"+cant_mod_sol+"',cant_sur='"+cant_mod_sur+"' where id='"+id_send+"'");
			
		 }
   }

	 
	  
	   
	



%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>.:Receta Farmacia MODIFICACION:.</title>
<script language="javascript" src="list02.js"></script>
<script type="text/javascript">
function validar(e) { // 1
    tecla = (document.all) ? e.keyCode : e.which; // 2
    if (tecla==8) return true; // 3
  patron = /\d/; // Solo acepta números



  //SOLO LETRAS-->patron =/[A-Za-z\s]/; // 4
  //SOLO LETRAS Y NUMEROS --> patron = /\d/; // Solo acepta números
  //numeros y letras --> patron = /\w/; // Acepta números y letras
//no aceptan numeros --> patron = /\D/; // No acepta números
//aceptan las letras ñÑ --> patron =/[A-Za-zñÑ\s]/; // igual que el ejemplo, pero acepta también las letras ñ y Ñ  
//determinado letras y numeros --> patron = /[ajt69]/;//También se puede hacer un patrón que acepte determinados caracteres, poniendolos entre corchetes. Veamos un ejemplo para validar que solo se acepte a, j, t, 6 y 9:
   
    te = String.fromCharCode(tecla); // 5
    return patron.test(te); // 6
} 
</script>
<style type="text/css">
<!--
.style2 {
	font-size: 10px;
	font-family: Arial, Helvetica, sans-serif;
}
.style4 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
}
.style5 {font-size: 14px}
.style6 {
	font-size: 12px;
	font-weight: bold;
}
.style7 {
	font-size: 16px;
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
}
.style11 {font-size: 12px}
-->
</style>
</head>

<body onLoad="mueveReloj();SetCur()">
<form name="form" method="post" action="modificar_rc.jsp?uni=<%=nom_unidad%>&juris=<%=no_jur%>&nombre=<%=nombre_jv%>&edad=<%=edad_jv%>&folio=<%=folio_jv%>&clave1=<%=clave1_jv%>&descrip1=<%=descrip1_jv%>&present1=<%=present1_jv%>&indica1=<%=indica1_jv%>&sol1=<%=sol1_jv%>&sur1=<%=sur1_jv%>&clave2=<%=clave2_jv%>&descrip2=<%=descrip2_jv%>&present2=<%=present2_jv%>&indica2=<%=indica2_jv%>&sol2=<%=sol2_jv%>&sur2=<%=sur2_jv%>&clave3=<%=clave3_jv%>&descrip3=<%=descrip3_jv%>&present3=<%=present3_jv%>&indica3=<%=indica3_jv%>&sol3=<%=sol3_jv%>&sur3=<%=sur3_jv%>&cause=<%=cause_jv%>&foliore=<%=foliore_jv%>&encar=<%=encar_jv%>&juris1=<%=juris_jv%>&clave_uni=<%=clave_jv%>&univer=<%=uni_jv%>&cedu=<%=cedu_jv%>&nomed=<%=nomed_jv%>&id_prov=<%=eliminar_jv%>&cv_dgo=<%=cv_dgo_jv%>&cv_uni=<%=cv_uni_jv%>&cv_mpio=<%=cv_mpio_jv%>&part=<%=part_jv%>&id_med=<%=id_med_jv%>&day5=<%=t1_jv%>&mes5=<%=t2_jv%>&aa5=<%=t3_jv%>&carnet=<%=carnet_jv%>&programa=<%=programa_jv%>&perfil=aleman&sexo=<%=sexo_jv%>&lote=<%=lote%>&cadu=<%=caducidad%>&id=<%=id_send%>&usuario=<%=usuario%>">

<table width="885" height="339" border="3" align="center" cellpadding="2">
  <tr>
    <td width="725" height="137"><table width="710" border="0" align="center" cellpadding="2">
      <tr>
        <td width="114" height="82"><img src="imagenes/nay_ima1.jpg" width="142" height="72" /></td>
        <td width="339"><div align="center"><span class="style7">SERVICIO DE SALUD DE NAYARIT<br />
        RECETA MEDICA<br />MODIFICAR SOL Y SUR </span></div></td>
        <td width="225" align="center"><img src="imagenes/ssn.jpg" width="162" height="78" /></td>
      </tr>
    </table>
      <table width="710" height="45" border="0" align="center" cellpadding="2">
        <tr>
          <td width="284" height="41">
            <table width="270" height="0%" border="0" cellpadding="2">
              <tr>
                <td width="221" height="100%" class="style2">FECHA:
                    
                
                  <span class="style2">
                  <label>                  </label>
                  <input name="txtf_date1" type="text" size="15" value="<%=date%>"  onKeyPress="return handleEnter(this, event)" readonly/></td>
              </tr>
            </table>          </td>
          <td width="250"><table width="167" height="0%" border="0" cellpadding="2">
            <tr>
              <td width="225" height="100%" class="style2">HORA:
                <input name="reloj" type="text" class="styl2" onKeyPress="return handleEnter(this, event)" size="15" readonly ></td>
            </tr>
          </table>            </td>
          <td width="172" align="center" class="style2">No. Folio
            <input type="text" name="txtf_foliore" size="20"  value="<%=foliore_jv%>" readonly/>
            <table width="152" height="0%" border="0" align="right" cellpadding="2">
          </table></td>
        </tr>
    </table>    </td>
  </tr>
        <tr>
          <td height="71" colspan="3" class="style4"><table width="710" border="0" align="center" cellpadding="2">
            <tr>
              <td width="533" class="style2">UNIDAD DE SALUD</td>
              <td width="170"><table width="170" border="0" align="left" cellpadding="2">
                <tr>
                  <td width="162" align="center"><div align="center" class="style2">JURISDICCION&nbsp;&nbsp;<input name="txtf_njuris" type="text" size="1" value="<%=no_jur%>" readonly/>
                  </div></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td colspan="2"><input type="text" name="txtf_unidadmed" size="55" colspan="3" class="style4"  value="<%=nom_unidad%>" readonly/></td>
            </tr>
          </table></td>
        </tr>
        
        
        
        <tr>
          <td height="123" colspan="3" class="style4"><table width="863" border="0" align="center" cellpadding="2">
            
            
            <tr>
              <td width="49" class="style11"><label> <br />
              </label></td>
              <td width="182" class="style11"><label></label></td>
              <td width="57" class="style11">&nbsp;</td>
              <td width="92" class="style11"><label></label></td>
              <td width="79" class="style11">&nbsp;</td>
              <td width="71" class="style11">&nbsp;</td>
              <td width="66" class="style11">&nbsp;</td>
              <td width="72" class="style11">&nbsp;</td>
              <td width="139" class="style11">&nbsp;</td>
            </tr>
            <tr>
              <td width="49" class="style11"><span class="style2">CLAVE </span></td>
              <td align="center"><span class="style2">DESCRIPCI&Oacute;N</span></td>
              <td align="center"><span class="style2">LOTE</span></td>
              <td align="center"><span class="style2">CADUCIDAD</span></td>
              <td align="center" class="style11"><span class="style2">CANT. SOL</span></td>
              <td class="style11"><span class="style2">CANT. A MOD</span></td>
              <td class="style11"><span class="style2">CANT. SUR</span></td>
              <td class="style11"><span class="style2">CANT. A MOD</span></td>
              <td class="style11">&nbsp;</td>
            </tr>
		
            <tr>
              <td class="style11" align="center"><%=clave1_jv%></td>
              <td class="style11" align="center"><%=descrip1_jv%></td>
              <td class="style11" align="center"><%=lote%></td>
              <td class="style11" align="center"><%=caducidad%></td>
			  
			 
              <td class="style11" align="center"><%=sol1_jv%></td>
              <td class="style11" align="center"><input type="text" name="txtf_sol1" size="5"  onkeypress="return validar(event)"/></td>
              <td align="center" class="style11"><%=sur1_jv%></td>
              <td class="style11" align="center"><input type="text" name="txtf_sur1" size="5"  onchange="setSur1(this.form)" onKeyPress="return validar(event)"/></td>
              <td class="style11"><input name="Submit" type="submit" class="but" value="Modificar" onChange="setSur1(this.form)" onClick="return verificaN1(document.forms.form)"/>
              &nbsp; <a href="rc_modi2.jsp?uni=<%=nom_unidad%>&juris=<%=no_jur%>&nombre=<%=nombre_jv%>&edad=<%=edad_jv%>&folio=<%=folio_jv%>&clave1=<%=clave1_jv%>&descrip1=<%=descrip1_jv%>&present1=<%=present1_jv%>&indica1=<%=indica1_jv%>&sol1=<%=sol1_jv%>&sur1=<%=sur1_jv%>&clave2=<%=clave2_jv%>&descrip2=<%=descrip2_jv%>&present2=<%=present2_jv%>&indica2=<%=indica2_jv%>&sol2=<%=sol2_jv%>&sur2=<%=sur2_jv%>&clave3=<%=clave3_jv%>&descrip3=<%=descrip3_jv%>&present3=<%=present3_jv%>&indica3=<%=indica3_jv%>&sol3=<%=sol3_jv%>&sur3=<%=sur3_jv%>&cause=<%=cause_jv%>&foliore=<%=foliore_jv%>&encar=<%=encar_jv%>&juris1=<%=juris_jv%>&clave_uni=<%=clave_jv%>&univer=<%=uni_jv%>&cedu=<%=cedu_jv%>&nomed=<%=nomed_jv%>&id_prov=<%=eliminar_jv%>&cv_dgo=<%=cv_dgo_jv%>&cv_uni=<%=cv_uni_jv%>&cv_mpio=<%=cv_mpio_jv%>&part=<%=part_jv%>&id_med=<%=id_med_jv%>&day5=<%=t1_jv%>&mes5=<%=t2_jv%>&aa5=<%=t3_jv%>&carnet=<%=carnet_jv%>&programa=<%=programa_jv%>&perfil=aleman&sexo=<%=sexo_jv%>&lote=<%=lote%>&cadu=<%=caducidad%>&id=<%=id_send%>&usuario=<%=usuario%>">Regresar</a></td>
            </tr>
            
			
            
            
          </table></td>
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
