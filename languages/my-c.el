;;;;;;;;;; C ;;;;;;;;;;

(require 'my-flymake)
(require 'my-git)
(require 'highlight-80+)
; (add-hook 'c-mode-hook 'flymake-mode)

(add-to-list 'completion-ignored-extensions ".gcno")
(add-to-list 'completion-ignored-extensions ".gcda")
(add-to-list 'completion-ignored-extensions ".d")
(add-to-list 'completion-ignored-extensions ".oc")
(add-to-list 'completion-ignored-extensions ".lst")

(add-hook 'c-mode-hook
	  '(lambda ()
             (define-key c-mode-map (kbd "C-c C-l") 'compile)
	     (define-key c-mode-map (kbd "C-c m") 'magit-status)
	     (define-key c-mode-map (kbd "C-;") 'comment-box)
	     (define-key c-mode-map (kbd "C-c C-f") 'flymake-mode)))

(require 'google-c-style)

(add-hook 'c-mode-common-hook '(lambda ()
				 (define-key c-mode-map (kbd "C-c C-l") 'compile)
				 (define-key c-mode-map (kbd "C-c m") 'magit-status)
				 (define-key c-mode-map (kbd "C-;") 'comment-box)
				 (define-key c-mode-map (kbd "C-c C-f") 'flymake-mode)
				 (setq comment-style 'multi)
				 (highlight-80+-mode)
				 (google-set-c-style)
				 (google-make-newline-indent)))


;;; This is my C style for non-Makani code

;; (setq indent-tabs-mode nil)
;; (setq c-indent-level 2)
;; (setq c-default-style "k&r")
;; (setq c-basic-offset 2)
