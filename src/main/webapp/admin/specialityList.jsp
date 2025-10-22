<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/template/header.jsp">
    <jsp:param name="title" value="Liste des spécialités"/>
</jsp:include>

<div class="max-w-7xl mx-auto px-4 py-8">
    <div class="flex items-center justify-between mb-6">
        <h2 class="text-2xl font-semibold text-gray-800 dark:text-gray-100">Liste des spécialités</h2>
        <a href="${pageContext.request.contextPath}/admin/specialities/new"
           class="inline-flex items-center px-4 py-2 rounded-md bg-green-600 text-white hover:bg-green-700">
            <i class="fa-solid fa-plus mr-2"></i>Nouvelle spécialité
        </a>
    </div>

    <!-- flash messages -->
    <c:if test="${param.msg eq 'spec-created'}">
        <div class="mb-4 p-3 rounded-md bg-green-50 dark:bg-green-900/20 text-green-700 dark:text-green-300 text-sm">
            Spécialité créée avec succès
        </div>
    </c:if>
    <c:if test="${param.msg eq 'spec-updated'}">
        <div class="mb-4 p-3 rounded-md bg-blue-50 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 text-sm">
            Spécialité modifiée avec succès
        </div>
    </c:if>
    <c:if test="${param.msg eq 'spec-deleted'}">
        <div class="mb-4 p-3 rounded-md bg-yellow-50 dark:bg-yellow-900/20 text-yellow-700 dark:text-yellow-300 text-sm">
            Spécialité supprimée avec succès
        </div>
    </c:if>

    <div class="bg-white dark:bg-gray-800 rounded-lg shadow overflow-hidden">
        <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700 text-sm">
            <thead class="bg-gray-50 dark:bg-gray-700 text-gray-600 dark:text-gray-300 uppercase tracking-wider">
            <tr>
                <th class="px-6 py-3 text-left">Code</th>
                <th class="px-6 py-3 text-left">Nom</th>
                <th class="px-6 py-3 text-left">Description</th>
                <th class="px-6 py-3 text-left">Département</th>
                <th class="px-6 py-3 text-center">Actions</th>
            </tr>
            </thead>
            <tbody class="divide-y divide-gray-200 dark:divide-gray-700">
            <c:choose>
                <c:when test="${empty specialities}">
                    <tr>
                        <td colspan="5" class="px-6 py-8 text-center text-gray-500 dark:text-gray-400">
                            Aucune spécialité trouvée. <a href="${pageContext.request.contextPath}/admin/specialities/new" class="text-indigo-600 hover:underline">Créer la première spécialité</a>
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${specialities}" var="spec">
                        <tr class="hover:bg-gray-50 dark:hover:bg-gray-700/50">
                            <td class="px-6 py-4 font-medium text-gray-900 dark:text-gray-100">${spec.code}</td>
                            <td class="px-6 py-4 text-gray-700 dark:text-gray-300">${spec.nom}</td>
                            <td class="px-6 py-4 text-gray-600 dark:text-gray-400 text-sm">
                                <c:choose>
                                    <c:when test="${not empty spec.description}">
                                        ${spec.description}
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-gray-400 italic">Aucune description</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="px-6 py-4 text-gray-700 dark:text-gray-300">
                                <c:choose>
                                    <c:when test="${not empty spec.departmentName}">
                                        ${spec.departmentName}
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-gray-400 italic">Aucun département</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="px-6 py-4 text-center space-x-2">
                                <!-- Modifier -->
                                <a href="${pageContext.request.contextPath}/admin/specialities/edit?id=${spec.id}"
                                   class="inline-flex items-center px-3 py-1.5 rounded-md bg-yellow-500 text-white hover:bg-yellow-600">
                                    <i class="fa-solid fa-pen-to-square mr-1"></i>Modifier
                                </a>

                                <!-- Supprimer -->
                                <form action="${pageContext.request.contextPath}/admin/specialities/delete" method="post"
                                      class="inline"
                                      onsubmit="return confirm('Êtes-vous sûr de vouloir supprimer cette spécialité ?');">
                                    <input type="hidden" name="id" value="${spec.id}">
                                    <button type="submit" class="inline-flex items-center px-3 py-1.5 rounded-md bg-red-600 text-white hover:bg-red-700">
                                        <i class="fa-solid fa-trash mr-1"></i>Supprimer
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/template/footer.jsp"/>
