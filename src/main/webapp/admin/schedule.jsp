<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 10/18/2025
  Time: 6:42 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="fmt" value="<%= java.time.format.DateTimeFormatter.ofPattern(\"dd MMM yyyy\") %>"/>
<jsp:include page="/WEB-INF/template/header.jsp">
    <jsp:param name="title" value="Planning"/>
</jsp:include>

<div class="max-w-7xl mx-auto px-4 py-8">
    <div class="flex items-center justify-between mb-6">
        <h2 class="text-2xl font-semibold text-gray-800 dark:text-gray-100">Disponibilités</h2>
        <div class="flex items-center space-x-2 text-sm">
            <a href="?doctorId=${doctorId}&week=${week-1}"
               class="px-3 py-1 rounded bg-gray-200 dark:bg-gray-700 hover:bg-gray-300">&lt;</a>
            <span class="px-4 py-1 font-medium">
    ${monday.format(fmt)} – ${monday.plusDays(4).format(fmt)}
</span>
            <a href="?doctorId=${doctorId}&week=${week+1}"
               class="px-3 py-1 rounded bg-gray-200 dark:bg-gray-700 hover:bg-gray-300">&gt;</a>
        </div>
    </div>

    <!-- Generate default week (admin only) -->
    <c:if test="${sessionScope.userRole eq 'ADMIN'}">
        <form method="post" action="${pageContext.request.contextPath}/admin/availability/generateWeek"
              class="mb-4">
            <input type="hidden" name="doctorId" value="${doctorId}">
            <button class="px-4 py-2 rounded-md bg-indigo-600 text-white hover:bg-indigo-700">
                Générer la semaine par défaut
            </button>
        </form>
    </c:if>

    <!-- Grid -->
    <div class="bg-white dark:bg-gray-800 rounded-lg shadow overflow-hidden">
        <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700 text-sm">
            <thead class="bg-gray-50 dark:bg-gray-700 text-gray-600 dark:text-gray-300">
            <tr>
                <th class="px-4 py-3 text-left">Heure</th>
                <c:forEach items="MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY" var="d">
                    <th class="px-4 py-3 text-center">${d}</th>
                </c:forEach>
            </tr>
            </thead>
            <tbody class="divide-y divide-gray-200 dark:divide-gray-700">

            <%-- Build time axis 08:00 – 18:00 30 min + 5 min buffer --%>
            <c:forEach begin="0" end="19" varStatus="s">
                <c:set var="start" value="${s.index*35}"/> <%-- 30+5 --%>
                <c:set var="hour" value="${8 + (start - (start%60))/60}"/>
                <c:set var="min" value="${start%60}"/>
                <fmt:formatNumber var="h" value="${hour}" minIntegerDigits="2"/>
                <fmt:formatNumber var="m" value="${min}" minIntegerDigits="2"/>
                <tr>
                    <td class="px-4 py-2 font-medium">${h}:${m}</td>

                    <c:forEach items="MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY" var="day">
                        <c:set var="lunch" value="${hour eq 13}"/>
                        <td class="px-2 py-2 text-center">

                                <%-- Lunch block --%>
                            <c:if test="${lunch}">
                                <span class="inline-block w-full py-2 rounded bg-gray-300 dark:bg-gray-600 text-gray-700 dark:text-gray-300 text-xs">Pause</span>
                            </c:if>

                                <%-- Find slot for this day/time --%>
                            <c:forEach items="${slots}" var="sl">
                                <c:if test="${sl.day eq day and sl.start.hour eq hour and sl.start.minute eq min and not lunch}">

                                    <c:choose>
                                        <%-- doctor is NOT available --%>
                                        <c:when test="${sl.status ne 'AVAILABLE'}">
        <span class="inline-block w-full py-2 rounded bg-red-100 dark:bg-red-900/30
                     text-red-700 dark:text-red-300 text-xs">
            Occupé
        </span>
                                        </c:when>

                                        <%-- doctor is available --%>
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${sessionScope.userRole eq 'PATIENT'}">
                                                    <form method="post"
                                                          action="${pageContext.request.contextPath}/patient/appointment/book"
                                                          class="inline">
                                                        <input type="hidden" name="availabilityId"
                                                               value="${sl.availabilityId}">
                                                        <button class="w-full px-2 py-1 rounded bg-green-600 text-white
                                   hover:bg-green-700 text-xs">
                                                            Réserver
                                                        </button>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                <span class="inline-block w-full py-2 rounded bg-green-100
                             dark:bg-green-900/30 text-green-700 dark:text-green-300 text-xs">
                    Libre
                </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>

                                </c:if>
                            </c:forEach>

                        </td>
                    </c:forEach>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/template/footer.jsp"/>
