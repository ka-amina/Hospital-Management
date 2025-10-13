<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 10/13/2025
  Time: 1:10 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title><%= request.getAttribute("id") == null ? "New" : "Edit" %> Speciality</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
<div class="max-w-2xl mx-auto px-4 py-8">
    <div class="bg-white rounded-lg shadow p-6">
        <h2 class="text-xl font-semibold mb-4"><%= request.getAttribute("id") == null ? "Create" : "Edit" %>
            Speciality</h2>

        <c:if test="${not empty error}">
            <div class="mb-4 text-red-600 font-medium">${error}</div>
        </c:if>

        <form method="post">
            <div class="mb-4">
                <label class="block text-gray-700 mb-1">Code</label>
                <input type="text" name="code" value="${dto.code}" required
                       class="w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500">
            </div>
            <div class="mb-4">
                <label class="block text-gray-700 mb-1">Name</label>
                <input type="text" name="nom" value="${dto.nom}" required
                       class="w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500">
            </div>
            <div class="mb-4">
                <label class="block text-gray-700 mb-1">Description</label>
                <textarea name="description" rows="3"
                          class="w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500">${dto.description}</textarea>
            </div>
            <div class="mb-6">
                <label class="block text-gray-700 mb-1">Department</label>
                <select name="departmentId" required
                        class="w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500">
                    <c:forEach items="${departments}" var="d">
                        <option value="${d.id}" ${dto.departmentId eq d.id ? 'selected' : ''}>${d.nom}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="flex items-center justify-between">
                <a href="${pageContext.request.contextPath}/admin/dashboard"
                   class="px-4 py-2 rounded-md bg-gray-200 text-gray-800 hover:bg-gray-300 transition">Cancel</a>
                <button type="submit"
                        class="px-4 py-2 rounded-md bg-indigo-600 text-white hover:bg-indigo-700 transition">
                    Save
                </button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
