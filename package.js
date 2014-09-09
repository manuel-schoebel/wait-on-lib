Package.describe({
  name: "manuelschoebel:wait-on-lib",
  summary: "Use Meteor Iron-Routers waitOn to load external javascript",
  git: "https://github.com/DerMambo/ms-seo.git",
  version: "0.1.0"
});

Package.onUse(function (api) {
  api.versionsFrom('0.9.0');
  api.use(['coffeescript'], 'client');

  api.export && api.export('IRLibLoader');

  api.addFiles('ir_lib_loader.coffee', 'client');
});

Package.onTest(function (api) {
  // no tests yet
});
