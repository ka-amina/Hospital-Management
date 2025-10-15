<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 10/15/2025
  Time: 1:59 AM
  To change this template use File | Settings | File Templates.
--%>
</main>

<script>
    function toggleSidebar() {
        document.getElementById('sidebar').classList.toggle('-translate-x-full');
    }

    function hideOnMobile() {
        if (window.innerWidth < 768) toggleSidebar();
    }

    document.getElementById('themeToggle').addEventListener('click', () => {
        document.documentElement.classList.toggle('dark');
        localStorage.setItem('dark', document.documentElement.classList.contains('dark'));
    });
</script>

<style>
    #sidebar {
        transition: width .3s
    }

    .sidebar-text {
        opacity: 0;
        transition: opacity .2s
    }

    #sidebar:hover .sidebar-text {
        opacity: 1
    }

    @media (min-width: 768px) {
        #sidebar:hover ~ header,
        #sidebar:hover ~ main {
            margin-left: 16rem;
            transition: margin-left .3s;
        }
    }
</style>
</body>
</html>