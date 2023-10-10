package com.example.VehicleReservationSystem;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ReservationServlet
 */
@WebServlet("/reservation")
public class ReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String location = request.getParameter("location");
        String vehicle_no = request.getParameter("registrationNumber");
        String mileage = request.getParameter("currentMileage");
        String message = request.getParameter("message");
        String uname = request.getParameter("username");
        //String email = request.getParameter("email");
        //String phone = request.getParameter("contactNumber");
        RequestDispatcher dispatcher = null;
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://51.132.137.223:3306/isec_assessment2?useSSL=false","isec","EUHHaYAmtzbv");
            //con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/isec_assessment2?useSSL=false","root","mysql");
            PreparedStatement pst = con.prepareStatement("insert into vehicle_service(username,date,time,location,vehicle_no,mileage,message) values(?,?,?,?,?,?,?)");
            //PreparedStatement pst = con.prepareStatement("insert into vehicle_service(username,email,phone,date,time,location,vehicle_no,mileage,message) values(?,?,?,?,?,?,?,?,?)");

            pst.setString(2, date);
            pst.setString(3, time);
            pst.setString(4, location);
            pst.setString(5, vehicle_no);
            pst.setString(6, mileage);
            pst.setString(7, message);
            pst.setString(1, uname);
            //pst.setString(2, email);
            //pst.setString(3, phone);

            int rowCount = pst.executeUpdate();
            dispatcher = request.getRequestDispatcher("reservation.jsp");
            if(rowCount>0) {
                request.setAttribute("status", "success");
            }else {
                request.setAttribute("status", "failed");
            }
            dispatcher.forward(request, response);
        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            try {
                con.close();
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }

}