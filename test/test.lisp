;;; -*- Mode:Lisp; Syntax:ANSI-Common-Lisp; Coding:utf-8 -*-

(in-package :graph-tgf-test)

(defsuite* :graph-tgf-test)

(deftest test.1
  (let ((graph (read-tgf (format nil "1~%#~%"))))
    (is (equal '(1) (nodes graph)))
    (is (equal nil (edges graph)))))

(deftest test.2
  (let ((graph (read-tgf (format nil "1~%2~%#~%"))))
    (is (equal '(1 2) (nodes graph)))
    (is (equal nil (edges graph)))))

(deftest test.3
  (let* ((*package* (find-package :graph-tgf-test))
         (graph (read-tgf (format nil "a~%b~%c~%#~%"))))
    (is (equal '(a b c) (nodes graph)))
    (is (equal nil (edges graph)))))

(deftest test.4
  (let* ((*package* (find-package :graph-tgf-test))
         (graph (read-tgf (format nil "a~%b~%c~%#~%a b~%"))))
    (is (equal '(a b c) (nodes graph)))
    (is (equal '((a b)) (edges graph)))))

(deftest test.5
  (let* ((*package* (find-package :graph-tgf-test))
         (graph (read-tgf (format nil "a~%b~%c~%#~%b a~%"))))
    (is (equal '(a b c) (nodes graph)))
    (is (equal '((b a)) (edges graph)))))

(deftest test.6
  (let* ((*package* (find-package :graph-tgf-test))
         (graph (read-tgf (format nil "a~%b~%c~%#~%b a~%a c~%"))))
    (is (equal '(a b c) (nodes graph)))
    (is (equal '((b a) (a c)) (edges graph)))))

(deftest test.7
  (let* ((*package* (find-package :graph-tgf-test))
         (graph (read-tgf (format nil "a~%b~%#~%b a~%a c~%"))))
    (is (equal '(a b c) (nodes graph)))
    (is (equal '((b a) (a c)) (edges graph)))))

(deftest test.8
  (let* ((*package* (find-package :graph-tgf-test))
         (graph (read-tgf (format nil "#~%a b~%a c~%"))))
    (is (equal '(a b c) (nodes graph)))
    (is (equal '((a b) (a c)) (edges graph)))))

(deftest test.9
  (signals error (read-tgf (format nil "1~%"))))

(deftest test.10
  (let* ((*package* (find-package :graph-tgf-test))
         (graph (read-tgf (format nil "#~%a c~%b c~%c d~%"))))
    (is (equal '(b a) (precedents graph 'c)))))

(deftest test.11
  (let ((graph (populate (make-instance 'digraph) :edges '((1 2) (2 3)))))
    (is (equal (format nil "1~%2~%3~%#~%1 2~%2 3~%")
               (write-tgf-to-string graph)))))

(deftest test.12
  (let ((graph (populate (make-instance 'digraph) :nodes '(1 2 3))))
    (is (equal (format nil "1~%2~%3~%#~%")
               (write-tgf-to-string graph)))))

(deftest test.13
  (let ((graph (populate (make-instance 'digraph))))
    (is (equal (format nil "#~%")
               (write-tgf-to-string graph)))))
