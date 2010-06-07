;;;;;;;;;; shared configuration for s-exp languages ;;;;;;;;

;; various lisps
(defun turn-on-paredit-mode ()
 (paredit-mode +1))

; I didn't like C-j being overridden, I want it to still work the old way in lisp-interaction
(eval-after-load "paredit"
 '(progn
    (define-key paredit-mode-map (read-kbd-macro "C-j") nil)))

(show-paren-mode)

(add-hook 'emacs-lisp-mode-hook 'turn-on-paredit-mode)
(add-hook 'lisp-mode-hook 'turn-on-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-paredit-mode)
(add-hook 'scheme-mode-hook 'turn-on-paredit-mode)
(add-hook 'clojure-mode-hook 'turn-on-paredit-mode)

(require 'electric-dot-and-dash)
(global-set-key "h" 'electric-dot-and-dash-dot)
(global-set-key "j" 'electric-dot-and-dash-dash)

(provide 'my-lisps)