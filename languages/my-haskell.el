;;;;;;; haskell setup ;;;;;;;;

;; Haskell
(add-to-list 'load-path "~/.emacs.d/site-lisp/haskell-mode")
(add-to-list 'load-path "~/.emacs.d/site-lisp/ghc-mod/elisp")
(autoload 'inf-haskell "inf-haskell" "inferior haskell process")

(require 'haskell-mode)
(require 'haskell-indent)
(require 'inf-haskell)
(require 'my-flymake)

(autoload 'ghc-init "ghc" nil t)

(setq auto-mode-alist
      (append '(("\\.hs$" . haskell-mode)
		("\\.lhs$" . literate-haskell-mode)) auto-mode-alist))

(require 'thingatpt)
(require 'thingatpt+)

(defun rgr/hayoo()
 (interactive)
 (let* ((default (region-or-word-at-point))
	(term (read-string (format "Hayoo for the following phrase (%s): "
                                   default))))
   (let ((term (if (zerop(length term)) default term)))
     (browse-url (format "http://holumbus.fh-wedel.de/hayoo/hayoo.html?query=%s&start" term)))))

(defun haskell-keys-setup (mode-map)
  (define-key mode-map (kbd "C-c C-m") 'haskell-indent-put-region-in-literate)
  (define-key mode-map (kbd "C-c C-=") 'haskell-indent-insert-equal)
  (define-key mode-map (kbd "C-c C-|") 'haskell-indent-insert-guard)
  (define-key mode-map (kbd "C-c C-o") 'haskell-indent-insert-otherwise)
  (define-key mode-map (kbd "C-c C-.") 'haskell-indent-align-guards-and-rhs)
  ;; run a hayoo search
  (define-key mode-map (kbd "C-c C-s") 'rgr/hayoo)
  (define-key mode-map (kbd "C-c C-w") 'haskell-indent-insert-where)
  (define-key mode-map (kbd "C-c C-f") 'ghc-flymake-toggle-command)
  (define-key mode-map (kbd "C-c C-c") 'comment-region)
  (define-key mode-map (kbd "C-c C-u") 'uncomment-region))

(haskell-keys-setup haskell-mode-map)
(haskell-keys-setup literate-haskell-mode-map)

(defun haskell-init-hook ()
  (ghc-init) 
  (setq haskell-font-lock-symbols 'unicode)
  (if (not (null buffer-file-name)) 
      (flymake-mode)))

(setq haskell-program-name "ghci")

(mmm-add-classes
'((literate-haskell-bird
  :submode text-mode
  :front "^[^>]"
  :include-front true
  :back "^>\\|$"
  )
 (literate-haskell-latex
  :submode literate-haskell-mode
  :front "^\\\\begin{code}"
  :front-offset (end-of-line 1)
  :back "^\\\\end{code}"
  :include-back nil
  :back-offset (beginning-of-line -1)
  )))

(add-hook 'literate-haskell-mode-hook 'my-mmm-mode)


(add-hook 'haskell-mode-hook 'haskell-init-hook)
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)

(add-hook 'literate-haskell-mode-hook 'haskell-init-hook)
(add-hook 'literate-haskell-mode-hook 'turn-on-haskell-ghci)
(add-hook 'literate-haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'literate-haskell-mode-hook 'turn-on-haskell-doc-mode)


