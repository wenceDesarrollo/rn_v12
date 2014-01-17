<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="" import="java.text.DecimalFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% DecimalFormat forma= new DecimalFormat("##,###.##"); %>
<%
response.setContentType ("application/vnd.ms-excel"); 
response.setHeader ("Content-Disposition", "attachment;filename=\"Reporte de Nivel de Servicio.xls\"");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<% java.util.Calendar currDate = new java.util.GregorianCalendar();
Class.forName("org.gjt.mm.mysql.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
   // add 1 to month because Calendar's months start at 0, not 1
  %>
<%

//declaracion de variables-------------------------------------------------------------------------------------------------------------------
String cant_sol="0", cant_sur="0", cant_nosur="0", recetas_tot="0", recetas_par="0", porcentaje="0", fecha="", mensaje=""; 
String cant_sol_col="0", cant_sur_col="0", cant_nosur_col="0", recetas_tot_col="0", recetas_par_col="0", porcentaje_col="0", fecha_col=""; 
int sol=0, sur=0, dif=0, sol_col=0, sur_col=0, dif_col=0, total_sol=0, total_sur=0, i=1, ancho=0;
//-------------------------------------------------------------------------------------------------------------------------------------------

Statement stmt = null ;
ResultSet rset =null;
stmt = conn.createStatement();

Statement stmt2 = null ;
ResultSet rset2 =null;
stmt2 = conn.createStatement();


String fecha1="2013-01-01", fecha2="2013-01-01", but="";



try { 
        but=""+request.getParameter("submit");
    }catch(Exception e){System.out.print("not");} 
	
	//out.print(but);
String t1_jv=request.getParameter("f1");
String t2_jv=request.getParameter("f2");
	//out.print(t2_jv);
fecha1= df.format(df2.parse(t1_jv));
fecha2= df.format(df2.parse(t2_jv));

String qry_sol="SELECT id_rec from detreceta WHERE fec_sur BETWEEN '"+fecha1+"' AND '"+fecha2+"' GROUP BY id_rec";
String qry_sol_colectivo="", qry_rece="";

rset = stmt.executeQuery(qry_sol); 
while(rset.next()){
	i++;
}
ancho=i*100;
%>

<html>
<head>
<script language="javascript" src="scw.js"></script>
</head>

<form action="rep_nivserv.jsp" method="get">
<h2>Nivel de Servicio de Farmacias</h2><br />
<h3>Del : <%=fecha1%>
al <%=fecha2%></h3>
</form>

<table bgcolor="#FFFFFF">
    <tr>
  <td><table width="200px" border="1" bgcolor="#FFFFFF" bordercolor="#CCCCCC">
      <tr>
        <td>Fecha</td>
      </tr>
      <tr>
        <td>Pzs Solicitadas</td>
      </tr>
      <tr>
        <td>Pzs no Surtidas</td>
      </tr>
       <tr>
        <td>Claves Solicitadas</td>
      </tr>
       <tr>
        <td>Claves no Surtidas</td>
      </tr>
       <tr>
        <td>Recetas Solicitadas</td>
      </tr>
      <tr>
        <td>Rec 100 / Rec Parciales</td>
      </tr>
      <tr>
        <td>Porcentaje</td>
      </tr>
      <tr>
        <td>Pzs Vendidas</td>
      </tr>
      <tr>
        <td>Importe Venta</td>
      </tr>
    </table></td>
  *
    <td><table border="1"  bgcolor="#FFFFFF" bordercolor="#CCCCCC">
    	<%
		try{
		%>
        <tr>
        <%
		String qry_fecha="select fec_sur from detreceta where fec_sur BETWEEN '"+fecha1+"' AND '"+fecha2+"' group by fec_sur";
		rset = stmt.executeQuery(qry_fecha); 
		while(rset.next())
		{
			fecha=df2.format(df.parse(rset.getString("fec_sur"))); 
			%>
			<td style="width:auto"><%=fecha%></td>
			<%
		}
		%>
		<td><strong>Totales</strong></td>
        </tr>
        <%
		String qry_pzsol="select sum(can_sol) as sol, bi.fec_carga from receta r, detreceta dr, bitacora bi where r.id_rec = dr.id_rec and  r.id_rec = bi.id_rec AND bi.fec_carga BETWEEN '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59' group by DAY(fec_carga) ;";
//String qry_pzsol="select sum(can_sol) as sol, fec_sur from detreceta where fec_sur BETWEEN '"+fecha1+"' AND '"+fecha2+"' group by fec_sur";
		%>
		<tr>
		<%
		int total_pzs_sol=0;
		rset = stmt.executeQuery(qry_pzsol); 
		while(rset.next())
		{
		  cant_sol=rset.getString("sol");
		  fecha=rset.getString("fec_carga");
		  sol = Integer.parseInt(cant_sol);
		  total_sol=sol;
		  total_pzs_sol += total_sol;
		  %>
		  <td style="text-align: right"><%=total_sol%></td>
		  <%
		}
		%>
		<td style="text-align: right"><strong><%=total_pzs_sol%></strong></td>
        </tr>
        <%
		} catch(Exception e){
			out.println(e.getMessage());
		}
		%>
        
		<%
		try{
		%>
		<%
		String qry_pzsur="select sum(can_sol) as sol, sum(cant_sur) as sur, bi.fec_carga from receta r, detreceta dr, bitacora bi where r.id_rec = dr.id_rec and  r.id_rec = bi.id_rec AND bi.fec_carga BETWEEN '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59' group by DAY(fec_carga) ;";
		%>
        <tr>
        <%
		int total_pzs_no_sur=0;
		rset = stmt.executeQuery(qry_pzsur); 
		while(rset.next())
		{
			cant_sol=rset.getString("sol"); 
			cant_sur=rset.getString("sur"); 
			fecha=rset.getString("fec_carga"); 
			sol=Integer.parseInt(cant_sol);
			sur=Integer.parseInt(cant_sur);
			dif=sol-sur;
			
			total_sol=dif;
			
		%>
        <td style="text-align: right"><%=total_sol%></td>
        <%
        total_pzs_no_sur += total_sol;
		}
		%>
		<td style="text-align: right"><strong><%=total_pzs_no_sur%></strong></td>
        </tr>
        <%
		} catch(Exception e){
			out.println(e.getMessage());
		}
		%>
        
        
        <%
		try{
		%>
        <tr>
        <%
		int tot_clavez_sol=0, total_cla_sol_c=0;
		String qry_cant_pzs="select fec_sur from detreceta where fec_sur BETWEEN '"+fecha1+"' AND '"+fecha2+"' group by fec_sur";
		rset = stmt.executeQuery(qry_cant_pzs); 
		while(rset.next())
		{
			fecha=rset.getString("fec_sur");
			int cont = 0, cont2=0;
			String qry_clasur="select dp.cla_pro from receta r, detreceta dr, bitacora bi, detalle_productos dp where r.id_rec = dr.id_rec and  r.id_rec = bi.id_rec AND dr.det_pro = dp.det_pro and bi.fec_carga BETWEEN '"+fecha+" 00:00:01' and '"+fecha+" 23:59:59' group by DAY(fec_carga), dp.cla_pro ;";
			rset2 = stmt2.executeQuery(qry_clasur); 
			while(rset2.next()){
				cont++;
			}
			%>
			<td style="text-align: right">
			<%=cont+cont2%>
			</td>
			<%
		}
		
		String qry_cant_pzsf="select dp.cla_pro from receta r, detreceta dr, bitacora bi, detalle_productos dp where r.id_rec = dr.id_rec and  r.id_rec = bi.id_rec AND dr.det_pro = dp.det_pro and bi.fec_carga BETWEEN '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59' group by dp.cla_pro ;";
		rset = stmt.executeQuery(qry_cant_pzsf); 
		while(rset.next()){
			tot_clavez_sol++;
		}
		
		int total_cla_soli=tot_clavez_sol;
		%>
        
        <td style="text-align: right"><strong><%=total_cla_soli%></strong></td>
        </tr>
        <%
		} catch(Exception e){
			out.println(e.getMessage());
		}
		%>
        
        <%
		try{
		%>
        <tr>
        <%
		int total_cla_no_sur=0, cont_nosur=0, cont4=0;
		String qry_cant_pzs1="select fec_sur from detreceta where fec_sur BETWEEN '"+fecha1+"' AND '"+fecha2+"' group by fec_sur";
		rset = stmt.executeQuery(qry_cant_pzs1); 
		while(rset.next())
		{
			fecha=rset.getString("fec_sur");
			int cont = 0, cont2=0, tot=0, cont3=0, cont5=0;
			String qry_clasur="select dp.cla_pro from receta r, detreceta dr, bitacora bi, detalle_productos dp where dr.status=0 and r.id_rec = dr.id_rec and  r.id_rec = bi.id_rec AND dr.det_pro = dp.det_pro and bi.fec_carga BETWEEN '"+fecha+" 00:00:01' and '"+fecha+" 23:59:59' group by DAY(fec_carga), dp.cla_pro ;";
			rset2 = stmt2.executeQuery(qry_clasur); 
			while(rset2.next()){
				cont++;
			}
			
			
			tot = (cont+cont5);
			%>
			<td style="text-align: right">
			<%=tot%>
           
			</td>
			<%
			//total_cla_no_sur += tot;
			//cont_nosur++;
		}
		int tot_clavez_nsol1=0, total_cla_nsol_c=0;
		String qry_cant_pzsnf="select dp.cla_pro from receta r, detreceta dr, bitacora bi, detalle_productos dp where dr.status=0 and r.id_rec = dr.id_rec and  r.id_rec = bi.id_rec AND dr.det_pro = dp.det_pro and bi.fec_carga BETWEEN '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59' group by dp.cla_pro ;";
		rset = stmt.executeQuery(qry_cant_pzsnf); 
		while(rset.next()){
			tot_clavez_nsol1++;
		}
		
		int total_cla_nos=tot_clavez_nsol1+total_cla_nsol_c;
		%>
        <td style="text-align: right"><strong><%=total_cla_nos%></strong></td>
        </tr>
        <%
		} catch(Exception e){
			out.println(e.getMessage());
		}
		%>
        
        
        
        
        <%
		try{
		%>
        <%
		String qry_tot_rece="select fec_sur from detreceta  where fec_sur BETWEEN '"+fecha1+"' AND '"+fecha2+"' group by fec_sur";
		%>
        <tr>
		<%
        int tot_rec_sol = 0;
        rset = stmt.executeQuery(qry_tot_rece); 
        while(rset.next()){
			fecha=rset.getString("fec_sur"); 
			int tot_folios=0;
			String qry_pzsur_col="select r.id_rec from bitacora bi, receta r where bi.fec_carga between '"+fecha+" 00:00:01' and '"+fecha+" 23:59:59' and r.baja = '0' and r.id_rec = bi.id_rec group by id_rec";
			rset2 = stmt2.executeQuery(qry_pzsur_col); 
			while(rset2.next()){
				tot_folios++;
        	}
        %>
        <td style="text-align: right"><%=tot_folios%></td>
        <%
        	tot_rec_sol+=tot_folios;
        }
        %>
        
        <td style="text-align: right"><strong><%=tot_rec_sol%></strong></td>
        </tr>
        <%
		} catch(Exception e){
			out.println(e.getMessage());
		}
		%>
       
       
        <%
		try{
		%>
		<%
        String qry_sur="select fec_sur from detreceta  where fec_sur BETWEEN '"+fecha1+"' AND '"+fecha2+"' group by fec_sur";
        %>
        <tr>
		<%
        int tot_rec_100 = 0, tot_rec_par= 0;
        rset = stmt.executeQuery(qry_sur); 
        while(rset.next())
        {
			int r_rf=0, r_no=0, r_parcial=0;
			fecha=rset.getString("fec_sur"); 
			
			String qry_surno="select r.id_rec from bitacora bi, receta r where bi.fec_carga between '"+fecha+" 00:00:01' and '"+fecha+" 23:59:59' and r.baja = '0' and r.id_rec = bi.id_rec group by id_rec";
			rset2 = stmt2.executeQuery(qry_surno); 
			while(rset2.next()){
				r_rf++;
			}
        
        
			qry_surno="select r.id_rec from bitacora bi, receta r, detreceta dr where r.id_rec = dr.id_rec and dr.status='0' and r.baja='0'  and bi.fec_carga between '"+fecha+" 00:00:01' and '"+fecha+" 23:59:59' and r.id_rec = bi.id_rec group by id_rec";
			rset2 = stmt2.executeQuery(qry_surno); 
			while(rset2.next()){
				r_no++;
			}
        
       		r_parcial= r_rf - r_no;
		%>
        <td style="text-align: right"><%=r_parcial%> // <%=r_no%></td>
        <%
        	tot_rec_100+=r_parcial;
        	tot_rec_par+=r_no;
        }
        %>
		<td style="text-align: right"><strong><%=(tot_rec_100)%>//<%=tot_rec_par%></strong></td>
        </tr>
        <%
		} catch(Exception e){
			out.println(e.getMessage());
		}
		%>
        
        
        
        <%
		try{
		%>
		<%
        String qry_por="select sum(can_sol) as sol, sum(cant_sur) as sur, bi.fec_carga from receta r, detreceta dr, bitacora bi where r.id_rec = dr.id_rec and  r.id_rec = bi.id_rec AND bi.fec_carga BETWEEN '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59' group by DAY(fec_carga) ;";
        %>
        <tr>
        <%
        int c_dias=0;
        float total_por=0;
        rset = stmt.executeQuery(qry_por); 
        while(rset.next())
        {
			cant_sol=rset.getString("sol"); 
			cant_sur=rset.getString("sur"); 
			fecha=rset.getString("fec_carga"); 
			
			if (cant_sol_col==null)
			cant_sol_col="0";
			
			if (cant_sur_col==null)
			cant_sur_col="0";
			
			float sol_d=Integer.parseInt(cant_sol);
			float sur_d=Integer.parseInt(cant_sur);
			float sol_d_col=Integer.parseInt(cant_sol_col);
			float sur_d_col=Integer.parseInt(cant_sur_col);
			
			float tot_f=((sur_d+sur_d_col)*100)/(sol_d+sol_d_col);
			
			%>
			<td style="text-align: right"><%=tot_f%> %</td>
			<%
			c_dias++;
			total_por += tot_f;
        }	
        float tot_porc = 0;
        if ( c_dias == 0){
        	tot_porc = 0;
        } else {
        	tot_porc = (total_por/c_dias);
        }
        
        %>
        <td style="text-align: right"><strong><%=tot_porc%> %</strong></td>
        </tr>
        <%
		} catch(Exception e){
			out.println(e.getMessage());
		}
		%>
        
        
        <%
		try{
		%>
        <tr>
        <%
		int tot_pzs_sol=0;
		String qry_fecha1="select sum(cant_sur) as sur, bi.fec_carga from receta r, detreceta dr, bitacora bi where r.id_rec = dr.id_rec and  r.id_rec = bi.id_rec AND bi.fec_carga BETWEEN '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59' group by DAY(fec_carga) ;";
		rset = stmt.executeQuery(qry_fecha1); 
		while(rset.next())
		{
		  cant_sol=rset.getString("sur");
		  fecha=rset.getString("fec_carga");
		  
		  if (cant_sol_col==null){
			cant_sol_col="0";
		  }
		  sol = Integer.parseInt(cant_sol);
		  sol_col=Integer.parseInt(cant_sol_col);
		  total_sol=sol+sol_col;
		  %>
		  <td style="text-align: right"><%=total_sol%></td>
		  <%
		  tot_pzs_sol += total_sol;
		}
		%>
        <td style="text-align: right"><strong><%=tot_pzs_sol%></strong></td>
        </tr>
        <%
		} catch(Exception e){
			out.println(e.getMessage());
		}
		%>
        
        
        
        <%
		try{
		%>
        <tr>
		<%
		float tot_ventas=0;
        String qry_fecha2="SELECT p.cos_pro, dr.cant_sur, sum(p.cos_pro * dr.cant_sur) as sum FROM detreceta dr, detalle_productos dp, productos p, receta r, bitacora bi where dr.id_rec = r.id_rec and r.id_rec = bi.id_rec and dr.det_pro = dp.det_pro AND dp.cla_pro = p.cla_pro and bi.fec_carga between '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59' group by DAY(bi.fec_carga) asc;";
        rset = stmt.executeQuery(qry_fecha2); 
        while(rset.next())
        {
		  float precio = Float.parseFloat(rset.getString("sum"));
          %>
          <td style="text-align: right">$ <%=forma.format(precio)%></td>
          <%
		  tot_ventas += precio;
        }
        %>
        <td style="text-align: right"><strong>$ <%=forma.format(tot_ventas)%></strong></td>
        </tr>
        <%
		} catch(Exception e){
			out.println(e.getMessage());
		}
		%>
        
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
