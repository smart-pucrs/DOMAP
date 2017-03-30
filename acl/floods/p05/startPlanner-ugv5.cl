#! /home/username/acl/alisp -#!
(require :asdf)
(push "/home/username/shop2/" asdf:*central-registry*)
(asdf:oos 'asdf:load-op :shop2)
(load "/home/username/floods/p05/ugv5")
#(define-floods-uav-domain)
#(load "/home/username/floods/p01/uav1")
#(find-plans 'uav1 :verbose :plans)
# (find-plans '$PROBLEM_NAME :which :shallowest :time-limit 10)
