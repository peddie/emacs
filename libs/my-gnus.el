;; GNUS

(require 'gnus)

(setq user-mail-address "mpeddie@gmail.com")
(setq user-full-name "Matthew Peddie")

(setq gnus-select-method '(nntp "news.gmane.org"))
(setq gnus-secondary-select-methods '())

(add-to-list 'gnus-secondary-select-methods '(nntp "news.gwene.org"))
(add-to-list 'gnus-secondary-select-methods '(nntp "freenews.netfront.net"))
(add-to-list 'gnus-secondary-select-methods '(nntp "news.gnus.org"))

(defun add-gmail-account-to-list (name)
  (add-to-list 'gnus-secondary-select-methods 
	       `(nnimap ,name 
			(nnimap-list-pattern ("INBOX" "mail/*"))	
			(nnimap-server-port 993)
			(nnimap-stream ssl)
			(nnimap-address "imap.gmail.com"))))

(defvar my-google-mail-accounts)
(setq my-google-mail-accounts '("mpeddie@gmail.com" "matt@makanipower.com" "peddie@jobyenergy.com" "matthew@peddies.net" "matt@general-rotors.com" "peddie@general-rotors.com"))

(mapc 'add-gmail-account-to-list my-google-mail-accounts)

(condition-case nil
    (progn (require ‘w3m nil t)
	   (setq mm-text-html-renderer ‘w3m
		 mm-inline-text-html-with-images t
		 mm-w3m-safe-url-regexp nil
		 mm-inline-large-images nil))
  (error nil))

(setq gnus-default-adaptive-score-alist
      '((gnus-dormant-mark (subject 100)) 
	(gnus-ticked-mark (subject 30)) 
	(gnus-read-mark (subject 30)) 
	(gnus-del-mark (subject -150)) 
	(gnus-catchup-mark (subject -150)) 
	(gnus-killed-mark (subject -1000)) 
	(gnus-expirable-mark (subject -1000))))

(setq gnus-always-force-window-configuration t)

(gnus-add-configuration
 '(article
   (horizontal 1.0
	       (vertical 40
			 (group 1.0))
	       (vertical 1.0
			 (summary 0.25 point)
			 (article 1.0)))))
(gnus-add-configuration
 '(summary
   (horizontal 1.0
	       (vertical 40
			 (group 1.0))
	       (vertical 1.0
			 (summary 1.0 point)))))

(require 'deuglify)
(defun standard-wash-this-article ()
        (interactive)
        (gnus-article-outlook-deuglify-article)
        (gnus-article-outlook-rearrange-citation)
;        (gnus-article-fill-cited-article nil '100)
        (gnus-article-capitalize-sentences))

(add-hook 'gnus-article-decode-hook 'standard-wash-this-article)

(provide 'my-gnus)
