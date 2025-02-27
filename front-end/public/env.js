/*
 * Define default environment variables of the application.
 * You can customize these values by overriding them to public/configs/env-local.js (create this file if not exist).
 * Don't forget to uncomment the env-local.js <script> tag in index.html.
 * To enable tracking, replace tracker.appId with your app ID in env-local.js.
 */

window.config = {
  env: 'dev',
  apiServices: {
    backend: 'http://127.0.0.1:3000/api/v1',
  },
};
