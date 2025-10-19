<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="fr" class="h-full">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>${param.title}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            darkMode: 'class',          // ‘class’ strategy, exactly like your script expects
            content: ['**/*.jsp'],      // not scanned, but we still safelist the tokens
            safelist: [
                'dark:bg-gray-900',
                'dark:bg-gray-800',
                'dark:bg-gray-700',
                'dark:text-gray-200',
                'dark:text-gray-300',
                'dark:text-white',
                'dark:border-gray-700',
                'dark:border-gray-800',
                'dark:from-gray-900',
                'dark:via-gray-800',
                'dark:to-gray-900',
                'dark:hover:bg-gray-700',
                'dark:hover:bg-gray-800',
                'dark:text-indigo-400',
                'dark:hover:text-indigo-400',
                'hidden'
            ]
        };
    </script>

    <!-- 1️⃣ Prevent flash of wrong theme -->
    <script>
        (function () {
            const dark = localStorage.theme === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches);
            if (dark) document.documentElement.classList.add('dark');
        })();
    </script>
</head>

<body class="h-full bg-white dark:bg-gray-900 text-gray-800 dark:text-gray-200">

<!-- ========== HEADER ========== -->
<header class="sticky top-0 z-50 bg-white/90 dark:bg-gray-900/90 backdrop-blur shadow-sm dark:shadow-none border-b border-gray-200 dark:border-gray-800">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-16">

            <!-- Logo -->
            <a href="${pageContext.request.contextPath}/"
               class="text-xl font-bold text-indigo-600 dark:text-indigo-400">Clinique Digitale</a>

            <!-- Desktop nav -->
            <nav class="hidden md:flex items-center gap-6">
                <c:choose>
                    <c:when test="${not empty sessionScope.authUser}">
                        <a href="${pageContext.request.contextPath}/${sessionScope.userRole.toLowerCase()}/dashboard"
                           class="text-sm font-medium hover:text-indigo-600 dark:hover:text-indigo-400">Tableau de
                            bord</a>
                        <form method="post" action="${pageContext.request.contextPath}/logout" class="inline">
                            <button class="text-sm font-medium hover:text-indigo-600 dark:hover:text-indigo-400">
                                Déconnexion
                            </button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login"
                           class="text-sm font-medium hover:text-indigo-600 dark:hover:text-indigo-400">Connexion</a>
                        <a href="${pageContext.request.contextPath}/register"
                           class="px-3 py-1.5 rounded-md bg-indigo-600 text-white text-sm font-medium hover:bg-indigo-700">S’inscrire</a>
                    </c:otherwise>
                </c:choose>

                <!-- Dark toggle -->
                <button id="theme-toggle" aria-label="Toggle dark mode"
                        class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition">
                    <!-- Sun icon -->
                    <svg id="icon-sun" class="hidden w-5 h-5 text-yellow-500" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"/>
                    </svg>
                    <!-- Moon icon -->
                    <svg id="icon-moon" class="hidden w-5 h-5 text-slate-400" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M12 3a9 9 0 108.9 7.64 5.39 5.39 0 01-9.2-5.61 5.4 5.4 0 011.3-3.5A9 9 0 0012 3z"/>
                    </svg>
                </button>
            </nav>

            <!-- Mobile menu button -->
            <div class="md:hidden flex items-center gap-2">
                <button id="mobile-theme-toggle" aria-label="Toggle dark mode"
                        class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800">
                    <svg class="w-5 h-5 text-gray-600 dark:text-gray-300" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M12 3a9 9 0 108.9 7.64 5.39 5.39 0 01-9.2-5.61 5.4 5.4 0 011.3-3.5A9 9 0 0012 3z"/>
                    </svg>
                </button>
                <button id="mobile-menu-button" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800">
                    <svg class="w-6 h-6 text-gray-600 dark:text-gray-300" fill="none" stroke="currentColor"
                         viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M4 6h16M4 12h16M4 18h16"/>
                    </svg>
                </button>
            </div>
        </div>

        <!-- Mobile panel -->
        <div id="mobile-menu" class="hidden md:hidden pb-4 pt-2 border-t border-gray-200 dark:border-gray-800">
            <c:choose>
                <c:when test="${not empty sessionScope.authUser}">
                    <a href="${pageContext.request.contextPath}/${sessionScope.userRole.toLowerCase()}/dashboard"
                       class="block px-3 py-2 rounded-md text-sm font-medium hover:bg-gray-100 dark:hover:bg-gray-800">Tableau
                        de bord</a>
                    <form method="post" action="${pageContext.request.contextPath}/logout" class="mt-1">
                        <button class="w-full text-left px-3 py-2 rounded-md text-sm font-medium hover:bg-gray-100 dark:hover:bg-gray-800">
                            Déconnexion
                        </button>
                    </form>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login"
                       class="block px-3 py-2 rounded-md text-sm font-medium hover:bg-gray-100 dark:hover:bg-gray-800">Connexion</a>
                    <a href="${pageContext.request.contextPath}/register"
                       class="mt-1 block px-3 py-2 rounded-md text-sm font-medium bg-indigo-600 text-white hover:bg-indigo-700">S’inscrire</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>
<!-- ========== END HEADER ========== -->

<!-- 2️⃣ Toggle script -->
<script>
    /* Show correct icon on load */
    function updateIcons() {
        const dark = document.documentElement.classList.contains('dark');
        document.getElementById('icon-sun').classList.toggle('hidden', !dark);
        document.getElementById('icon-moon').classList.toggle('hidden', dark);
    }

    updateIcons();

    /* Toggle theme */
    function toggleTheme() {
        const html = document.documentElement;
        html.classList.toggle('dark');
        localStorage.theme = html.classList.contains('dark') ? 'dark' : 'light';
        updateIcons();
    }

    /* Desktop + mobile buttons */
    document.getElementById('theme-toggle')?.addEventListener('click', toggleTheme);
    document.getElementById('mobile-theme-toggle')?.addEventListener('click', toggleTheme);

    /* Mobile menu */
    document.getElementById('mobile-menu-button').addEventListener('click', () => {
        document.getElementById('mobile-menu').classList.toggle('hidden');
    });
</script>