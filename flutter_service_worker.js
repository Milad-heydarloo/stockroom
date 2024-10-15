'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"index.html": "849adeb97e1f5fe93528aa5c5edfc847",
"/": "849adeb97e1f5fe93528aa5c5edfc847",
"favicon.png": "2ce08210fe3dea224fb9ece8f274c7ce",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"canvaskit/canvaskit.js": "5caccb235fad20e9b72ea6da5a0094e6",
"canvaskit/chromium/canvaskit.js": "ffb2bb6484d5689d91f393b60664d530",
"canvaskit/chromium/canvaskit.wasm": "393ec8fb05d94036734f8104fa550a67",
"canvaskit/canvaskit.wasm": "d9f69e0f428f695dc3d66b3a83a4aa8e",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"main.dart.js": "c05d1fdb34e786f05095e48d01953439",
"icons/Icon-512.png": "faddf743c84d4843c323ed83c676e345",
"icons/Icon-maskable-192.png": "0f7485b634a11edbe0cd9b058c722c1b",
"icons/Icon-maskable-512.png": "faddf743c84d4843c323ed83c676e345",
"icons/Icon-192.png": "0f7485b634a11edbe0cd9b058c722c1b",
"manifest.json": "b28a7e46b6f9145b47a085b6e482196d",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "b37ae0f14cbc958316fac4635383b6e8",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "aa1ec80f1b30a51d64c72f669c1326a7",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "5178af1d278432bec8fc830d50996d6f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "b93248a553f9e8bc17f1065929d5934b",
"assets/packages/flutter_map/lib/assets/flutter_map_logo.png": "208d63cc917af9713fc9572bd5c09362",
"assets/FontManifest.json": "4d58d5d2256a903578bcb7228e2cdac4",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/NOTICES": "c5e23f561b18527482c0bddb6020ce77",
"assets/assets/satter.png": "0506b348fd2457e46a4a754ff1f2918f",
"assets/assets/swirls.svg": "ebd60d6baf67414628147028ea5382d0",
"assets/assets/sattersvg.svg": "f9175dc08fc74490daab90a57345c214",
"assets/assets/ins.png": "a624026978083046a9fbcf07443ea670",
"assets/assets/calendar.svg": "44dc5e7c4290b9312b91f0cb3377bd2d",
"assets/assets/app-logo.svg": "b0ce2ba920596a3a8e506d5a27b63cb7",
"assets/assets/swirls3.svg": "0691e7353e1767ce6b2f8ca43a80fec9",
"assets/assets/medail.svg": "bb392b5d8b6f0881891c5fcb1efd56db",
"assets/assets/dm.ttf": "001fe3b28401d348cb0d122c65bbf9b6",
"assets/assets/logo.svg": "50ac89287e374ce31bacbc5baede9bb3",
"assets/assets/invoice.svg": "ed6bd474d30a8d750aa924a78918b1ac",
"assets/assets/satereh.svg": "095199b76ea65abf82009cea37c7b72f",
"assets/assets/garland.svg": "6e75c8b61d9ab548483d72a5a4a0560a",
"assets/assets/profile.jpg": "1e4cf308782c44346db361e95c003a6c",
"assets/assets/shahre.png": "9509226916cb692b1c0a7b6ed1db5f04",
"assets/assets/resume.svg": "46677fc92c26b05ef05f6f57ee6cbf2f",
"assets/assets/Untitled.gif": "3000c475d5532bbf7cc206464ac15dec",
"assets/assets/swirls2.svg": "5b91d6eef2a3c06a44b2ffe870538535",
"assets/assets/mohrsv.svg": "08949cb494c1e27875fb2c3ede5d8a29",
"assets/assets/animation.gif": "bfa6b48fe35cc52b28f7359ade03d584",
"assets/assets/swirls1.svg": "7b2b0976d9656ce4badcb72c1d1eb9a2",
"assets/assets/document.svg": "c0d272e3925fb4d1e2fa5828863da184",
"assets/assets/satereha.png": "0506b348fd2457e46a4a754ff1f2918f",
"assets/fonts/dm.ttf": "001fe3b28401d348cb0d122c65bbf9b6",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/fonts/vazir_fd_medium_wol.ttf": "5340bb6f45ae63ffea8b8be3e7da5d91",
"assets/AssetManifest.bin": "1b489133f514d0bc2c651b4e9802aede",
"assets/AssetManifest.json": "8eb57b8ed3b5fde528942c6be10c058d",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"version.json": "af6fb5b37b5d6dcc27ceea9b3c54ddaf"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
