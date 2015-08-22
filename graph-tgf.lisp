;;; -*- Mode:Lisp; Syntax:ANSI-Common-Lisp; Coding:utf-8 -*-

(in-package :graph-tgf)

(defun foo123 () 123)

(defgeneric read-tgf (input))

(defmethod read-tgf ((input string))
  (with-input-from-string (stream input)
    (read-tgf stream)))

(defmethod read-tgf ((input pathname))
  (with-open-file (stream input)
    (read-tgf stream)))

(defmethod read-tgf ((input stream))
  (let ((graph (make-instance 'digraph)))
    (loop with separator-line-found
          for line = (read-line input nil)
          while line
          until (and (equal line "#")
                     (setq separator-line-found t))
          do (add-node graph (read-from-string line))
          finally (unless separator-line-found
                    (error "~@<separator line containing only `#' not found~@:>")))
    (loop for line = (read-line input nil)
          while line
          do (with-input-from-string (in line)
               (add-edge graph (list (read in) (read in)))))
    graph))

(defun read-tgf-from-file (pathname-designator)
  (read-tgf (pathname pathname-designator)))

(defun write-tgf-to-string (graph)
  (with-output-to-string (output)
    (write-tgf graph output)))

(defun write-tgf-to-file (graph pathname-designator
                          &key (if-exists :error))
  (with-open-file (stream pathname-designator
                          :direction :output
                          :if-exists if-exists)
    (write-tgf graph stream)))

(defun write-tgf (graph &optional stream)
  (let ((stream (cond
                  ((null stream) *standard-output*)
                  ((eql stream t) *terminal-io*)
                  (t stream))))
    (dolist (node (nodes graph))
      (format stream "~A~%" node))
    (write-line "#" stream)
    (dolist (edge (edges graph))
      (format stream "~A ~A~%" (first edge) (second edge)))))
