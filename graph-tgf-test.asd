;;; -*- Mode:Lisp; Syntax:ANSI-Common-Lisp; Coding:utf-8 -*-

(in-package :asdf-user)

(defsystem :graph-tgf-test
  :name "graph-tgf-test"
  :description "Tests for graph-tgf"
  :components ((:module "test"
                :components ((:file "package")
                             (:file "test" :depends-on ("package")))))
  :depends-on (:graph-tgf :myam :alexandria :split-sequence))

(defmethod perform ((op test-op)
                    (system (eql (find-system :graph-tgf-test))))
  (perform op (find-system :graph-tgf)))
