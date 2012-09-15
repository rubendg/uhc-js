---
layout: default
title: "Documentation / User Guide"
---
{% capture content %}
## Getting Started

This page contains documentation specific to the JavaScript backend. To learn
more of the UHC please look at the [extensive documentation][uhc-extensive-doc].


### Installation of UHC
Clone the latest version of the JavaScript branch of UHC. This is somewhat 
risky but new features will be found here first.

Make sure you have the dependencies, also make sure you have GHC installed:

<pre class="prettyprint lang-bsh">
cabal install uulib uuagc
</pre>

Now build the UHC:


<pre class="prettyprint lang-bsh linenums">
$> cd somewhere
$> git clone git://github.com/UU-ComputerScience/uhc.git
$> cd uhc
$> git checkout js
$> cd EHC
$> autoconf
$> ./configure
$> make uhc
</pre>

Optionally perform a `make install`.



### Compiling a program

Compiling happens by calling UHC with the `-tjs` flag.

<pre class="prettyprint lang-bsh">
uhc -tjs Main.hs
</pre>

This will compile Main.hs and generate a `.js` file for each import you made,
as well as the main module. It will also create a file `Main.html` for you that
contains a bare-bone HTML template including the references to the generated
JavaScript code.

If you want the UHC to generate a single JavaScript file you can add the
following parameter: `-O,2`. It will enable whole-program optimisation
and output all JavaScript to the file `Main.js`.

As we do not yet have full Cabal support we currently resort to makefiles. (If
someone wants to convert this to
[shake](http://hackage.haskell.org/package/shake), please go ahead!) For an
explanation for how the automatic inclusion works see [Automatically generating
import path directives](#automatically_generating_import_path_directives).


<pre class="prettyprint linenums">
IMPORTS = $(shell ./libs.hs)
UHC = /your/path/to/UHC
COMPILER = ${UHC} ${IMPORTS} --import-path=$any_libraries_you_use$ -tjs -O,2

all: build

build: 
	${COMPILER} main.hs

.PHONY clean:
	rm `find . -d -name "*.core*"`
	rm `find . -d -name "*.hi*"`
</pre>

## Communicating with JavaScript
We offer several bindings to JavaScript, jQuery, and BackBone. They can be found in
the [UHC-JavaScript][uhc-js] library.


### Types
When writing the `import` and `export` declarations you are yourself responsible for
choosing the right types. This means that exposing a Haskell function that returns
a Haskell datatype will give you exactly that: the Runtime representation of the
Haskell datatype. Everything except for Ints are implemented as Haskell 

### Importing and exporting from and to JavaScript

We can import functions from the JavaScript world in the following manner. Note
the use of the `.` and the numbered arguments. In this case we import the
`substr` function that works on strings.


<pre class="prettyprint linenums lang-hs">
foreign import js "%1.substr(%2, %3)"
  subStr :: JSString -> Int -> Int -> JSString
</pre>

You can also replace the `%2, %3` by `%*`, it will then put all not explicitly
named parameters there.


<pre class="prettyprint linenums lang-hs">
foreign import js "%1.substr(%*)"
  subStr :: JSString -> Int -> Int -> JSString
</pre>

### Conversion of objects
Perhaps one the most common things is converting between Haskell's `String` and
the native JavaScript String, which has the type `JSString`. Beware of the fact
that this is an expensive operation and therefore should be used as little as
possible.

We provide the following class functions: `toJS` and `fromJS` that will convert
a value from one world to the other. These do not work for general Haskell 
data-types yet. However, there is work underway to provide a generic function
that will convert any Haskell record to a JavaScript object.

In the mean time you can use `toObj`. This will convert Haskell records to
JavaScript objects but isn't able to convert fields of type `a -> b`. 



## Examples / Practice
This is the list of currently active UHC-JS enabled projects:

* JCU-HS ([demo](http://jcu.chrisdone.com/login), [announce](http://alessandrovermeulen.me/2012/01/26/getting-rid-of-javascript-with-haskell))

### Installation script for JCU-HS
An installation script for installing the JCU app together with its dependencies
is available from [this gist][jcu-install-script]. Currently the script does
**not** build nor install UHC for you.

If you trust us you may run the following command directly from your shell. It
will run the installer in your current working directory:

{% code bash %}
ruby <(curl -s https://raw.github.com/gist/1902090/0588a1a1e5a7bb8935ee9afdd7d96949abbe7ff5/install.rb)
{% endcode %}

Follow the on screen instructions when running the installer.


## Misc.

### Automatically generating import path directives
With the following Haskell script you can easily add libraries by adding a
symlink to the `lib/` dir pointing to the source directory of your library.


{% code hs %} 
#! /usr/bin/env runhaskell
-- File: libs.hs
module Main where

import Data.List        (intercalate)
import System.Directory (getDirectoryContents, canonicalizePath)
  
main = do
  libs        <- getDirectoryContents "lib"
  let libs'   =  [ "lib/" ++ x | x <- libs, head x /= '.']
  libs''      <- mapM canonicalizePath libs'
  let libs''' =  unwords $ map ("--import-path=" ++) libs'' 
  putStrLn libs''' 
{% endcode %}

[jcu-spockz-fork]: https://github.com/spockz/JCU
[jcu-install-script]: https://gist.github.com/1902090 "A Ruby Script to install JCU and dependencies."
[uhc-github]: https://github.com/UU-ComputerScience
[uhc-js]: https://github.com/UU-ComputerScience/uhc-js
[uhc-extensive-doc]: http://www.cs.uu.nl/wiki/bin/view/Ehc/Documentation



{% endcapture %}

<div class="container">
  <div class="row">
  <div class="span3 bs-docs-sidebar">
    <ul class="nav nav-list bs-docs-sidenav" data-spy="affix"  data-offset-top="85">

          <!-- <li><a href="#getting_started">Getting Started</a></li><li><a href="#communicating_with_javascript">Communicating with JavaScript</a></li><li class="active"><a href="#examples__practice">Examples / Practice</a></li> -->
    </ul>
  </div>
  <div class="span9 content">
    {{ content | markdownify }}
  </div>
  </div>
</div>