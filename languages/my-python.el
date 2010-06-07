;;;;;;;; python setup ;;;;;;;;;;;

;; Python
(add-to-list 'load-path "/usr/share/emacs/site-lisp/pymacs")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/python-mode")
(setq auto-mode-alist
      (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist
      (cons '("python" . python-mode)
            interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)
(add-hook 'python-mode-hook
          '(lambda () 
             (local-set-key "\C-i"     'my-tab)))

