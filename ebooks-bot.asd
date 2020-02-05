;;;; ebooks-bot.asd

(asdf:defsystem #:ebooks-bot
  :description "mastodon ebooks bot"
  :author "ava fox"
  :license  "NPLv1+"
  :version "0.0.1"
  :serial t
  :depends-on (#:glacier #:maiden-markov #:with-user-abort
	       #:unix-opts #:log4cl)
  :components ((:file "package")
               (:file "ebooks-bot"))
  :build-operation "program-op"
  :build-pathname "bin/ebooks-bot"
  :entry-point "ebooks-bot::main")

#+sb-core-compression
(defmethod asdf:perform ((o asdf:image-op) (c asdf:system))
  (uiop:dump-image (asdf:output-file o c) :executable t :compression t))

