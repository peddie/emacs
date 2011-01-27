;;;;;;; scheme ;;;;;;;;;

(require 'my-lisps)

;; Main multi-scheme mode (quack)
; (autoload 'quack "quack" "scheme editing mode" t) 
(require 'quack)

(set-variable 'scheme-program-name "mit-scheme")
(setq auto-mode-alist
      (append '(("\\.scm$" . quack)
		("\\.ss$" . quack)
                ("\\.sch$" . quack)
                ("\\.scme$" . quack))
              auto-mode-alist))

;; Bigloo
(add-to-list 'load-path "/usr/share/emacs23/site-lisp/bigloo")
(add-to-list 'load-path "site-lisp/bmacs/bee")
(add-to-list 'load-path "site-lisp/bmacs")
; (require 'bee-mode)
; (require 'bee-bdb)
; (autoload 'bee-mode "bee-mode" "bee mode" t)
;; (setq auto-mode-alist
;;       (append '(("\\.bgl$" . bee-mode)
;;                 ("\\.bee$" . bee-mode))
;;               auto-mode-alist))

(setq quack-programs '("bigloo" "csi" "csi -hygienic" "gsi" "gsi -:d-" "gsi ~~/syntax-case.scm -" "guile" "kawa" "mit-scheme" "rs" "scheme" "scheme48" "scmutils"))

;; gambit!

; (autoload 'gambit-inferior-mode "gambit" "Hook Gambit mode into cmuscheme.")
; (autoload 'gambit-mode "gambit" "Hook Gambit mode into scheme.")
; (require 'gambit-inferior-mode)
(require 'gambit)
(add-hook 'inferior-scheme-mode-hook (function gambit-inferior-mode))
(add-hook 'scheme-mode-hook (function gambit-mode))
(setq scheme-program-name "gsi -:d-")
(setq auto-mode-alist
      (append '(("\\.gmb$" . gambit-mode)
                ("\\.gscm$" . gambit-mode))
              auto-mode-alist))

;; scheme48
(add-to-list 'load-path "site-lisp/slime48")
; (require 'slime48)


;; mechanics/MIT scheme
; (autoload 'xscheme "xscheme" "another scheme editing mode" t)
(require 'xscheme)

;; slime for scheme -- maximum win!
(require 'slime-scheme)
(add-to-list 'load-path "site-lisp/slime48")
(add-to-list 'load-path "/home/peddie/software/lisp/swank-chicken")
(add-hook 'slime-load-hook (lambda () (require 'slime-scheme)))
(require 'chicken-slime)

(defun mit-scheme-init (file encoding)
  (format "%S\n\n"
	  `(begin
	    (load-option 'format)
	    (load-option 'sos)
	    (eval 
	     '(construct-normal-package-from-description
	       (make-package-description '(swank) '(()) 
					 (vector) (vector) (vector) false))
	     (->environment '(package)))
	    ;; (load ,(expand-file-name 
	    ;; 	    "../contrib/swank-mit-scheme.scm" ; <-- insert your path
	    ;; 	    slime-path)
	    ;; 	  (->environment '(swank)))
	    (load "/home/peddie/software/lisp/slime/contrib/swank-mit-scheme.scm"
		  (->environment '(swank)))
	    (eval '(start-swank ,file) (->environment '(swank))))))

(defun mit-scheme ()
  (interactive)
  (slime 'mit-scheme))

(defun find-mit-scheme-package ()
  (save-excursion
    (let ((case-fold-search t))
      (and (re-search-backward "^[;]+ package: \\((.+)\\).*$" nil t)
	   (match-string-no-properties 1)))))

(setq slime-find-buffer-package-function 'find-mit-scheme-package)
