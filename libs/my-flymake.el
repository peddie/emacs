;;;;;;;;;; flymake mode for compiling on the fly ;;;;;;;;;;;

;; (add-to-list 'load-path "/usr/share/emacs/23.2/lisp/progmodes/")

(require 'flymake)
(require 'flymake-cursor)
(require 'flymake-init)
(ignore-errors (require 'my-flymake-minor-mode))

; (add-hook 'find-file-hook 'flymake-find-file-hook)

(add-hook 'flymake-mode-hook
	  (lambda ()
	    (setq flymake-gui-warnings-enabled nil)
	    (custom-set-faces
	     '(flymake-errline ((((class color)) (:underline "red"))))
	     '(flymake-warnline ((((class color)) (:underline "orange")))))
	    ;; (define-key flymake-mode-map (kbd "M-n") 'flymake-goto-next-error)
	    ;; (define-key flymake-mode-map (kbd "M-p") 'flymake-goto-prev-error)
	    (my-flymake-minor-mode)))

(setq flymake-buildfile-dirs '("./" "../" "../../"))

(defun flymake-set-faces (&optional f)
  (custom-set-faces
   '(flymake-errline ((((class color)) (:underline "red"))))
   '(flymake-warnline ((((class color)) (:underline "orange"))))))

(flymake-set-faces)
(add-hook 'after-make-frame-functions 'flymake-set-faces)

(provide 'my-flymake)
