[![License: Artistic-2.0](https://img.shields.io/badge/License-Artistic%202.0-0298c3.svg)](https://opensource.org/licenses/Artistic-2.0)

Please raise an Issue if you would like to feedback or assist.

_PLEASE NOTE: FOR THE EDITROW EXAMPLE, PLEASE INSTALL A PATCHED VERSION OF CROMPONENT (V0.0.13) AS FOLLOWS_
- `zef uninstall Cromponent`
- `git clone https://github.com/librasteve/Cromponent.git`
- `cd Cromponent`
- `git checkout -b editrow`
- `zef install .`

# Air::Examples

Playing with the hArc stack (HTMX, Air, Red, Cro) - https://harcstack.org. Some websites with Pico CSS styling.

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

### Run an example and view it
- `cd Air-Examples/bin`
- `ls`
- `raku 00-nano.raku`


## COPYRIGHT AND LICENSE

Copyright(c) 2026 Henley Cloud Consulting Ltd.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.
