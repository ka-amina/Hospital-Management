<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 10/19/2025
  Time: 4:40 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="fr" class="h-full">
<head>
    <meta charset="utf-8">
    <title>Connexion – Clinique Digitale</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- optional dark-mode support -->
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
    <!-- Logo / Title -->
    <div class="text-center">
        <h1 class="text-2xl font-bold text-gray-800 dark:text-gray-100">Clinique Digitale</h1>
        <p class="text-sm text-gray-500 dark:text-gray-400 mt-1">Connectez-vous pour continuer</p>
    </div>

    <!-- Error banner -->
    <c:if test="${not empty error}">
        <div class="bg-red-50 dark:bg-red-900/20 text-red-700 dark:text-red-300 p-3 rounded-lg text-sm">
                ${error}
        </div>
    </c:if>

    <!-- Login form -->
    <form method="post" action="${pageContext.request.contextPath}/login" class="space-y-4">
        <!-- Email -->
        <div>
            <label for="email" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Adresse e-mail</label>
            <input type="email" name="email" id="email" required
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

        <!-- Remember me -->
        <div class="flex items-center">
            <input id="remember" name="remember" type="checkbox"
                   class="h-4 w-4 text-indigo-600 border-gray-300 rounded focus:ring-indigo-500">
            <label for="remember" class="ml-2 block text-sm text-gray-700 dark:text-gray-300">
                Rester connecté
            </label>
        </div>

        <!-- Submit -->
        <button type="submit"
                class="w-full py-2 px-4 rounded-lg bg-indigo-600 hover:bg-indigo-700
                     text-white font-medium transition">
            Connexion
        </button>
    </form>

    <!-- Footer -->
    <p class="text-center text-xs text-gray-500 dark:text-gray-400">
        Vous n'avez pas de compte ? Contactez l'administrateur.
    </p>
</div>
</body>
</html>