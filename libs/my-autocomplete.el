;;;;;;;;;;;; new advanced autocomplete mode ;;;;;;;;;;;;

(when (require 'auto-complete-config nil 'noerror) ;; don't break if not installed 
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
  (setq ac-comphist-file  "~/.emacs.d/ac-comphist.dat")
  (ac-config-default))
