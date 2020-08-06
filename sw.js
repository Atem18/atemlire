const ASSETS = [
  "/assets/css/main.css",
  "/index.html",
  "/offline.html",
  "/"
];

let cache_name = "kmdotnet"; // The string used to identify our cache

self.addEventListener("install", event => {
    console.log("installing...");
    event.waitUntil(
        caches
            .open(cache_name)
            .then(cache => {
                return cache.addAll(ASSETS);
            })
            .catch(err => console.log(err))
    );
});

self.addEventListener("fetch", event => {
  if (event.request.url === "{{ site.url }}") {
      event.respondWith(
          fetch(event.request).catch(err =>
              self.cache.open(cache_name).then(cache => cache.match("/offline.html"))
          )
      );
  } else {
      event.respondWith(
          fetch(event.request).catch(err =>
              caches.match(event.request).then(response => response)
          )
      );
  }
});