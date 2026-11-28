const prefix = 'agenda-shell-';
const version = prefix + 'v3';
const shell = ['./', './index.html', './portada.css', './manifest.webmanifest', './icons/agenda-192.png', './icons/agenda-512.png', './icons/apple-touch-icon.png'];

self.addEventListener('install', event => {
  event.waitUntil(caches.open(version).then(cache => cache.addAll(shell)));
});

self.addEventListener('activate', event => {
  event.waitUntil(caches.keys().then(keys => Promise.all(
    keys.filter(key => key.startsWith(prefix) && key !== version).map(key => caches.delete(key))
  )));
});

self.addEventListener('fetch', event => {
  const request = event.request;
  if(request.method !== 'GET' || !request.url.startsWith(self.registration.scope)) return;
  if(request.mode === 'navigate'){
    event.respondWith(fetch(request).catch(() => caches.match(new URL('index.html', self.registration.scope))));
    return;
  }
  event.respondWith(caches.match(request).then(cached => cached || fetch(request)));
});
