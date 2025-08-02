[![License: Artistic-2.0](https://img.shields.io/badge/License-Artistic%202.0-0298c3.svg)](https://opensource.org/licenses/Artistic-2.0)

Please raise an Issue if you would like to feedback or assist.

_PLEASE NOTE: FOR THE EDITROW EXAMPLE, PLEASE INSTALL A PATCHED VERSION OF CROMPONENT (V0.0.13) AS FOLLOWS_
- `zef uninstall Cromponent`
- `zef install https://github.com/librasteve/Cromponent.git`

# Air::Examples

Playing with the hArc stack (HTMX, Air, Red, Cro) - https://harcstack.org. Some websites with Pico CSS styling.

# Local

## GETTING STARTED

Install raku - eg. from [rakubrew](https://rakubrew.org), then:

### Install Air, Cro & Red
- `zef install --/test cro`
- `zef install Red --exclude="pq:ver<5>"`
- `zef install Air`

If this is your first Raku installation, you may need some native libraries (e.g. for UUID for Red), please check the module specific documentation and issues.

You will also need a SASS compiler such as Dart (see below).

### Git clone this repo
- `git clone https://github.com/librasteve/Air-Examples.git`
- `cd Air-Examples`

### Set ENV vars for host and port
- `export CRO_WEBSITE_HOST="0.0.0.0"`
- `export CRO_WEBSITE_PORT="4000"`

### Run and view it
- `raku -I. service.raku`
- Open a browser and go to `http://localhost:3000`

Select the example site you want by commenting out the others in the `Examples.rakumod` file.

You will note that cro has many other options as documented at [Cro](https://cro.raku.org) if you want to deploy to a production server.

---

# Server

## Development

### Pico CSS (IntelliJ)
install sass (in the static/css dir)
- follow this [guide](https://www.jetbrains.com/help/webstorm/transpiling-sass-less-and-scss-to-css.html)
    - install IJ sass & file watcher plugins
    - `cd static/css`
    - `brew install npm`
    - `npm install -g sass`
    - `npm install @picocss/pico`
    - in styles.css, `@use "node_modules/@picocss/pico/scss";`
    - `sass styles.scss styles.css`  [target is then styles.scss/styles]
    - `--load-path=node_modules/@picocss/pico/scss/`
      from https://picocss.com
- some tweaks to root styles (mainly to reduce scale) from [here](https://github.com/picocss/pico/discussions/482)

## Deployment
- Install sass (dart) [adjust version as needed]
- `curl -L -o dart-sass.tar.gz https://github.com/sass/dart-sass/releases/download/1.77.5/dart-sass-1.77.5-linux-x64.tar.gz`
- `tar -xzf dart-sass.tar.gz`
- `sudo mv dart-sass /opt/dart-sass`
- `sudo ln -s /opt/dart-sass/sass /usr/local/bin/sass`
- Install Air, Cro & Red (see above)
- `git clone https://github.com/librasteve/Air-Examples.git && cd Air-Examples`
- `zef install . --force-install --/test`
- adjust .cro.yml for your needs (e.g. HTTPS) -or-
- `raku -Ilib service.raku` [edit port if needed] -or-
- `nohup raku -Ilib service.raku >> server.log 2>&1`  <=== detach from terminal [note PID]
- `tail -f server.log` and finally `kill -9 PID`  [ps -ef | grep raku]

## Build
this site runs on a linux server preloaded with git, raku, zef (& docker-compose) which can be set up with raku [CLI::AWS::EC2-Simple](https://raku.land/zef:librasteve/CLI::AWS::EC2-Simple)
- `sudo apt-get install build-essential` (for Digest::SHA1::Native)
- viz. https://chatgpt.com/share/6748a185-c690-8009-96ff-80bf8018dd7d
    - `sudo apt-get install nginx`
    - `sudo systemctl start nginx`
    - `sudo systemctl enable nginx`
    - etc
    - `vi simple.raku`   <= port to 8888
    - `raku simple.raku`
- using librasteve for certbot

---

# COPYRIGHT AND LICENSE

Copyright(c) 2025 Henley Cloud Consulting Ltd.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.
