<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.text.SimpleDateFormat" import="java.util.Date" import="java.text.ParsePosition" errorPage="" import ="java.awt.image.BufferedImage" import ="java.io.*" import ="javax.imageio.ImageIO" import ="net.sourceforge.jbarcodebean.*" import ="net.sourceforge.jbarcodebean.model.*" %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("HH:mm:ss"); %>
<% 
//  Conexión a la BDD -------------------------------------------------------------
Class.forName("org.gjt.mm.mysql.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
Statement stmt = con.createStatement();
ResultSet rset= null;
Statement stmt2 = con.createStatement();
ResultSet rset2= null;
JBarcodeBean barcode = new JBarcodeBean();
// fin objetos de conexión ------------------------------------------------------
String but="";
String fol_rec="", nom_pac="", car_pac="", sex_pac = "", fec_nac="", folio_sp="", med1="", med2="", cod_pac="";
String cla_uni="";


		try{
				 barcode.setCode("1234");
				 barcode.setCheckDigit(true);
				 BufferedImage bufferedImage = barcode.draw(new BufferedImage(100, 100, BufferedImage.TYPE_INT_RGB));
				 File file = new File("C://Archivos de Programa/Apache Group/Tomcat 4.1/webapps/rn_v12/cb/1234.png");
				 ImageIO.write(bufferedImage, "png", file);	
		}catch (Exception e) {
		out.println(e.getMessage());
		}
		%>