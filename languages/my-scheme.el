;;;;;;; scheme ;;;;;;;;;

(require 'my-lisps)

;; Main multi-scheme mode (quack)
; (autoload 'quack "quack" "scheme editing mode" t) 
(require 'quack)
(require 'cmuscheme)

(set-variable 'scheme-program-name "mit-scheme")
(setq auto-mode-alist
      (append '(("\\.scm$" . scheme-mode)
		("\\.ss$" . scheme-mode)
                ("\\.sch$" . scheme-mode)
                ("\\.scme$" . scheme-mode))
              auto-mode-alist))

(setq quack-programs 
      '("mit-scheme-native" 
	"bigloo" 
	"csi" 
	"csi -hygienic" 
	"gsi" 
	"gsi -:d-" 
	"gsi ~~/syntax-case.scm -" 
	"guile" 
	"kawa" 
	"mit-scheme" 
	"rs" 
	"scheme" 
	"scheme48" 
	"scmutils"))

(add-hook 'scheme-mode-hook (lambda ()
			       (slime-mode t)))

;; Bigloo
(site-lisp-path "bigloo")
(local-path "site-lisp/bmacs/bee")
(local-path "site-lisp/bmacs")
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
(local-path "site-lisp/slime48")
; (require 'slime48)


;; mechanics/MIT scheme
; (autoload 'xscheme "xscheme" "another scheme editing mode" t)
(require 'xscheme)

;; slime for scheme -- maximum win!
(require 'slime-scheme)
(local-path "site-lisp/slime48")
(add-lisp "swank-chicken")
(add-hook 'slime-load-hook (lambda () (require 'slime-scheme)))
(require 'chicken-slime)
(setq swank-chicken-path (concat my-common-lisp "swank-chicken/swank-chicken.scm"))

(defun chicken-doc (&optional obtain-function)
  (interactive)
  (let ((func (funcall (or obtain-function 'current-word))))
    (when func
      (process-send-string (scheme-proc)
                           (format "(require-library chicken-doc) ,doc %S\n" func))
      (save-selected-window
        (select-window (display-buffer (get-buffer scheme-buffer) t))
        (goto-char (point-max))))))
  
(eval-after-load 'cmuscheme
 '(define-key scheme-mode-map "\C-cd" 'chicken-doc))

(eval-after-load 'scheme
 '(define-key scheme-mode-map "\C-cd" 'chicken-doc))

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
	    (load (concat my-common-lisp "slime/contrib/swank-mit-scheme.scm")
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
