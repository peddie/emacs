(defvar xpp-mode-hook nil)
(defvar xpp-mode-map
  (let ((xpp-mode-map (make-keymap)))
    (define-key xpp-mode-map "\C-j" 'newline-and-indent)
    xpp-mode-map)
  "Keymap for XPP major mode")

(add-to-list 'auto-mode-alist '("\\.ode\\'" . xpp-mode))

(defcustom xpp-function-list '("sin" "cos" "tan" "atan" "atan2"
			       "sinh" "cosh" "tanh" "exp" "delay"
			       "ln" "log" "log10" "pi"  "asin" "acos" "heav" 
			       "sign" "ceil" "flr" "ran" "abs"
			       "max" "min" "normal" "besselj" 
			       "bessely" "erf" "erfc" "poisson")
  "List of reserved functions for XPP used in highlighting.")

(defcustom xpp-keyword-list '("aux" "bdry" "done" "export"
			      "global" "init" "if" "then" "else" 
			      "markov" "number" "options" "par" 
			      "param" "params" "set" "solve" 
			      "special" "table" "voltera" "wiener")
  "List of keywords for XPP highlighting.")

(defconst xpp-font-lock-keywords
  (list
   (list
    (if (fboundp 'regexp-opt)
	(concat "\\<\\(" (regexp-opt xpp-function-list) "\\)\\>"))
    '(0 font-lock-function-name-face))
   (list
    (if (fboundp 'regexp-opt)
	(concat "\\<\\(" (regexp-opt xpp-keyword-list) "\\)\\>"))
    '(0 font-lock-builtin-face))
   '("@.*" . font-lock-constant-face)
   '("d.+/dt\\|^.'" . font-lock-variable-name-face)
   '("^\\(.+\\)(.)=" 1 font-lock-function-name-face))
  "Highlighting expressions for XPP mode")



(defvar xpp-mode-syntax-table
  (let ((xpp-mode-syntax-table (make-syntax-table)))
    (modify-syntax-entry ?_ "w" xpp-mode-syntax-table)
    (modify-syntax-entry ?# "<" xpp-mode-syntax-table)
    (modify-syntax-entry ?\n ">" xpp-mode-syntax-table)
    (modify-syntax-entry ?\" "<" xpp-mode-syntax-table)
    xpp-mode-syntax-table)
  "Syntax table for xpp-mode")
    
(defun xpp-mode ()
  "Major mode for editing .ode files read by XPPAUT"
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table xpp-mode-syntax-table)
  (use-local-map xpp-mode-map)
  (set (make-local-variable 'font-lock-defaults) '(xpp-font-lock-keywords))
  (setq major-mode 'xpp-mode)
  (setq mode-name "XPP")
  (run-hooks 'xpp-mode-hook))

(provide 'xpp-mode)
