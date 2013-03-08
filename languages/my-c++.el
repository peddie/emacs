;;;;;;;;; C++ ;;;;;;;

(require 'my-flymake)
(require 'my-git)
; damn, worst idea ever
; (add-hook 'c++-mode-hook 'flymake-mode)

(add-to-list 'completion-ignored-extensions ".gcno")
(add-to-list 'completion-ignored-extensions ".gcda")
(add-to-list 'completion-ignored-extensions ".d")
(add-to-list 'completion-ignored-extensions ".oc")
(add-to-list 'completion-ignored-extensions ".lst")

(require 'google-c-style)

;; (defun flymake-cpplint-init ()
;;   (flymake-simple-make-init-impl
;;    'flymake-create-temp-with-folder-structure nil nil
;;    (file-name-nondirectory buffer-file-name)
;;    'flymake-get-cpplint-cmdline))

;; (defun flymake-get-cpplint-cmdline (source base-dir)
;;   (list "cpplint"
;; 	(list source base-dir)))

;; (push '(".+\\.cpp$" flymake-cpplint-init flymake-simple-java-cleanup)
;;       flymake-allowed-file-name-masks)

;; (push '(".+\\.cc$" flymake-cpplint-init flymake-simple-java-cleanup)
;;       flymake-allowed-file-name-masks)

(add-hook 'c++-mode-hook
	  '(lambda ()
             (define-key c++-mode-map (kbd "C-c C-l") 'compile)
             (define-key c++-mode-map (kbd "C-;") 'comment-box)
	     (define-key c++-mode-map (kbd "C-c C-f") 'flymake-mode)
	     (define-key c++-mode-map (kbd "C-c m") 'magit-status)
	     (setq indent-tabs-mode nil)
	     (setq c-default-style "google")
	     (google-set-c-style)
	     (google-make-newline-indent)
	     (setq comment-style 'multi)))

