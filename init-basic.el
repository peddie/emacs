;;; a few choice settings for sending other people or copying to work
;;; computers that other people have to use

(defvar emacs-root "~/.emacs.d/")

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(defalias 'qrr 'query-replace-regexp)
(defalias 'rr 'replace-regexp)
(defalias 'rs 'replace-string)
(defalias 'qs 'query-replace)
(defalias 'qr 'query-replace)
(global-set-key "\M-s" 'isearch-forward-regexp)
(global-set-key "\M-r" 'isearch-backward-regexp)

(setq make-backup-files t)
(setq version-control t)
(setq backup-directory-alist `((".*" . ,(concat emacs-root "backups/"))))

(setq
  scroll-margin 0 ;; do smooth scrolling, ...
  scroll-conservatively 100000 ;; ... the defaults ...
  scroll-up-aggressively 0 ;; ... are very ...
  scroll-down-aggressively 0 ;; ... annoying
  scroll-preserve-screen-position t) ;; preserve screen pos with C-v/M-v

(setq focus-follows-mouse t)
(setq set-mark-command-repeat-pop t)
(size-indication-mode 1)
(setq indicate-empty-lines t)
(setq frame-title-format "emacs - %b")
(setq require-final-newline t) ;; end files with a newline

(autoload 'complete "complete" "Completion mode, hopefully")
(partial-completion-mode t)

(setq my-font "DejaVu Sans Mono-13:weight=book")
(add-to-list 'default-frame-alist `(font . ,my-font))
(set-frame-font my-font)

(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
		       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

(global-set-key [f11] 'fullscreen)

(defun toggle-matt-mode () 
  (interactive)
  (progn 
    (menu-bar-mode)
    (scroll-bar-mode)
    (tool-bar-mode)))

(global-set-key [f12] 'toggle-matt-mode)

(defun reasonable-settings ()
  (progn
    (global-font-lock-mode 1)
    (auto-compression-mode 1)
    (setq inhibit-startup-message t)
    (setq inhib)
    (setq mouse-yank-at-point t)
    (setq font-lock-maximum-decoration t)
    (fset 'yes-or-no-p 'y-or-n-p)
    (defadvice yes-or-no-p (around prevent-dialog activate)
      "Prevent yes-or-no-p from activating a dialog"
      (let ((use-dialog-box nil))
	ad-do-it))
    (defadvice y-or-n-p (around prevent-dialog-yorn activate)
      "Prevent y-or-n-p from activating a dialog"
      (let ((use-dialog-box nil))
	ad-do-it))))

(reasonable-settings)

(defun turn-on-paredit-mode ()
  (paredit-mode +1))

(eval-after-load "paredit"
 '(progn
    (define-key paredit-mode-map (read-kbd-macro "C-j") nil)))

(add-hook 'emacs-lisp-mode-hook 'turn-on-paredit-mode)
(add-hook 'emacs-lisp-mode-hook '(lambda () (show-paren-mode t)))

;;;;;;;;; ido-mode ;;;;;;;;;;;

(require 'ido)
(setq
 ido-save-directory-list-file (concat emacs-root "cache/ido.last")
 ido-ignore-buffers ;; ignore these guys
 '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*trace"
   "^\*compilation" "^\*GTAGS" "^session\.*" "^\*")
 ido-work-directory-list '("~/" "~/Desktop" "~/Documents" "~src")
 ido-case-fold t ; be case-insensitive
 ido-enable-last-directory-history t ; remember last used dirs
 ido-max-work-directory-list 30 ; should be enough
 ido-max-work-file-list 50 ; remember many
 ido-use-filename-at-point nil ; don't use filename at point (annoying)
 ido-use-url-at-point nil ; don't use url at point (annoying)
 ido-enable-flex-matching t ; don't try to be too smart
 ido-max-prospects 10 ; don't spam my minibuffer
 ido-confirm-unique-completion t) ; wait for RET, even with unique completion
(ido-mode 'both) ;; for buffers and files

;; when using ido, the confirmation is rather annoying...
(setq confirm-nonexistent-file-or-buffer nil)

;; increase minibuffer size when ido completion is active
(add-hook 'ido-minibuffer-setup-hook
  (function
    (lambda ()
      (make-local-variable 'resize-minibuffer-window-max-height)
      (setq resize-minibuffer-window-max-height 1))))

