<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.io.PrintWriter"%>
<%@page import="evaluation.EvaluationDAO"%>
<%@page import="likey.LikeyDTO"%>
<%@page import="user.UserDAO" %>


<%
	//Checking whether userID is null
	String userID = null;

	if(session.getAttribute("userID") != null) {

		userID = (String) session.getAttribute("userID");

	}

	if(userID == null) {

		PrintWriter script = response.getWriter();
	
		script.println("<script>");
	
		script.println("alert('Please Signin');");
	
		script.println("location.href = 'userLogin.jsp'");
	
		script.println("</script>");
	
		script.close();

	}


	request.setCharacterEncoding("UTF-8");
	
	String evaluationID = null;
	
	if(request.getParameter("evaluationID") != null) {
	
		evaluationID = (String) request.getParameter("evaluationID");
	
	}
	
	
	EvaluationDAO evaluationDAO = new EvaluationDAO();
	System.out.println(evaluationDAO.getUserID(evaluationID) + " " + userID);
	
	
	
	if(userID.equals(evaluationDAO.getUserID(evaluationID))) {
		
		int result = new EvaluationDAO().delete(evaluationID);
	
			if (result == 1) {
				session.setAttribute("userID", userID);
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('Delete the post successfully');");
				script.println("location.href='index.jsp'");
				script.println("</script>");
				script.close();
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('Something goes wrong');");
				script.println("history.back();");
				script.println("</script>");
				script.close();
			}
		} else {
	
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('You can delete the post you wrote');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
		}
%>