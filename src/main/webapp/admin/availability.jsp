<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 10/15/2025
  Time: 1:44 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/template/header.jsp">
    <jsp:param name="title" value="Gérer les disponibilités"/>
</jsp:include>

<div class="max-w-5xl mx-auto px-4 py-8">
    <h2 class="text-2xl font-semibold mb-6 text-gray-800 dark:text-gray-100">Gérer les disponibilités</h2>

    <!-- flash messages -->
    <c:if test="${param.msg eq 'added'}">
        <div class="mb-4 p-3 rounded-md bg-green-50 dark:bg-green-900/20 text-green-700 dark:text-green-300 text-sm">
            Créneau ajouté
        </div>
    </c:if>
    <c:if test="${param.msg eq 'deleted'}">
        <div class="mb-4 p-3 rounded-md bg-yellow-50 dark:bg-yellow-900/20 text-yellow-700 dark:text-yellow-300 text-sm">
            Créneau supprimé
        </div>
    </c:if>
    <c:if test="${not empty sessionScope.error}">
        <div class="mb-4 p-3 rounded-md bg-red-50 dark:bg-red-900/20 text-red-700 dark:text-red-300 text-sm">
                ${sessionScope.error}
        </div>
        <c:remove var="error" scope="session"/>
    </c:if>

    <!-- current slots -->
    <div class="bg-white dark:bg-gray-800 rounded-lg shadow mb-8">
        <div class="px-6 py-4 border-b dark:border-gray-700">
            <h4 class="text-lg font-medium text-gray-800 dark:text-gray-100">Créneaux actuels</h4>
        </div>
        <div class="overflow-auto">
            <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700 text-sm">
                <thead class="bg-gray-50 dark:bg-gray-700 text-gray-600 dark:text-gray-300">
                <tr>
                    <th class="px-6 py-3 text-left">Jour</th>
                    <th class="px-6 py-3 text-left">Début</th>
                    <th class="px-6 py-3 text-left">Fin</th>
                    <th class="px-6 py-3 text-center">Action</th>
                </tr>
                </thead>
                <tbody class="divide-y divide-gray-200 dark:divide-gray-700">
                <c:forEach items="${slots}" var="s">
                    <tr class="hover:bg-gray-50 dark:hover:bg-gray-700/50">
                        <td class="px-6 py-4">${s.jourSemaine}</td>
                        <td class="px-6 py-4">${s.heureDebut}</td>
                        <td class="px-6 py-4">${s.heureFin}</td>
                        <td class="px-6 py-4 text-center">
                            <form method="post" action="${pageContext.request.contextPath}/admin/availability"
                                  onsubmit="return confirm('Supprimer ?');" class="inline">
                                <input type="hidden" name="_method" value="delete">
                                <input type="hidden" name="slotId" value="${s.id}">
                                <input type="hidden" name="doctorId" value="${param.doctorId}">
                                <button class="px-3 py-1.5 rounded-md bg-red-600 text-white hover:bg-red-700 text-sm">
                                    Supprimer
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- add slot -->
    <div class="bg-white dark:bg-gray-800 rounded-lg shadow p-6">
        <h4 class="text-lg font-medium mb-4 text-gray-800 dark:text-gray-100">Ajouter un créneau</h4>
        <form method="post" action="${pageContext.request.contextPath}/admin/availability" class="space-y-4">
            <input type="hidden" name="doctorId" value="${param.doctorId}">

            <div class="grid grid-cols-1 md:grid-cols-4 gap-4 items-end">
                <div>
                    <label class="block mb-1 text-sm font-medium text-gray-700 dark:text-gray-300">Jour</label>
                    <select name="jour" required
                            class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 dark:bg-gray-700 rounded-md
                         focus:outline-none focus:ring-2 focus:ring-indigo-500">
                        <c:forEach var="j" items="MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY">
                            <option value="${j}">${j}</option>
                        </c:forEach>
                    </select>
                </div>

                <div>
                    <label class="block mb-1 text-sm font-medium text-gray-700 dark:text-gray-300">Début</label>
                    <input type="time" name="debut" required
                           class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 dark:bg-gray-700 rounded-md
                        focus:outline-none focus:ring-2 focus:ring-indigo-500">
                </div>

                <div>
                    <label class="block mb-1 text-sm font-medium text-gray-700 dark:text-gray-300">Fin</label>
                    <input type="time" name="fin" required
                           class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 dark:bg-gray-700 rounded-md
                        focus:outline-none focus:ring-2 focus:ring-indigo-500">
                </div>

                <div>
                    <button class="w-full px-4 py-2 rounded-md bg-indigo-600 text-white hover:bg-indigo-700 transition">
                        Ajouter
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/template/footer.jsp"/>