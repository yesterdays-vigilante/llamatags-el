Llamatags-el
============

This is a simple emacs plugin to manage CTAGS files. Since I started writing this, I've come across a bunch of other pieces of code to do effectively the same thing, but re-inventing the wheel is fun, right?

To use, just put llamatags.el somewhere in your load path and:

```elisp
(require 'llamatags)

(llamatags-init)
```