---
layout: default
title: "The Utrecht Haskell Compiler JavaScript Backend Page"
---

{:toc}

<div class="alert">
  <p>
    This page is currently under construction. In the mean time please
    consider looking at the reports <a
    href="http://www.norm2782.com/improving-uhc-js-report.pdf">Improving the
    UHC JavaScript Backend</a> (Jurriën Stutterheim) and <a
    href="http://alessandrovermeulen.me/2012/01/26/getting-rid-of-javascript-with-haskell/">Getting
    Rid of JavaScript with Haskell</a> (Alessandro Vermeulen). Also take a look at
    <a
    href="http://www.haskell.org/haskellwiki/The_JavaScript_Problem#UHC">Haskell:
    The JavaScript Problem</a>.
  </p>
</div>

{% capture introduction %}
A short introduction: how to get started
----------------------------------------
Please report bugs in the UHC-JS backend or in the UHC-JS library in the [GitHub
Issue Tracker](https://github.com/UU-ComputerScience/uhc-js/issues). Please note
that UHC related issues will eventually get their own issue tracker once the UHC
has been moved to GitHub. Also consider joining
[#uhcjs](irc://irc.freenode.net/uhcjs) on FreeNode.

Demo
----
The JCU app discussed in "Getting Rid of JavaScript with Haskell" has been put
online by [Chris Done](http://chrisdone.com/).

Go to the [instance](http://jcu.chrisdone.com/login). And log in with username
"uhcjsdemo@example.com" and password "123456". And check out the [source
code](https://github.com/UU-ComputerScience/JCU). For installation instructions
please refer to the section "Locations and Setup" in "Getting Rid of JavaScript
with Haskell".
{% endcapture %}

{% capture resources %}
Resources
---------

* [Improving the UHC JavaScript Backend](http://www.norm2782.com/improving-uhc-js-report.pdf) - Jurriën Stutterheim
* [Getting Rid of JavaScript with Haskell](http://alessandrovermeulen.me/2012/01/26/getting-rid-of-javascript-with-haskell) - Alessandro Vermeulen
* [The JavaScript Problem (Haskell Wiki)](http://www.haskell.org/haskellwiki/The_JavaScript_Problem#UHC)
* [The UHC Blog](http://utrechthaskellcompiler.wordpress.com/)
* [The UHC Wiki](http://www.cs.uu.nl/wiki/UHC) and [Getting started](http://www.cs.uu.nl/wiki/bin/view/UHC/GettingStarted). 
  Be sure to pick the [js](https://subversion.cs.uu.nl/repos/project.UHC.pub/branches/js/) branch on the repo for latest developments.
* [UHC JS Backend Quick Start](http://chrisdone.com/posts/2012-01-06-uhc-javascript.html) - Chris Done
* [Client-Side Haskell code](https://github.com/spockz/JCU/tree/master/resources/static/hjs) - Alessandro Vermeulen
{% endcapture %}

<div class="two-column">
  <div class="column">
    {{ introduction | markdownify }}
  </div>
  <div class="column block">
    {{ resources | markdownify }}
  </div>  
</div>
<div style="clear:both"></div>

Installation instructions
-------------------------

Checkout the latest version of the JavaScript branch of UHC. This is somewhat 
risky but new features will be found here first.

Make sure you have the dependencies, also make sure you have GHC installed:

{% highlight bash %}
cabal install uulib uuagc
{% endhighlight %}

Now build the UHC:

{% highlight bash linenos %}
$> cd somewhere
$> git clone git://github.com/UU-ComputerScience/uhc.git
$> cd uhc
$> git checkout js
$> cd EHC
$> autoconf
$> ./configure
$> make uhc && make 101/ehclib EHC_VARIANT_TARGET=js
{% endhighlight %}

Optionally perform a `make install`.

### Installation script for JCU-HS ###
An installation script for installing the JCU app together with its dependencies
is available from [this gist][jcu-install-script]. Currently the script does
**not** build nor install UHC for you.

If you trust us you may run the following command directly from your shell. It
will run the installer in your current working directory:

{% highlight ruby %}
ruby <(curl -s https://raw.github.com/gist/1902090/e2a0508cea4bd4bc3abeed87b054e32e1c99931e/install.rb)
{% endhighlight %}

Follow the on screen instructions when running the installer.

[jcu-spockz-fork]: https://github.com/spockz/JCU
[jcu-install-script]: https://gist.github.com/1902090 "A Ruby Script to install JCU and dependencies."