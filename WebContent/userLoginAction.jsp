<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%

	request.setCharacterEncoding("UTF-8");
	String userID = null;
	String userPassword = null;
	String userEmail = null;
	
	if(request.getParameter("userID") != null) {

		userID = (String) request.getParameter("userID");

	}
 
	if(request.getParameter("userPassword") != null) {

		userPassword = (String) request.getParameter("userPassword");

	}


	

	if (userID == null || userPassword == null) {

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('All inputs required');");
		script.println("history.back();");
		script.println("</script>");
		script.close();

	} else {
	

		UserDAO userDAO = new UserDAO();
		String inputPassword = new SHA256().getSHA256(userPassword);

		int result = userDAO.login(userID, inputPassword);
	
		if (result == 1) {
			
			session.setAttribute("userID", userID);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='index.jsp'");
			script.println("</script>");
			System.out.println("@@@@@");
			script.close();

		

		} else if(result == 0){

			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Invalid Password');");
			script.println("history.back()");
			script.println("</script>");
			script.close();

		}else if(result == -1){

			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Invalid ID');");
			script.println("history.back()");
			script.println("</script>");
			script.close();

		}else if(result == -2){

			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Somthing went wrong');");
			script.println("history.back()");
			script.println("</script>");
			script.close();

		}

	}

%>


