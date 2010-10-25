;;;;;;; custom keys ;;;;;;;

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(defalias 'qrr 'query-replace-regexp)
(defalias 'rr 'replace-regexp)
(defalias 'rs 'replace-string)
(defalias 'qs 'query-replace)
(defalias 'qr 'query-replace)
(global-set-key "\M-s" 'isearch-forward-regexp)
(global-set-key "\M-r" 'isearch-backward-regexp)
(global-set-key "\C-i" 'my-tab)

; where's that confounded backspace?
(global-set-key [(backspace)] 'backward-delete-char-untabify)
;(global-set-key "\C-h" 'delete-backward-char) 
;(global-set-key "\M-h" 'backward-kill-word)

; substitutes for old bindings
;(global-set-key "\M-p" 'mark-paragraph)
;(global-set-key "\M-?" 'help-command) 

; perhaps bad ideas?
(global-set-key "\C-c\C-c" 'comment-region)
;; (global-set-key "\C-c\C-u" 'uncomment-region)
;; (global-set-key "\C-x\C-g" 'goto-line)

(global-set-key "\C-c\C-p" 'ps-print-buffer-with-faces)
; (global-set-key "\C-xm" 'browse-url-at-point)

; time for some macro-trons
(global-set-key [f10]  'start-kbd-macro)
(global-set-key [f11]  'end-kbd-macro)
(global-set-key [f12]  'call-last-kbd-macro)
(global-set-key (kbd "C-x a r") 'align-regexp)
(global-set-key (kbd "M-/") 'hippie-expand)
