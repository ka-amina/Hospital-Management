<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 10/15/2025
  Time: 1:46 AM
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/template/header.jsp">
    <jsp:param name="title" value="Liste des docteurs"/>
</jsp:include>

<div class="max-w-7xl mx-auto px-4 py-8">
    <div class="flex items-center justify-between mb-6">
        <h2 class="text-2xl font-semibold text-gray-800 dark:text-gray-100">Liste des docteurs</h2>
        <a href="${pageContext.request.contextPath}/admin/doctors/new"
           class="inline-flex items-center px-4 py-2 rounded-md bg-green-600 text-white hover:bg-green-700">
            <i class="fa-solid fa-plus mr-2"></i>Nouveau docteur
        </a>
    </div>

    <!-- flash messages -->
    <c:if test="${param.msg eq 'doc-created'}">
        <div class="mb-4 p-3 rounded-md bg-green-50 dark:bg-green-900/20 text-green-700 dark:text-green-300 text-sm">
            Docteur créé
        </div>
    </c:if>
    <c:if test="${param.msg eq 'doc-updated'}">
        <div class="mb-4 p-3 rounded-md bg-blue-50 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 text-sm">Docteur
            modifié
        </div>
    </c:if>
    <c:if test="${param.msg eq 'doc-deleted'}">
        <div class="mb-4 p-3 rounded-md bg-yellow-50 dark:bg-yellow-900/20 text-yellow-700 dark:text-yellow-300 text-sm">
            Docteur désactivé
        </div>
    </c:if>

    <div class="bg-white dark:bg-gray-800 rounded-lg shadow overflow-hidden">
        <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700 text-sm">
            <thead class="bg-gray-50 dark:bg-gray-700 text-gray-600 dark:text-gray-300 uppercase tracking-wider">
            <tr>
                <th class="px-6 py-3 text-left">Matricule</th>
                <th class="px-6 py-3 text-left">Nom</th>
                <th class="px-6 py-3 text-left">Spécialité</th>
                <th class="px-6 py-3 text-left">Département</th>
                <th class="px-6 py-3 text-center">Actif</th>
                <th class="px-6 py-3 text-center">Actions</th>
            </tr>
            </thead>
            <tbody class="divide-y divide-gray-200 dark:divide-gray-700">
            <c:forEach items="${doctors}" var="d">
                <tr class="hover:bg-gray-50 dark:hover:bg-gray-700/50">
                    <td class="px-6 py-4 font-medium">${d.matricule}</td>
                    <td class="px-6 py-4">${d.nom}</td>
                    <td class="px-6 py-4">${d.specialtyName}</td>
                    <td class="px-6 py-4">${d.departmentName}</td>
                    <td class="px-6 py-4 text-center">
              <span class="inline-flex px-2 py-1 text-xs rounded-full
                           ${d.actif ? 'bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-300'
                                      : 'bg-gray-100 text-gray-800 dark:bg-gray-700 dark:text-gray-300'}">
                      ${d.actif ? 'Oui' : 'Non'}
              </span>
                    </td>
                    <td class="px-6 py-4 text-center space-x-2">
                        <!-- Modifier -->
                        <a href="${pageContext.request.contextPath}/admin/doctors/edit?id=${d.id}"
                           class="inline-flex items-center px-3 py-1.5 rounded-md bg-yellow-500 text-white hover:bg-yellow-600">
                            <i class="fa-solid fa-pen-to-square mr-1"></i>Modifier
                        </a>

                        <!-- Supprimer -->
                        <form action="${pageContext.request.contextPath}/admin/doctors/delete" method="post"
                              class="inline"
                              onsubmit="return confirm('Supprimer ?');">
                            <input type="hidden" name="id" value="${d.id}">
                            <button class="inline-flex items-center px-3 py-1.5 rounded-md bg-red-600 text-white hover:bg-red-700">
                                <i class="fa-solid fa-trash mr-1"></i>Supprimer
                            </button>
                        </form>

                        <!-- Générer les disponibilités -->
                        <form action="${pageContext.request.contextPath}/admin/availability/generate"
                              method="post" class="inline space-x-1">

                            <input type="hidden" name="doctorId" value="${d.id}">

                            <!-- date de début (obligatoire) -->
                            <input type="date" name="startDate" required
                                   placeholder="Date début"
                                   class="px-2 py-1 border rounded dark:bg-gray-700 dark:text-gray-200 text-sm"
                                   value="<%= java.time.LocalDate.now() %>">

                            <!-- date de fin (obligatoire) -->
                            <input type="date" name="endDate" required
                                   placeholder="Date fin"
                                   class="px-2 py-1 border rounded dark:bg-gray-700 dark:text-gray-200 text-sm"
                                   value="<%= java.time.LocalDate.now() %>">

                            <button type="submit"
                                    class="inline-flex items-center px-3 py-1.5 rounded-md bg-indigo-600 text-white hover:bg-indigo-700 text-sm">
                                <i class="fa-solid fa-calendar-plus mr-1"></i>Générer
                            </button>
                        </form>

                        <!-- Voir l'agenda -->
                        <a href="${pageContext.request.contextPath}/doctor/schedule?doctorId=${d.id}"
                           class="inline-flex items-center px-3 py-1.5 rounded-md bg-sky-600 text-white hover:bg-sky-700">
                            <i class="fa-solid fa-calendar-day mr-1"></i>Agenda
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/template/footer.jsp"/>