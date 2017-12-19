#! /home/username/acl/alisp -#!
(require :asdf)
(push "/home/username/shop2/" asdf:*central-registry*)
(asdf:oos 'asdf:load-op :shop2)
(load "/home/username/shop2/examples/toy/basic-example.lisp")
