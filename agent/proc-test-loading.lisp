;;;; -*- Mode: LISP; Syntax: COMMON-LISP; indent-tabs-mode: nil; coding: utf-8; show-trailing-whitespace: t -*-
;;;; Copyright (C) 2011 Anton Vodonosov (avodonosov@yandex.ru)
;;;; See LICENSE for details.

;;;; This file is loaded into a child lisp process to test
;;;; whether particular ASDF system can be quickloaded on
;;;; this lisp implementation.

(in-package :cl-user)

;;; Configure away the normal ASDF source registry, so we only use Quicklisp.
(asdf:initialize-source-registry `(:source-registry :ignore-inherited-configuration))

(defun test-loading (system-name)
  (wrap-status
    (ql:quickload system-name :verbose t)
    :ok))

(defun test-loading-main (log-file system-name private-quicklisp-dir asdf-output-root-dir)
  (let ((quicklisp-output-dir (merge-pathnames (make-pathname :directory '(:relative "ql"))
                                               asdf-output-root-dir)))

    (add-asdf-output-translation private-quicklisp-dir quicklisp-output-dir))
  (saving-output log-file
                 (lambda ()
                   (format t "  *features*:        ~(~A~)~%~%" (sort (copy-list *features*) #'string<))
                   (test-loading system-name))))
