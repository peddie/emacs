;;;;;;;; general options ;;;;;;;
(defun reasonable-settings ()
  (progn
    (global-font-lock-mode 1)
    (menu-bar-mode 0)
    (scroll-bar-mode 0)
    (tool-bar-mode 0)
    (auto-compression-mode 1)
    (setq inhibit-startup-message t)
    (setq inhib)
    (setq mouse-yank-at-point t)
    (setq font-lock-maximum-decoration t)
    (fset 'yes-or-no-p 'y-or-n-p)
    (setq buffer-file-coding-system 'utf-8)
    (prefer-coding-system 'utf-8)
    (setq default-file-name-coding-system 'utf-8)
    (setq default-keyboard-coding-system 'utf-8)
    (setq default-process-coding-system '(utf-8 . utf-8))
    (setq default-sendmail-coding-system 'utf-8)
    (setq default-terminal-coding-system 'utf-8)
    (defadvice yes-or-no-p (around prevent-dialog activate)
      "Prevent yes-or-no-p from activating a dialog"
      (let ((use-dialog-box nil))
	ad-do-it))
    (defadvice y-or-n-p (around prevent-dialog-yorn activate)
      "Prevent y-or-n-p from activating a dialog"
      (let ((use-dialog-box nil))
	ad-do-it))))

(reasonable-settings)

(setq default-frame-alist
 	'((frame-title-format . "emacs - %b")
	  (menu-bar-mode . 0)
	  (scroll-bar-mode . 0)
	  (tool-bar-mode . 0)))

(add-hook 'after-make-frame-functions
	  (lambda (frame)
	    (reasonable-settings)
	    (setq color-theme-is-global nil)
	    (select-frame frame)
	    (set-variable 'solarized-contrast 'normal)
	    (setq solarized-termcolors 256)
	    (if window-system
		(color-theme-solarized-light)
	      (color-theme-solarized-light))))

;; scrolling (from http://www.djcbsoftware.nl/dot-emacs.html)
(setq 
  scroll-margin 0                        ;; do smooth scrolling, ...
  scroll-conservatively 100000           ;; ... the defaults ...
  scroll-up-aggressively 0               ;; ... are very ...
  scroll-down-aggressively 0             ;; ... annoying
  scroll-preserve-screen-position t)     ;; preserve screen pos with C-v/M-v 

(setq focus-follows-mouse t)
(setq set-mark-command-repeat-pop t)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(setq indicate-empty-lines t)
(setq frame-title-format "emacs - %b")
(setq require-final-newline t)           ;; end files with a newline

;(normal-top-level-add-subdirs-to-load-path)

;;; backup files
(setq make-backup-files t)
(setq version-control t)
(setq backup-directory-alist `((".*" . ,(concat emacs-root "backups/"))))
(size-indication-mode)

(local-path "site-lisp/solarized")
(require 'color-theme-solarized)

(provide 'my-options)
