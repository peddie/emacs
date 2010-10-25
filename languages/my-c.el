;;;;;;;;;; C ;;;;;;;;;;

(require 'my-flymake)
; (add-hook 'c-mode-hook 'flymake-mode)
(require 'my-git)

(add-hook 'c-mode-hook
	  '(lambda ()
             (define-key c-mode-map (kbd "C-c C-l") 'compile)
	     (define-key c-mode-map (kbd "C-c m") 'magit-status)
	     (define-key c-mode-map (kbd "C-c C-v") 'uncomment-region)
	     (setq indent-tabs-mode nil)
	     (setq c-indent-level 2)
	     (setq c-default-style "k&r")
	     (setq c-basic-offset 2)))
