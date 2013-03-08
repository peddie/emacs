;;;;;;; git configuration ;;;;;;;;;

; magit
(local-path "site-lisp/magit")
(require 'magit)
(global-set-key (kbd "C-c s") 'magit-status)

(local-path "site-lisp/mo-git-blame")
(autoload 'mo-git-blame-file "mo-git-blame" nil t)
(autoload 'mo-git-blame-current "mo-git-blame" nil t)

(provide 'my-git)
