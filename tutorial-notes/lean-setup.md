# Installing and Setting Up Lean 3

## Installing Lean Using Elan

Elan is a package manager and installer for Lean. There are many ways to install Elan, as shown [here](https://github.com/leanprover/elan#manual-installation). I chose to install from [the provided release binary](https://github.com/leanprover/elan/releases/tag/v1.3.1).

Once you install `elan-init` for linux, run: `./elan-init`. Copying from the install message:

"It will add the leanpkg, lean, and elan commands to Elan's bin directory, located at: `$HOME/.elan/bin`. This path will then be added to your PATH environment variable by modifying the profile file located at: `$HOME/.profile`. You can uninstall at any time with elan self uninstall and these changes will
be reverted."

Now run `elan default stable` to download and install lean3.  Check that it works correctly by:

``` bash
$ lean --version
Lean (version 3.4.2, commit cbd2b6686ddb, Release)
```

#### If You, For Some Reason

... want to install elan and lean globally, using the binaries- I did a little workaround here:

``` bash
cd /usr/local/lib
sudo mv /home/chaos/.elan ./elan
cd /usr/local/bin
sudo ln -s /usr/local/lib/elan/bin/elan elan
sudo ln -s /usr/local/lib/elan/bin/lake lake
sudo ln -s /usr/local/lib/elan/bin/lean lean
sudo ln -s /usr/local/lib/elan/bin/leanc leanc
sudo ln -s /usr/local/lib/elan/bin/leanchecker leanchecker
sudo ln -s /usr/local/lib/elan/bin/leanmake leanmake
sudo ln -s /usr/local/lib/elan/bin/leanpkg leanpkg
cd $HOME
vim .profile
<remove last line of .profile related to elan>
```

## Your Dev Environment

To start with, while lean does compile like any other language, most of the interesting stuff happens before compilation. So we need a tool for all that interesting stuff.

You can use lean with both emacs and Visual Studio Code. Documentation for both is [here](https://leanprover.github.io/reference/using_lean.html). Since I myself am using Emacs, I'll provide a 5-minute guide to installing emacs and setting up your lean development environment.

### If You Take The Emacs Option

Vanilla emacs comes with very few batteries included- about the same amount as Vim- so I would recommend installing [Prelude](https://github.com/bbatsov/prelude), which sets up a bunch of sane emacs configs like the package manager, various programming language setups, etc..

After cloning prelude and opening emacs, you can enable or disable a bunch of language modes by uncommenting the `require` lines in `.emacs.d/personal/prelude-modules.el`.

You can put your own personal config- any bits of elisp you want- in either `.emacs.d/personal/preload/` or in `.emacs.d/personal/custom.el`

My own emacs-prelude config is [here](https://github.com/AdLucem/autognomy/tree/master/pretty/cieltechno/personal), if you want a very quick and basic setup from someone who doesn’t use emacs full-time.

Now install lean using the MELPA package manager:

``` emacs-lisp
;; update the package list
Alt-x package-refresh-contents
;; open the package list
Alt-x package-list-packages
;; search for lean-mode
Ctrl-s lean-mode
```

You should now see `Lean` in the mode-line when you open a `.lean` file.

#### A Small Note

If you directly copy-paste my config file into your `.emacs.d/personal` folder, emacs will give you this error:

```jsx
Warning (initialization): An error occurred while loading
‘/home/chaos/.emacs.d/init.el’:

error: Unable to find theme file for ‘oceanic’

To ensure normal operation, you should investigate and remove the
cause of the error in your initialization file.  Start Emacs with
the ‘--debug-init’ option to view a complete error backtrace.
```

This is because you haven't installed all the packages that have been required by my config. To install packages:

- Get the list of installable packages via `M-x package-list-packages`
- Search for any uninstalled packages via `C-s <enter search term`
- Click on the package name to open the install window

#### Some Additional Documentation For Dev Environments

    - [A handy presentation for Emacs lean-mode commands](http://www.cs.cmu.edu/~soonhok/talks/lean-mode.pdf)
