<template>
  <header class="app-header">
    <div class="logo">MyApp</div>
    <nav>
      <router-link to="/">Search</router-link>
      <a href="#about">About</a>
    </nav>
  </header>
  <router-view />
</template>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
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
  position: fixed;
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
</style>
