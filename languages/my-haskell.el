;;;;;;; haskell setup ;;;;;;;;

;; Haskell
(defvar my-cabal (concat my-home ".cabal/"))
(local-path "site-lisp/haskell-mode")
(local-path "site-lisp/ghc-mod/elisp")
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
  (turn-on-haskell-decl-scan)
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


;;; The following is obsol33t

;; (add-hook 'literate-haskell-mode-hook 'haskell-unicode)
;; (add-hook 'haskell-mode-hook 'haskell-unicode)

;; (defun unicode-symbol (name)
;;   "Translate a symbolic name for a Unicode character -- e.g., LEFT-ARROW                                      
;;  or GREATER-THAN into an actual Unicode character code. "
;;   (decode-char 'ucs (case name                                             
;; 		      (left-arrow 8592)
;; 		      (up-arrow 8593)
;; 		      (right-arrow 8594)
;; 		      (down-arrow 8595)                                                
;; 		      (double-vertical-bar #X2551)                  
;; 		      (equal #X003d)
;; 		      (not-equal #X2260)
;; 		      (identical #X2261)
;; 		      (not-identical #X2262)
;; 		      (less-than #X003c)
;; 		      (greater-than #X003e)
;; 		      (less-than-or-equal-to #X2264)
;; 		      (greater-than-or-equal-to #X2265)                        
;; 		      (logical-and #X2227)
;; 		      (logical-or #X2228)
;; 		      (logical-neg #X00AC)                                                  
;; 		      ('nil #X2205)
;; 		      (horizontal-ellipsis #X2026)
;; 		      (double-exclamation #X203C)
;; 		      (prime #X2032)
;; 		      (double-prime #X2033)
;; 		      (for-all #X2200)
;; 		      (there-exists #X2203)
;; 		      (element-of #X2208)              
;; 		      (square-root #X221A)
;; 		      (squared #X00B2)
;; 		      (cubed #X00B3)                                            
;; 		      (lambda #X03BB)
;; 		      (alpha #X03B1)
;; 		      (beta #X03B2)
;; 		      (gamma #X03B3)
;; 		      (delta #X03B4))))

;; (defun substitute-pattern-with-unicode (pattern symbol)
;;   "Add a font lock hook to replace the matched part of PATTERN with the                                       
;;      Unicode symbol SYMBOL looked up with UNICODE-SYMBOL."
;;   (font-lock-add-keywords
;;    nil `((,pattern 
;; 	  (0 (progn (compose-region (match-beginning 1) (match-end 1)
;; 				    ,(unicode-symbol symbol)
;; 				    'decompose-region)
;; 		    nil))))))

;; (defun substitute-patterns-with-unicode (patterns)
;;   "Call SUBSTITUTE-PATTERN-WITH-UNICODE repeatedly."
;;   (mapcar #'(lambda (x)
;; 	      (substitute-pattern-with-unicode (car x)
;; 					       (cdr x)))
;; 	  patterns))

;; (defun haskell-unicode ()
;;   (substitute-patterns-with-unicode
;;    (list (cons "\\(<-\\)" 'left-arrow)
;; 	 (cons "\\(->\\)" 'right-arrow)
;; 	 (cons "\\(==\\)" 'identical)
;; 	 (cons "\\(/=\\)" 'not-identical)
;; 	 (cons "\\(()\\)" 'nil)
;; 	 (cons "\\<\\(sqrt\\)\\>" 'square-root)
;; 	 (cons "\\(&&\\)" 'logical-and)
;; 	 (cons "\\(||\\)" 'logical-or)
;; 	 (cons "\\<\\(not\\)\\>" 'logical-neg)
;; 	 (cons "\\(>\\)\\[^=\\]" 'greater-than)
;; 	 (cons "\\(<\\)\\[^=\\]" 'less-than)
;; 	 (cons "\\(>=\\)" 'greater-than-or-equal-to)
;; 	 (cons "\\(<=\\)" 'less-than-or-equal-to)
;; 	 (cons "\\<\\(alpha\\)\\>" 'alpha)
;; 	 (cons "\\<\\(beta\\)\\>" 'beta)
;; 	 (cons "\\<\\(gamma\\)\\>" 'gamma)
;; 	 (cons "\\<\\(delta\\)\\>" 'delta)
;; 	 (cons "\\(''\\)" 'double-prime)
;; 	 (cons "\\('\\)" 'prime)
;; 	 (cons "\\(!!\\)" 'double-exclamation)
;; 	 (cons "\\(\\.\\.\\)" 'horizontal-ellipsis))))
