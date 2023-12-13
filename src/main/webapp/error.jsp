<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            color: #fff; 
            margin: 0;
            padding: 0;
        }

        .error-container {
            max-width: 600px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #7e57c2; 
        }

        p {
            margin-bottom: 20px;
            color: #333; 
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #7e57c2; 
            color: #fff;
            text-decoration: none;
            border-radius: 3px;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>Oops! Something went wrong.</h1>
        <p>We're sorry, but an unexpected error occurred. Please try again later.</p>
        <a href="Home.jsp" class="btn">Back to Home</a>
    </div>
</body>
</html>
