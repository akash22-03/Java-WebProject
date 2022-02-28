<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.entities.User" %>
<%@page errorPage="error_page.jsp" %>
<% 
    User user = (User) session.getAttribute("currentUser");
    if(user==null){
        response.sendRedirect("login_page.jsp");
    }
%>
<%
    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao d = new PostDao(ConnectionProvider.getConnection());
    Post p = d.getPostByPostId(postId);
    
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= p.getpTitle() %> || TechBlog</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner{
                clip-path: polygon(50% 0%, 100% 0, 100% 89%, 75% 100%, 40% 84%, 0 100%, 0 0); 
                /*Designed using bennettfeely.com/clippy/ */
            }
            .post-title{
                font-weight: 100;
                font-size: 30px;
            }
            .post-content{
                font-weight: 100;
                font-size: 20px;
            }
            .post-image{
                
            }
            .post-date{
                font-style: italic;
                font-weight: bold;
            }
            .post-user-info{
                font-size: 20px;
                font-weight: 300;
            }
            .row-user{
                border: 1px solid #e2e2e2;
                padding-top: 15px;
            }
            body{
                background: url(img/bg.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
        <a class="navbar-brand" href="index.jsp"><span class="fa fa-audio-description"></span>  Akash</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
              <a class="nav-link" href="profile.jsp">BBRTech.com <span class="sr-only">(current)</span></a>
            </li>

            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="	fa fa-code"></span> Categories
              </a>
              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                <a class="dropdown-item" href="#">Programming Language</a>
                <a class="dropdown-item" href="#">Project Implementation</a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#">Data Structure</a>
              </div>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#"><span class="fa fa-address-card-o"></span> Contact</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-asterisk"></span> Post</a>
            </li>
            
          </ul>
            <ul class="navbar-nav mr-right">
                <li class="nav-item">
                    <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle"></span> <%=user.getName()%></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="LogoutServlet"><span class="fa fa-user-circle"></span> LogOut</a>
                </li>
            </ul>
        </div>
      </nav>
                <!-- end of navbar -->
                
                
                <!-- main content -->
                <div class="container">
                    <div class="row my-4">
                        <div class="col-md-8 offset-md-2">
                            <div class="card">
                                <div class="card-header primary-background text-white">
                                    <h4 class="post-title"><%= p.getpTitle() %></h4>
                                </div>
                                <div class="card-body">
                                    <img class="card-img-top mt-2 post-image" src="bolgpics/<%= p.getpPic() %>" alt="Card image cap">
                                    <div class="row my-3 row-user">
                                        <div class="col-md-8">
                                            <% 
                                                UserDao ud = new UserDao(ConnectionProvider.getConnection());
                                            %>
                                            <p class="post-user-info"><a href="#"><%= ud.getUserByUserId(p.getUserId()).getName() %></a> has posted:</p>
                                        </div>
                                        <div class="col-md-4">
                                            <p class="post-date"><%= DateFormat.getDateTimeInstance().format(p.getpDate()) %></p>
                                        </div>
                                    </div>
                                    <p class="post-content"><%= p.getpContent() %></p>
                                    <br><br>
                                    <div class="post-code">
                                         <pre><%= p.getpCode() %></pre>
                                    </div>
                                </div>
                                <div class="card-footer primary-background ">
                                    <%
                                        LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                                    %>
                                        <a href="#!" onClick="doLike(<%= p.getPid() %>,<%= user.getId() %>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter">  <%=ld.countLikeOnPost(p.getPid()) %> </span></a>
                                    <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span> 2</span></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--end of main content -->
                
                
                <!-- start of profile modal -->
            <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">My Profile</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                  <div class="modal-body">
                      <div class="container text-center">
                          <img src="pics/<%= user.getProfile() %>" class="img-fluid" style="border-radius:50%; max-width: 150px;"><br>
                          <h5 class="modal-title mt-3" id="exampleModalLabel"><%=user.getName() %></h5>
                          <div id="profile-details">
                              <table class="table">
                                <tbody>
                                  <tr>
                                    <th scope="row">ID :</th>
                                    <td><%=user.getId() %></td>
                                  </tr>
                                  <tr>
                                    <th scope="row">Email :</th>
                                    <td><%=user.getEmail() %></td>
                                  </tr>
                                  <tr>
                                    <th scope="row">Gender :</th>
                                    <td><%=user.getGender() %></td>
                                  </tr>
                                  <tr>
                                    <th scope="row">Status :</th>
                                    <td><%=user.getAbout() %></td>
                                  </tr>
                                  <tr>
                                    <th scope="row">Registered On :</th>
                                    <td><%=user.getDateTime().toString() %></td>
                                  </tr>
                                </tbody>
                              </table>
                          </div>
                          <!-- profile edit-->
                          <div id="profile-edit" style="display:none;">
                              <h3 class="mt-2">Please edit carefully</h3>
                              <form action="EditServlet" method="POST" enctype="multipart/form-data">
                                  <!--enctype="multipart/form-data" for image/audio/video -->
                                  <table class="table">
                                      <tr>
                                        <td>ID :</td>
                                        <td><%=user.getId() %></td>
                                      </tr>
                                      <tr>
                                        <td>Email :</td>
                                        <td><input type="email" class="form-control" name ="user_email" value=" <%=user.getEmail() %>"></td>
                                      </tr>
                                      <tr>
                                        <td>Name :</td>
                                        <td><input type="text" class="form-control" name="user_name" value="<%= user.getName() %>"></td>
                                      </tr>
                                      <tr>
                                        <td>Password:</td>
                                        <td><input type="password" class="form-control" name="user_password" value="<%= user.getPassword() %>"></td>
                                      </tr>
                                      <tr>
                                        <th scope="row">Gender :</th>
                                        <td><%=user.getGender() %></td>
                                      </tr>
                                      <tr>
                                        <th>About :</th>
                                        <td><textarea rows="3" class="form-control" name="user_about"><%= user.getAbout()%></textarea></td>
                                        </tr>
                                        <tr>
                                        <th scope="row">Profile Pic :</th>
                                        <td><input type="file" name="image" class="form-control"></td>
                                      </tr>
                                  </table>
                                <div class="container">
                                    <button type="submit" class="btn btn-outline-primary">Save</button>
                                </div>
                              </form>
                          </div>
                      </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" id="edit-profile-button" class="btn btn-primary">Edit</button>
                  </div>
                </div>
              </div>
            </div>
        <!-- end of profile modal -->
        
        <!-- start of post modal -->
            <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Post Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                  <div class="modal-body">
                      <form id="add-post-form" action ="AddPostServlet" method="POST">
                          <div class="form-group">
                              <select class="form-control" name="cid">
                                    <option selected disabled>---Select Category---</option>
                                    <% 
                                        PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                        ArrayList<Category> list = postd.getAllCategories();
                                        for(Category c : list){
                                        %>
                                        <option value="<%= c.getCid() %>"><%= c.getName() %></option>
                                        <%
                                        }
                                    %>
                                </select>
                          </div>
                          <div class="form-group">
                              <input type="text" name="pTitle" class="form-control" placeholder="Enter Post Title" />
                               
                          </div>
                          <div class="form-group">
                              <textarea class="form-control" name="pContent" style="height:200px;" placeholder="Enter your content  "></textarea>
                          </div>
                          <div class="form-group">
                              <textarea class="form-control" name="pCode" style="height:200px;" placeholder="Enter your program(if any)  "></textarea>
                          </div>
                          <div class="form-group">
                              <label>Select your picture</label><br>
                              <input type="file" name="pic"/>
                          </div>
                            <div class="container text-center">
                                <button type="submit" class="btn btn-outline-primary">Post</button>
                            </div>
                      </form>
                  </div>
                  
                </div>
              </div>
            </div>
                                
        <!-- end of post modal -->
        
        <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
    </body>
</html>
