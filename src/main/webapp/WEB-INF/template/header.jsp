<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 10/15/2025
  Time: 1:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en" class="h-full">
<head>
    <meta charset="utf-8">
    <title><c:out value="${param.title}"/> – Clinic Management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script>
        tailwind.config = {darkMode: 'class'};
        (function () {
            const saved = localStorage.getItem('dark');
            const initial = saved === 'true' || (!saved && window.matchMedia('(prefers-color-scheme: dark)').matches);
            if (initial) document.documentElement.classList.add('dark');
        })();
    </script>
</head>
<body class="bg-gray-100 dark:bg-gray-900 text-gray-800 dark:text-gray-200 transition-colors">

<!-- ========== SIDEBAR ========== -->
<aside id="sidebar"
       class="fixed left-0 top-0 h-full
              md:w-16 md:hover:w-64 md:transition-width md:bg-white md:dark:bg-gray-800
              w-64 bg-white dark:bg-gray-800
              transform -translate-x-full md:translate-x-0
              shadow-lg z-40 overflow-hidden">

    <div class="flex justify-end p-3 md:hidden">
        <button onclick="toggleSidebar()" class="text-gray-500 dark:text-gray-400">
            <i class="fa-solid fa-times"></i>
        </button>
    </div>

    <div class="flex items-center space-x-3 px-4 h-16 border-b dark:border-gray-700">
        <i class="fa-solid fa-hospital text-xl text-indigo-600 dark:text-indigo-400"></i>
        <span class="sidebar-text whitespace-nowrap font-semibold text-lg">Clinic</span>
    </div>

    <nav class="px-2 py-4 space-y-2">
        <c:import url="/WEB-INF/template/sidebarLinks.jsp"/>
        <div class="pt-6">
            <a href="${pageContext.request.contextPath}/logout"
               class="flex items-center space-x-3 px-3 py-2 rounded-md hover:bg-red-50 dark:hover:bg-red-900/20 text-red-600 dark:text-red-400">
                <i class="fa-solid fa-right-from-bracket w-5 text-center"></i>
                <span class="sidebar-text whitespace-nowrap">Logout</span>
            </a>
        </div>
    </nav>
</aside>

<!-- ========== TOP BAR ========== -->
<header class="md:ml-16 flex items-center justify-between px-6 py-4 bg-white dark:bg-gray-800 shadow">
    <div class="flex items-center space-x-3">
        <button onclick="toggleSidebar()" class="md:hidden text-gray-600 dark:text-gray-300">
            <i class="fa-solid fa-bars"></i>
        </button>
        <h1 class="text-xl font-semibold"><c:out value="${param.title}"/></h1>
    </div>

    <button id="themeToggle" class="p-2 rounded-full hover:bg-gray-200 dark:hover:bg-gray-700">
        <i class="fa-solid fa-sun text-yellow-500 dark:hidden"></i>
        <i class="fa-solid fa-moon text-slate-300 hidden dark:inline"></i>
    </button>
</header>

<!-- ========== MAIN CONTENT ========== -->
<main class="md:ml-16 p-6">