<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 10/15/2025
  Time: 1:47 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/template/header.jsp">
    <jsp:param name="title" value="${empty dto.id ? 'Nouveau docteur' : 'Modifier docteur'}"/>
</jsp:include>

<div class="max-w-3xl mx-auto px-4 py-8">
    <div class="bg-white dark:bg-gray-800 rounded-lg shadow p-6">
        <h2 class="text-xl font-semibold mb-5 text-gray-800 dark:text-gray-100">
            <c:out value="${empty dto.id ? 'Nouveau docteur' : 'Modifier docteur'}"/>
        </h2>

        <c:if test="${not empty error}">
            <div class="mb-4 p-3 rounded-md bg-red-50 dark:bg-red-900/20 text-red-700 dark:text-red-300 text-sm">
                    ${error}
            </div>
        </c:if>

        <form method="post" 
              action="${empty dto.id ? pageContext.request.contextPath.concat('/admin/doctors/new') 
                                     : pageContext.request.contextPath.concat('/admin/doctors/edit')}" 
              class="space-y-4">
            <input type="hidden" name="id" value="${dto.id}">

            <div>
                <label class="block mb-1 text-sm font-medium text-gray-700 dark:text-gray-300">Nom</label>
                <input name="nom" value="${dto.nom}" required
                       class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 dark:bg-gray-700 rounded-md
                      focus:outline-none focus:ring-2 focus:ring-indigo-500">
            </div>

            <div>
                <label class="block mb-1 text-sm font-medium text-gray-700 dark:text-gray-300">Email</label>
                <input type="email" name="email" value="${dto.email}" required
                       class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 dark:bg-gray-700 rounded-md
                      focus:outline-none focus:ring-2 focus:ring-indigo-500">
            </div>

            <div>
                <label class="block mb-1 text-sm font-medium text-gray-700 dark:text-gray-300">Matricule</label>
                <input name="matricule" value="${dto.matricule}" required
                       class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 dark:bg-gray-700 rounded-md
                      focus:outline-none focus:ring-2 focus:ring-indigo-500">
            </div>

            <div>
                <label class="block mb-1 text-sm font-medium text-gray-700 dark:text-gray-300">Titre</label>
                <input name="titre" value="${dto.titre}"
                       class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 dark:bg-gray-700 rounded-md
                      focus:outline-none focus:ring-2 focus:ring-indigo-500">
            </div>

            <div>
                <label class="block mb-1 text-sm font-medium text-gray-700 dark:text-gray-300">Spécialité</label>
                <select name="specialtyId" required
                        class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 dark:bg-gray-700 rounded-md
                       focus:outline-none focus:ring-2 focus:ring-indigo-500">
                    <c:forEach items="${specialities}" var="s">
                        <option value="${s.id}" ${dto.specialtyId eq s.id ? 'selected' : ''}>${s.nom}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="flex items-center">
                <input type="checkbox" id="actif" name="actif" value="true" ${dto.actif ? 'checked' : ''}
                       class="h-4 w-4 text-indigo-600 border-gray-300 rounded focus:ring-indigo-500">
                <label for="actif" class="ml-2 text-sm text-gray-700 dark:text-gray-300">Actif</label>
            </div>

            <div class="flex items-center justify-between pt-4">
                <a href="${pageContext.request.contextPath}/admin/doctors"
                   class="px-4 py-2 rounded-md bg-gray-200 dark:bg-gray-700 text-gray-800 dark:text-gray-200
                  hover:bg-gray-300 dark:hover:bg-gray-600 transition">
                    Annuler
                </a>
                <button type="submit"
                        class="px-4 py-2 rounded-md bg-indigo-600 text-white hover:bg-indigo-700 transition">
                    Enregistrer
                </button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/template/footer.jsp"/>