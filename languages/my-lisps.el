;;;;;;;;;; shared configuration for s-exp languages ;;;;;;;;

(setq slime-lisp-implementations
   '((sbcl ("/usr/local/bin/sbcl"))
     (abcl ("/usr/local/bin/abcl"))
     (clojure ("/home/peddie/bin/clojure") :init swank-clojure-init)
     (mit-scheme ("/usr/local/bin/mit-scheme-native") :init mit-scheme-init)
     (chicken ("csi") :init chicken-slime-init)))

(add-hook 'emacs-lisp-mode-hook 'turn-on-paredit-mode)
(add-hook 'lisp-mode-hook 'turn-on-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-paredit-mode)
(add-hook 'scheme-mode-hook 'turn-on-paredit-mode)
(add-hook 'clojure-mode-hook 'turn-on-paredit-mode)

(add-hook 'emacs-lisp-mode-hook '(lambda () (show-paren-mode t)))
(add-hook 'lisp-mode-hook '(lambda () (show-paren-mode t)))
(add-hook 'lisp-interaction-mode-hook '(lambda () (show-paren-mode t)))
(add-hook 'scheme-mode-hook '(lambda () (show-paren-mode t)))
(add-hook 'clojure-mode-hook '(lambda () (show-paren-mode t)))

(require 'electric-dot-and-dash)
(global-set-key "h" 'electric-dot-and-dash-dot)
(global-set-key "j" 'electric-dot-and-dash-dash)

;; various lisps
(defun turn-on-paredit-mode ()
 (paredit-mode +1))

; I didn't like C-j being overridden, I want it to still work the old way in lisp-interaction
(eval-after-load "paredit"
 '(progn
    (define-key paredit-mode-map (read-kbd-macro "C-j") nil)))

(provide 'my-lisps)

