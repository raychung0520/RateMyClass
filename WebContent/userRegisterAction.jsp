<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%

	request.setCharacterEncoding("UTF-8");
	String userID = null;
	
	if(session.getAttribute("userID") != null){
		
		userID = (String) session.getAttribute("userID");
	}
	
	
  	if(userID != null){
  		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Your are logged in');");
		script.println("location.href='index.jsp';");
		script.println("</script>");
		script.close();
		return;
  		
  	}

	String userPassword = null;
	String userEmail = null;

	if(request.getParameter("userID") != null) {

		userID = (String) request.getParameter("userID");

	}

	if(request.getParameter("userPassword") != null) {

		userPassword = (String) request.getParameter("userPassword");

	}

	if(request.getParameter("userEmail") != null) {

		userEmail = (String) request.getParameter("userEmail");

	}

	if (userID == null || userPassword == null || userEmail == null) {

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('All inputs required');");
		script.println("history.back();");
		script.println("</script>");
		script.close();

	} else {
		
		UserDAO userDAO = new UserDAO();
		int result = userDAO.join(new UserDTO(userID, SHA256.getSHA256(userPassword), userEmail, SHA256.getSHA256(userEmail), false));

		if (result == -1) {

			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Username already exists');");
			script.println("history.back();");
			script.println("</script>");
			script.close();

		} else {

			PrintWriter script = response.getWriter();
			session=request.getSession();
			session.setAttribute("userID", userID);
			script.println("<script>");
			script.println("location.href = 'emailSendAction.jsp';");
			script.println("</script>");
			script.close();

		}

	}

%>


