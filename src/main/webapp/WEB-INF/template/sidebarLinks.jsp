<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 10/15/2025
  Time: 2:00 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<a href="${pageContext.request.contextPath}/admin/dashboard"
   class="flex items-center space-x-3 px-3 py-2 rounded-md hover:bg-indigo-50 dark:hover:bg-gray-700">
    <i class="fa-solid fa-gauge w-5 text-center"></i>
    <span class="sidebar-text whitespace-nowrap">Dashboard</span>
</a>
<a href="${pageContext.request.contextPath}/admin/doctors"
   class="flex items-center space-x-3 px-3 py-2 rounded-md hover:bg-indigo-50 dark:hover:bg-gray-700">
    <i class="fa-solid fa-user-doctor w-5 text-center"></i>
    <span class="sidebar-text whitespace-nowrap">Doctors</span>
</a>
<a href="${pageContext.request.contextPath}/admin/departments"
   class="flex items-center space-x-3 px-3 py-2 rounded-md hover:bg-indigo-50 dark:hover:bg-gray-700">
    <i class="fa-solid fa-building-user w-5 text-center"></i>
    <span class="sidebar-text whitespace-nowrap">Departments</span>
</a>
<a href="${pageContext.request.contextPath}/admin/specialities"
   class="flex items-center space-x-3 px-3 py-2 rounded-md hover:bg-indigo-50 dark:hover:bg-gray-700">
    <i class="fa-solid fa-stethoscope w-5 text-center"></i>
    <span class="sidebar-text whitespace-nowrap">Specialities</span>
</a>
