;;; -*- Mode:Lisp; Syntax:ANSI-Common-Lisp; Coding:utf-8 -*-

(in-package :asdf-user)

(defsystem :graph-tgf
  :name "graph-tgf"
  :description "Reading and writing graphs from and to tgf."
  :author "Kilian Sprotte <kilian.sprotte@gmail.com>"
  :version #.(with-open-file
                 (vers (merge-pathnames "version.lisp-expr" *load-truename*))
               (read vers))
  :components ((:static-file "version" :pathname #p"version.lisp-expr")
               (:file "package")
               (:file "graph-tgf" :depends-on ("package"))
               )
  :depends-on (:alexandria :graph))

(defmethod perform ((op test-op)
                    (system (eql (find-system :graph-tgf))))
  (oos 'load-op :graph-tgf-test)
  (funcall (intern "RUN!" "MYAM") :graph-tgf-test))
