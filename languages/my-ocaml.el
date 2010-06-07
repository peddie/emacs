;;;;;;;;;;;;; OCaml ;;;;;;;;

(add-to-list 'load-path "/usr/share/emacs/site-lisp/tuareg-mode")
; (add-to-list 'load-path "/usr/share/emacs/site-lisp/ocaml-mode")
(require 'tuareg)
; (require 'camldebug-tuareg)
; (require 'tuareg-imenu-set-imenu) 

(add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)

(setq auto-mode-alist 
      (append '(("\\.ml[ily]?$" . tuareg-mode)
		("\\.topml$" . tuareg-mode))
	      auto-mode-alist))

