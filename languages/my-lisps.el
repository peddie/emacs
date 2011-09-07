;;;;;;;;;; shared configuration for s-exp languages, including slime ;;;;;;;;

(defconst my-common-lisp (concat my-home "software/lisp/"))
(defun add-lisp (p)
  (add-to-list 'load-path (concat my-common-lisp p)))

(setq slime-lisp-implementations
   `((sbcl (,(concat local-bin "sbcl")))
     (abcl (,(concat local-bin "abcl")))
     (clojure (,(concat my-bin "clojure")) :init swank-clojure-init)
     (qi (,(concat my-bin "qi")) :init qi-init-cmd)
     (mit-scheme (,(concat local-bin "mit-scheme-native")) :init mit-scheme-init)
     (chicken (,(concat local-bin "csi")) :init chicken-slime-init)))

(setq slime-default-lisp 'sbcl)

(add-hook 'emacs-lisp-mode-hook 'turn-on-paredit-mode)
(add-hook 'lisp-mode-hook 'turn-on-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-paredit-mode)
(add-hook 'scheme-mode-hook 'turn-on-paredit-mode)
; (add-hook 'clojure-mode-hook 'turn-on-paredit-mode)

(add-hook 'emacs-lisp-mode-hook '(lambda () (show-paren-mode t)))
(add-hook 'lisp-mode-hook '(lambda () (show-paren-mode t)))
(add-hook 'lisp-interaction-mode-hook '(lambda () (show-paren-mode t)))
(add-hook 'scheme-mode-hook '(lambda () (show-paren-mode t)))
; (add-hook 'clojure-mode-hook '(lambda () (show-paren-mode t)))

;; various lisps
(defun turn-on-paredit-mode ()
 (paredit-mode +1))

; I didn't like C-j being overridden, I want it to still work the old way in lisp-interaction
(eval-after-load "paredit"
 '(progn
    (define-key paredit-mode-map (read-kbd-macro "C-j") nil)))

(provide 'my-lisps)

