;;;;;;; haskell setup ;;;;;;;;

(add-to-list 'completion-ignored-extensions ".hi")

;; Haskell
(defvar my-cabal (concat my-home ".cabal/"))
(local-path "site-lisp/haskell-mode")
(local-path (concat my-cabal "share/ghc-mod-1.10.15/"))
(autoload 'inf-haskell "inf-haskell" "inferior haskell process")

(require 'haskell-mode)
(require 'inf-haskell)
(require 'my-flymake)

(autoload 'ghc-init "ghc" nil t)

(setq auto-mode-alist
      (append '(("\\.hs$" . haskell-mode)
		("\\.lhs$" . literate-haskell-mode)) auto-mode-alist))

(require 'thingatpt)
(require 'thingatpt+)

(defun haskell-keys-setup (mode-map)
  (define-key mode-map (kbd "C-c C-f") 'ghc-flymake-toggle-command))

(haskell-keys-setup haskell-mode-map)
(haskell-keys-setup literate-haskell-mode-map)

(defun haskell-init-hook ()
  (ghc-init) 
;;   (setq haskell-font-lock-symbols 'unicode)
;;   (turn-on-haskell-decl-scan)
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
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)

(add-hook 'literate-haskell-mode-hook 'haskell-init-hook)
(add-hook 'literate-haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'literate-haskell-mode-hook 'turn-on-haskell-doc-mode)

;; (add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
;; (add-hook 'literate-haskell-mode-hook 'turn-on-haskell-ghci)

