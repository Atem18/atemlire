---
title: Index

---
## Set automatically Dark mode in Nuxt.JS and Vuetify

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