<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/template/header.jsp">
    <jsp:param name="title" value="Patient Dashboard" />
</jsp:include>

<main class="md:ml-16 p-6">
    <div class="max-w-4xl mx-auto">
        <div class="bg-white dark:bg-gray-800 rounded-lg shadow p-6 mb-6">
            <h2 class="text-2xl font-semibold mb-2">Patient Dashboard</h2>

            <c:if test="${not empty param.msg}">
                <div class="mb-3 p-3 rounded bg-green-50 text-green-800">${param.msg}</div>
            </c:if>
            <c:if test="${not empty param.error}">
                <div class="mb-3 p-3 rounded bg-red-50 text-red-800">${param.error}</div>
            </c:if>

            <c:if test="${not empty user}">
                <p class="text-lg">Bienvenue, <span class="font-medium">${user.nom}</span>!</p>
                <p class="text-sm text-gray-600 dark:text-gray-400">Email: ${user.email}</p>
            </c:if>
            <p class="mt-4 text-sm text-gray-700 dark:text-gray-300">Use the navigation to view appointments and manage your profile.</p>
        </div>

        <!-- Upcoming -->
        <div class="bg-white dark:bg-gray-800 rounded-lg shadow p-6 mb-6">
            <h3 class="text-lg font-semibold mb-4">Upcoming Appointments</h3>
            <c:choose>
                <c:when test="${not empty upcomingAppointments}">
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                            <thead class="text-left text-sm text-gray-600 dark:text-gray-300">
                            <tr>
                                <th class="px-4 py-2">Date</th>
                                <th class="px-4 py-2">Time</th>
                                <th class="px-4 py-2">Doctor</th>
                                <th class="px-4 py-2">Type</th>
                                <th class="px-4 py-2">Actions</th>
                            </tr>
                            </thead>
                            <tbody class="text-sm divide-y divide-gray-100 dark:divide-gray-700">
                            <c:forEach items="${upcomingAppointments}" var="a">
                                <tr>
                                    <td class="px-4 py-3">${a.dateRdv}</td>
                                    <td class="px-4 py-3">${a.heureRdv}</td>
                                    <td class="px-4 py-3">${a.doctor.nom}</td>
                                    <td class="px-4 py-3">${a.type}</td>
                                    <td class="px-4 py-3">
                                        <form method="post" action="${pageContext.request.contextPath}/patient/appointments/cancel" onsubmit="return confirm('Cancel this appointment?');">
                                            <input type="hidden" name="appointmentId" value="${a.id}" />
                                            <button class="px-3 py-1 rounded bg-red-600 text-white text-sm hover:bg-red-700">Cancel</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="text-sm text-gray-600">No upcoming appointments.</p>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- History -->
        <div class="bg-white dark:bg-gray-800 rounded-lg shadow p-6">
            <h3 class="text-lg font-semibold mb-4">Appointment History</h3>
            <c:choose>
                <c:when test="${not empty historyAppointments}">
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                            <thead class="text-left text-sm text-gray-600 dark:text-gray-300">
                            <tr>
                                <th class="px-4 py-2">Date</th>
                                <th class="px-4 py-2">Time</th>
                                <th class="px-4 py-2">Doctor</th>
                                <th class="px-4 py-2">Type</th>
                                <th class="px-4 py-2">Status</th>
                            </tr>
                            </thead>
                            <tbody class="text-sm divide-y divide-gray-100 dark:divide-gray-700">
                            <c:forEach items="${historyAppointments}" var="h">
                                <tr>
                                    <td class="px-4 py-3">${h.dateRdv}</td>
                                    <td class="px-4 py-3">${h.heureRdv}</td>
                                    <td class="px-4 py-3">${h.doctor.nom}</td>
                                    <td class="px-4 py-3">${h.type}</td>
                                    <td class="px-4 py-3">${h.statut}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="text-sm text-gray-600">No past appointments.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/template/footer.jsp" />
