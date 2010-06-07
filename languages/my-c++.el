;;;;;;;;; C++ ;;;;;;;

(require 'my-flymake)

(add-hook 'c++-mode-hook 'flymake-mode)

(add-hook 'c++-mode-hook
	  '(lambda ()
	     (setq indent-tabs-mode nil)
	     (setq c-indent-level 2)
	     (setq c-default-style "bjarne")
	     (setq c-basic-offset 2)))

