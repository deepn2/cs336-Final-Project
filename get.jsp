<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
	    	String car = (String)request.getParameter("`make/model`");
	    	String city =(String)request.getParameter("`city/town`");
	    	String type =(String)request.getParameter("type");
	    	String age =(String)request.getParameter("age");
	    	int atr1=1;
	    	int atr2=1;
	    	if(type.equals("22")){
	    		atr1=12;
	    	}else if(type.equals("17")){
	    		atr1=9;
	    	}else if(type.equals("12")){
	    		atr1=5;
	    	}
	    	
	    	if(age.equals("100")){
	    		atr2=240;
	    	}else if(age.equals("80")){
	    		atr2=180;
	    	}else if(age.equals("40")){
	    		atr2=140;
	    	}else if(type.equals("25")){
	    		atr2=125;
	    	}else if(type.equals("20")){
	    		atr2=100;
	    	}else if(type.equals("15")){
	    		atr2=85;
	    	}
	    	
	    	Random random = new Random();
	    	
	    	int total = atr1*atr2;
	    	total+=17+1;
	    	
	    	out.print("Based on our data, your approximate insurance premium would be: $"+total+" per year, ie. $"+(total/12)+" per month");
		    
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