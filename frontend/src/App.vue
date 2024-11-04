<template>
  <div id="app">
    <header class="app-header">
      <router-link to="/" class="logo">MyApp</router-link>
      <nav>
        <!-- TODO: 他に追加したい要素ができたら消す -->
        <a href="#about">About</a>
      </nav>
    </header>
    <router-view />
    <footer class="app-footer">
      <ul class="footer-links">
        <li>
          <a href="https://github.com/youha6149" target="_blank">Github</a>
        </li>
        <li>
          <a href="https://qiita.com/youha" target="_blank">Qiita</a>
        </li>
        <li>
          <a
            href="https://github.com/youha6149/nationwide_search_app"
            target="_blank"
            >Repository</a
          >
        </li>
      </ul>
      <div class="copyright">© 2024 MyApp</div>
    </footer>
  </div>
</template>

<style>
body {
  margin: 0%;
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.app-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-image: linear-gradient(
    90deg,
    rgba(196, 182, 197, 1),
    rgba(35, 117, 163, 1)
  );
  padding: 10px 20px;
  color: white;
  position: relative;
  top: 0;
  left: 0;
  right: 0;
  width: 100%;
  box-sizing: border-box;
}

.logo {
  font-size: 24px;
  font-weight: bold;
}

nav {
  display: flex;
  gap: 20px;
}

nav a {
  font-weight: bold;
  color: white;
  text-decoration: none;
}

nav a.router-link-exact-active {
  color: white;
}

nav a:hover {
  text-decoration: underline;
}

.app-footer {
  display: flex;
  flex-direction: column;
  align-items: center;
  background-image: linear-gradient(
    90deg,
    rgba(196, 182, 197, 1),
    rgba(35, 117, 163, 1)
  );
  padding: 10px 0;
  margin-top: auto;
  width: 100%;
}

.footer-links {
  display: flex;
  gap: 20px;
  list-style: none;
  padding: 0;
  margin: 0 0 10px 0;
}

.footer-links li a {
  color: white;
  text-decoration: none;
}

.footer-links li a:hover {
  text-decoration: underline;
}

.copyright {
  color: white;
  text-align: center;
  font-size: 10px;
}
</style>
