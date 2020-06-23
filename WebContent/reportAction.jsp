<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@page import="util.SHA256"%>
<%@page import="util.Gmail"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%

	UserDAO userDAO = new UserDAO();
	String userID = null;
	if(session.getAttribute("userID") != null) {

		userID = (String) session.getAttribute("userID");

	}
	System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + userID);

	if(userID == null) {

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Please Login');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;

	}

	request.setCharacterEncoding("UTF-8");
	String reportTitle = null;
	String reportContent = null;
	
	if(request.getParameter("reportTitle") != null) {

		reportTitle = (String) request.getParameter("reportTitle");

	}
	
	if(request.getParameter("reportContent") != null) {

		reportContent = (String) request.getParameter("reportContent");

	}
	
	if(reportTitle == null || reportContent == null){
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('All input are requried');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
		
	}

	String host = "http://localhost:8080/RateMyClass/";
	String from = "raychung0520@gmail.com";
	String to = userDAO.getUserEmail(userID);
	String subject = "The post has been report";
	String content = "User: " + userID + "<br>Title: " + reportTitle + "<br>Content: " + reportContent;  

	
	Properties p = new Properties();
	p.put("mail.smtp.user", from);
	p.put("mail.smtp.host", "smtp.googlemail.com");
	p.put("mail.smtp.port", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");

	try{

	    Authenticator auth = new Gmail();
	    Session ses = Session.getInstance(p, auth);
	    ses.setDebug(true);
	    MimeMessage msg = new MimeMessage(ses); 
	    msg.setSubject(subject);
	    Address fromAddr = new InternetAddress(from);
	    msg.setFrom(fromAddr);
	    Address toAddr = new InternetAddress(to);
	    msg.addRecipient(Message.RecipientType.TO, toAddr);
	    msg.setContent(content, "text/html;charset=UTF-8");
	    Transport.send(msg);

	} catch(Exception e){

	    e.printStackTrace();
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Something went wrong');");
		script.println("history.back();");
		script.println("</script>");
		script.close();		
	    return;

	}
	

	PrintWriter script = response.getWriter();

	script.println("<script>");
	script.println("alert('Report the post successfully');");
	script.println("history.back();");
	script.println("</script>");
	script.close();		
	

%>
