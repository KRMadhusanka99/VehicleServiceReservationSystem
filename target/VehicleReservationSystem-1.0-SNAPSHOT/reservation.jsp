<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 10/3/2023
  Time: 11:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="io.asgardeo.java.saml.sdk.util.SSOAgentConstants" %>
<%@ page import="io.asgardeo.java.saml.sdk.bean.LoggedInSessionBean" %>
<%@ page import="io.asgardeo.java.saml.sdk.bean.LoggedInSessionBean.SAML2SSO" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Retrieve the session bean.
    LoggedInSessionBean sessionBean = (LoggedInSessionBean) session.getAttribute(SSOAgentConstants.SESSION_BEAN_NAME);

    // SAML response
    SAML2SSO samlResponse = sessionBean.getSAML2SSO();

    // Autheticated username
    String subjectId = samlResponse.getSubjectId();

    // Authenticated user's attributes
    Map<String, String> saml2SSOAttributes = samlResponse.getSubjectAttributes();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Vehicle Reservation</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>
<%
    String username = null;
    String email = null;
    String mobile = null;
    String fname = null;
    String lname = null;
    if (saml2SSOAttributes != null) {
        for (Map.Entry<String, String> entry : saml2SSOAttributes.entrySet()) {
            String attributeName = entry.getKey();
            String attributeValue = entry.getValue();
            if ("http://wso2.org/claims/username".equals(attributeName)) {
                username = attributeValue;
            }
            else if ("http://wso2.org/claims/emailaddress".equals(attributeName)) {
                email = attributeValue;
            }
            else if ("http://wso2.org/claims/mobile".equals(attributeName)) {
                mobile = attributeValue;
            }
            else if ("http://wso2.org/claims/givenname".equals(attributeName)) {
                fname = attributeValue;
            }
            else if ("http://wso2.org/claims/lastname".equals(attributeName)) {
                lname = attributeValue;
            }
        }
    }
%>
<input type="hidden" id="status" value="<%= request.getAttribute("status") %>">
<div class="container">
    <h1>Service Reservation</h1>
    <div class="card">
        <div class="card-body">

            <form action="reservation" method="post">

                <div class="form-group row">
                    <label for="username" class="col-sm-2 col-form-label">Username</label>
                    <div class="col-sm-7">
                        <input id="username" type="text" class="form-control" name="username" required="required" value=<%=username%> >
                    </div>
                </div>

                <div class="form-group row">
                    <label for="name" class="col-sm-2 col-form-label">Name</label>
                    <div class="col-sm-7">
                        <input id="name" type="text" class="form-control" name="name" required="required" value=<%=fname%>&nbsp;<%=lname%>>
                    </div>
                </div>

                <div class=" form-group row">
                    <label for="email" class="col-sm-2 col-form-label">Email</label>
                    <div class="col-sm-7">
                        <input id="email" type="email" class="form-control" name="email" required="required" value=<%=email%>>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="contactNumber" class="col-sm-2 col-form-label">Contact Number</label>
                    <div class="col-sm-7">
                        <input id="contactNumber" type="tel" class="form-control" name="contactNumber" required="required" value=<%=mobile%>>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="date" class="col-sm-2 col-form-label">Date</label>
                    <div class="col-sm-7">
                        <input id="date" type="date" class="form-control" name="date" required="required">
                    </div>
                </div>

                <div class="form-group row">
                    <label for="time" class="col-sm-2 col-form-label">Preferred time</label>
                    <div class="col-sm-7">
                        <input id="time" type="time" class="form-control" name="time" required="required">
                    </div>
                </div>

                <div class="form-group row">
                    <label for="location" class="col-sm-2 col-form-label">Preferred location</label>
                    <div class="col-sm-7">
                        <select id="location" class="form-control" name="location" required="required">
                                <option value="">Select district</option>
                                <option value="Ampara">Ampara District</option>
                                <option value="Anuradhapura">Anuradhapura District</option>
                                <option value="Badulla">Badulla District</option>
                                <option value="Batticaloa">Batticaloa District</option>
                                <option value="Colombo">Colombo District</option>
                                <option value="Galle">Galle District</option>
                                <option value="Gampaha">Gampaha District</option>
                                <option value="Hambantota">Hambantota District</option>
                                <option value="Jaffna">Jaffna District</option>
                                <option value="Kalutara">Kalutara District</option>
                                <option value="Kandy">Kandy District</option>
                                <option value="Kegalle">Kegalle District</option>
                                <option value="Kilinochchi">Kilinochchi District</option>
                                <option value="Mannar">Mannar District</option>
                                <option value="Matale">Matale District</option>
                                <option value="Matara">Matara District</option>
                                <option value="Monaragala">Monaragala District</option>
                                <option value="Mullaitivu">Mullaitivu District</option>
                                <option value="Nuwara Eliya ">Nuwara Eliya District</option>
                                <option value="Polonnaruwa">Polonnaruwa District</option>
                                <option value="Puttalam">Puttalam District</option>
                                <option value="Ratnapura">Ratnapura district</option>
                                <option value="Trincomalee">Trincomalee District</option>
                                <option value="Vavuniya">Vavuniya District</option>
                        </select>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="registrationNumber" class="col-sm-2 col-form-label">Vehicle Registration Number</label>
                    <div class="col-sm-7">
                        <input id="registrationNumber"  type="text" class="form-control" required="required"
                               name="registrationNumber" placeholder="XX1234">
                    </div>
                </div>

                <div class="form-group row">
                    <label for="currentMileage" class="col-sm-2 col-form-label">Current Mileage</label>
                    <div class="col-sm-7">
                        <input id="currentMileage" type="text" class="form-control" required="required"
                               name="currentMileage" placeholder="Enter current mileage">
                    </div>
                </div>

                <div class="form-group row">
                    <label for="message" class="col-sm-2 col-form-label">Message</label>
                    <div class="col-sm-7">
                        <textarea id="message" type="text" class="form-control" name="message" required="required"
                                  placeholder="Enter your message"></textarea>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary" >Register</button>
                <a href='home.jsp' class="btn btn-primary" >Back to home</a>
            </form>
        </div>
    </div>
</div>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="alert/dist/sweetalert.css">

<script type="text/javascript">

    var status = document.getElementById("status").value;
    if(status == "success"){
        swal("Congrats","Reservation Added Successfully","success");
    }
    if(status == "empty"){
        swal("Wrong","Please fill all fields","error");
    }
    if(status == "invaliduser"){
        swal("Wrong","Invalid Username","error");
    }
    if(status == "invalidno"){
        swal("Wrong","Invalid Vehicle Number","error");
    }
    if(status == "invalidmileage"){
        swal("Wrong","Incorrect mileage","error");
    }
    if(status == "invalidmessage"){
        swal("Wrong","Incorrect message","error");
    }
    if(status == "invaliddate"){
        swal("Wrong","Incorrect date","error");
    }
    if(status == "invalidtime"){
        swal("Wrong","Incorrect time","error");
    }
    if(status == "invalidlocation"){
        swal("Wrong","Incorrect location","error");
    }
</script>
</body>
</html>
