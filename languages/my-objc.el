;;;;;;;;;; C ;;;;;;;;;;

(require 'my-flymake)

(add-hook 'objc-mode-hook 'flymake-mode)

(add-hook 'objc-mode-hook
	  '(lambda ()
	     (setq indent-tabs-mode nil)
	     (setq c-indent-level 2)
	     (setq c-default-style "k&r")
	     (setq c-basic-offset 2)))
