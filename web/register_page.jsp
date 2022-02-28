<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner{
                clip-path: polygon(50% 0%, 100% 0, 100% 89%, 75% 100%, 40% 84%, 0 100%, 0 0); 
                /*Designed using bennettfeely.com/clippy/ */
            }
        </style>
    </head>
    <body>
    <%@include file="normal_navbar.jsp" %>
    <main class="primary-background" style="padding-bottom:80px">
        <div class="container">
            <div class="col-md-6 offset-md-3">
                <div class="card">
                    <div class="card-header primary-background text-white text-center">
                        <span class="fa fa-3x fa-user-plus"></span>
                        <br>
                        Register here
                    </div>
                    <div class="card-body">
                        <form id="reg-form" action="RegisterServlet" method="POST">
                            <div class="form-group">
                              <label for="user_name">User Name</label>
                              <input type="text" name="user_name" class="form-control" id="user_name" aria-describedby="emailHelp" placeholder="Enter name">
                            </div>
                            <div class="form-group">
                              <label for="exampleInputEmail1">Email address</label>
                              <input type="email" name="user_email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                              <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                            </div>
                            <div class="form-group">
                              <label for="exampleInputPassword1">Password</label>
                              <input type="password" name="user_password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                            </div>
                            <div class="form-group">
                              <label for="gender">Select Gender     </label>
                              <input type="radio" id="gender" name="gender" value="male">  Male
                              <input type="radio" id="gender" name="gender" value="female">  Female
                            </div>
                            <div class="form-group">
                                <textarea name="about" class="form-control" id="" rows="5" placeholder="Tell us something about you"></textarea>
                            </div>
                            <div class="form-check">
                              <input type="checkbox" name="check" class="form-check-input" id="exampleCheck1">
                              <label class="form-check-label" for="exampleCheck1">Agree Terms and Conditions</label>
                            </div><br>
                            <div class="container text-center" id="loader" style="display:none">
                                <span class="fa fa-refresh fa-spin "></span>
                                <h4>Please wait...</h4>
                            </div>
                            
                            <button id="submit-btn" type="submit" class="btn btn-primary">Submit</button>
                        </form>                       
                    </div>              
                </div>
            </div>
        </div>
    </main>
        <!-- javascripts -->
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script>   
            $(document).ready(function(){
                console.log("ready....");
                $('#reg-form').on('submit',function(event){
                    event.preventDefault();
                    let form = new FormData(this);
                    $("#submit-btn").hide();
                    $("#loader").show();
                    //send register servlet
                    $.ajax({
                       url:"RegisterServlet",
                       type:'POST',
                       data:form,
                       success:function(data,textStatus,jqXHR){
                           console.log(data);
                           $("#submit-btn").show();
                           $("#loader").hide();
                           if(data.trim()==='done'){
                                swal("Registered Successfully")
                                .then((value) => {
                                window.location="login_page.jsp";
                                });
                           }else{
                               swal(data);
                           }
                           
                       },
                       error:function(jqXHRm ,textStatus, errorThrown){
                           console.log(jqXHR);
                           $("#submit-btn").show();
                           $("#loader").hide();
                           swal("Something went again..try again")
                       },
                       processData:false,
                       contentType:false
                    });
                });
            });
        </script>
    </body>
</html>
