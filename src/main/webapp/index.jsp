<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hospital Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            background: white;
            padding: 50px;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            text-align: center;
            max-width: 500px;
        }

        h1 {
            color: #667eea;
            margin-bottom: 20px;
        }

        .btn {
            display: inline-block;
            padding: 15px 30px;
            margin: 10px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            transition: background 0.3s;
        }

        .btn:hover {
            background: #764ba2;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>🏥 Hospital Management System</h1>
    <p>Welcome to the Digital Clinic Management Application</p>
    <hr>
    <a href="test" class="btn">📋 Test Application</a>
    <a href="db-test" class="btn">🔍 Test Database</a>
</div>
</body>
</html>