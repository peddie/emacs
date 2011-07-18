;;;;;;;;;; flymake mode for compiling on the fly ;;;;;;;;;;;

(add-to-list 'load-path "/usr/share/emacs/23.2/lisp/progmodes/")

(require 'flymake)
(require 'flymake-cursor)
(require 'flymake-init)
; (add-hook 'find-file-hook 'flymake-find-file-hook)
(autoload 'flymake-minor-mode "flymake-minor-mode.el")

(add-hook 'flymake-mode-hook
	  (lambda ()
	    (flymake-minor-mode)
	    (define-key my-flymake-minor-mode-map (kbd "M-n") 'flymake-goto-next-error)
	    (define-key my-flymake-minor-mode-map (kbd "M-p") 'flymake-goto-prev-error)))

(provide 'my-flymake)
