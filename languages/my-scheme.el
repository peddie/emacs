;;;;;;; scheme ;;;;;;;;;

(require 'my-lisps)

;; Scheme (chicken)
(autoload 'quack "quack" "scheme editing mode" t) 
(autoload 'xscheme "xscheme" "another scheme editing mode" t)
(set-variable 'scheme-program-name "mit-scheme")
(add-to-list 'load-path "/usr/local/share/emacs/22.2/site-lisp/bigloo")
(setq auto-mode-alist
      (append '(("\\.scm$" . quack)
		("\\.ss$" . quack)
                ("\\.sch$" . quack)
                ("\\.scme$" . quack))
              auto-mode-alist))
;; mechanics

;; ;; Bigloo
;; (autoload 'bdb "bdb" "bdb mode" t)
;; (autoload 'bee-mode "bee-mode" "bee mode" t)
;; (add-to-list 'load-path "/usr/share/emacs23/site-lisp")
;; (add-to-list 'load-path"/usr/share/emacs23/site-lisp/bigloo")

(setq quack-programs (quote ("mechanics" "bigloo" "csi" "csi -hygienic" "gosh" "gsi" "gsi ~~/syntax-case.scm -" "guile" "kawa" "mit-scheme" "mred -z" "mzscheme" "mzscheme -M errortrace" "mzscheme -il r6rs" "mzscheme -il typed-scheme" "mzscheme3m" "mzschemecgc" "rs" "scheme" "scheme48" "scmutils" "scsh" "sisc" "stklos" "sxi")))