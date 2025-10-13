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
<html lang="en" class="h-full">
<head>
    <meta charset="utf-8">
    <title><%= request.getAttribute("id") == null ? "New" : "Edit" %> Department</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {darkMode: 'class'};
        (function () {
            const saved = localStorage.getItem('dark');
            const initial = saved === 'true' || (!saved && window.matchMedia('(prefers-color-scheme: dark)').matches);
            if (initial) document.documentElement.classList.add('dark');
        })();
    </script>
</head>
<body class="bg-gray-100 dark:bg-gray-900 text-gray-800 dark:text-gray-200">

<!-- ===== TOP BAR (matches dashboard) ===== -->
<header class="flex items-center justify-between px-6 py-4 bg-white dark:bg-gray-800 shadow">
    <a href="${pageContext.request.contextPath}/admin/dashboard"
       class="flex items-center space-x-2 text-indigo-600 dark:text-indigo-400 font-semibold">
        <i class="fa-solid fa-arrow-left"></i>
        <span>Back to Dashboard</span>
    </a>
    <button id="themeToggle" class="p-2 rounded-full hover:bg-gray-200 dark:hover:bg-gray-700">
        <i class="fa-solid fa-sun text-yellow-500 dark:hidden"></i>
        <i class="fa-solid fa-moon text-slate-300 hidden dark:inline"></i>
    </button>
</header>

<!-- ===== FORM CARD ===== -->
<div class="max-w-2xl mx-auto px-4 py-8">
    <div class="bg-white dark:bg-gray-800 rounded-lg shadow p-6">
        <h2 class="text-xl font-semibold mb-4">
            <%= request.getAttribute("id") == null ? "Create" : "Edit" %> Department
        </h2>

        <c:if test="${not empty error}">
            <div class="mb-4 text-red-600 dark:text-red-400 font-medium">${error}</div>
        </c:if>

        <form method="post">
            <div class="mb-4">
                <label class="block mb-1">Code</label>
                <input type="text" name="code" value="${dto.code}" required
                       class="w-full px-3 py-2 border dark:border-gray-600 dark:bg-gray-700 rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500">
            </div>
            <div class="mb-4">
                <label class="block mb-1">Name</label>
                <input type="text" name="nom" value="${dto.nom}" required
                       class="w-full px-3 py-2 border dark:border-gray-600 dark:bg-gray-700 rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500">
            </div>
            <div class="mb-6">
                <label class="block mb-1">Description</label>
                <textarea name="description" rows="4"
                          class="w-full px-3 py-2 border dark:border-gray-600 dark:bg-gray-700 rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500">${dto.description}</textarea>
            </div>

            <div class="flex items-center justify-between">
                <a href="${pageContext.request.contextPath}/admin/dashboard"
                   class="px-4 py-2 rounded-md bg-gray-200 dark:bg-gray-700 text-gray-800 dark:text-gray-200 hover:bg-gray-300 dark:hover:bg-gray-600 transition">
                    Cancel
                </a>
                <button type="submit"
                        class="px-4 py-2 rounded-md bg-indigo-600 text-white hover:bg-indigo-700 transition">
                    Save
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    document.getElementById('themeToggle').addEventListener('click', () => {
        document.documentElement.classList.toggle('dark');
        localStorage.setItem('dark', document.documentElement.classList.contains('dark'));
    });
</script>
</body>
</html>
