     _____          _                              _ 
    |  ___|__  _ __| |_ _   _ _ __   ___  ___   __| |
    | |_ / _ \| '__| __| | | | '_ \ / _ \/ _ \ / _` |
    |  _| (_) | |  | |_| |_| | | | |  __/ (_) | (_| |
    |_|  \___/|_|   \__|\__,_|_| |_|\___|\___/ \__,_|

## Introduction

Fortune on demand creates by default a bottom horizontal split window with the
result of the unix fortune command. The `fortune` command must be available to
run this plugin. If you don't have it, try something like this on a unix
system: `# aptitude install fortune`.

## Mappings

By default, `<Leader>F` invokes the plugin. You can disable all mappings using
`let g:fortuneod_map_keys = 0` in your .vimrc.

To create your prefered map, use for example: `nnoremap ,f
<Plug>FortuneodStart`.

## Configuration

* `g:fortuneod_botright_split 0|1` Default value is 1. Fortuneod opens a
  bottom horizontal split. If you want a top horizontal split set
  `g:fortuneod_botright_split = 0` in your .vimrc.

* `g:fortuneod_map_keys 0|1` Default value is 1. To disable all mapping, set
  it to 0.

## Commands

Pressing `n` in the Fortune window will show another fortune.
