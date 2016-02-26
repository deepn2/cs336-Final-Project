<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%      
	List<String> list = new ArrayList<String>();

	try {



	    	//Create a connection string
			//String url = "jdbc:mysql://your_VM:3306/your_db";
	    	String url = "jdbc:mysql://cs336final.cqmmn85plgcy.us-east-1.rds.amazonaws.com:3306/cs336final";
	    	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		    Class.forName("com.mysql.jdbc.Driver");
	    
	    	//Create a connection to your DB
		   // Connection con = DriverManager.getConnection(url, "csuser", "your_pwd");
		    Connection con = DriverManager.getConnection(url, "cs336", "finalproject");
	    	//Create a SQL statement
		    Statement stmt = con.createStatement();
	    		String day = (String)request.getParameter("day");
		    	String month = (String)request.getParameter("month");
		    	String year = (String)request.getParameter("year");
		    	String day2 = (String)request.getParameter("day2");
		    	String month2 = (String)request.getParameter("month2");
		    	String year2 = (String)request.getParameter("year2");
		    	String date = month+"-"+day+"-"+year;
		    	String date2 = month2+"-"+day2+"-"+year2;
	    	String city = (String)request.getParameter("`city/town`");
	    	
	    	String[] queries; 
	    	queries = request.getParameterValues("id");
	    	String selectstmt=" ";
	    	selectstmt+="a." +"accident_id" +",";
	    	%> 
	    	<TABLE BORDER="1" WIDTH ="100%" > 
	    	<TR> <TH>Accident ID</TH> <% 
	    	if(queries!=null){
	    		 for(int i=0; i<queries.length;i++){
	    		 if(queries[i].equals("`make/model`"))
	    				 {
	    			 %>	 
	                     <TH>Make/Model</TH> 
	                 <%
	                 selectstmt+="a."+queries[i]+",";
	    				 }
				else if (queries[i].equals("year"))
					{
					%> <TH>Year Manufactured</TH> <% 
					selectstmt+="a."+queries[i]+",";
					}
	    		 
				else if (queries[i].equals("safety_rating"))
				{
					%> <TH>Safety Rating</TH> <% 
					selectstmt+="a."+queries[i]+",";
				}
				
	    		else if(queries[i].equals("accident_history")) {
	    			%> <TH>Accident History</TH> <% 
	    			 selectstmt+="b."+queries[i]+","; 
	    		}
	    		else if(queries[i].equals("DUI")){ 
	    			%> <TH>DUI</TH> <%
	    			 selectstmt+="b."+queries[i]+","; 
	    			}
	    		else if(queries[i].equals("gender")){
	    			%> <TH>Gender</TH> <%
	    			selectstmt+="b."+queries[i]+","; 
	    		}
	    		else if((queries[i].equals("age"))){
	    			%> <TH>Age</TH> <%
	    			selectstmt+="b."+queries[i]+","; 
	    		}
	    		
	    		 else if(queries[i].equals("street")) {
	    			 %> <TH>Street</TH> <%
	    			 selectstmt+="c."+queries[i]+",";
	    		 }
	    		 else if(queries[i].equals("`city/town`")){
	    			 %> <TH>City/Town</TH> <%
	    			 selectstmt+="c."+queries[i]+",";
	    		 }
	    		 else if(queries[i].equals("time")){ 
	    			 %> <TH>Time</TH> <%
		    			selectstmt+="c."+queries[i]+",";
		    		}
	    		}
	    	}   else{
	    		out.print("No attributes selected...");
	    	}
	    	if (selectstmt.length() > 0 && selectstmt.charAt(selectstmt.length()-1)==',') {
	    	      selectstmt = selectstmt.substring(0, selectstmt.length()-1);
	    	    }
	    		 
	    	
	    	//Make a SELECT query from the table specified by the 'command' parameter at the HelloWorld.jsp
			String	str = "SELECT "+selectstmt+" FROM car_table a, driver_table b, location_time_table c WHERE ((a.accident_id = b.accident_id) AND (c.accident_id=b.accident_id)AND(c.date between '"+date+"' AND '"+date2+"')"+"AND(c.`city/town`='"+city+"'));";
	    	
			//Run the query against the database.
	    	ResultSet result = stmt.executeQuery(str);
	    	
		   ResultSetMetaData metadata = result.getMetaData();
	    	//int i=0;
		    //parse out the results
		   
		    
 while(result.next()) {
		    	%>
		    	
						<TR>
						<% 
						for(int i =1; i<= metadata.getColumnCount();i++)
						{ %>
		                    <TD> <%= result.getString(i) %> </TD>
		                    </TD>
		                    <%} %>
		          
		                </TR>
		                <%}%>
		                
		            </TABLE>
		         <% 
		    
		    //close the connection.
		    con.close();

	} catch (Exception e) {
		e.printStackTrace();
	}
	
	
	
%>
<!-- <script type="text/javascript">
    // ref: http://stackoverflow.com/a/1293163/2343
    // This will parse a delimited string into an array of
    // arrays. The default delimiter is the comma, but this
    // can be overriden in the second argument.
    function CSVToArray( strData, strDelimiter ){
        // Check to see if the delimiter is defined. If not,
        // then default to comma.
        strDelimiter = (strDelimiter || ",");

        // Create a regular expression to parse the CSV values.
        var objPattern = new RegExp(
            (
                // Delimiters.
                "(\\" + strDelimiter + "|\\r?\\n|\\r|^)" +

                // Quoted fields.
                "(?:\"([^\"]*(?:\"\"[^\"]*)*)\"|" +

                // Standard fields.
                "([^\"\\" + strDelimiter + "\\r\\n]*))"
            ),
            "gi"
            );


        // Create an array to hold our data. Give the array
        // a default empty first row.
        var arrData = [[]];

        // Create an array to hold our individual pattern
        // matching groups.
        var arrMatches = null;


        // Keep looping over the regular expression matches
        // until we can no longer find a match.
        while (arrMatches = objPattern.exec( strData )){

            // Get the delimiter that was found.
            var strMatchedDelimiter = arrMatches[ 1 ];

            // Check to see if the given delimiter has a length
            // (is not the start of string) and if it matches
            // field delimiter. If id does not, then we know
            // that this delimiter is a row delimiter.
            if (
                strMatchedDelimiter.length &&
                strMatchedDelimiter !== strDelimiter
                ){

                // Since we have reached a new row of data,
                // add an empty row to our data array.
                arrData.push( [] );

            }

            var strMatchedValue;

            // Now that we have our delimiter out of the way,
            // let's check to see which kind of value we
            // captured (quoted or unquoted).
            if (arrMatches[ 2 ]){

                // We found a quoted value. When we capture
                // this value, unescape any double quotes.
                strMatchedValue = arrMatches[ 2 ].replace(
                    new RegExp( "\"\"", "g" ),
                    "\""
                    );

            } else {

                // We found a non-quoted value.
                strMatchedValue = arrMatches[ 3 ];

            }


            // Now that we have our value string, let's add
            // it to the data array.
            arrData[ arrData.length - 1 ].push( strMatchedValue );
        }

        // Return the parsed data.
        return( arrData );
    }

</script>
(function() {

    var csv_path = "data/sample.csv",

    var renderCSVDropdown = function(csv) {
        var dropdown = $('select#my-dropdown');
        for(var i = 0; i < csv.length; i++) {
            var record = csv[i];
            var entry = $('<option>').attr('value', record.someProperty);
            dropdown.append(entry);
        }
    };

    $.get( https://drive.google.com/open?id=0B87B1QbRsOAXVS14NzBoYnJQNEU, function(data) {
        var csv = CSVToArray(data);
        renderCSVDropdown(csv);
    });

}()); -->
</body>
</html>