<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.util.Random,java.sql.Time" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%      

	try {

	    	//Create a connection string
			//String url = "jdbc:mysql://localhost:3306/your_db";
	    	String url = "jdbc:mysql://cs336final.cqmmn85plgcy.us-east-1.rds.amazonaws.com:3306/cs336final";
	    	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		    Class.forName("com.mysql.jdbc.Driver");

	    	//Create a connection to your DB
		    //Connection con = DriverManager.getConnection(url, "csuser", "your_pwd");
		    Connection con = DriverManager.getConnection(url, "cs336", "finalproject");
	    	//Create a SQL statement
		    Statement stmt = con.createStatement();
	    	//Populate SQL statement with an actual query. It returns a single number. The number of beers in the DB.
		    String str = "SELECT COUNT(*) as cnt FROM driver_table";
	    	
	    	//Run the query against the DB
		    ResultSet result = stmt.executeQuery(str);
	    	
	    	//Start parsing out the result of the query. Don't forget this statement. It opens up the result set.
		    result.next();
	    	
		    //Parse out the result of the query
		    int countDriver = result.getInt("cnt");
		    
		   
 			String str2 = "SELECT COUNT(*) as cnt FROM location_time_table";
	    	//Run the query against the DB
		    ResultSet result2 = stmt.executeQuery(str2);
	    	//Start parsing out the result of the query. Don't forget this statement. It opens up the result set.
		    result2.next();
		    //Parse out the result of the query
		    int countLocation = result2.getInt("cnt");
		    //Populate SQL statement with an actual query. It returns a single number. The number of beers in the DB.
		    String str3 = "SELECT COUNT(*) as cnt FROM car_table";
		    //Run the query against the DB
		    ResultSet result3 = stmt.executeQuery(str3);
		    //Start parsing out the result of the query. Don't forget this statement. It opens up the result set.
		    result3.next();
		    //Parse out the result of the query
		    int countAccidents = result3.getInt("cnt");
		    
		    //Get parameters from the HTML form at the HelloWorld.jsp
		    String newMakeModel = request.getParameter("`make/model`");
		    String newCarYear = request.getParameter("year");
		    String newSafetyRating= request.getParameter("safety_rating");
		    String newAccidentHistory = request.getParameter("accident_history");
		    String newAge =request.getParameter("age");
		    String newStreet =request.getParameter("street");
		    String newDUI = request.getParameter("DUI");
		    String newGender = request.getParameter("gender");
		    String newDay = request.getParameter("day");
		    String newMonth = request.getParameter("month");
		    String newYear = request.getParameter("year2");
		    String newCity=request.getParameter("`city/town`");
		    String newDate = newMonth+"-"+newDay+"-"+newYear;
		    final Random random = new Random();
		    final int millisInDay = 24*60*60*1000;
		    Time newTime = new Time((long)random.nextInt(millisInDay));
		    int newAccidentID = random.nextInt(1000000)+80863;
		    
		    //Make an insert statement for the Sells table:
		    String insert = "INSERT INTO car_table(`make/model`, year,safety_rating,accident_id )" +
	                  "VALUES (?, ?, ?, ?)";
		    
		    String insert2 = "INSERT INTO driver_table(age, gender,accident_history,DUI,accident_id )" +
	                  "VALUES (?, ?, ?, ?, ?)";
		    
		    String insert3 = "INSERT INTO location_time_table(street, `city/town`,date,time, accident_id )" +
	                  "VALUES (?, ?, ?, ?, ?)";
		    
		    //Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);
	
			PreparedStatement ps2 = con.prepareStatement(insert2);
			PreparedStatement ps3 = con.prepareStatement(insert3);
			

		    //Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, newMakeModel);
			ps.setString(2, newCarYear);
			ps.setString(3, newSafetyRating);
			ps.setInt(4,newAccidentID);
			
			ps2.setString(1, newAge);
			ps2.setString(2, newGender);
			ps2.setString(3, newAccidentHistory);
			ps2.setString(4,newDUI);
			ps2.setInt(5,newAccidentID);
			
			ps3.setString(1, newStreet);
			ps3.setString(2, newCity);
			ps3.setString(3, newDate);
			ps3.setString(4,newTime.toString());
			ps3.setInt(5,newAccidentID);
			//Run the query against the DB
			ps.executeUpdate();
			ps2.executeUpdate();
			ps3.executeUpdate();
			
			//Check counts once again (the same as the above)
		    String query = "SELECT COUNT(*) as cnt FROM car_table";
		    ResultSet set1 = stmt.executeQuery(query);
		    set1.next();
		    int countAccidentsN = set1.getInt("cnt");
		    String query2 = "SELECT COUNT(*) as cnt FROM driver_table";
		    ResultSet set2 = stmt.executeQuery(query2);
		    set2.next();
		    int countDriverN = set2.getInt("cnt");
		    String query3 = "SELECT COUNT(*) as cnt FROM location_time_table";
		    ResultSet set3 = stmt.executeQuery(query3);
		    set3.next();
		    int countLocationN = set3.getInt("cnt");
		    //Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		    con.close();
		    
		    //Compare counts of the beers and bars before INSERT on Sells and after to figure out whether there is a bar and a beer stub records inserted by a trigger. 
		    int updateCarTable = (countAccidents != countAccidentsN) ? 1 : 0;
		    int updateDriverTable = (countDriver != countDriverN) ? 1 : 0;
		    int updateLocationTable = (countLocation != countLocationN) ? 1 : 0;
		
		    if((updateCarTable >0) && (updateDriverTable >0) && (updateLocationTable>0)){
		    	out.print("Succesfully inserted!");
		    }
		    /* if (updateBeer > 0)
		    {
		    	//Create a dynamic HTML form for beer update if needed. The form is not going to show up if the beer specified at HelloWorld.jsp already exists in the database.
		    	out.print("Beer " + newBeer + " details: <br>");
		    	out.print("<form method=\"post\" action=\"newBeerDetails.jsp\">"+
		    			  "<table> <tr>	<td>Manf</td><td><input type=\"text\" name=\"manufacturer\"></td>   	</tr>"+
						  "</table> <br>" );
		    }
		    
		    if (updateBar > 0)
		    {
		    	//Create a dynamic HTML form for bar update if needed. The form is not going to show up if the bar  specified at HelloWorld.jsp already exists in the database..
		    	//The form goes inside the HTML table too make alignment of the elements prettier.
		    	//See show.jsp for clear notation of the HTML table and HelloWorld.jsp for clear notation of the HTML form
		    	out.print("Bar " + newBar + " details: <br>");
		    	out.print("<table> <tr>	<td>Address</td><td><input type=\"text\" name=\"addr\"></td>   	</tr>"+
		    			  " 	<tr>  	<td>License</td><td><input type=\"text\" name=\"license\"></td> 	</tr>"+
		    			  "	<tr>  	<td>City</td><td><input type=\"text\" name=\"city\"></td> 	</tr>"+
		    			  "	<tr>  	<td>Phone</td><td><input type=\"text\" name=\"phone\"></td> 	</tr>"+
		    			  "</table> <br> <input type=\"submit\" value=\"submit\">" +
		    			  //use hidden inputs to pass the new beer and new bar keys as well as requiresUpdate flags to the update page.
		    			  "<input type=\"hidden\" name=\"bar\" value=\"" + newBar + "\"/>" + 
		    			  "<input type=\"hidden\" name=\"beer\" value=\"" + newBeer + "\"/>" +
		    			  "<input type=\"hidden\" name=\"ubar\" value=\"" + Integer.toString(updateBar) + "\"/>" + 
				    	  "<input type=\"hidden\" name=\"ubeer\" value=\"" + Integer.toString(updateBeer) + "\"/>" +
		    			  "</form>");
		    } */
		    
		    out.print("insert succeeded");
	} catch (Exception ex) {
		ex.printStackTrace();
		out.print("insert failed");
	}
	
	
%>
</body>
</html>