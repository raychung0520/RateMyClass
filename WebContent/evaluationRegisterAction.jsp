<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%

	request.setCharacterEncoding("UTF-8");

	String userID = null;
	
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	
	
  	if(userID == null){
		
  		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Please Login');");
		script.println("location.href='userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
  		
  	}

	String lectureName = null;
	String professorName= null;
	int lectureYear = 0;
	String semesterDivide= null;
	String lectureDivide= null;
	String evaluationTitle= null;
	String evaluationContent= null;
	String totalScore= null;
	String creditScore= null;
	String comfortableScore= null;
	String lectureScore= null;


	if(request.getParameter("lectureName") != null) {

		lectureName = (String) request.getParameter("lectureName");

	}

	if(request.getParameter("professorName") != null) {

		professorName = (String) request.getParameter("professorName");

	}

	if(request.getParameter("lectureYear") != null) {
		try{
			
			lectureYear = Integer.parseInt(request.getParameter("lectureYear"));
		}catch(Exception e){
			System.out.println("강의연도오류");
		}
		
	}
	if(request.getParameter("semesterDivide") != null) {

		semesterDivide = (String) request.getParameter("semesterDivide");

	}
	if(request.getParameter("lectureDivide") != null) {

		lectureDivide = (String) request.getParameter("lectureDivide");

	}
	if(request.getParameter("evaluationTitle") != null) {

		evaluationTitle = (String) request.getParameter("evaluationTitle");

	}
	if(request.getParameter("evaluationContent") != null) {

		evaluationContent = (String) request.getParameter("evaluationContent");

	}
	if(request.getParameter("totalScore") != null) {

		totalScore = (String) request.getParameter("totalScore");

	}
	if(request.getParameter("creditScore") != null) {

		creditScore = (String) request.getParameter("creditScore");

	}
	if(request.getParameter("comfortableScore") != null) {

		comfortableScore = (String) request.getParameter("comfortableScore");

	}
	if(request.getParameter("lectureScore") != null) {

		lectureScore = (String) request.getParameter("lectureScore");

	}
	
	System.out.println(semesterDivide + " " + lectureDivide + " "+ evaluationTitle + "  " + evaluationContent + " "
			+ totalScore);
	

	if (userID == null ||lectureName == null ||professorName == null || lectureYear == 0 || semesterDivide== null  || lectureDivide == null
			|| evaluationTitle == null || evaluationContent == null ||totalScore == null || creditScore == null
			|| comfortableScore == null || lectureScore == null) {

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('All inputs are required');");
		script.println("history.back();");
		script.println("</script>");
		script.close();

	} else {
		
		EvaluationDAO evaluationDAO = new EvaluationDAO();
		int result = evaluationDAO.write(new EvaluationDTO(0, userID, lectureName, professorName,lectureYear , semesterDivide
				, lectureDivide, evaluationTitle, evaluationContent, totalScore, creditScore, comfortableScore,lectureScore, 0));

		if (result == -1) {

			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Failed posting');");
			script.println("history.back();");
			script.println("</script>");
			script.close();

		} else {

			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'index.jsp';");
			script.println("</script>");
			script.close();

		}

	}

%>


