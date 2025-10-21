<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/template/header.jsp">
    <jsp:param name="title" value="Appointments" />
</jsp:include>

<main class="md:ml-16 p-6">
    <div class="max-w-4xl mx-auto">
        <div class="bg-white dark:bg-gray-800 rounded-lg shadow p-6 mb-6">
            <h2 class="text-2xl font-semibold mb-2">My Appointments</h2>
            <p class="text-sm text-gray-600">Manage your upcoming appointments and view history.</p>
        </div>

        <div class="bg-white dark:bg-gray-800 rounded-lg shadow p-6 mb-6">
            <h3 class="text-lg font-semibold mb-4">Upcoming</h3>
            <c:if test="${not empty upcomingAppointments}">
                <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700 text-sm">
                    <thead class="text-left text-gray-600 dark:text-gray-300">
                    <tr><th class="px-4 py-2">Date</th><th class="px-4 py-2">Time</th><th class="px-4 py-2">Doctor</th><th class="px-4 py-2">Actions</th></tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${upcomingAppointments}" var="a">
                        <tr>
                            <td class="px-4 py-2">${a.dateRdv}</td>
                            <td class="px-4 py-2">${a.heureRdv}</td>
                            <td class="px-4 py-2">${a.doctor.nom}</td>
                            <td class="px-4 py-2">
                                <form method="post" action="${pageContext.request.contextPath}/patient/appointments/cancel" onsubmit="return confirm('Cancel this appointment?');">
                                    <input type="hidden" name="appointmentId" value="${a.id}" />
                                    <button class="px-3 py-1 rounded bg-red-600 text-white text-sm">Cancel</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty upcomingAppointments}">
                <p class="text-sm text-gray-600">No upcoming appointments.</p>
            </c:if>
        </div>

        <div class="bg-white dark:bg-gray-800 rounded-lg shadow p-6">
            <h3 class="text-lg font-semibold mb-4">History</h3>
            <c:if test="${not empty historyAppointments}">
                <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700 text-sm">
                    <thead class="text-left text-gray-600 dark:text-gray-300">
                    <tr><th class="px-4 py-2">Date</th><th class="px-4 py-2">Time</th><th class="px-4 py-2">Doctor</th><th class="px-4 py-2">Status</th></tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${historyAppointments}" var="h">
                        <tr>
                            <td class="px-4 py-2">${h.dateRdv}</td>
                            <td class="px-4 py-2">${h.heureRdv}</td>
                            <td class="px-4 py-2">${h.doctor.nom}</td>
                            <td class="px-4 py-2">${h.statut}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty historyAppointments}">
                <p class="text-sm text-gray-600">No history appointments.</p>
            </c:if>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/template/footer.jsp" />
