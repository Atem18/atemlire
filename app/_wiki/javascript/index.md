---
title: Javascript
permalink: "/wiki/javascript/"

---
## Set automatically Dark mode in Nuxt.JS and Vuetify

Put the following code to your layout(s)

```javascript
created () {
  this.initDarkMode()
},
methods: {
  initDarkMode () {
    const mq = window.matchMedia('(prefers-color-scheme: dark)')
    mq.addEventListener('change', (e) => {
      this.$vuetify.theme.dark = e.matches
    })
    if (mq.matches) {
      this.$vuetify.theme.dark = true
    }
  }
}
```