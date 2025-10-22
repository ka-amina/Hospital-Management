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

    <div class="bg-white dark:bg-gray-800 rounded-lg shadow p-4">
        <h3 class="text-lg font-semibold mb-3">Upcoming Appointments</h3>
        <table class="min-w-full text-sm">
            <thead>
            <tr class="text-left text-gray-600 dark:text-gray-300">
                <th>Date</th>
                <th>Time</th>
                <th>Patient</th>
                <th>Doctor</th>
                <th>Type</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${upcomingAppointments}" var="a">
                <tr>
                    <td>${a.dateRdv}</td>
                    <td>${a.heureRdv}</td>
                    <td>${a.patient.nom}</td>
                    <td>${a.doctor.nom}</td>
                    <td>${a.type}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</section>

<jsp:include page="/WEB-INF/template/footer.jsp"/>