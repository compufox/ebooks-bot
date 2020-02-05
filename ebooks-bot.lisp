;;;; ebooks-bot.lisp

(in-package :ebooks-bot)

(defun main ()
  (log:config :warn)
  
  (multiple-value-bind (opts args) (get-opts)
    (when (or (getf opts :help)
	      (every #'null opts))
      (unix-opts:describe))

    (when (getf opts :log)
      (log:config :info))

    (unless (getf opts :config)
      (log:error "please provide a config")
      (uiop:quit 1))

    (let* ((config-file (getf opts :config))
	   (bot (make-instance 'mastodon-bot :config-file config-file))
	   (generator-filename (concatenate 'string
					    (bot-username bot)
					    ".generator"))
	   (generator (read-generator generator-filename)))

      ;; get the accounts (just ids?) of all accounts we follow
      (setf (conf:config :following-accounts)
;	    (mapcar #'tooter:id
		    (tooter:following (bot-client bot)))

      ;; somehow know what status id we were on last. (put it in config and save?)
      ;; in a separate thread go and start downloading each status from the last id
      ;;  up until the newest one

      (run-bot (bot :delete-command t)
	;; schedule up some threads to fetch new statuses every few days
	(add-command "update" #'fetch-new-posts :privileged t :add-prefix t)
	(after-every (2 :days :async t :run-immediately t)
	  (fetch-new-posts))
      
	;; drop into a loop where we post every hour or so
	(after-every (1 :hour)
	  (post (make-sentence generator)
		:cw "ebooks post"))))))
      
      
		       
      
