<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/template/header.jsp">
    <jsp:param name="title" value="Nos Docteurs"/>
</jsp:include>

<div class="max-w-7xl mx-auto px-4 py-8">
    <!-- Header -->
    <div class="mb-8">
        <h2 class="text-3xl font-bold text-gray-800 dark:text-gray-100 mb-2">Nos Docteurs Disponibles</h2>
        <p class="text-gray-600 dark:text-gray-400">Trouvez le spécialiste qu'il vous faut et prenez rendez-vous</p>
    </div>

    <!-- Filters -->
    <div class="bg-white dark:bg-gray-800 rounded-lg shadow p-6 mb-6">
        <form method="get" action="${pageContext.request.contextPath}/patient/doctors" class="grid grid-cols-1 md:grid-cols-4 gap-4">
            <!-- Name filter -->
            <div>
                <label for="name" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                    <i class="fa-solid fa-magnifying-glass mr-2"></i>Rechercher par nom
                </label>
                <input type="text" 
                       id="name" 
                       name="name" 
                       value="${nameFilter}"
                       placeholder="Ex: Dr. Martin"
                       class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 dark:bg-gray-700 dark:text-gray-200 rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500">
            </div>

            <!-- Department filter -->
            <div>
                <label for="departmentId" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                    <i class="fa-solid fa-building mr-2"></i>Département
                </label>
                <select id="departmentId" 
                        name="departmentId"
                        class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 dark:bg-gray-700 dark:text-gray-200 rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500">
                    <option value="">Tous les départements</option>
                    <c:forEach items="${departments}" var="dept">
                        <option value="${dept.id}" ${selectedDepartmentId == dept.id ? 'selected' : ''}>
                            ${dept.nom}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- Date filter -->
            <div>
                <label for="startDate" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                    <i class="fa-solid fa-calendar-day mr-2"></i>Date de disponibilité <span class="text-gray-400 text-xs">(optionnel)</span>
                </label>
                <input type="date" 
                       id="startDate" 
                       name="startDate" 
                       value="${startDate}"
                       class="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 dark:bg-gray-700 dark:text-gray-200 rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500">
            </div>

            <!-- Submit button -->
            <div class="flex items-end">
                <button type="submit" 
                        class="w-full px-6 py-2 bg-teal-600 text-white rounded-md hover:bg-teal-700 transition font-medium">
                    <i class="fa-solid fa-filter mr-2"></i>Filtrer
                </button>
            </div>
        </form>
    </div>

    <!-- Results count -->
    <c:if test="${not empty doctors}">
        <div class="mb-4 text-gray-600 dark:text-gray-400">
            <p><strong>${doctors.size()}</strong> docteur(s) trouvé(s)</p>
        </div>
    </c:if>

    <!-- Doctors grid -->
    <c:choose>
        <c:when test="${not empty doctors}">
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <c:forEach items="${doctors}" var="doctor">
                    <div class="bg-white dark:bg-gray-800 rounded-lg shadow-md hover:shadow-xl transition-shadow duration-300 overflow-hidden border border-gray-200 dark:border-gray-700">
                        <!-- Doctor card -->
                        <div class="p-6">
                            <!-- Avatar and name section -->
                            <div class="flex items-start space-x-4 mb-4">
                                <div class="flex-shrink-0">
                                    <div class="w-16 h-16 bg-gradient-to-br from-teal-500 to-cyan-600 rounded-full flex items-center justify-center text-white font-bold text-2xl shadow-lg">
                                        ${doctor.nom.substring(0, 1).toUpperCase()}
                                    </div>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <h3 class="text-lg font-bold text-gray-900 dark:text-gray-100 mb-1 leading-tight">
                                        ${doctor.titre != null ? doctor.titre : 'Dr.'} ${doctor.nom}
                                    </h3>
                                    <p class="text-sm text-gray-500 dark:text-gray-400 font-mono">${doctor.matricule}</p>
                                </div>
                            </div>

                            <!-- Divider -->
                            <div class="border-t border-gray-200 dark:border-gray-700 my-4"></div>

                            <!-- Doctor info -->
                            <div class="space-y-3">
                                <!-- Specialty -->
                                <div class="flex items-start">
                                    <i class="fa-solid fa-stethoscope text-teal-600 dark:text-teal-400 mt-1 mr-3 flex-shrink-0"></i>
                                    <div class="flex-1 min-w-0">
                                        <p class="text-xs text-gray-500 dark:text-gray-400 uppercase tracking-wide">Spécialité</p>
                                        <p class="text-sm font-medium text-gray-900 dark:text-gray-100 truncate">${doctor.specialtyName}</p>
                                    </div>
                                </div>

                                <!-- Department -->
                                <div class="flex items-start">
                                    <i class="fa-solid fa-building text-teal-600 dark:text-teal-400 mt-1 mr-3 flex-shrink-0"></i>
                                    <div class="flex-1 min-w-0">
                                        <p class="text-xs text-gray-500 dark:text-gray-400 uppercase tracking-wide">Département</p>
                                        <p class="text-sm font-medium text-gray-900 dark:text-gray-100 truncate">${doctor.departmentName}</p>
                                    </div>
                                </div>

                                <!-- Email -->
                                <div class="flex items-start">
                                    <i class="fa-solid fa-envelope text-teal-600 dark:text-teal-400 mt-1 mr-3 flex-shrink-0"></i>
                                    <div class="flex-1 min-w-0">
                                        <p class="text-xs text-gray-500 dark:text-gray-400 uppercase tracking-wide">Contact</p>
                                        <p class="text-sm text-gray-700 dark:text-gray-300 truncate" title="${doctor.email}">${doctor.email}</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Action button -->
                            <div class="mt-6">
                                <a href="${pageContext.request.contextPath}/doctor/schedule?doctorId=${doctor.id}" 
                                   class="block w-full text-center px-4 py-3 bg-teal-600 text-white rounded-lg hover:bg-teal-700 focus:outline-none focus:ring-2 focus:ring-teal-500 focus:ring-offset-2 transition font-medium text-sm shadow-sm">
                                    <i class="fa-solid fa-calendar-days mr-2"></i>Voir les disponibilités
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <!-- Empty state - shown when no doctors found -->
            <div class="text-center py-12">
                <i class="fa-solid fa-user-doctor text-6xl text-gray-300 dark:text-gray-600 mb-4"></i>
                <c:choose>
                    <c:when test="${not empty nameFilter or not empty selectedDepartmentId or not empty startDate}">
                        <p class="text-gray-600 dark:text-gray-400 text-lg">Aucun docteur trouvé avec ces critères</p>
                        <p class="text-gray-500 dark:text-gray-500 text-sm mt-2">Essayez de modifier vos filtres</p>
                    </c:when>
                    <c:otherwise>
                        <p class="text-gray-600 dark:text-gray-400 text-lg">Aucun docteur disponible pour le moment</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/template/footer.jsp"/>
