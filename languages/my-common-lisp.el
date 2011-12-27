;;;;;;;;; Common Lisp config ;;;;;;;;

(require 'my-lisps)

; SLIME
(local-path "site-lisp/slime")
(local-path "site-lisp/slime/contrib")
(require 'slime)

(local-path "site-lisp/redshank")
(setq inferior-lisp-program "sbcl")

(add-to-list 'auto-mode-alist '("\\.lisp$" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.cl$" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.asd$" . lisp-mode))
(autoload 'slime "slime" "Superior Lisp Interaction Mode for Emacs" t)
(slime-setup '(slime-fancy slime-asdf slime-fuzzy slime-tramp slime-presentations))
; slime-fuzzy slows everything down

(setq slime-backend (concat emacs-root "site-lisp/slime/swank-loader.lisp"))
(eval-after-load "slime"
 '(progn
    (setq common-lisp-hyperspec-root "file:///usr/share/doc/hyperspec/")
    (setq common-lisp-hyperspec-symbol-table "/usr/share/doc/hyperspec/Data/Map_Sym.txt")
    (setq slime-multiprocessing t)
    (define-key slime-mode-map (kbd "TAB") 'slime-indent-and-complete-symbol)
    (setq slime-complete-symbol*-fancy t
          slime-complete-symbol-function 'slime-fuzzy-complete-symbol
          slime-when-complete-filename-expand t
          slime-truncate-lines nil
          slime-autodoc-use-multiline-p t)
    (define-key slime-repl-mode-map (kbd "C-c ;")
      'slime-insert-balanced-comments)
    (define-key slime-repl-mode-map (kbd "C-c M-;")
      'slime-remove-balanced-comments)
    (define-key slime-mode-map (kbd "C-c ;")
      'slime-insert-balanced-comments)
    (define-key slime-mode-map (kbd "C-c M-;")
      'slime-remove-balanced-comments)
    (define-key slime-mode-map (kbd "C-c C-q") 
      'slime-close-all-parens-in-sexp)
     (define-key slime-mode-map (kbd "RET") 'newline-and-indent)
    (define-key slime-mode-map (kbd "C-j") 'newline)
    (define-key slime-mode-map [C-tab] 'slime-selector)))
(add-hook 'lisp-mode-hook (lambda ()
                           (cond ((not (featurep 'slime))
                                  (require 'slime)
                                  (normal-mode)))))

; (indent-tabs-mode nil)
; (pair-mode t)

;; femlisp (Finite Element Method for Common Lisp)
(setq *femlisp-root* (concat my-common-lisp "femlisp/"))
(add-lisp "femlisp/elisp")
(autoload 'femlisp "femlisp" "finite-element calculations in common lisp")

     ;;; for showing the SLIME buffer if it is hidden
(defun show-repl-maybe-start-slime ()
  (interactive)
  (if (slime-connected-p)
      (slime-display-output-buffer)
    (slime 'sbcl)))
(global-set-key [f9] 'show-repl-maybe-start-slime)

;;;; Redshank for common lisp ;;;;
(require 'redshank-loader)
(eval-after-load "redshank-loader"
  `(redshank-setup '(lisp-mode-hook) t))

(font-lock-add-keywords
   'lisp-mode
   `(("[^-]\\(FIXME\\|TODO\\|KLUDGE\\|QUESTION\\|WARNING\\|#[+-]debug\\)"
1 'font-lock-todo-face t)
     ("[(:]\\(in-package\\|in-suite\\|not-yet-implemented\\|ignore-errors\\|read-from-string\\|eval\\|production-only.?\\|break[^)]?\\|break/inspect.?\\|break/print.?\\|print\\)[
        \n()]" 1 'font-lock-todo-face t)
     ("\\*debug-io\\*\\|\\*trace-output\\*" 0 'font-lock-todo-face t)))
