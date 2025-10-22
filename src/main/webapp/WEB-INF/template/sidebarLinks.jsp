<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 10/15/2025
  Time: 2:00 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="current" value="${pageContext.request.requestURI}" />
<c:set var="userRole" value="${sessionScope.userRole}" />

<!-- Admin Links -->
<c:if test="${userRole == 'ADMIN'}">
  <a href="${pageContext.request.contextPath}/admin/dashboard"
     class="flex items-center space-x-3 px-3 py-2 rounded-md ${current.contains('/admin/dashboard') ? 'bg-indigo-50 dark:bg-gray-700' : 'hover:bg-indigo-50 dark:hover:bg-gray-700'}">
    <i class="fa-solid fa-gauge w-5 text-center"></i>
    <span class="sidebar-text whitespace-nowrap">Dashboard</span>
  </a>

  <a href="${pageContext.request.contextPath}/admin/doctors"
     class="flex items-center space-x-3 px-3 py-2 rounded-md ${current.contains('/admin/doctors') ? 'bg-indigo-50 dark:bg-gray-700' : 'hover:bg-indigo-50 dark:hover:bg-gray-700'}">
    <i class="fa-solid fa-user-doctor w-5 text-center"></i>
    <span class="sidebar-text whitespace-nowrap">Doctors</span>
  </a>

  <a href="${pageContext.request.contextPath}/admin/departments"
     class="flex items-center space-x-3 px-3 py-2 rounded-md ${current.contains('/admin/departments') ? 'bg-indigo-50 dark:bg-gray-700' : 'hover:bg-indigo-50 dark:hover:bg-gray-700'}">
    <i class="fa-solid fa-building-user w-5 text-center"></i>
    <span class="sidebar-text whitespace-nowrap">Departments</span>
  </a>

  <a href="${pageContext.request.contextPath}/admin/specialities"
     class="flex items-center space-x-3 px-3 py-2 rounded-md ${current.contains('/admin/specialities') ? 'bg-indigo-50 dark:bg-gray-700' : 'hover:bg-indigo-50 dark:hover:bg-gray-700'}">
    <i class="fa-solid fa-stethoscope w-5 text-center"></i>
    <span class="sidebar-text whitespace-nowrap">Specialities</span>
  </a>
</c:if>

<!-- Patient Links -->
<c:if test="${userRole == 'PATIENT'}">
  <a href="${pageContext.request.contextPath}/patient/dashboard"
     class="flex items-center space-x-3 px-3 py-2 rounded-md ${current.contains('/patient/dashboard') ? 'bg-indigo-50 dark:bg-gray-700' : 'hover:bg-indigo-50 dark:hover:bg-gray-700'}">
    <i class="fa-solid fa-house w-5 text-center"></i>
    <span class="sidebar-text whitespace-nowrap">Dashboard</span>
  </a>

  <a href="${pageContext.request.contextPath}/patient/doctors"
     class="flex items-center space-x-3 px-3 py-2 rounded-md ${current.contains('/patient/doctors') ? 'bg-indigo-50 dark:bg-gray-700' : 'hover:bg-indigo-50 dark:hover:bg-gray-700'}">
    <i class="fa-solid fa-user-doctor w-5 text-center"></i>
    <span class="sidebar-text whitespace-nowrap">Find Doctors</span>
  </a>

  <a href="${pageContext.request.contextPath}/appointments"
     class="flex items-center space-x-3 px-3 py-2 rounded-md ${current.contains('/appointments') ? 'bg-indigo-50 dark:bg-gray-700' : 'hover:bg-indigo-50 dark:hover:bg-gray-700'}">
    <i class="fa-solid fa-calendar-check w-5 text-center"></i>
    <span class="sidebar-text whitespace-nowrap">My Appointments</span>
  </a>

  <a href="${pageContext.request.contextPath}/profile"
     class="flex items-center space-x-3 px-3 py-2 rounded-md ${current.contains('/profile') ? 'bg-indigo-50 dark:bg-gray-700' : 'hover:bg-indigo-50 dark:hover:bg-gray-700'}">
    <i class="fa-solid fa-id-card w-5 text-center"></i>
    <span class="sidebar-text whitespace-nowrap">Profile</span>
  </a>
</c:if>

<!-- Doctor Links -->
<c:if test="${userRole == 'DOCTOR'}">
  <a href="${pageContext.request.contextPath}/doctor/schedule"
     class="flex items-center space-x-3 px-3 py-2 rounded-md ${current.contains('/doctor/schedule') ? 'bg-indigo-50 dark:bg-gray-700' : 'hover:bg-indigo-50 dark:hover:bg-gray-700'}">
    <i class="fa-solid fa-calendar-days w-5 text-center"></i>
    <span class="sidebar-text whitespace-nowrap">My Schedule</span>
  </a>

  <a href="${pageContext.request.contextPath}/appointments"
     class="flex items-center space-x-3 px-3 py-2 rounded-md ${current.contains('/appointments') ? 'bg-indigo-50 dark:bg-gray-700' : 'hover:bg-indigo-50 dark:hover:bg-gray-700'}">
    <i class="fa-solid fa-calendar-check w-5 text-center"></i>
    <span class="sidebar-text whitespace-nowrap">Appointments</span>
  </a>

  <a href="${pageContext.request.contextPath}/profile"
     class="flex items-center space-x-3 px-3 py-2 rounded-md ${current.contains('/profile') ? 'bg-indigo-50 dark:bg-gray-700' : 'hover:bg-indigo-50 dark:hover:bg-gray-700'}">
    <i class="fa-solid fa-id-card w-5 text-center"></i>
    <span class="sidebar-text whitespace-nowrap">Profile</span>
  </a>
</c:if>
