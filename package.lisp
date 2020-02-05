;;;; package.lisp

(defpackage ebooks-bot
  (:use :cl :with-user-abort :glacier)
  (:import-from :unix-opts
		:define-opts
		:get-opts)
  (:import-from :maiden-markov
		:read-generator
		:write-generator
		:learn
		:generator))
(in-package :ebooks-bot)

(define-opts
  (:name :help
   :description "prints this help"
   :short #\h
   :long "help")
  (:name :log
   :description "prints logging info"
   :short #\l
   :long "log")
  (:name :config
   :description "the config file to load"
   :short #\c
   :long "config"
   :arg-parser #'identity
   :meta-var "FILE"))
	
