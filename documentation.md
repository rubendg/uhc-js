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
someone wants to convert this to [shake](http://hackage.haskell.org/package/shake), please go ahead!)

<pre class="prettyprint linenums">
COMPILER = $yourpath$ --import-path=$any_libraries_you_use$ -tjs -O,2

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




## Examples / Practice
This is the list of currently active UHC-JS enabled projects:

* JCU-App ([demo](http://jcu.chrisdone.com/login), [announce](http://alessandrovermeulen.me/2012/01/26/getting-rid-of-javascript-with-haskell))

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