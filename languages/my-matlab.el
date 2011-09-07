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

(defun my-matlab-mode-hook ()
  ; (setq matlab-indent-function t)       ; if you want function bodies indented
  (setq fill-column 80)         ; where auto-fill should wrap
  ; (matlab-mode-hilit)
  (turn-on-auto-fill))
(setq matlab-mode-hook 'my-matlab-mode-hook)
(defun my-matlab-shell-mode-hook ()
  '())
(setq matlab-mode-hook 'my-matlab-mode-hook)
;(define-key matlab-mode-map (quote [f10]) `matlab-shell-run-region)
