;;;;;;;;;;;; new advanced autocomplete mode ;;;;;;;;;;;;

(when (require 'auto-complete-config nil 'noerror) ;; don't break if not installed 
(add-to-list 'ac-dictionary-directories (concat emacs-root "ac-dict"))
  (setq ac-comphist-file (concat emacs-root "ac-comphist.dat"))
  (ac-config-default))
