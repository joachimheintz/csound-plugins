# Repository of plugins

This is a repository for plugins for [csound](https://csound.com/). 

# Plugins in this repo

### jsfx

jsfx support in csound, allows any REAPER's jsfx plugin to be loaded and controlled inside csound

### klib

very efficient hashtables for csound

### poly


Parallel and sequential multiplexing opcodes, they enable to create and control multiple instances of a csound opcode

### else

A miscellaneous collection of effects (distortion, saturation, ring-modulation), noise generators (low freq. noise, chaos attractors, etc), envelope generators, etc.


# Installation


    git clone https://github.com/csound-plugins/csound-plugins
    cd csound-plugins
    mkdir build & cd build
    cmake ..
    make
    sudo make install


# Documentation of all plugins

Go to [Documentation](https://csound-plugins.github.io/csound-plugins/)


## Use the offline documentation

FIrst install [mkdocs](https://www.mkdocs.org/):

    pip3 install mkdocs --user

At the root folder of the project, do: 

    mkdocs build

The documentation can then be browsed at `site/index.html`


## Generate the documentation

    ./scripts/generate-docs


# Contributing 

See [Contributing](https://github.com/csound-plugins/csound-plugins/wiki/contributing)
