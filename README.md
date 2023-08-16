# Repository of plugins

This is a repository for plugins for [csound](https://csound.com/). 

--------------

# Documentation of all plugins

Go to [Documentation](https://csound-plugins.github.io/csound-plugins/)

--------------


# Plugins in this repo

### klib

very efficient hashtables (dictionaries) and other data structures for csound


### poly

Parallel and sequential multiplexing opcodes, they enable the creation and control of multiple 
instances of a csound opcode


## beosc

additive synthesis implementing the loris model sine+noise


### else

A miscellaneous collection of effects (distortion, saturation, ring-modulation), noise 
generators (low freq. noise, chaos attractors, etc), envelope generators, etc.


### jsfx

jsfx support in csound, allows any REAPER's jsfx plugin to be loaded and controlled inside csound


## pathtools

opcodes to handle paths and filenames in a cross-platform manner



----------------

# Download

https://github.com/csound-plugins/csound-plugins/releases

----------------

# Build

```bash
git clone  https://github.com/csound-plugins/csound-plugins
cd csound-plugins
git submodule update --init --recursive
mkdir build
cd build
cmake ..
cmake --build . --parallel
cmake --install .
```
