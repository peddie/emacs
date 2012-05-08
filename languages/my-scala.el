;;;;;;; scala setup ;;;;;;;;

;; scala
(local-path "site-lisp/scala-mode")
(require 'scala-mode)

;; ENSIME mode
(local-path "site-lisp/ensime/src/main/elisp/")
(require 'ensime)

(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(setq auto-mode-alist
      (append '(("\\.scala$" . scala-mode)) auto-mode-alist))

(provide 'my-scala)
