<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 10/13/2025
  Time: 12:55 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en" class="h-full">
<head>
    <meta charset="utf-8">
    <title>Admin Dashboard – Clinic Management</title>
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

    <!-- Close btn (mobile only) -->
    <div class="flex justify-end p-3 md:hidden">
        <button onclick="toggleSidebar()" class="text-gray-500 dark:text-gray-400">
            <i class="fa-solid fa-times"></i>
        </button>
    </div>

    <!-- Logo / Title -->
    <div class="flex items-center space-x-3 px-4 h-16 border-b dark:border-gray-700">
        <i class="fa-solid fa-hospital text-xl text-indigo-600 dark:text-indigo-400"></i>
        <span class="sidebar-text whitespace-nowrap font-semibold text-lg">Clinic</span>
    </div>

    <!-- Nav -->
    <nav class="px-2 py-4 space-y-2">
        <a href="#" onclick="openTab('dept'); hideOnMobile()"
           class="flex items-center space-x-3 px-3 py-2 rounded-md hover:bg-indigo-50 dark:hover:bg-gray-700 text-indigo-600 dark:text-indigo-400 font-semibold">
            <i class="fa-solid fa-building-user w-5 text-center"></i>
            <span class="sidebar-text whitespace-nowrap">Departments</span>
        </a>
        <a href="#" onclick="openTab('spec'); hideOnMobile()"
           class="flex items-center space-x-3 px-3 py-2 rounded-md hover:bg-indigo-50 dark:hover:bg-gray-700">
            <i class="fa-solid fa-stethoscope w-5 text-center"></i>
            <span class="sidebar-text whitespace-nowrap">Specialities</span>
        </a>

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
        <!-- hamburger (mobile) -->
        <button onclick="toggleSidebar()" class="md:hidden text-gray-600 dark:text-gray-300">
            <i class="fa-solid fa-bars"></i>
        </button>
        <h1 class="text-xl font-semibold">Admin Dashboard</h1>
    </div>

    <button id="themeToggle" class="p-2 rounded-full hover:bg-gray-200 dark:hover:bg-gray-700">
        <i class="fa-solid fa-sun text-yellow-500 dark:hidden"></i>
        <i class="fa-solid fa-moon text-slate-300 hidden dark:inline"></i>
    </button>
</header>

<!-- ========== MAIN CONTENT ========== -->
<main class="md:ml-16 p-6">
    <!-- Departments panel -->
    <div id="dept-panel" class="tab-panel">
        <!-- same content as previous dashboard.jsp -->
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-2xl font-semibold">Departments</h2>
            <a href="${pageContext.request.contextPath}/admin/departments/new"
               class="px-4 py-2 rounded-md bg-green-600 text-white hover:bg-green-700 text-sm">
                <i class="fa-solid fa-plus mr-2"></i>New Department
            </a>
        </div>

        <div class="overflow-x-auto bg-white dark:bg-gray-800 rounded-lg shadow">
            <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                <thead class="bg-gray-50 dark:bg-gray-700 text-gray-600 dark:text-gray-300 text-sm uppercase tracking-wider">
                <tr>
                    <th class="px-6 py-3 text-left">Code</th>
                    <th class="px-6 py-3 text-left">Name</th>
                    <th class="px-6 py-3 text-left">Description</th>
                    <th class="px-6 py-3 text-center">Actions</th>
                </tr>
                </thead>
                <tbody class="divide-y divide-gray-200 dark:divide-gray-700 text-sm">
                <c:forEach items="${departments}" var="d">
                    <tr>
                        <td class="px-6 py-4 font-medium">${d.code}</td>
                        <td class="px-6 py-4">${d.nom}</td>
                        <td class="px-6 py-4 text-gray-600 dark:text-gray-400">${d.description}</td>
                        <td class="px-6 py-4 text-center space-x-2">
                            <a href="${pageContext.request.contextPath}/admin/departments/edit?id=${d.id}"
                               class="inline-flex items-center px-3 py-1.5 rounded-md bg-yellow-500 text-white hover:bg-yellow-600">
                                <i class="fa-solid fa-pen-to-square mr-1"></i>Edit
                            </a>
                            <form action="${pageContext.request.contextPath}/admin/departments/delete" method="post"
                                  class="inline"
                                  onsubmit="return confirm('Delete this department?');">
                                <input type="hidden" name="id" value="${d.id}">
                                <button class="inline-flex items-center px-3 py-1.5 rounded-md bg-red-600 text-white hover:bg-red-700">
                                    <i class="fa-solid fa-trash mr-1"></i>Delete
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Specialities panel -->
    <div id="spec-panel" class="tab-panel hidden">
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-2xl font-semibold">Specialities</h2>
            <a href="${pageContext.request.contextPath}/admin/specialities/new"
               class="px-4 py-2 rounded-md bg-green-600 text-white hover:bg-green-700 text-sm">
                <i class="fa-solid fa-plus mr-2"></i>New Speciality
            </a>
        </div>

        <div class="overflow-x-auto bg-white dark:bg-gray-800 rounded-lg shadow">
            <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                <thead class="bg-gray-50 dark:bg-gray-700 text-gray-600 dark:text-gray-300 text-sm uppercase tracking-wider">
                <tr>
                    <th class="px-6 py-3 text-left">Code</th>
                    <th class="px-6 py-3 text-left">Name</th>
                    <th class="px-6 py-3 text-left">Department</th>
                    <th class="px-6 py-3 text-center">Actions</th>
                </tr>
                </thead>
                <tbody class="divide-y divide-gray-200 dark:divide-gray-700 text-sm">
                <c:forEach items="${specialities}" var="s">
                    <tr>
                        <td class="px-6 py-4 font-medium">${s.code}</td>
                        <td class="px-6 py-4">${s.nom}</td>
                        <td class="px-6 py-4">${s.departmentName}</td>
                        <td class="px-6 py-4 text-center space-x-2">
                            <a href="${pageContext.request.contextPath}/admin/specialities/edit?id=${s.id}"
                               class="inline-flex items-center px-3 py-1.5 rounded-md bg-yellow-500 text-white hover:bg-yellow-600">
                                <i class="fa-solid fa-pen-to-square mr-1"></i>Edit
                            </a>
                            <form action="${pageContext.request.contextPath}/admin/specialities/delete" method="post"
                                  class="inline"
                                  onsubmit="return confirm('Delete this speciality?');">
                                <input type="hidden" name="id" value="${s.id}">
                                <button class="inline-flex items-center px-3 py-1.5 rounded-md bg-red-600 text-white hover:bg-red-700">
                                    <i class="fa-solid fa-trash mr-1"></i>Delete
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</main>

<!-- ========== JS ========== -->
<script>
    /* ----- sidebar ----- */
    function toggleSidebar() {
        document.getElementById('sidebar').classList.toggle('-translate-x-full');
    }

    function hideOnMobile() {
        if (window.innerWidth < 768) toggleSidebar();
    }

    /* ----- tabs ----- */
    function openTab(tab) {
        document.querySelectorAll('.tab-panel').forEach(p => p.classList.add('hidden'));
        document.querySelectorAll('.tab-link').forEach(l => {
            l.classList.remove('text-indigo-600', 'dark:text-indigo-400', 'font-semibold');
        });
        document.getElementById(tab + '-panel').classList.remove('hidden');
        event.currentTarget.classList.add('text-indigo-600', 'dark:text-indigo-400', 'font-semibold');
    }

    /* ----- theme ----- */
    document.getElementById('themeToggle').addEventListener('click', () => {
        document.documentElement.classList.toggle('dark');
        localStorage.setItem('dark', document.documentElement.classList.contains('dark'));
    });
</script>

<style>
    /* smooth width transition */
    #sidebar {
        transition: width .3s
    }

    .sidebar-text {
        opacity: 0;
        transition: opacity .2s
    }

    #sidebar:hover .sidebar-text {
        opacity: 1
    }

    @media (min-width: 768px) {
        #sidebar:hover ~ header,
        #sidebar:hover ~ main {
            margin-left: 16rem; /* same width the sidebar grows to */
            transition: margin-left .3s; /* keep the animation smooth */
        }
    }
</style>
</body>
</html>