<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="/WEB-INF/template/header.jsp">
    <jsp:param name="title" value="Accueil – Clinique Digitale"/>
</jsp:include>

<!-- Hero -->
<section
        class="bg-gradient-to-br from-indigo-50 via-white to-cyan-50 dark:from-gray-900 dark:via-gray-800 dark:to-gray-900">
    <div class="max-w-7xl mx-auto px-4 py-20 text-center">
        <h1 class="text-4xl md:text-5xl font-extrabold text-gray-800 dark:text-white">
            Votre santé <span class="text-indigo-600">entre de bonnes mains</span>
        </h1>
        <p class="mt-4 max-w-2xl mx-auto text-lg text-gray-600 dark:text-gray-300">
            Planifiez vos consultations en ligne, suivez vos rendez-vous et accédez à vos notes médicales en toute
            simplicité.
        </p>

        <!-- CTA buttons -->
        <div class="mt-10 flex flex-col sm:flex-row gap-4 justify-center">
            <c:choose>
                <%-- Logged-in user : go to dashboard --%>
                <c:when test="${not empty sessionScope.authUser}">
                    <a href="${pageContext.request.contextPath}/${sessionScope.userRole.toLowerCase()}/dashboard"
                       class="px-6 py-3 rounded-lg bg-indigo-600 text-white font-medium hover:bg-indigo-700 transition">
                        Mon tableau de bord
                    </a>
                    <form method="post" action="${pageContext.request.contextPath}/logout" class="inline">
                        <button type="submit"
                                class="px-6 py-3 rounded-lg bg-gray-200 dark:bg-gray-700 text-gray-800 dark:text-white font-medium hover:bg-gray-300 dark:hover:bg-gray-600 transition">
                            Déconnexion
                        </button>
                    </form>
                </c:when>

                <%-- Visitor : register / login --%>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/register"
                       class="px-6 py-3 rounded-lg bg-indigo-600 text-white font-medium hover:bg-indigo-700 transition">
                        Créer un compte patient
                    </a>
                    <a href="${pageContext.request.contextPath}/login"
                       class="px-6 py-3 rounded-lg bg-white dark:bg-gray-800 text-indigo-600 dark:text-indigo-400 font-medium border border-indigo-600 dark:border-indigo-400 hover:bg-indigo-50 dark:hover:bg-gray-700 transition">
                        Se connecter
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</section>

<!-- Features grid -->
<section class="py-16 bg-white dark:bg-gray-800">
    <div class="max-w-7xl mx-auto px-4">
        <h2 class="text-3xl font-bold text-center text-gray-800 dark:text-white">Nos services</h2>
        <div class="mt-12 grid md:grid-cols-3 gap-8 text-center">

            <!-- Patient card -->
            <div class="p-6 rounded-xl bg-gray-50 dark:bg-gray-900 border border-gray-200 dark:border-gray-700">
                <div class="text-indigo-600 mb-4">
                    <svg class="w-12 h-12 mx-auto" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                    </svg>
                </div>
                <h3 class="text-xl font-semibold text-gray-800 dark:text-white">Patients</h3>
                <p class="mt-2 text-gray-600 dark:text-gray-300">
                    Prenez rendez-vous en ligne, consultez vos historiques et recevez des rappels automatiques.
                </p>
            </div>

            <!-- Doctor card -->
            <div class="p-6 rounded-xl bg-gray-50 dark:bg-gray-900 border border-gray-200 dark:border-gray-700">
                <div class="text-indigo-600 mb-4">
                    <svg class="w-12 h-12 mx-auto" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                    </svg>
                </div>
                <h3 class="text-xl font-semibold text-gray-800 dark:text-white">Médecins</h3>
                <p class="mt-2 text-gray-600 dark:text-gray-300">
                    Gérez vos disponibilités, consultez votre agenda et rédigez vos notes médicales.
                </p>
            </div>

            <!-- Admin card -->
            <div class="p-6 rounded-xl bg-gray-50 dark:bg-gray-900 border border-gray-200 dark:border-gray-700">
                <div class="text-indigo-600 mb-4">
                    <svg class="w-12 h-12 mx-auto" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"/>
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                    </svg>
                </div>
                <h3 class="text-xl font-semibold text-gray-800 dark:text-white">Administration</h3>
                <p class="mt-2 text-gray-600 dark:text-gray-300">
                    Paramétrez les spécialités, départements et supervisez l'activité globale.
                </p>
            </div>
        </div>
    </div>
</section>

<!-- CTA banner -->
<!-- CTA banner -->
<section class="py-12 bg-indigo-600 dark:bg-indigo-800">
    <div class="max-w-4xl mx-auto px-4 text-center">
        <h2 class="text-2xl font-bold text-white">Prenez rendez-vous en quelques clics</h2>
        <p class="mt-2 text-indigo-100">Rejoignez-nous dès aujourd'hui.</p>
        <div class="mt-6">
            <a href="${pageContext.request.contextPath}/register"
               class="inline-block px-6 py-3 rounded-lg bg-white text-indigo-600 font-medium hover:bg-indigo-50 transition">
                S'inscrire maintenant
            </a>
        </div>
    </div>
</section>
<jsp:include page="/WEB-INF/template/footer.jsp"/>