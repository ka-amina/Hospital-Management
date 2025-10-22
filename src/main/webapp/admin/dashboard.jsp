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

<!-- Summary metrics -->
<section class="mb-8">
    <div class="grid grid-cols-4 gap-4 mb-6">
        <div class="p-4 bg-white dark:bg-gray-800 rounded-lg shadow">
            <div class="text-sm text-gray-500">Patients</div>
            <div class="text-2xl font-semibold">${totalPatients}</div>
        </div>
        <div class="p-4 bg-white dark:bg-gray-800 rounded-lg shadow">
            <div class="text-sm text-gray-500">Doctors</div>
            <div class="text-2xl font-semibold">${totalDoctors}</div>
        </div>
        <div class="p-4 bg-white dark:bg-gray-800 rounded-lg shadow">
            <div class="text-sm text-gray-500">Appointments</div>
            <div class="text-2xl font-semibold">${totalAppointments}</div>
        </div>
        <div class="p-4 bg-white dark:bg-gray-800 rounded-lg shadow">
            <div class="text-sm text-gray-500">Cancellation Rate (30d)</div>
            <div class="text-2xl font-semibold">${cancellationRate}%</div>
        </div>
    </div>

    <div class="bg-white dark:bg-gray-800 rounded-lg shadow p-6">
        <h3 class="text-lg font-semibold mb-4 text-gray-800 dark:text-gray-100">Upcoming Appointments</h3>
        
        <c:choose>
            <c:when test="${not empty upcomingAppointments}">
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700 text-sm">
                        <thead class="bg-gray-50 dark:bg-gray-700">
                            <tr class="text-left text-gray-600 dark:text-gray-300">
                                <th class="px-4 py-3 font-medium">Date</th>
                                <th class="px-4 py-3 font-medium">Time</th>
                                <th class="px-4 py-3 font-medium">Patient</th>
                                <th class="px-4 py-3 font-medium">Doctor</th>
                                <th class="px-4 py-3 font-medium">Type</th>
                                <th class="px-4 py-3 font-medium">Status</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200 dark:divide-gray-700">
                            <c:forEach items="${upcomingAppointments}" var="a">
                                <tr class="hover:bg-gray-50 dark:hover:bg-gray-700/50">
                                    <td class="px-4 py-3 text-gray-900 dark:text-gray-100">${a.dateRdv}</td>
                                    <td class="px-4 py-3 text-gray-900 dark:text-gray-100">${a.heureRdv}</td>
                                    <td class="px-4 py-3 text-gray-700 dark:text-gray-300">${a.patient.nom}</td>
                                    <td class="px-4 py-3 text-gray-700 dark:text-gray-300">${a.doctor.nom}</td>
                                    <td class="px-4 py-3 text-gray-600 dark:text-gray-400">${a.type}</td>
                                    <td class="px-4 py-3">
                                        <c:set var="statusName" value="${a.statut.name()}" />
                                        <span class="inline-flex px-2 py-1 text-xs rounded-full
                                            ${statusName == 'CONFIRMED' ? 'bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-300' : 
                                              statusName == 'PENDING' ? 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900/30 dark:text-yellow-300' :
                                              statusName == 'CANCELED' ? 'bg-red-100 text-red-800 dark:bg-red-900/30 dark:text-red-300' :
                                              'bg-gray-100 text-gray-800 dark:bg-gray-700 dark:text-gray-300'}">
                                            ${statusName}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center py-12">
                    <i class="fa-solid fa-calendar-xmark text-6xl text-gray-300 dark:text-gray-600 mb-4"></i>
                    <p class="text-gray-600 dark:text-gray-400 text-lg mb-2">No upcoming appointments</p>
                    <p class="text-gray-500 dark:text-gray-500 text-sm">
                        When patients book appointments, they will appear here.
                    </p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<jsp:include page="/WEB-INF/template/footer.jsp"/>