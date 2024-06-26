# Sterling
Sterling is a system for defining extensible languages using inference
rules.


## Extensible Languages
There are several views of extensible languages in the literature.
The view we use is one with a base language and
independently-developed extensions to this base, and guaranteed
composition of the base language and extensions.

The base language introduces a set of syntactic categories and
constructors building them.  It also introduces a set of semantic
analyses.

Extensions can add new constructors building the syntactic categories
from the base language and define the base language's semantic
analyses on them.  Any such new constructors are also given a
projection to the base language.  Extensions can also introduce new
syntactic categories and constructors of them, as well as new semantic
analyses.  When we combine multiple extensions, these new analyses are
defined on constructors from other extensions by using the definition
on the projection.

A more in-depth discussion of language extension can be found [in the
documentation](docs/extensibleLanguages.md).


## Required Software and Set-up
Sterling is written in [Silver](https://github.com/melt-umn/silver) and
thus requires Silver for building.  Running Sterling requires Java 8
and Bash.  Some extensions will require other software to use to run
the compiled version of the defined language.

Once this software is installed, run
```
./build
```
in the repository root to build the Sterling system using Silver.  Then
run
```
./install
```
to install the `sterling` script.  Sterling can then be run as
`sterling`.  The `install` script only needs to be run once, even if
you rebuild using the `build` script.

Sterling has been tested on Linux, but may run on MacOS or the Windows
Subsystem for Linux (WSL).


## Documentation
Documentation for writing languages in Sterling and running them can be
found in the [docs directory](docs/).

Additionally the [examples directory](examples/) contains a number of
languages to peruse to learn about Sterling.
