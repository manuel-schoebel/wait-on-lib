Package.describe({
  name: "manuelschoebel:wait-on-lib",
  summary: "Use Meteor Iron-Routers waitOn to load external javascript",
  git: "https://github.com/DerMambo/wait-on-lib.git",
  version: "0.2.0"
});

Package.onUse(function (api) {
  api.versionsFrom('1.0');
  api.use(['coffeescript'], 'client');

  api.export && api.export('IRLibLoader');

  api.addFiles('ir_lib_loader.coffee', 'client');
});

Package.onTest(function (api) {
  // no tests yet
});
