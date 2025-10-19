<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 10/20/2025
  Time: 12:37 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="fr" class="h-full">
<head>
    <meta charset="utf-8">
    <title>Inscription – Clinique Digitale</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {darkMode: 'class'};
        if (localStorage.theme === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
            document.documentElement.classList.add('dark');
        } else {
            document.documentElement.classList.remove('dark');
        }
    </script>
</head>
<body class="bg-gray-50 dark:bg-gray-900 flex items-center justify-center min-h-screen">
<div class="w-full max-w-md space-y-6 p-8 bg-white dark:bg-gray-800 rounded-2xl shadow-lg">
    <div class="text-center">
        <h1 class="text-2xl font-bold text-gray-800 dark:text-gray-100">Créer mon compte patient</h1>
        <p class="text-sm text-gray-500 dark:text-gray-400 mt-1">Remplissez le formulaire ci-dessous</p>
    </div>

    <c:if test="${not empty error}">
        <div class="bg-red-50 dark:bg-red-900/20 text-red-700 dark:text-red-300 p-3 rounded-lg text-sm">
                ${error}
        </div>
    </c:if>

    <form method="post" class="space-y-4">
        <!-- Full name -->
        <div>
            <label for="nom" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Nom complet</label>
            <input type="text" name="nom" id="nom" required
                   value="${dto.nom}"
                   class="mt-1 w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg
                      bg-gray-50 dark:bg-gray-700 text-gray-800 dark:text-gray-200
                      focus:ring-indigo-500 focus:border-indigo-500">
        </div>

        <!-- Email -->
        <div>
            <label for="email" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Adresse e-mail</label>
            <input type="email" name="email" id="email" required
                   value="${dto.email}"
                   class="mt-1 w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg
                      bg-gray-50 dark:bg-gray-700 text-gray-800 dark:text-gray-200
                      focus:ring-indigo-500 focus:border-indigo-500">
        </div>

        <!-- Password -->
        <div>
            <label for="password" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Mot de
                passe</label>
            <input type="password" name="password" id="password" required
                   class="mt-1 w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg
                      bg-gray-50 dark:bg-gray-700 text-gray-800 dark:text-gray-200
                      focus:ring-indigo-500 focus:border-indigo-500">
        </div>

        <!-- CIN -->
        <div>
            <label for="cin" class="block text-sm font-medium text-gray-700 dark:text-gray-300">CIN</label>
            <input type="text" name="cin" id="cin" required
                   value="${dto.cin}"
                   class="mt-1 w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg
                      bg-gray-50 dark:bg-gray-700 text-gray-800 dark:text-gray-200
                      focus:ring-indigo-500 focus:border-indigo-500">
        </div>

        <!-- Birth date -->
        <div>
            <label for="dateNaissance" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Date de
                naissance</label>
            <input type="date" name="dateNaissance" id="dateNaissance" required
                   value="${dto.dateNaissance}"
                   class="mt-1 w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg
                      bg-gray-50 dark:bg-gray-700 text-gray-800 dark:text-gray-200
                      focus:ring-indigo-500 focus:border-indigo-500">
        </div>

        <!-- Gender -->
        <div>
            <label for="sexe" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Sexe</label>
            <select name="sexe" id="sexe" required
                    class="mt-1 w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg
                       bg-gray-50 dark:bg-gray-700 text-gray-800 dark:text-gray-200
                       focus:ring-indigo-500 focus:border-indigo-500">
                <c:forEach items="${genders}" var="g">
                    <option value="${g}" ${dto.sexe eq g ? 'selected' : ''}>${g}</option>
                </c:forEach>
            </select>
        </div>

        <!-- Submit -->
        <button type="submit"
                class="w-full py-2 px-4 rounded-lg bg-indigo-600 hover:bg-indigo-700
                     text-white font-medium transition">
            S'inscrire
        </button>
    </form>

    <p class="text-center text-xs text-gray-500 dark:text-gray-400">
        Déjà un compte ? <a href="${pageContext.request.contextPath}/login"
                            class="text-indigo-600 hover:underline">Connexion</a>
    </p>
</div>
</body>
</html>
