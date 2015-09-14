/**
 * Comparing versions of globally-installed modules and the versions in
 * a package.json
 */

"use strict";

var fs = require("fs");
var path = require("path");
var home = process.env.HOME;
var filepath = process.argv[2];
if (!fs.existsSync(filepath)) {
  process.exit(1);
}
var pkg = require(filepath);
var deps = pkg.dependencies;
var devDeps = pkg.devDependencies;

console.log([
  "dep = global = local",
  "--------------------",
].join("\n"));
for (var dep in deps) {
  spit(dep, deps[dep]);
}

console.log([
  "",
  "devDep = global = local",
  "-----------------------",
].join("\n"));
for (var dep in devDeps) {
    spit(dep, devDeps[dep]);
}

function spit(name, lversion) {
  var gversion = "?";
  var gpath = path.join(home, "node_modules", name, "package.json");
  if (fs.existsSync(gpath)) {
    gversion = require(gpath).version;
  }
  console.log("%s = %s = %s", name, gversion, lversion);
}
