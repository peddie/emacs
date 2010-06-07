;;;;;;; haskell setup ;;;;;;;;

;; Haskell
; (add-to-list 'load-path "/home/peddie/.emacs.d/site-lisp/haskell-mode")
(add-to-list 'load-path "/home/peddie/software/haskellmode-emacs")
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(autoload 'inf-haskell "inf-haskell" "inferior haskell process")
(require 'haskell-mode)
(require 'inf-haskell)
(require 'my-flymake)

(add-hook 'haskell-mode-hook 'flymake-mode)

(setq auto-mode-alist
      (append '(("\\.hs$" . haskell-mode)
		("\\.lhs$" . haskell-mode)) auto-mode-alist))

(setq haskell-program-name "ghci")
;; (defun rgr/hayoo()  
;;   (interactive)
;;   (let* ((default (region-or-word-at-point))
;; 	 (term (read-string (format "Hayoo for the following phrase (%s): "
;; 				    default))))
;;     (let ((term (if (zerop(length term)) default term)))
;;       (browse-url (format "http://holumbus.fh-wedel.de/hayoo/results/hayoo.html?query=%s&start" term)))))

; (define-key haskell-mode-map (kbd "<f3>") (lambda()(interactive)(rgr/hayoo))) 

(add-hook 'haskell-mode-hook 'my-mmm-mode)

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
