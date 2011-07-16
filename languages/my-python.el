;;;;;;;; python setup ;;;;;;;;;;;

;; Python
(site-lisp-path "pymacs")
(site-lisp-path "python-mode")
(setq auto-mode-alist
      (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist
      (cons '("ipython" . python-mode) 
	    (cons '("python" . python-mode)
		  interpreter-mode-alist)))
	    
(autoload 'python-mode "python-mode" "Python editing mode." t)
(add-hook 'python-mode-hook
          '(lambda () 
             (local-set-key "\C-i"     'my-tab)))

(require 'python-mode)
(require 'pymacs)
(require 'ipython)
(setq py-python-command-args '( "-colors" "Linux"))
(setq ipython-completion-command-string "print(';'.join(__IP.Completer.all_completions('%s')))\n")


(defadvice py-execute-buffer (around python-keep-focus activate)
  "Thie advice to make focus python source code after execute command `py-execute-buffer'."
  (let ((remember-window (selected-window))
        (remember-point (point)))
    ad-do-it
    (select-window remember-window)
    (goto-char remember-point)))

;; (defun rgr/python-execute()
;;   (interactive)
;;   (if mark-active
;;       (py-execute-string (buffer-substring-no-properties (region-beginning) (region-end)))
;;     (py-execute-buffer)))

;; (global-set-key (kbd "C-c C-e") 'rgr/python-execute)

(add-hook 'python-mode-hook
          '(lambda () (eldoc-mode 1)) t)

(provide 'python-programming)
