;;;;;;;; MATLAB, that steaming pile of hoe ;;;;;;;;

(add-to-list 'load-path "/home/peddie/.emacs.d/site-lisp/matlab-mode")

(autoload 'matlab-mode "/home/peddie/.emacs.d/site-lisp/matlab-mode/matlab.el" "Enter Matlab mode." t)
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(autoload 'matlab-shell "/home/peddie/.emacs.d/site-lisp/matlab-mode/matlab.el" "Interactive Matlab mode." t) 
(defun my-matlab-mode-hook ()
  ; (setq matlab-indent-function t)       ; if you want function bodies indented
  (setq fill-column 76)         ; where auto-fill should wrap
  ; (matlab-mode-hilit)
  (turn-on-auto-fill))
(setq matlab-mode-hook 'my-matlab-mode-hook)
(defun my-matlab-shell-mode-hook ()
  '())
(setq matlab-mode-hook 'my-matlab-mode-hook)
;(define-key matlab-mode-map (quote [f10]) `matlab-shell-run-region)
