<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 10/19/2025
  Time: 9:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="/WEB-INF/template/header.jsp">
    <jsp:param name="title" value="Tableau de bord – Docteur"/>
</jsp:include>

<%
    /* page-level utilities */
    java.time.LocalDate monday = (java.time.LocalDate) request.getAttribute("monday");
    java.time.format.DateTimeFormatter dtf = java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy");
%>

<div class="max-w-7xl mx-auto px-4 py-8">

    <!-- Heading + week navigator -->
    <div class="flex items-center justify-between mb-6">
        <h2 class="text-2xl font-semibold text-gray-800 dark:text-gray-100">
            Mon planning
        </h2>
        <div class="flex items-center space-x-2 text-sm">
            <a href="?doctorId=${doctorId}&week=${week-1}"
               class="px-3 py-1 rounded bg-gray-200 dark:bg-gray-700 hover:bg-gray-300">&lt;</a>
            <span class="px-4 py-1 font-medium">
        <%= monday.format(dtf) %> – <%= monday.plusDays(4).format(dtf) %>
      </span>
            <a href="?doctorId=${doctorId}&week=${week+1}"
               class="px-3 py-1 rounded bg-gray-200 dark:bg-gray-700 hover:bg-gray-300">&gt;</a>
        </div>
    </div>

    <!-- Quick actions -->
    <div class="flex items-center gap-4 mb-6">
        <form method="post" action="${pageContext.request.contextPath}/admin/availability/generate"
              class="inline">
            <input type="hidden" name="doctorId" value="${doctorId}">
            <input type="hidden" name="startDate" value="${monday}" />
            <input type="hidden" name="endDate" value="${monday.plusDays(4)}" />
            <button type="submit"
                    class="px-4 py-2 rounded-md bg-indigo-600 text-white hover:bg-indigo-700">
                Générer ma semaine
            </button>
        </form>

        <form method="post" action="${pageContext.request.contextPath}/logout" class="inline">
            <button type="submit"
                    class="px-4 py-2 rounded-md bg-gray-600 text-white hover:bg-gray-700">
                Déconnexion
            </button>
        </form>
    </div>

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
            <%-- MORNING 08:00 – 12:40  (9 slots) --%>
            <c:forEach begin="0" end="8" varStatus="s">
                <c:set var="start" value="${java.time.LocalTime.of(8,0).plusMinutes(s.index * 35)}"/>
                <tr>
                    <td class="px-4 py-2 font-medium">
                        <fmt:formatNumber value="${start.hour}" minIntegerDigits="2"/>:<fmt:formatNumber
                            value="${start.minute}" minIntegerDigits="2"/>
                    </td>
                    <c:forEach items="MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY" var="day">
                        <td class="px-2 py-2 text-center">
                            <c:forEach items="${slots}" var="sl">
                                <c:if test="${sl.day eq day and sl.start eq start}">
                                    <c:choose>
                                        <c:when test="${sl.status eq 'AVAILABLE'}">
                                            <span class="inline-block w-full py-2 rounded bg-green-100 dark:bg-green-900/30 text-green-700 dark:text-green-300 text-xs">Libre</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="inline-block w-full py-2 rounded bg-red-100 dark:bg-red-900/30 text-red-700 dark:text-red-300 text-xs">Occupé</span>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </c:forEach>
                        </td>
                    </c:forEach>
                </tr>
            </c:forEach>

            <%-- LUNCH BLOCK 13:00-14:00 --%>
            <tr>
                <td class="px-4 py-2 font-medium">13:00-14:00</td>
                <c:forEach items="MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY" var="day">
                    <td class="px-2 py-2 text-center">
                        <span class="inline-block w-full py-2 rounded bg-gray-300 dark:bg-gray-600 text-gray-700 dark:text-gray-300 text-xs">Pause</span>
                    </td>
                </c:forEach>
            </tr>

            <%-- AFTERNOON 14:00 – 17:30  (7 slots) --%>
            <c:forEach begin="0" end="6" varStatus="s">
                <c:set var="start" value="${java.time.LocalTime.of(14,0).plusMinutes(s.index * 35)}"/>
                <tr>
                    <td class="px-4 py-2 font-medium">
                        <fmt:formatNumber value="${start.hour}" minIntegerDigits="2"/>:<fmt:formatNumber
                            value="${start.minute}" minIntegerDigits="2"/>
                    </td>
                    <c:forEach items="MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY" var="day">
                        <td class="px-2 py-2 text-center">
                            <c:forEach items="${slots}" var="sl">
                                <c:if test="${sl.day eq day and sl.start eq start}">
                                    <c:choose>
                                        <c:when test="${sl.status eq 'AVAILABLE'}">
                                            <span class="inline-block w-full py-2 rounded bg-green-100 dark:bg-green-900/30 text-green-700 dark:text-green-300 text-xs">Libre</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="inline-block w-full py-2 rounded bg-red-100 dark:bg-red-900/30 text-red-700 dark:text-red-300 text-xs">Occupé</span>
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
