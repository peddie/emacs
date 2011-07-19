;;;;;;; git configuration ;;;;;;;;;

; magit
(local-path "site-lisp/magit")
(require 'magit)
(global-set-key (kbd "C-c s") 'magit-status)

(provide 'my-git)
