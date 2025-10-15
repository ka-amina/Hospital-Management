<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 10/13/2025
  Time: 12:55 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/template/header.jsp">
    <jsp:param name="title" value="Admin Dashboard"/>
</jsp:include>

<!-- Departments panel -->
<section class="mb-10">
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
                              class="inline" onsubmit="return confirm('Delete this department?');">
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
</section>

<!-- Specialities panel -->
<section>
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
                              class="inline" onsubmit="return confirm('Delete this speciality?');">
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
</section>

<jsp:include page="/WEB-INF/template/footer.jsp"/>