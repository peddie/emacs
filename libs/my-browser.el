;;;;;; browser setup ;;;;;;;

;; this is mostly for SLIME so it can get the hyperspec

(local-path "site-lisp/emacs-w3m")

(require 'w3m-ems)
(require 'w3m)

(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)

(require 'w3m-lnum)
(defun jao-w3m-go-to-linknum ()
  "Turn on link numbers and ask for one to go to."
  (interactive)
  (let ((active w3m-link-numbering-mode))
    (when (not active) (w3m-link-numbering-mode))
    (unwind-protect
	(w3m-move-numbered-anchor (read-number "Anchor number: "))
      (when (not active) (w3m-link-numbering-mode)))))

;; (require 'w3m-session)

;; (setq w3m-session-file "~/.emacs.d/w3m-session")
;; (setq w3m-session-save-always nil)
;; (setq w3m-session-load-always nil)
;; (setq w3m-session-show-titles t)
;; (setq w3m-session-duplicate-tabs 'ask) ;  'never, 'always, 'ask

(defun w3m-add-keys ()
  (define-key w3m-mode-map "S" 'w3m-session-save)
  (define-key w3m-mode-map "L" 'w3m-session-load)
  (define-key w3m-mode-map "f" 'jao-w3m-go-to-linknum))
(add-hook 'w3m-mode-hook 'w3m-add-keys)
