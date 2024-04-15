# GNPyWrapper

[![Build Status](https://github.com/filchristou/GNPyWrapper.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/filchristou/GNPyWrapper.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://UniStuttgart-IKR.github.io/GNPyWrapper.jl/dev)

## Introduction

The goal of the GNPyWrapper.jl is to increase the programmabilty of the already existing [GNPy Package](https://gnpy.readthedocs.io/en/master/) ([github page](https://github.com/Telecominfraproject/oopt-gnpy), [pip page](https://pypi.org/project/gnpy/)).

It is mainly written in [Julia](https://julialang.org/) because this language has some advantages. For example code execution speed.

The work was inspired by the *gnpy-transmission-example* provided by the developers of GNPy.

The idea of the GNPyWrapper.jl is to only use the core functionalities of the [GNPy Package](https://gnpy.readthedocs.io/en/master/). This is done by:

- Getting rid of:

    - the automatic initialization step of the provided *gnpy-transmission-example*
    
    - and thereby getting rid of json data format and merging process


- Providing:

    - network element example descriptions in "native" Julia language 

        - which were created from *gnpy-transmission-example* with json-data
    
    - from which you can generate gnpy objects and vice versa

    - a automatic process from which you can generate element and path descriptions

    - two examples

        1. "example_01.jl"
        2. "example_02.jl"

### Advantages

- interface from Julia to Python for GNPy Package and vice versa

- full control over gnpy elements

- also, better "understanding" of what is going on in the core of GNPy



### Disadvantages

right now:

- less automation


## Installation and Initialization of GNPyWrapper.jl

1. git clone this repo
2. run julia
3. activate the GNPyWrapper.jl
4. activate/install julia specifc packages 

    1. CondaPkg

        > using CondaPkg
        
        > ]conda add python 
    
    2. PythonCall
        
        > using PythonCall

5. install GNPy from pip

    > ]conda pip_add gnpy==2.8.0



## Examples

First example

- Set up:

    - you need to copy *cli_example_02.py* and paste it in the correct folder of GNPy (gnpy.core.tools) next to *cli_example*
        - the *cli_example_02.py* can be found in GNPyWrapper.jl\test\gnpy_transmission_example_script 
        - the folder is located in the \GNPyWrapper.jl\.CondaPkg\env\Lib\site-packages\gnpy\tools

- From Julia in the GNPyWrapper.jl\test folder run:

    > include("example_01.jl")

Second example

- Set up:

    - you need to copy *cli_example_02.py* and paste it in the correct folder of GNPy (gnpy.core.tools) next to *cli_example*
        - the *cli_example_02.py* can be found in GNPyWrapper.jl\test\gnpy_transmission_example_script 
        - the folder is located in the \GNPyWrapper.jl\.CondaPkg\env\Lib\site-packages\gnpy\tools

- From Julia in GNPyWrapper.jl\test folder run:

    > include("example_02.jl")
