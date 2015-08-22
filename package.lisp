;;; -*- Mode:Lisp; Syntax:ANSI-Common-Lisp; Coding:utf-8 -*-

(defpackage :graph-tgf
  (:use :common-lisp :alexandria :graph)
  (:export :foo123
   #:read-tgf
   #:read-tgf-from-file
   #:write-tgf-to-string
   #:write-tgf
   #:write-tgf-to-file))
