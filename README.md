General
====

Initial
====

> npm install

note:
don't do bower install

config
====

> ./app/config/error-code-factory.coffee
> ./app/config/http.coffee
> ./app/config/router.coffee

Dev mode
====

gulp dev [--release]

Watch & Auto compile all files and start a static-server.

Use dev configuation by defualt


--release

Run dev with release config files

note:

add new file will not triger compile, you need rerun gulp dev to make new file compile.

Build
====

gulp build [--release]

Compile&concat all files to build path

Use dev configuation by defualt


--release

Run build with release config files


static-server
====

gulp static-server [--build]

Start a static server

Use dev files by defualt


--build

Run static-server with builded files

note:

js file and template are not compressed.