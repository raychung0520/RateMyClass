<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="evaluation.EvaluationDTO" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<!doctype html>

<html>

  <head>

    <title>Rate My Class</title>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/custom.css">

  </head>

  <body>
  
  <%
  
  	request.setCharacterEncoding("UTF-8");
  	String lectureDivide = "overall";
  	String searchType = "latest";
  	String search = "";
  	int pageNumber = 0;
  	
  	if(request.getParameter("lectureDivide") != null){
  		
  		lectureDivide = request.getParameter("lectureDivide");
  		
  	}
  	if(request.getParameter("searchType") != null){
  		
  		searchType = request.getParameter("searchType");
  		
  	}
  	if(request.getParameter("search") != null){
  		
  		search = request.getParameter("search");
  		
  	}
  	if(request.getParameter("pageNumber") != null){
  		
  		try{
  			
  			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
  			
  		}catch(Exception e){
  			
  			System.out.println("Search function went wrong");
  		}
  		
  	}
  	
  
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
  		
  	}
  	
  	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
  	if(emailChecked == false){
  		PrintWriter script = response.getWriter();
  		script.println("<script>");
  		script.println("location.href = 'emailSendConfirm.jsp';");
  		script.println("</script>");
  		script.close();
  	}

  %>
  
  

    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <a class="navbar-brand" href="index.jsp">Rate My Class</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbar">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item active">
            <a class="nav-link" href="index.jsp">Main</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">

              Members
              
            </a>

          <div class="dropdown-menu" aria-labelledby="dropdown">
<%
            if(userID == null){
%>
              <a class="dropdown-item" href="userLogin.jsp">Login</a>
              <a class="dropdown-item" href="userRegister.jsp">Register</a>

<%
            }else {
%>
              <a class="dropdown-item" href="userLogout.jsp">Logout</a>
              
              
<%
            }
%>
      
            </div>
          </li>
        </ul>
        <form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
          <input type="text" name="search" class="form-control mr-sm-2" placeholder="Search">
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
      </div>
    </nav>

    <div class="container">
      <form method="get" action="./index.jsp" class="form-inline mt-3">
        <select name="lectureDivide" class="form-control mx-1 mt-2">
          <option value="all">All</option>
          <option value="major" <% if(lectureDivide.equals("major")) out.println("selected"); %>>Major</option>
          <option value="ge" <% if(lectureDivide.equals("ge")) out.println("selected"); %>>GE</option>
          <option value="etc" <% if(lectureDivide.equals("etc")) out.println("selected"); %>>Etc</option>
        </select>
                
        <select name="lectureDivide" class="form-control mx-1 mt-2">
          <option value="latest">latest</option>
          <option value="like" <% if(searchType.equals("like")) out.println("selected"); %>>Like</option>
        </select>
        
        <input type="text" name="search" class="form-control mx-1 mt-2" placeholder="Search">
        <button type="submit" class="btn btn-primary mx-1 mt-2">Search</button>
        <a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">Post</a>
        <a class="btn btn-danger ml-1 mt-2" data-toggle="modal" href="#reportModal">Report</a>

      </form>
        
<%

	ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
	evaluationList = new EvaluationDAO().getList(lectureDivide, searchType, search, pageNumber);
	if(evaluationList != null)
	for(int i = 0; i < evaluationList.size(); i++) {
		
		if(i == 5) 
			break;

		EvaluationDTO evaluation = evaluationList.get(i);
%>
      <div class="card bg-light mt-3">
        <div class="card-header bg-light">
          <div class="row">
          <div class="col-8 text-left"><%=evaluation.getLectureName()%>&nbsp;<small><%=evaluation.getProfessorName()%></small>
            <div class="col-4 text-right">
             Overall <span style="color: red;"><%= evaluation.getTotalScore() %></span>
            </div>
          </div>
        </div>
        <div class="card-body">
          <h5 class="card-title">
            <%= evaluation.getEvaluationTitle() %>&nbsp;<small>(<%= evaluation.getLectureYear() %>)</small>
          </h5>
          <p class="card-text"><%= evaluation.getEvaluationContent() %></p>
          <div class="row">
            <div class="col-9 text-left">
              Grade <span style="color: red;"><%= evaluation.getCreditScore() %></span>
              Easiness <span style="color: red;"><%= evaluation.getComfortableScore() %></span>
              Helpful <span style="color: red;"><%= evaluation.getLectureScore() %></span>
              <span style="color: green;">(Like:<%= evaluation.getLikeCount() %>)</span>
            </div>
            <div class="col-3 text-right">
              <a onclick="return confirm('Like the post?')" href="./likeAction.jsp?evaluationID=<%=evaluation.getEvaluationID()%>">Like</a>
              <a onclick="return confirm('Delete the post?')" href="./deleteAction_re.jsp?evaluationID=<%=evaluation.getEvaluationID()%>">Delete</a>
              
            </div>
          </div>
        </div>
      </div>
         <%
    		} 
    %>
     
    <ul class="pagination justify-content-center mt-3">
      <li class="page-item">
<%

	if(pageNumber <= 0) {

%>     
        <a class="page-link disabled">Prev</a>
<%

	} else {

%>
		<a class="page-link" href="./index.jsp?lectureDivide=<%=URLEncoder.encode(lectureDivide, "UTF-8")%>&searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber - 1%>">Prev</a>
<%
	}

%>
      </li>
      <li class="page-item">

<%

	if(evaluationList.size() < 6) {
%>     

        <a class="page-link disabled">Next</a>

<%

	} else {

%>

		<a class="page-link" href="./index.jsp?lectureDivide=<%=URLEncoder.encode(lectureDivide, "UTF-8")%>&searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber + 1%>">Next</a>

<%

	}

%>

      </li>
    </ul>

    <div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
    	    <h5 class="modal-title" id="modal">Post</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form action="evaluationRegisterAction.jsp" method="post">
              <div class="form-row">
                <div class="form-group col-sm-6">
                  <label>Class Title</label>
                  <input type="text" name="lectureName" class="form-control" maxlength="20">
                </div>
                <div class="form-group col-sm-6">
                  <label>Professor Name</label>
                  <input type="text" name="professorName" class="form-control" maxlength="20">
                </div>
              </div>
              <div class="form-row">
                <div class="form-group col-sm-4">
                  <label>Year</label>
                  <select name="lectureYear" class="form-control">
                    <option value="2011">2011</option>
                    <option value="2012">2012</option>
                    <option value="2013">2013</option>
                    <option value="2014">2014</option>
                    <option value="2015">2015</option>
                    <option value="2016">2016</option>
                    <option value="2017">2017</option>
                    <option value="2018">2018</option>
                    <option value="2019" selected>2019</option>
                    <option value="2020">2020</option>
                    <option value="2021">2021</option>
                    <option value="2022">2022</option>
                    <option value="2023">2023</option>
                  </select>
                </div>
                <div class="form-group col-sm-4">

                  <label>Semester</label>
                  <select name="semesterDivide" class="form-control">
                    <option name="spring" selected>Spring</option>
                    <option name="summer">Summer</option>
                    <option name="fall">2Fall</option>
                    <option name="winter">Winter</option>
                  </select>
                </div>

                <div class="form-group col-sm-4">
                  <label>Classification</label>
                  <select name="lectureDivide" class="form-control">
                    <option name="major" selected>Major</option>
                    <option name="ge">GE</option>
                    <option name="etc">etc</option>
                  </select>

                </div>

              </div>

              <div class="form-group">
                <label>Title</label>
                <input type="text" name="evaluationTitle" class="form-control" maxlength="20">
              </div>
              <div class="form-group">
                <label>Content</label>
                <textarea type="text" name="evaluationContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
              </div>
              <div class="form-row">
                <div class="form-group col-sm-3">
                  <label>Overall</label>
                  <select name="totalScore" class="form-control">
                    <option value="A" selected>A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                    <option value="F">F</option>
                  </select>
                </div>
                <div class="form-group col-sm-3">
                  <label>Grade</label>
                  <select name="creditScore" class="form-control">
                    <option value="A" selected>A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                    <option value="F">F</option>
                  </select>
                </div>

                <div class="form-group col-sm-3">
                  <label>Easiness</label>
                  <select name="comfortableScore" class="form-control">
                    <option value="A" selected>A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                    <option value="F">F</option>
                  </select>
                </div>
                <div class="form-group col-sm-3">
                  <label>Helpful</label>
                  <select name="lectureScore" class="form-control">
                    <option value="A" selected>A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                    <option value="F">F</option>
                  </select>
                </div>
              </div>
              <div class="modal-footer">

                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>

                <button type="submit" class="btn btn-primary">Post</button>

              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    <div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="modal">Report</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form method="post" action="./reportAction.jsp">
              <div class="form-group">
                <label>Report Title</label>
                <input type="text" name="reportTitle" class="form-control" maxlength="20">
              </div>
              <div class="form-group">
                <label>Report Content</label>
                <textarea type="text" name="reportContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-danger">Report</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    <footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">

      Copyright ¨Ï 2019 Rate My Class , Ray Chung All Rights Reserved.
    </footer>


    <script src="./js/jquery.min.js"></script>
    <script src="./js/popper.min.js"></script>
    <script src="./js/bootstrap.min.js"></script>

  </body>

</html>


