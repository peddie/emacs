;;;;;;;; MATLAB, that steaming pile of hoe ;;;;;;;;

(local-path "site-lisp/matlab-emacs")

(load-library "matlab-load")

(autoload 'matlab-mode 
  (concat emacs-root "site-lisp/matlab-mode/matlab.el") 
  "Enter Matlab mode." t)

; prefer this to octave-mode or mercury-mode -- it is better for
; editing than octave-mode, and I write MATLAB more often than
; Mercury.
(assq-delete-all "\\.m\\'" auto-mode-alist)
(setq auto-mode-alist 
      (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(autoload 'matlab-shell 
  (concat emacs-root "site-lisp/matlab-mode/matlab.el") 
  "Interactive Matlab mode." t)

(defun flymake-mlint-init ()
  (flymake-simple-make-init-impl
   'flymake-create-temp-with-folder-structure nil nil
   (file-name-nondirectory buffer-file-name)
   'flymake-get-mlint-cmdline))

(defun flymake-get-mlint-cmdline (source base-dir)
  (list "~/asscock/bin/glnx86/mlint" (list source)))

(push '(".+\\.m$" flymake-mlint-init flymake-simple-java-cleanup)
      flymake-allowed-file-name-masks)

(add-to-list 'flymake-err-line-patterns 
	     '("^L \\([[:digit:]]+\\) (C \\([[:digit:]]+\\)-[[:digit:]]+): \\(.+\\)$"
	       nil 1 2 3))

;;; emacs assumes that if a value ends in "-function", it's a function
;;; and could be dangerous if loaded from a local values file.  This
;;; value just configures indentation settings, so tell emacs not to
;;; worry.
(mapc (lambda (x)
	(add-to-list 'safe-local-variable-values x))
      '((matlab-indent-function . nil)
	(matlab-indent-function . true)))

(defun my-matlab-mode-hook ()
  (flymake-mode)
  (setq matlab-indent-level 2)
  (setq matlab-indent-function t)       ; if you want function bodies indented
  (setq matlab-fill-code t)		; fill code with ...
  (setq matlab-fill-fudge 3)		; flexiblity for filling
  ; (matlab-mode-hilit)
  ; (turn-on-auto-fill)
  )
(setq matlab-mode-hook 'my-matlab-mode-hook)
(defun my-matlab-shell-mode-hook ()
  '())
(setq matlab-mode-hook 'my-matlab-mode-hook)
;(define-key matlab-mode-map (quote [f10]) `matlab-shell-run-region)
