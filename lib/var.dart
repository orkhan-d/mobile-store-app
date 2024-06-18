Uri getAPI(String path) {
  return Uri(scheme: 'http', host: '127.0.0.1', port: 8000, path: '/api$path');
}

String getAPIString(String path) {
  return "http://127.0.0.1:8000/api$path";
}