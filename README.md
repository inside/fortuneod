Fortuneod - Fortune on demand
=============================

Description
-----------

Fortune on demand creates a bottom (by default) horizontal split window with the result of the unix fortune command.

Configuration
-------------

`g:fortuneod_botright_split 0|1`: Default value is 1. By default, fortuneod opens a bottom horizontal split. If you want a top horizontal split set `g:fortuneod_botright_split = 0` in your .vimrc.

Mappings
--------

`<Leader>F` invokes the plugin if it is not already mapped. If you don't wan't `<Leader>F`, create your prefered map, for example: `noremap ,f <Plug>FortuneodStart`

Commands
--------

Pressing `n` in the Fortune window will show another fortune.
