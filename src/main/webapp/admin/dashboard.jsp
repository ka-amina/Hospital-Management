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
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Admin Dashboard – Clinic Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font-Awesome for tiny icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="bg-gray-100">

<!-- Top bar -->
<nav class="bg-indigo-700 text-white shadow">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-16">
            <div class="flex items-center space-x-3">
                <i class="fa-solid fa-hospital text-xl"></i>
                <span class="font-semibold text-lg">Admin Dashboard</span>
            </div>
            <a href="${pageContext.request.contextPath}/logout"
               class="px-3 py-2 rounded-md text-sm bg-indigo-800 hover:bg-indigo-900 transition">
                <i class="fa-solid fa-right-from-bracket mr-2"></i>Logout
            </a>
        </div>
    </div>
</nav>

<!-- Main container -->
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">

    <!-- Tab navigation -->
    <div class="border-b border-gray-200">
        <nav class="-mb-px flex space-x-8">
            <button data-tab="dept"
                    class="tab-button active-tab">
                <i class="fa-solid fa-building-user mr-2"></i>Departments
            </button>
            <button data-tab="spec"
                    class="tab-button">
                <i class="fa-solid fa-stethoscope mr-2"></i>Specialities
            </button>
        </nav>
    </div>

    <!-- Departments panel -->
    <div id="dept-panel" class="tab-panel mt-6">
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-xl font-semibold text-gray-700">Departments</h2>
            <a href="${pageContext.request.contextPath}/admin/departments/new"
               class="px-4 py-2 rounded-md bg-green-600 text-white hover:bg-green-700 transition text-sm">
                <i class="fa-solid fa-plus mr-2"></i>New Department
            </a>
        </div>

        <div class="overflow-x-auto bg-white rounded-lg shadow">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50 text-gray-600 text-sm uppercase tracking-wider">
                <tr>
                    <th class="px-6 py-3 text-left">Code</th>
                    <th class="px-6 py-3 text-left">Name</th>
                    <th class="px-6 py-3 text-left">Description</th>
                    <th class="px-6 py-3 text-center">Actions</th>
                </tr>
                </thead>
                <tbody class="divide-y divide-gray-200 text-sm">
                <c:forEach items="${departments}" var="d">
                    <tr>
                        <td class="px-6 py-4 font-medium text-gray-900">${d.code}</td>
                        <td class="px-6 py-4">${d.nom}</td>
                        <td class="px-6 py-4 text-gray-600">${d.description}</td>
                        <td class="px-6 py-4 text-center space-x-2">
                            <a href="${pageContext.request.contextPath}/admin/departments/edit?id=${d.id}"
                               class="inline-flex items-center px-3 py-1.5 rounded-md bg-yellow-500 text-white hover:bg-yellow-600 transition">
                                <i class="fa-solid fa-pen-to-square mr-1"></i>Edit
                            </a>
                            <form action="${pageContext.request.contextPath}/admin/departments/delete" method="post"
                                  class="inline"
                                  onsubmit="return confirm('Delete this department?');">
                                <input type="hidden" name="id" value="${d.id}">
                                <button class="inline-flex items-center px-3 py-1.5 rounded-md bg-red-600 text-white hover:bg-red-700 transition">
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
    <div id="spec-panel" class="tab-panel hidden mt-6">
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-xl font-semibold text-gray-700">Specialities</h2>
            <a href="${pageContext.request.contextPath}/admin/specialities/new"
               class="px-4 py-2 rounded-md bg-green-600 text-white hover:bg-green-700 transition text-sm">
                <i class="fa-solid fa-plus mr-2"></i>New Speciality
            </a>
        </div>

        <div class="overflow-x-auto bg-white rounded-lg shadow">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50 text-gray-600 text-sm uppercase tracking-wider">
                <tr>
                    <th class="px-6 py-3 text-left">Code</th>
                    <th class="px-6 py-3 text-left">Name</th>
                    <th class="px-6 py-3 text-left">Department</th>
                    <th class="px-6 py-3 text-center">Actions</th>
                </tr>
                </thead>
                <tbody class="divide-y divide-gray-200 text-sm">
                <c:forEach items="${specialities}" var="s">
                    <tr>
                        <td class="px-6 py-4 font-medium text-gray-900">${s.code}</td>
                        <td class="px-6 py-4">${s.nom}</td>
                        <td class="px-6 py-4">${s.departmentName}</td>
                        <td class="px-6 py-4 text-center space-x-2">
                            <a href="${pageContext.request.contextPath}/admin/specialities/edit?id=${s.id}"
                               class="inline-flex items-center px-3 py-1.5 rounded-md bg-yellow-500 text-white hover:bg-yellow-600 transition">
                                <i class="fa-solid fa-pen-to-square mr-1"></i>Edit
                            </a>
                            <form action="${pageContext.request.contextPath}/admin/specialities/delete" method="post"
                                  class="inline"
                                  onsubmit="return confirm('Delete this speciality?');">
                                <input type="hidden" name="id" value="${s.id}">
                                <button class="inline-flex items-center px-3 py-1.5 rounded-md bg-red-600 text-white hover:bg-red-700 transition">
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

</div>

<!-- Tab switcher (vanilla JS) -->
<script>
    const buttons = document.querySelectorAll('.tab-button');
    const panels = {
        dept: document.getElementById('dept-panel'),
        spec: document.getElementById('spec-panel')
    };
    buttons.forEach(btn => {
        btn.addEventListener('click', () => {
            const tab = btn.dataset.tab;
            // reset
            buttons.forEach(b => b.classList.remove('active-tab'));
            Object.values(panels).forEach(p => p.classList.add('hidden'));
            // activate
            btn.classList.add('active-tab');
            panels[tab].classList.remove('hidden');
        });
    });
</script>

<style>
    .tab-button {
        @apply px-4 py-2 border-b-2 border-transparent text-gray-500 hover:text-indigo-600 hover:border-indigo-300 transition;
    }

    .active-tab {
        @apply border-indigo-600 text-indigo-600 font-medium;
    }
</style>

</body>
</html>
