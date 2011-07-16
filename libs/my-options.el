;;;;;;;; general options ;;;;;;;
(local-path "site-lisp/solarized")
(require 'color-theme-solarized)


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
    (fset 'yes-or-no-p 'y-or-n-p)))

;; scrolling (from http://www.djcbsoftware.nl/dot-emacs.html)
(setq 
  scroll-margin 0                        ;; do smooth scrolling, ...
  scroll-conservatively 100000           ;; ... the defaults ...
  scroll-up-aggressively 0               ;; ... are very ...
  scroll-down-aggressively 0             ;; ... annoying
  scroll-preserve-screen-position t)     ;; preserve screen pos with C-v/M-v 

; this is for dark environments
;; (set-background-color "black")
;; (set-foreground-color "grey90")
;; (set-cursor-color "white")
; this is for light environments
;;       '((cursor-color . "grey3") 
;; 	(background-color . "grey85") 
;; 	(foreground-color . "grey7") 

;; (setq solarized-termcolors 256)
;; (setq solarized-contrast 'normal)
;; (color-theme-solarized-light)
;; (setq color-theme-is-global nil)

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

(provide 'my-options)
