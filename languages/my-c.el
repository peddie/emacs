;;;;;;;;;; C ;;;;;;;;;;

; (require 'my-flymake)
; (add-hook 'c-mode-hook 'flymake-mode)

(add-hook 'c-mode-hook
	  '(lambda ()
             (define-key c-mode-map (kbd "C-c m") 'compile)
	     (setq indent-tabs-mode nil)
	     (setq c-indent-level 2)
	     (setq c-default-style "k&r")
	     (setq c-basic-offset 2)))
