<template>
  <div class="pdf-viewer">
    <div class="iframe-container">
      <iframe
        src="https://docs.google.com/presentation/d/e/2PACX-1vSR9GbLD-22P94Yy7U7VrZmtSCgoFpbLmbwpUstvFzGs21ZEJf3Sbjht2z4CQpmR6oh2GqrZumHaTPE/embed?start=false&loop=false&delayms=3000"
        frameborder="0"
        width="960"
        height="749"
        allowfullscreen="true"
        mozallowfullscreen="true"
        webkitallowfullscreen="true"
      ></iframe>
    </div>
  </div>
</template>

<style scoped>
.pdf-viewer {
  width: 100%;
  max-width: 800px;
  margin: 20px auto;
}

.iframe-container {
  position: relative;
  width: 100%;
  padding-top: 56.25%;
}

.iframe-container iframe {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  border: 0;
}
</style>
